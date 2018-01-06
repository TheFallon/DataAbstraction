
DROP TABLE match;
CREATE GLOBAL TEMPORARY TABLE match
(match_id       NUMBER(3) CONSTRAINT match_pk PRIMARY KEY,
 buy_request_id NUMBER(5) NOT NULL, 
 buyer_id       NUMBER(6) NOT NULL,
 sell_request_id NUMBER(5) NOT NULL,
 seller_id       NUMBER(6) NOT NULL,
 trade_amount    NUMBER(7) NOT NULL,
 share_price     NUMBER(10,4) NOT NULL,
 trade_made      NUMBER(1) DEFAULT 0 CHECK (trade_made IN (0, 1)) NOT NULL
 )
 ON COMMIT DELETE ROWS;
  

CREATE OR REPLACE PACKAGE request_pkg
IS
  g_match_id  NUMBER(3);
  
  FUNCTION GetMarketPrice
  (p_stock_ex_id      IN NUMBER,
   p_stock_id         IN NUMBER
  ) RETURN trade.share_price%TYPE;
  
  PROCEDURE BuyIsFillable
  (p_request          IN request%ROWTYPE,
   p_market_price     IN trade.share_price%TYPE, 
   pio_total_current  IN OUT trade.shares%TYPE,
   p_debug_indent     IN NUMBER,
   po_isFillable      OUT BOOLEAN
  );
  
  PROCEDURE SellIsFillable
  (
   p_request          IN request%ROWTYPE,
   p_market_price     IN trade.share_price%TYPE, 
   pio_total_current  IN OUT trade.shares%TYPE,
   p_debug_indent     IN NUMBER,
   po_isFillable      OUT BOOLEAN
  );
  
  PROCEDURE TryBuyRequest
  (
  p_request        IN request%ROWTYPE,    
  po_status        OUT VARCHAR2
  );
  
  PROCEDURE TrySellRequest
  (
  p_request        IN request%ROWTYPE,    
  po_status        OUT VARCHAR2
  );

  PROCEDURE MakeTrades
  (
   p_stock_ex_id      IN stock_exchange.stock_ex_id%TYPE,
   p_stock_id         IN company.stock_id%TYPE
  );
  
  PROCEDURE ProcessRequests;
END;
/
show errors PACKAGE request_pkg;





































CREATE OR REPLACE PACKAGE BODY request_pkg IS

FUNCTION GetMarketPrice
  (p_stock_ex_id      IN NUMBER,
   p_stock_id         IN NUMBER
  ) RETURN trade.share_price%TYPE
AS
     l_market_price trade.share_price%TYPE;
  BEGIN
  SELECT   
     share_price
  INTO l_market_price
  FROM trade
  WHERE trade_id = (SELECT MAX(sub.trade_id) 
                    FROM trade sub
                    WHERE sub.stock_ex_id = p_stock_ex_id
                      AND sub.stock_id = p_stock_id);

  RETURN l_market_price;

EXCEPTION  
  WHEN NO_DATA_FOUND THEN
     SELECT starting_price * cv.exchange_rate 
     INTO l_market_price  
     FROM company c 
     JOIN conversion cv
       ON cv.from_currency_id = c.currency_id
      AND cv.to_currency_id = (SELECT se.currency_id
                               FROM stock_exchange se
                               WHERE se.stock_ex_id = p_stock_ex_id)
     WHERE c.stock_id = p_stock_id;
     
     RETURN l_market_price;
END;

PROCEDURE BuyIsFillable
  (p_request          IN request%ROWTYPE,
   p_market_price     IN trade.share_price%TYPE, 
   pio_total_current  IN OUT trade.shares%TYPE,
   p_debug_indent     IN NUMBER,
   po_isFillable      OUT BOOLEAN
  )
AS
   l_trade_amount     trade.shares%TYPE := 0;
   l_trade_amount_tmp trade.shares%TYPE := 0;
   l_sell_fillable    boolean;
   
