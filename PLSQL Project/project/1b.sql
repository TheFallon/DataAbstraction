/*
1) Create Stock_History table
*/
CREATE TABLE stock_history (
  stock_ex_id NUMBER(6) NOT NULL CONSTRAINT stock_history_ex_FK REFERENCES stock_exchange(stock_ex_id),
  stock_id NUMBER(6) NOT NULL CONSTRAINT stock_history_id_FK REFERENCES company(stock_id),
  trading_date DATE NOT NULL,
  time_open DATE NOT NULL,
  time_close DATE NULL,
  open NUMBER (10,4) NULL,
  high NUMBER(10,4)NULL,
  low NUMBER (10,4) NULL,
  close NUMBER(10,4) NULL,
  volume NUMBER(12,4) NULL,
  CONSTRAINT stock_history_PK PRIMARY KEY (stock_ex_id, stock_id,time_open)
)
;

/*
2) Create OPEN_TRADING_DAY procedure
*/

CREATE OR REPLACE PROCEDURE open_trading_day



exec open_trading_day(