-- clean up old project
DROP TABLE trades CASCADE CONSTRAINTS;
DROP TABLE broker_stock_ex CASCADE CONSTRAINTS;
DROP TABLE shares_prices CASCADE CONSTRAINTS;
DROP TABLE shares CASCADE CONSTRAINTS;
DROP TABLE stock_exchanges CASCADE CONSTRAINTS;
DROP TABLE companies CASCADE CONSTRAINTS;
DROP TABLE brokers CASCADE CONSTRAINTS;
DROP TABLE currencies CASCADE CONSTRAINTS;
DROP TABLE places CASCADE CONSTRAINTS;
DROP TABLE shares_amount CASCADE CONSTRAINTS;
DROP SEQUENCE shares_amount_id_seq;
DROP TABLE share_holders CASCADE CONSTRAINTS;
DROP TABLE share_holder CASCADE CONSTRAINTS;
DROP TABLE share_holder_stock_ex CASCADE CONSTRAINTS;
DROP TABLE share_holder_shares CASCADE CONSTRAINTS;
DROP TABLE transaction_types CASCADE CONSTRAINTS;
DROP TABLE shares_issued CASCADE CONSTRAINTS;
DROP TABLE stock_price CASCADE CONSTRAINTS;
DROP SEQUENCE shares_amount_seq;
DROP PACKAGE request_pkg;
DROP PROCEDURE OPEN_TRADING_DAY;
DROP PROCEDURE CLOSE_TRADING_DAY;
DROP PROCEDURE INSERT_DIRECT_HOLDER;
DROP PROCEDURE INSERT_COMPANY;
DROP PROCEDURE DECLARE_STOCK;
DROP PROCEDURE LIST_STOCK;
DROP PROCEDURE STOCK_SPLIT;
DROP PROCEDURE REVERSE_SPLIT;


DROP SEQUENCE trade_id_seq;
DROP SEQUENCE request_id_seq;
   
DROP VIEW conversion;
DROP TABLE broker_stock_ex CASCADE CONSTRAINTS;
DROP TABLE trade CASCADE CONSTRAINTS;
DROP TABLE request CASCADE CONSTRAINTS;
DROP TABLE stock_listing CASCADE CONSTRAINTS;
DROP TABLE stock_exchange CASCADE CONSTRAINTS;
DROP TABLE shares_authorized CASCADE CONSTRAINTS;
DROP TABLE company CASCADE CONSTRAINTS;
DROP TABLE broker CASCADE CONSTRAINTS;
DROP TABLE conversion_rate CASCADE CONSTRAINTS;
DROP TABLE currency CASCADE CONSTRAINTS;
DROP TABLE place CASCADE CONSTRAINTS;

DROP TABLE direct_holder CASCADE CONSTRAINTS;
DROP TABLE shareholder CASCADE CONSTRAINTS;

CREATE TABLE place (
  place_id          NUMBER(6) NOT NULL,
  city              VARCHAR2(50) NOT NULL,
  country           VARCHAR2(50) NOT NULL,
  CONSTRAINT place_pk PRIMARY KEY (place_id)
);

CREATE TABLE currency (
  currency_id       NUMBER(6) NOT NULL,
  symbol            VARCHAR2(5) NOT NULL,
  name              VARCHAR2(50) NOT NULL,
  CONSTRAINT currency_pk PRIMARY KEY (currency_id),
  CONSTRAINT currency_name_uk UNIQUE (name),
  CONSTRAINT currency_symbol_uk UNIQUE (symbol)
);

CREATE TABLE conversion_rate
(from_currency_id  NUMBER(6) NOT NULL,
 to_currency_id    NUMBER(6) NOT NULL,
 exchange_rate     NUMBER(10,6) NOT NULL,
 PRIMARY KEY (from_currency_id, to_currency_id),
 CONSTRAINT conv_from_fk 
    FOREIGN KEY (from_currency_id) REFERENCES currency(currency_id),
 CONSTRAINT conv_to_fk 
    FOREIGN KEY (to_currency_id) REFERENCES currency(currency_id)
 );

CREATE or REPLACE VIEW conversion
AS 
   SELECT
     from_currency_id,
     to_currency_id,
     exchange_rate
   FROM conversion_rate
   UNION
   SELECT
    to_currency_id,
    from_currency_id,
    1/exchange_rate
   FROM conversion_rate
   WHERE to_currency_id != from_currency_id;