BEGIN
po_isFillable := FALSE;

dbms_output.put_line(lpad('.',p_debug_indent*3,'.') || 
   ' BuyIsFillable. RequestID: ' || p_request.request_id ||
   ' Minimum: ' || p_request.minimum_shares || 
   ' Shares: ' || p_request.shares || 
   ' Current Total: ' || pio_total_current ||
   ' Remainder: ' || (p_request.shares - pio_total_current));
   
IF pio_total_current >= p_request.minimum_shares THEN
   po_isFillable := TRUE;
END IF;
FOR sellrequest IN (SELECT *
                    FROM request 
                    WHERE buy_sell = 'SELL'
                      AND p_market_price <= nvl(request.stop_price,999999.9999)
                      AND p_market_price >= nvl(request.limit_price, 0)
                      AND request.stock_ex_id = p_request.stock_ex_id
                      AND request.stock_id    = p_request.stock_id
                      AND request.status = 'ACTIVE'
                      AND request_id NOT IN 
                         (SELECT sell_request_id FROM match)
                    ORDER BY request_id) LOOP
   EXECUTE IMMEDIATE 'SAVEPOINT sp_buy' || to_char(p_debug_indent);
   l_trade_amount := least(p_request.shares - pio_total_current, sellrequest.shares);
   dbms_output.put_line(lpad('.',p_debug_indent*3,'.') || 
      ' BuyIsFillable. Found a seller.  Request ID: ' || sellrequest.request_id || 
      ' Selling: ' || sellrequest.shares || 
      ' Trade amount: ' || l_trade_amount);
   g_match_id := g_match_id + 1;
   INSERT INTO match
      (match_id,
       buy_request_id, buyer_id,
       sell_request_id, seller_id,
       trade_amount, share_price, trade_made)
   VALUES 
      (g_match_id,
       p_request.request_id, p_request.shareholder_id,
       sellrequest.request_id,   sellrequest.shareholder_id,
       l_trade_amount, p_market_price, 0);
      
   IF l_trade_amount = sellrequest.shares THEN
      pio_total_current := pio_total_current + l_trade_amount;
      dbms_output.put_line(lpad('.',p_debug_indent*3,'.') || ' BuyIsFillable. Sell Request: ' || sellrequest.request_id || ' completely filled.  Shares_filled = ' || l_trade_amount);
   ELSE
      l_trade_amount_tmp := 0;
      sellrequest.shares := sellrequest.shares - l_trade_amount;
      sellrequest.minimum_shares := greatest(sellrequest.minimum_shares - l_trade_amount,0);
      request_pkg.sellisfillable(sellrequest, 
          p_market_price,
          l_trade_amount_tmp, 
          p_debug_indent+1,
          l_sell_fillable);
      IF l_sell_fillable THEN
         pio_total_current := pio_total_current + l_trade_amount;
         dbms_output.put_line(lpad('.',p_debug_indent*3,'.') || ' Trade Amount Temp: ' || l_trade_amount_tmp);
         dbms_output.put_line(lpad('.',p_debug_indent*3,'.') || ' BuyIsFillable. Total Current:  ' || pio_total_current || ' Minimum: ' || p_request.minimum_shares);
         dbms_output.put_line(lpad('.',p_debug_indent*3,'.') || ' BuyIsFillable. Line 207. SellRequestID: ' || sellrequest.request_id || '. Trade Amount: ' || l_trade_amount || '. Shares: ' || p_request.shares);
      ELSE
         dbms_output.put_line(lpad('.',p_debug_indent*3,'.') || ' BuyIsFillable. Request ID: ' || sellrequest.request_id || ' is not fillable. Rolling back.');
         EXECUTE IMMEDIATE 'ROLLBACK TO sp_buy' || TO_CHAR(p_debug_indent);
      END IF;
   END IF;
   IF pio_total_current >= p_request.minimum_shares THEN
      po_isFillable := TRUE;
   END IF;
   exit WHEN p_request.shares - pio_total_current = 0;
         
