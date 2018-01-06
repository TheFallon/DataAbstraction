TRUNCATE TABLE trade;
DELETE FROM request;

DROP SEQUENCE request_id_seq;

CREATE SEQUENCE request_id_seq
START WITH 1
INCREMENT BY 1;


INSERT INTO request
(REQUEST_ID,SHAREHOLDER_ID,REQUEST_DATE,BUY_SELL,STOCK_EX_ID,STOCK_ID,
SHARES,MINIMUM_SHARES,TIME_IN_FORCE,LIMIT_PRICE,STOP_PRICE)
VALUES
(request_id_seq.NEXTVAL, 19,    SYSDATE,    'BUY',  7,        5,
1000, 1,               'DAY ONLY',  NULL,       null);

INSERT INTO request
(REQUEST_ID,SHAREHOLDER_ID,REQUEST_DATE,BUY_SELL,STOCK_EX_ID,STOCK_ID,
SHARES,MINIMUM_SHARES,TIME_IN_FORCE,LIMIT_PRICE,STOP_PRICE)
VALUES
(request_id_seq.NEXTVAL, 13,    SYSDATE,    'BUY',  7,        1,
5000, 1,               'DAY ONLY',  NULL,       NULL);

INSERT INTO request
(REQUEST_ID,SHAREHOLDER_ID,REQUEST_DATE,BUY_SELL,STOCK_EX_ID,STOCK_ID,
SHARES,MINIMUM_SHARES,TIME_IN_FORCE,LIMIT_PRICE,STOP_PRICE)
VALUES
(request_id_seq.NEXTVAL, 18,    SYSDATE,    'BUY',  7,        2,
1000, 1,               'DAY ONLY',  NULL,       NULL);


INSERT INTO request
(REQUEST_ID,SHAREHOLDER_ID,REQUEST_DATE,BUY_SELL,STOCK_EX_ID,STOCK_ID,
SHARES,MINIMUM_SHARES,TIME_IN_FORCE,LIMIT_PRICE,STOP_PRICE)
VALUES
(request_id_seq.NEXTVAL, 16,    SYSDATE,    'SELL',  7,        2,
1000, 1,               'DAY ONLY',  NULL,       NULL);

exec Request_Pkg.ProcessRequests;

SELECT * FROM request;
SELECT * FROM trade;

INSERT INTO request
(REQUEST_ID,SHAREHOLDER_ID,REQUEST_DATE,BUY_SELL,STOCK_EX_ID,STOCK_ID,
SHARES,MINIMUM_SHARES,TIME_IN_FORCE,LIMIT_PRICE,STOP_PRICE)
VALUES
(request_id_seq.NEXTVAL, 10,    SYSDATE,    'SELL',  7,        5,
500, 1,               'DAY ONLY',  NULL,       null);

INSERT INTO request
(REQUEST_ID,SHAREHOLDER_ID,REQUEST_DATE,BUY_SELL,STOCK_EX_ID,STOCK_ID,
SHARES,MINIMUM_SHARES,TIME_IN_FORCE,LIMIT_PRICE,STOP_PRICE)
VALUES
(request_id_seq.NEXTVAL, 10,    SYSDATE,    'SELL',  7,        1,
500, 1,               'DAY ONLY',  NULL,       NULL);

INSERT INTO request
(REQUEST_ID,SHAREHOLDER_ID,REQUEST_DATE,BUY_SELL,STOCK_EX_ID,STOCK_ID,
SHARES,MINIMUM_SHARES,TIME_IN_FORCE,LIMIT_PRICE,STOP_PRICE)
VALUES
(request_id_seq.NEXTVAL, 11,    SYSDATE,    'SELL',  7,        5,
500, 1,               'DAY ONLY',  NULL,       NULL);

exec Request_Pkg.ProcessRequests;
SELECT * FROM request;
SELECT * FROM trade;

INSERT INTO request
(REQUEST_ID,SHAREHOLDER_ID,REQUEST_DATE,BUY_SELL,STOCK_EX_ID,STOCK_ID,
SHARES,MINIMUM_SHARES,TIME_IN_FORCE,LIMIT_PRICE,STOP_PRICE)
VALUES
(request_id_seq.NEXTVAL, 12,    SYSDATE,    'SELL',  7,        1,
6000, 1,               'DAY ONLY',  NULL,       NULL);


INSERT INTO request
(REQUEST_ID,SHAREHOLDER_ID,REQUEST_DATE,BUY_SELL,STOCK_EX_ID,STOCK_ID,
SHARES,MINIMUM_SHARES,TIME_IN_FORCE,LIMIT_PRICE,STOP_PRICE)
VALUES
(request_id_seq.NEXTVAL, 19,    SYSDATE,    'BUY',  7,        1,
1000000, 1,               'DAY ONLY',  NULL,       NULL);

exec Request_Pkg.ProcessRequests;
SELECT * FROM request;
SELECT * FROM trade;

INSERT INTO request
(REQUEST_ID,SHAREHOLDER_ID,REQUEST_DATE,BUY_SELL,STOCK_EX_ID,STOCK_ID,
SHARES,MINIMUM_SHARES,TIME_IN_FORCE,LIMIT_PRICE,STOP_PRICE)
VALUES
(request_id_seq.NEXTVAL, 22,    SYSDATE,    'SELL',  7,        1,
50000, 1,               'DAY ONLY',      625.2,       NULL);

INSERT INTO request
(REQUEST_ID,SHAREHOLDER_ID,REQUEST_DATE,BUY_SELL,STOCK_EX_ID,STOCK_ID,
SHARES,MINIMUM_SHARES,TIME_IN_FORCE,LIMIT_PRICE,STOP_PRICE)
VALUES
(request_id_seq.NEXTVAL, 2,    SYSDATE,    'SELL',  7,        1,
60000, 1,               'DAY ONLY',      630.5,       NULL);

set serveroutput on;
exec Request_Pkg.ProcessRequests;
SELECT * FROM request;
SELECT * FROM trade;

INSERT INTO request
(REQUEST_ID,SHAREHOLDER_ID,REQUEST_DATE,BUY_SELL,STOCK_EX_ID,STOCK_ID,
SHARES,MINIMUM_SHARES,TIME_IN_FORCE,LIMIT_PRICE,STOP_PRICE)
VALUES
(request_id_seq.NEXTVAL, 18,    SYSDATE,    'SELL',  7,        1,
900000, 1,           'IMMEDIATE OR CANCEL', NULL,     NULL);


set serveroutput on;
exec Request_Pkg.ProcessRequests;
SELECT * FROM request;
SELECT * FROM trade;