CREATE TABLE broker (
  broker_id         NUMBER(6) NOT NULL,
  first_name        VARCHAR2(25) NOT NULL,
  last_name         VARCHAR2(25) NOT NULL,
  CONSTRAINT broker_pk PRIMARY KEY (broker_id)
);

CREATE TABLE stock_exchange (
  stock_ex_id       NUMBER(6) NOT NULL,
  name              VARCHAR2(50) NOT NULL,
  symbol            VARCHAR2(10) NOT NULL,
  place_id          NUMBER(6) NOT NULL,
  currency_id       NUMBER(6) NOT NULL,
  CONSTRAINT stock_ex_pk PRIMARY KEY (stock_ex_id),
  CONSTRAINT se_place_fk FOREIGN KEY (place_id) REFERENCES place(place_id),
  CONSTRAINT se_currency_fk FOREIGN KEY (currency_id) REFERENCES currency(currency_id)
)
;
  
CREATE TABLE broker_stock_ex (
  broker_id         NUMBER(6) NOT NULL,
  stock_ex_id       NUMBER(6) NOT NULL,
  CONSTRAINT broker_stock_ex_pk PRIMARY KEY (broker_id, stock_ex_id),
  CONSTRAINT bse_broker_fk FOREIGN KEY (broker_id) REFERENCES broker(broker_id),
  CONSTRAINT bse_se_fk FOREIGN KEY (stock_ex_id) REFERENCES stock_exchange(stock_ex_id)
);


CREATE TABLE shareholder (
   shareholder_id NUMBER(6) NOT NULL,
   type            VARCHAR2(25) NOT NULL,
   CONSTRAINT shareholder_pk PRIMARY KEY (shareholder_id),
   CONSTRAINT sh_type_CK CHECK (type = 'Company' OR type = 'Direct_Holder')
);

CREATE TABLE company (
  company_id        NUMBER(6) NOT NULL,
  name              VARCHAR2(20) NOT NULL,
  place_id          NUMBER(6) NOT NULL,
  stock_id          NUMBER(6) NULL,
  starting_price    NUMBER(10,4) NULL,
  currency_id       NUMBER(6)    NULL,
  CONSTRAINT company_pk PRIMARY KEY (company_id),
  CONSTRAINT co_shareholder_fk FOREIGN KEY (company_id) REFERENCES shareholder(shareholder_id),
  CONSTRAINT co_place_fk       FOREIGN KEY (place_id) REFERENCES place(place_id),
  CONSTRAINT co_name_UK        UNIQUE (name),
  CONSTRAINT co_stock_uk       UNIQUE (stock_id),
  CONSTRAINT co_currency_FK FOREIGN KEY (currency_id)  REFERENCES currency(currency_id),
  CONSTRAINT co_public_CHK  CHECK ((stock_id IS NULL AND starting_price IS NULL AND CURRENCY_ID IS NULL)
                                   OR (stock_id IS NOT NULL AND starting_price IS NOT NULL AND currency_id IS NOT NULL))
);

CREATE TABLE direct_holder (
  direct_holder_id  NUMBER(6) NOT NULL,
  first_name        VARCHAR2(25) NOT NULL,
  last_name         VARCHAR2(25) NOT NULL,
  CONSTRAINT direct_holder_pk PRIMARY KEY (direct_holder_id),
  CONSTRAINT dh_shareholder_fk FOREIGN KEY (direct_holder_id) REFERENCES shareholder(shareholder_id)
);

CREATE TABLE shares_authorized (
  stock_id   NUMBER(6)   NOT NULL,
  time_start DATE        NOT NULL,
  time_end   DATE        NULL,
  authorized     NUMBER(12,4) NOT NULL,
  CONSTRAINT shares_authorized_PK PRIMARY KEY (stock_id, time_start),
  CONSTRAINT si_stock_FK FOREIGN KEY (stock_id)  REFERENCES company(stock_id)
);

CREATE TABLE stock_listing (
  stock_id NUMBER(6)   NOT NULL CONSTRAINT stocklist_stock_FK REFERENCES company(stock_id),
  stock_ex_id NUMBER(6)  NOT NULL CONSTRAINT stocklist_stockex_FK REFERENCES stock_exchange(stock_ex_id),
  stock_symbol  VARCHAR2(20)  NOT NULL,
  CONSTRAINT stock_listing_PK PRIMARY KEY (stock_id, stock_ex_id),
  CONSTRAINT stock_ex_symbol_uk  UNIQUE (stock_ex_id, stock_symbol)
);