END loop;
END;


PROCEDURE SellIsFillable
(
 p_request          IN request%ROWTYPE,
 p_market_price     IN trade.share_price%TYPE, 
 pio_total_current  IN OUT trade.shares%TYPE,
 p_debug_indent     IN NUMBER,
 po_isFillable      OUT BOOLEAN
)
AS
   l_trade_amount     trade.shares%TYPE := 0;
   l_trade_amount_tmp trade.shares%TYPE := 0;
   l_buy_fillable     boolean;
   
BEGIN
po_isFillable := FALSE;

dbms_output.put_line(lpad('.',p_debug_indent*3,'.') || 
   ' SellIsFillable. Request ID: ' || p_request.request_id ||
   ' Minimum: ' || p_request.minimum_shares || 
   ' Shares: ' || p_request.shares || 
   ' Current Total: ' || pio_total_current ||
   ' Remainder: ' || (p_request.shares - pio_total_current));

IF pio_total_current >= p_request.minimum_shares THEN
   po_isFillable := TRUE;
END IF;
FOR buyrequest IN (SELECT *
                   FROM request 
                   WHERE buy_sell = 'BUY'
                     AND p_market_price >= nvl(request.stop_price,0)
                     AND p_market_price <= nvl(request.limit_price,999999.9999)
                     AND request.stock_ex_id = p_request.stock_ex_id
                     AND request.stock_id    = p_request.stock_id
                     AND request.status = 'ACTIVE'
                     AND request_id NOT IN 
                         (SELECT buy_request_id FROM match)
                   ORDER BY request_id) LOOP
   l_trade_amount := least(p_request.shares - pio_total_current, buyrequest.shares);
   dbms_output.put_line(lpad('.',p_debug_indent*3,'.') || 
            ' SellIsFillable. Found buyer. Request ID:' || buyrequest.request_id || 
            ' asking ' || buyrequest.shares || 
            ' trade amount ' || l_trade_amount);
   EXECUTE IMMEDIATE 'SAVEPOINT sp_sell' || to_char(p_debug_indent);
   g_match_id := g_match_id + 1;
   INSERT INTO match
         (match_id, 
          buy_request_id,  buyer_id,
          sell_request_id, seller_id,
          trade_amount, share_price, trade_made)
   VALUES (g_match_id, 
           buyrequest.request_id, buyrequest.shareholder_id,
           p_request.request_id, p_request.shareholder_id,
           l_trade_amount, p_market_price, 0);

   IF l_trade_amount = buyrequest.shares THEN
      pio_total_current := pio_total_current + l_trade_amount;
      dbms_output.put_line(lpad('.',p_debug_indent*3,'.') || ' SellIsFillable. Buy Request: ' || buyrequest.request_id || ' completely filled.  Shares_filled = ' || l_trade_amount);
   ELSE
      l_trade_amount_tmp := 0;
      buyrequest.shares := buyrequest.shares - l_trade_amount;
      buyrequest.minimum_shares := greatest(buyrequest.minimum_shares - l_trade_amount,0);
      request_pkg.buyisfillable(buyrequest, 
          p_market_price,
          l_trade_amount_tmp, 
          p_debug_indent+1,
          l_buy_fillable);
      IF l_buy_fillable THEN
         pio_total_current := pio_total_current + l_trade_amount;
         dbms_output.put_line(lpad('.',p_debug_indent*3,'.') || ' Trade Amount Temp: ' || l_trade_amount_tmp);
         dbms_output.put_line(lpad('.',p_debug_indent*3,'.') || ' SellIsFillable. Total Current:  ' || pio_total_current || ' Minimum: ' || p_request.minimum_shares);
         dbms_output.put_line(lpad('.',p_debug_indent*3,'.') || ' SellIsFillable. Line 299. BuyRequestID: ' || buyrequest.request_id || '. Trade Amount: ' || l_trade_amount || '. Shares: ' || p_request.shares);
      ELSE
         dbms_output.put_line(lpad('.',p_debug_indent*3,'.') || ' SellIsFillable. Buy Request ID: ' || buyrequest.request_id || ' is not fillable. Rolling back.');
         EXECUTE IMMEDIATE 'ROLLBACK TO sp_sell' || to_char(p_debug_indent);
      END IF;
   END IF;
   IF pio_total_current >= p_request.minimum_shares THEN
      po_isFillable := TRUE;
   END IF;
   exit WHEN p_request.shares - pio_total_current = 0;
END loop;
END;

PROCEDURE TryBuyRequest
  (
  p_request        IN request%ROWTYPE,    
  po_status        OUT VARCHAR2
  )
 IS
   l_market_price      trade.share_price%TYPE;
   l_fillable          boolean := FALSE;
   l_total_current     request.shares%TYPE := 0;   
 
BEGIN

po_status := 'ACTIVE';
l_market_price := request_pkg.GetMarketPrice(p_request.stock_ex_id, p_request.stock_id);

IF l_market_price >= nvl(p_request.stop_price,0)
   AND l_market_price <= nvl(p_request.limit_price,999999.9999) THEN
   dbms_output.put_line('  TryBuyRequest. Request ID: ' || p_request.request_id || ' is active at market price');
   
   request_pkg.buyisfillable(
          p_request, l_market_price, 
          l_total_current, 
          1, l_fillable);
   IF l_total_current = p_request.shares THEN
      dbms_output.put_line('  TryBuyRequest.  Request ID: ' || p_request.request_id || ' is fillable at market price');
      request_pkg.maketrades(p_request.stock_ex_id, p_request.stock_id);
      po_status := 'COMPLETED';
   ELSE 
      FOR item IN (SELECT limit_price
                   FROM request
                   WHERE buy_sell = 'SELL'
                     AND stock_ex_id = p_request.stock_ex_id
                     AND stock_id = p_request.stock_id
                     AND status = 'ACTIVE'
                     AND limit_price > l_market_price
                     AND limit_price <= nvl(p_request.limit_price,999999)
                   ORDER BY limit_price ASC) loop

         dbms_output.put_line('  TryBuyRequest.  Request ID: ' || p_request.request_id || ' trying a higher price ' || item.limit_price);
         request_pkg.buyisfillable(
                   p_request, 
                   item.limit_price, 
                   l_total_current, 
                   1, 
                   l_fillable);
         IF l_total_current = p_request.shares THEN
            exit;
         END IF;
      END loop;
      IF l_fillable THEN
         IF l_total_current = p_request.shares THEN
            dbms_output.put_line('  TryBuyRequest.  Request ID: ' || p_request.request_id || ' is fillable.  Shares: ' || p_request.shares || '. Min Shares: ' || p_request.minimum_shares || '. Shares Filled: ' || l_total_current );
            po_status := 'COMPLETED';
         ELSE
            dbms_output.put_line('  TryBuyRequest.  Request ID: ' || p_request.request_id || ' is partially filled.  Shares: ' || p_request.shares || '. Min Shares: ' || p_request.minimum_shares || '. Shares Filled: ' || l_total_current );
            po_status := 'PARTIAL FILL';
         END IF;
         request_pkg.maketrades(
                       p_request.stock_ex_id, p_request.stock_id);
      END IF;

   END IF;
ELSE
   dbms_output.put_line('  TryBuyRequest. Request ID: ' || p_request.request_id || ' is not active at market price');
END IF;
END;

PROCEDURE TrySellRequest
  (
  p_request        IN request%ROWTYPE,    
  po_status        OUT VARCHAR2
  )
 IS
   l_market_price      trade.share_price%TYPE;
   l_fillable          boolean := FALSE;
   l_total_current     request.shares%TYPE := 0;