CREATE TABLE request
(request_id NUMBER(5) CONSTRAINT request_pk PRIMARY KEY,
 parent_request_id NUMBER(5) NULL CONSTRAINT request_parent_FK REFERENCES request(request_id),
 shares_filled  NUMBER(7) NULL,
 shareholder_id NUMBER(6) 
    CONSTRAINT request_shareholder_fk 
    REFERENCES shareholder(shareholder_id) NOT NULL,
 request_date DATE NOT NULL,
 buy_sell VARCHAR2(4) 
    CONSTRAINT request_buy_sell_chk CHECK (buy_sell IN ('BUY','SELL')) NOT NULL,
 status VARCHAR2(20) 
    DEFAULT 'ACTIVE' 
    CONSTRAINT request_status_chk CHECK (status IN
       ('ACTIVE','PARTIAL FILL','COMPLETED','CANCELLED')) NOT NULL,
 stock_ex_id NUMBER(6) NOT NULL, 
 stock_id NUMBER(6) NOT NULL, 
 shares   NUMBER(7) NOT NULL,
 minimum_shares  NUMBER(7) DEFAULT 0 NOT NULL,
 CONSTRAINT min_shares_chk CHECK (minimum_shares <= shares),
 CONSTRAINT shares_filled_chk CHECK (shares_filled >= minimum_shares AND shares_filled <= shares),
 time_in_force VARCHAR2(20) 
    CONSTRAINT request_time_in_force CHECK (time_in_force IN
       ('DAY ONLY','GOOD UNTIL CANCELLED','IMMEDIATE OR CANCEL')) NOT NULL,
 limit_price NUMBER(10,4) NULL,
 stop_price  NUMBER(10,4) NULL,
 CONSTRAINT request_stock_fk 
    FOREIGN KEY (stock_ex_id, stock_id) 
    REFERENCES stock_listing(stock_ex_id, stock_id)
);

CREATE SEQUENCE request_id_seq
   INCREMENT BY 1
   START WITH 1
;

CREATE TABLE trade (
  trade_id          NUMBER(9) NOT NULL,
  stock_id          NUMBER(6) NOT NULL,
  transaction_time  DATE      NOT NULL,
  shares            NUMBER(12,4) NOT NULL,
  stock_ex_id       NUMBER(6) NULL,
  share_price       NUMBER(10,4) NULL,
  price_total       NUMBER(20,2) NULL,
  buyer_id          NUMBER(6) NULL,
  seller_id         NUMBER(6) NULL,
  buy_broker_id     NUMBER(6) NULL,
  sell_broker_id    NUMBER(6) NULL,
  buy_request_id    NUMBER(5) NULL,
  sell_request_id   NUMBER(5) NULL,
  CONSTRAINT trade_pk PRIMARY KEY (trade_id),
  CONSTRAINT trade_stock_ex_fk     FOREIGN KEY (stock_ex_id)     REFERENCES stock_exchange(stock_ex_id),
  CONSTRAINT trade_stock_fk        FOREIGN KEY (stock_id)        REFERENCES company(stock_id),
  CONSTRAINT trade_buyer_fk        FOREIGN KEY (buyer_id)        REFERENCES shareholder(shareholder_id),
  CONSTRAINT trade_seller_fk       FOREIGN KEY (seller_id)       REFERENCES shareholder(shareholder_id),
  CONSTRAINT trade_buy_broker_fk   FOREIGN KEY (buy_broker_id)   REFERENCES broker(broker_id),
  CONSTRAINT trade_sell_broker_fk  FOREIGN KEY (sell_broker_id)  REFERENCES broker(broker_id),
  CONSTRAINT trade_buy_request_fk  FOREIGN KEY (buy_request_id)  REFERENCES request(request_id),
  CONSTRAINT trade_sell_request_fk FOREIGN KEY (sell_request_id) REFERENCES request(request_id)
);

CREATE SEQUENCE trade_id_seq
   INCREMENT BY 1
   START WITH 1
;

INSERT INTO place (place_id,city,country) VALUES (1,'London','United Kingdom');
INSERT INTO place (place_id,city,country) VALUES (2,'Paris','France');
INSERT INTO place (place_id,city,country) VALUES (3,'New York','USA');
INSERT INTO place (place_id,city,country) VALUES (4,'Tokyo','Japan');
INSERT INTO place (place_id,city,country) VALUES (5,'Sydney','Australia');
INSERT INTO place (place_id,city,country) VALUES (6,'Moscow','Russia');

INSERT INTO currency (currency_id,symbol,name) VALUES (1,'$','Dollar');
INSERT INTO currency (currency_id,symbol,name) VALUES (2,'€','Euro');
INSERT INTO currency (currency_id,symbol,name) VALUES (3,'£','British Pound');
INSERT INTO currency (currency_id,symbol,name) VALUES (5,'¥','Yen');

-- dollar to dollar
INSERT INTO conversion_rate VALUES (1,1,1);
-- dollar to euro
INSERT INTO conversion_rate VALUES (1,2, 0.724737);
-- dollar to pound
INSERT INTO conversion_rate VALUES (1,3, 0.6221);
-- dollar to yen
INSERT INTO conversion_rate VALUES (1,5, 78.3800);

-- euro to euro
INSERT INTO conversion_rate VALUES (2,2,1);
-- euro to pound 
INSERT INTO conversion_rate VALUES (2, 3, 0.8061);
-- euro to yen 
INSERT INTO conversion_rate VALUES (2, 5, 101.5570);

-- pound to pound
INSERT INTO conversion_rate VALUES (3,3,1);
-- pound to yen
INSERT INTO conversion_rate VALUES (3, 5, 125.9880);

-- yen to yen
INSERT INTO conversion_rate VALUES (5,5,1);

INSERT INTO broker (broker_id,first_name,last_name) VALUES (1,'John','Smith');
INSERT INTO broker (broker_id,first_name,last_name) VALUES (2,'Herbert','Jackson');
INSERT INTO broker (broker_id,first_name,last_name) VALUES (3,'Richard','Bradley');
INSERT INTO broker (broker_id,first_name,last_name) VALUES (4,'Frank','Denzel');
INSERT INTO broker (broker_id,first_name,last_name) VALUES (5,'Elric','Crofton');
INSERT INTO broker (broker_id,first_name,last_name) VALUES (6,'Ted','Gore');
INSERT INTO broker (broker_id,first_name,last_name) VALUES (7,'John','Bush');
INSERT INTO broker (broker_id,first_name,last_name) VALUES (8,'Andre','Sinclair');
INSERT INTO broker (broker_id,first_name,last_name) VALUES (9,'Danielle','Perety');
INSERT INTO broker (broker_id,first_name,last_name) VALUES (10,'Arabella','Volvitz');
INSERT INTO broker (broker_id,first_name,last_name) VALUES (11,'Parker','Hamilton');
INSERT INTO broker (broker_id,first_name,last_name) VALUES (12,'Andrew','Wallace');
INSERT INTO broker (broker_id,first_name,last_name) VALUES (13,'Bruce','Smith');
INSERT INTO broker (broker_id,first_name,last_name) VALUES (14,'Tommy','Mack');
INSERT INTO broker (broker_id,first_name,last_name) VALUES (15,'Frederick','Raven');

INSERT INTO shareholder (shareholder_id, type) VALUES (1,'Company');
INSERT INTO shareholder (shareholder_id, type) VALUES (2,'Company');
INSERT INTO shareholder (shareholder_id, type) VALUES (3,'Company');
INSERT INTO shareholder (shareholder_id, type) VALUES (4,'Company');
INSERT INTO shareholder (shareholder_id, type) VALUES (5,'Company');
INSERT INTO shareholder (shareholder_id, type) VALUES (6,'Company');
INSERT INTO shareholder (shareholder_id, type) VALUES (7,'Company');
INSERT INTO shareholder (shareholder_id, type) VALUES (8,'Company');
INSERT INTO shareholder (shareholder_id, type) VALUES (9,'Company');