BEGIN

po_status := 'ACTIVE';
l_market_price := request_pkg.GetMarketPrice(p_request.stock_ex_id, p_request.stock_id);

IF l_market_price <= nvl(p_request.stop_price,999999.9999)
   AND l_market_price >= nvl(p_request.limit_price,0) THEN

   dbms_output.put_line('  TrySellRequest. Request ID: ' || p_request.request_id || ' is active at market price');
 
   request_pkg.sellisfillable(
              p_request,
              l_market_price, 
              l_total_current, 
              1, 
              l_fillable);
   IF l_total_current = p_request.shares THEN
      dbms_output.put_line('  TrySellRequest. Request ID: ' || p_request.request_id || ' is fillable at market price');
      request_pkg.maketrades(p_request.stock_ex_id, p_request.stock_id);
      po_status := 'COMPLETED';
   ELSE
      FOR item IN (SELECT limit_price
                   FROM request
                   WHERE buy_sell = 'BUY'
                     AND stock_ex_id = p_request.stock_ex_id
                     AND stock_id = p_request.stock_id
                     AND status = 'ACTIVE'
                     AND limit_price < l_market_price
                     AND limit_price >= nvl(p_request.limit_price,0)
                   ORDER BY limit_price DESC) loop
         dbms_output.put_line('  TrySellRequest.  Request ID: ' || p_request.request_id || ' trying a lower price ' || item.limit_price);
         request_pkg.sellisfillable(
                   p_request,
                   item.limit_price, 
                   l_total_current, 
                   1, 
                   l_fillable);
         IF l_total_current = p_request.shares THEN
            EXIT;
         END IF;
      END LOOP;
      IF l_fillable THEN
         IF l_total_current = p_request.shares THEN
            dbms_output.put_line('  TrySellRequest.  Request ID: ' || p_request.request_id || ' is fillable. Shares: ' || p_request.shares || '. Min Shares: ' || p_request.minimum_shares || '. Shares Filled: ' || l_total_current );
            po_status := 'COMPLETED';
         ELSE
            dbms_output.put_line('  TrySellRequest.  Request ID: ' || p_request.request_id || ' is partially filled. Shares: ' || p_request.shares || '. Min Shares: ' || p_request.minimum_shares || '. Shares Filled: ' || l_total_current );
            po_status := 'PARTIAL FILL';
         END IF;
         request_pkg.maketrades(
                    p_request.stock_ex_id, p_request.stock_id);
         
      END IF;
   END IF;
ELSE
   dbms_output.put_line('  TrySellRequest.  Request ID: ' || p_request.request_id || ' is not active at current market price.');
END IF;
END;

PROCEDURE MakeTrades
 (
   p_stock_ex_id      IN stock_exchange.stock_ex_id%TYPE,
   p_stock_id         IN company.stock_id%TYPE
  )
AS
l_rowcount NUMBER(3);