INSERT INTO company (company_id,name,place_id,stock_id,starting_price,currency_id) VALUES (1,'British Airways',1,   2,12.13,3);
INSERT INTO company (company_id,NAME,place_id,stock_id,starting_price,currency_id) VALUES (2,'The New York Times',3,3,24.26,1);
INSERT INTO company (company_id,NAME,place_id,stock_id,starting_price,currency_id) VALUES (3,'Toyota Motors',3,     4,85.06,1);
INSERT INTO company (company_id,NAME,place_id,stock_id,starting_price,currency_id) VALUES (4,'BNP Paribas',2,       5,56.56,2);
INSERT INTO company (company_id,NAME,place_id,stock_id,starting_price,currency_id) VALUES (5,'EDF',2,               6,41.76,2);
INSERT INTO company (company_id,NAME,place_id,stock_id,starting_price,currency_id) VALUES (6,'Tesco',1,             7,427.7,1);
INSERT INTO company (company_id,NAME,place_id,stock_id,starting_price,currency_id) VALUES (7,'IBM',1,               8,342.5,1);
INSERT INTO company (company_id,name,place_id,stock_id,starting_price,currency_id) VALUES (8,'Google',3,            1,619.4,1);
INSERT INTO company (company_id,name,place_id,stock_id) VALUES (9,'Castlemaine',5, null);

INSERT INTO shareholder(shareholder_id, type) VALUES (10,'Direct_Holder');
INSERT INTO shareholder(shareholder_id, type) VALUES (11,'Direct_Holder');
INSERT INTO shareholder(shareholder_id, type) VALUES (12,'Direct_Holder');
INSERT INTO shareholder(shareholder_id, type) VALUES (13,'Direct_Holder');
INSERT INTO shareholder(shareholder_id, type) VALUES (14,'Direct_Holder');
INSERT INTO shareholder(shareholder_id, type) VALUES (15,'Direct_Holder');
INSERT INTO shareholder(shareholder_id, type) VALUES (16,'Direct_Holder');
INSERT INTO shareholder(shareholder_id, type) VALUES (17,'Direct_Holder');
INSERT INTO shareholder(shareholder_id, type) VALUES (18,'Direct_Holder');
INSERT INTO shareholder(shareholder_id, type) VALUES (19,'Direct_Holder');

INSERT INTO direct_holder(direct_holder_id,first_name,last_name) VALUES (10,'Elliot','Wilson');
INSERT INTO direct_holder(direct_holder_id,first_name,last_name) VALUES (11,'David','Richards');
INSERT INTO direct_holder(direct_holder_id,first_name,last_name) VALUES (12,'Jacob','Nash');
INSERT INTO direct_holder(direct_holder_id,first_name,last_name) VALUES (13,'Patricia','Olives');
INSERT INTO direct_holder(direct_holder_id,first_name,last_name) VALUES (14,'Anthony','Johnson');
INSERT INTO direct_holder(direct_holder_id,first_name,last_name) VALUES (15,'Jack','Elinson');
INSERT INTO direct_holder(direct_holder_id,first_name,last_name) VALUES (16,'Samual','Andrews');
INSERT INTO direct_holder(direct_holder_id,first_name,last_name) VALUES (17,'Christopher','Nichols');
INSERT INTO direct_holder(direct_holder_id,first_name,last_name) VALUES (18,'Janet','Anne');
INSERT INTO direct_holder(direct_holder_id,first_name,last_name) VALUES (19,'Frank','Vernon');

INSERT INTO shareholder (shareholder_id, type) VALUES (20,'Company');
INSERT INTO shareholder (shareholder_id, type) VALUES (21,'Company');
INSERT INTO shareholder (shareholder_id, type) VALUES (22,'Company');
INSERT INTO shareholder (shareholder_id, type) VALUES (23,'Company');
INSERT INTO shareholder (shareholder_id, type) VALUES (24,'Company');
INSERT INTO shareholder (shareholder_id, type) VALUES (25,'Company');

INSERT INTO company (company_id,NAME,place_id, stock_id) VALUES (20,'Barclays',1,NULL);
INSERT INTO company (company_id,NAME,place_id, stock_id) VALUES (21,'UBS',3,NULL);
INSERT INTO company (company_id,NAME,place_id, stock_id) VALUES (22,'Credit Suisse',3,NULL);
INSERT INTO company (company_id,NAME,place_id, stock_id) VALUES (23,'RBC',2,NULL);
INSERT INTO company (company_id,NAME,place_id, stock_id) VALUES (24,'RBS',2,NULL);
INSERT INTO company (company_id,NAME,place_id, stock_id) VALUES (25,'Bank of America',1,NULL);



INSERT INTO stock_exchange (stock_ex_id,name,symbol,place_id,currency_id) VALUES (1,'London Stock Exchange','LSE',1, 3);
INSERT INTO stock_exchange (stock_ex_id,name,symbol,place_id,currency_id) VALUES (2,'Euronext Paris','EP', 2, 2);
INSERT INTO stock_exchange (stock_ex_id,name,symbol,place_id,currency_id) VALUES (3,'New York Stock Exchange','NYSE',3, 1);
INSERT INTO stock_exchange (stock_ex_id,name,symbol,place_id,currency_id) VALUES (4,'Tokyo Stock Exchange','TSE',4, 5);
INSERT INTO stock_exchange (stock_ex_id,name,symbol,place_id,currency_id) VALUES (5,'Moscow Stock Exchange','MSE',6, 2);
INSERT INTO stock_exchange (stock_ex_id,NAME,symbol,place_id,currency_id) VALUES (6,'NASDAQ Stock Exchange','NASDAQ',3, 1);
INSERT INTO stock_exchange (stock_ex_id,NAME,symbol,place_id,currency_id) VALUES (7,'Another Friendly Exchange','AFE',3, 1);

INSERT INTO stock_listing(stock_id, stock_ex_id, stock_symbol) VALUES (1,3,'GOOG');
INSERT INTO stock_listing(stock_id, stock_ex_id, stock_symbol) VALUES (2,1,'BA');
INSERT INTO stock_listing(stock_id, stock_ex_id, stock_symbol) VALUES (3,3,'NYT');
INSERT INTO stock_listing(stock_id, stock_ex_id, stock_symbol) VALUES (4,3,'TM');
INSERT INTO stock_listing(stock_id, stock_ex_id, stock_symbol) VALUES (4,4,'TYO:6201');
INSERT INTO stock_listing(stock_id, stock_ex_id, stock_symbol) VALUES (5,2,'BNP');
INSERT INTO stock_listing(stock_id, stock_ex_id, stock_symbol) VALUES (6,2,'EDF:EN PARIS');
INSERT INTO stock_listing(stock_id, stock_ex_id, stock_symbol) VALUES (7,6,'TESO');
INSERT INTO stock_listing(stock_id, stock_ex_id, stock_symbol) VALUES (8,3,'IBM');

INSERT INTO stock_listing(stock_id, stock_ex_id, stock_symbol) VALUES (1,7,'GOOG:1');
INSERT INTO stock_listing(stock_id, stock_ex_id, stock_symbol) VALUES (2,7,'BA:1');
INSERT INTO stock_listing(stock_id, stock_ex_id, stock_symbol) VALUES (3,7,'NYT:1');
INSERT INTO stock_listing(stock_id, stock_ex_id, stock_symbol) VALUES (4,7,'TM:1');
INSERT INTO stock_listing(stock_id, stock_ex_id, stock_symbol) VALUES (5,7,'BNP:1');
INSERT INTO stock_listing(stock_id, stock_ex_id, stock_symbol) VALUES (6,7,'EDF:1');
INSERT INTO stock_listing(stock_id, stock_ex_id, stock_symbol) VALUES (8,7,'IBM:1');

INSERT INTO broker_stock_ex (broker_id,stock_ex_id) VALUES (1,1);
INSERT INTO broker_stock_ex (broker_id,stock_ex_id) VALUES (3,1);
INSERT INTO broker_stock_ex (broker_id,stock_ex_id) VALUES (9,1);
INSERT INTO broker_stock_ex (broker_id,stock_ex_id) VALUES (10,1);
INSERT INTO broker_stock_ex (broker_id,stock_ex_id) VALUES (12,1);
INSERT INTO broker_stock_ex (broker_id,stock_ex_id) VALUES (1,2);
INSERT INTO broker_stock_ex (broker_id,stock_ex_id) VALUES (2,2);
INSERT INTO broker_stock_ex (broker_id,stock_ex_id) VALUES (6,2);
INSERT INTO broker_stock_ex (broker_id,stock_ex_id) VALUES (7,2);
INSERT INTO broker_stock_ex (broker_id,stock_ex_id) VALUES (11,2);
INSERT INTO broker_stock_ex (broker_id,stock_ex_id) VALUES (13,2);
INSERT INTO broker_stock_ex (broker_id,stock_ex_id) VALUES (15,2);
INSERT INTO broker_stock_ex (broker_id,stock_ex_id) VALUES (1,3);
INSERT INTO broker_stock_ex (broker_id,stock_ex_id) VALUES (5,3);
INSERT INTO broker_stock_ex (broker_id,stock_ex_id) VALUES (8,3);
INSERT INTO broker_stock_ex (broker_id,stock_ex_id) VALUES (12,3);
INSERT INTO broker_stock_ex (broker_id,stock_ex_id) VALUES (14,3);
INSERT INTO broker_stock_ex (broker_id,stock_ex_id) VALUES (15,3);
INSERT INTO broker_stock_ex (broker_id,stock_ex_id) VALUES (1,4);
INSERT INTO broker_stock_ex (broker_id,stock_ex_id) VALUES (4,4);
INSERT INTO broker_stock_ex (broker_id,stock_ex_id) VALUES (11,4);
INSERT INTO broker_stock_ex (broker_id,stock_ex_id) VALUES (13,4);
INSERT INTO broker_stock_ex (broker_id,stock_ex_id) VALUES (14,4);
INSERT INTO broker_stock_ex (broker_id,stock_ex_id) VALUES (15,4);
INSERT INTO broker_stock_ex (broker_id,stock_ex_id) VALUES (13,6);
INSERT INTO broker_stock_ex (broker_id,stock_ex_id) VALUES (14,6);
INSERT INTO broker_stock_ex (broker_id,stock_ex_id) VALUES (15,6);