BEGIN
   INSERT INTO trade
      (trade_id, stock_ex_id, stock_id, transaction_time,
       shares, share_price, price_total, buyer_id, seller_id,
       buy_request_id, sell_request_id)
   SELECT 
      trade_id_seq.nextval,
      p_stock_ex_id,
      p_stock_id,
      SYSDATE,
      trade_amount,
      share_price,
      price_total,
      buyer_id,
      seller_id,
      buy_request_id,
      sell_request_id
   FROM (SELECT 
          m.trade_amount,
          m.share_price,
          m.trade_amount * m.share_price AS price_total,
          m.buyer_id,
          m.seller_id,
          m.buy_request_id,
          m.sell_request_id
         FROM match m
         WHERE m.trade_made = 0
         ORDER BY m.match_id ASC)
   ;
   l_rowcount := SQL%ROWCOUNT;   
   dbms_output.put_line('  MakeTrades. Trades Generated: ' || l_rowcount);
   
   UPDATE request r
      SET shares_filled = (SELECT sum(trade_amount) 
                           FROM match
                           WHERE match.buy_request_id = r.request_id)
   WHERE r.request_id IN (SELECT buy_request_id FROM match);

   UPDATE request r
      SET shares_filled = (SELECT sum(trade_amount) 
                           FROM match
                           WHERE match.sell_request_id = r.request_id)
   WHERE r.request_id IN (SELECT sell_request_id FROM match);

   UPDATE match
     SET trade_made = 1;

   UPDATE request
     SET status = CASE 
                  WHEN shares_filled = shares
                       THEN 'COMPLETED'
                  ELSE 'PARTIAL FILL'
                  END
   WHERE status = 'ACTIVE'
     AND request_id IN 
            (SELECT buy_request_id FROM match
             UNION
             SELECT sell_request_id FROM match)
          ;
   INSERT INTO request
     (request_id,
      parent_request_id,
      shares_filled,
      shareholder_id,
      request_date,
      buy_sell,
      status,
      stock_ex_id,
      stock_id,
      shares,
      minimum_shares,
      time_in_force,
      limit_price,
      stop_price)
   SELECT
      request_id_seq.NEXTVAL,
      r.request_id,
      null,
      r.shareholder_id,
      r.request_date,
      r.buy_sell,
      'ACTIVE',
      r.stock_ex_id,
      r.stock_id,
      r.shares - r.shares_filled,
      1,
      r.time_in_force,
      r.limit_price,
      r.stop_price
   FROM request r
   WHERE r.status = 'PARTIAL FILL'
     AND r.time_in_force <> 'IMMEDIATE OR CANCEL'
     AND r.request_id IN 
         (SELECT buy_request_id FROM match
         UNION
         SELECT sell_request_id FROM match);
   l_rowcount := SQL%ROWCOUNT;   
   dbms_output.put_line('  MakeTrades. Child Requests Generated: ' || l_rowcount);
   
END;

PROCEDURE ProcessRequests
AS
CURSOR requests IS 
   SELECT * 
   FROM request
   WHERE status = 'ACTIVE'
   ORDER BY request_id
   FOR UPDATE;
l_r           requests%rowtype;
l_status      request.status%type;
l_match_count NUMBER(2);
BEGIN

   g_match_id := 1;
   
   OPEN requests;
   FETCH requests INTO l_r;
   WHILE requests%FOUND LOOP
      
      dbms_output.put_line('ProcessRequests. Start. Request ID: ' || l_r.request_id || ' Time in Force: ' || l_r.time_in_force);
      DELETE FROM match
      WHERE trade_made = 0;

      SELECT count(*) 
      INTO l_match_count
      FROM match
      WHERE buy_request_id = l_r.request_id
         OR sell_request_id = l_r.request_id;
         
      IF l_match_count = 0 THEN
         IF l_r.buy_sell = 'BUY' THEN
            request_pkg.TryBuyRequest (
               l_r,
               l_status);
         ELSE  
            request_pkg.TrySellRequest (
               l_r,
               l_status);
         END IF;
         IF l_r.time_in_force = 'IMMEDIATE OR CANCEL' 
               AND l_status = 'ACTIVE' THEN
            UPDATE request
            SET status = 'CANCELLED'
            WHERE CURRENT OF requests;
            l_status := 'CANCELLED';
         END IF;
         dbms_output.put_line('ProcessRequests. End. Request ID: ' || l_r.request_id || ' Time in Force: ' || l_r.time_in_force || ' Status: ' || l_status);
      ELSE
         dbms_output.put_line('ProcessRequests. End. Request ID: ' || l_r.request_id || ' already matched.');
      END IF;
      FETCH requests INTO l_r;
   END LOOP;
   CLOSE requests;
    
   COMMIT;
   
END;
      


END;  -- end of package body
/

show errors package body request_pkg;