-- Authorizations
INSERT INTO shares_authorized (stock_id, time_start, time_end, authorized) 
                        VALUES (1,SYSDATE-190,NULL,4500000);

INSERT INTO shares_authorized (stock_id, time_start, time_end, authorized) 
                        VALUES (2,SYSDATE-190,NULL,2000000);

INSERT INTO shares_authorized (stock_id, time_start, time_end, authorized) 
                        VALUES (3,SYSDATE-195,NULL,500000);

INSERT INTO shares_authorized (stock_id, time_start, time_end, authorized) 
                        VALUES (3,SYSDATE-190,NULL, 1000000);
--  Stock Split
UPDATE shares_authorized si
  SET time_end = (SELECT MIN(sub.time_start) -  INTERVAL '0 00:00:01' DAY TO SECOND
                  FROM shares_authorized sub
                  WHERE sub.stock_id = si.stock_id
                    AND sub.time_start > si.time_start)
WHERE si.stock_id = 3
 AND time_end IS NULL;
 

INSERT INTO shares_authorized (stock_id, time_start, time_end, authorized) 
                        VALUES (4,SYSDATE-175,NULL,130000);

INSERT INTO shares_authorized (stock_id, time_start, time_end, authorized) 
                        VALUES (5,SYSDATE-180,NULL,6000);

INSERT INTO shares_authorized (stock_id, time_start, time_end, authorized) 
                        VALUES (6,SYSDATE-190,NULL,575000);

INSERT INTO shares_authorized (stock_id, time_start, time_end, authorized) 
                        VALUES (7,SYSDATE-190,NULL,3200000);


COMMIT;

-- TABLE STATISTICS
DECLARE
 l_schema VARCHAR2(30);
BEGIN
  SELECT 
     sys_context( 'userenv', 'current_schema' ) 
  INTO l_schema
  FROM dual;

  DBMS_STATS.GATHER_TABLE_STATS(l_schema,'TRADE');
  DBMS_STATS.GATHER_TABLE_STATS(l_schema,'BROKER_STOCK_EX');
  DBMS_STATS.GATHER_TABLE_STATS(l_schema,'STOCK_LISTING');
  DBMS_STATS.GATHER_TABLE_STATS(l_schema,'STOCK_EXCHANGE');
  DBMS_STATS.GATHER_TABLE_STATS(l_schema,'COMPANY');
  DBMS_STATS.GATHER_TABLE_STATS(l_schema,'BROKER');
  DBMS_STATS.GATHER_TABLE_STATS(l_schema,'CURRENCY');
  DBMS_STATS.GATHER_TABLE_STATS(l_schema,'CONVERSION_RATE');
  DBMS_STATS.GATHER_TABLE_STATS(l_schema,'PLACE');
  DBMS_STATS.GATHER_TABLE_STATS(l_schema,'SHARES_AUTHORIZED');
  DBMS_STATS.GATHER_TABLE_STATS(l_schema,'DIRECT_HOLDER');
  DBMS_STATS.GATHER_TABLE_STATS(l_schema,'shareholder');

END;
/
