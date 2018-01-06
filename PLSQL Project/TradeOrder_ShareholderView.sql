

CREATE OR REPLACE VIEW shareholder_view
  (shareholder_id, type, first_name, last_name, company_name, place_id, stock_id)
AS
   SELECT 
      s.shareholder_id,
      s.TYPE,
      d.first_name,
      d.last_name,
      NULL AS company_name,
      NULL AS place_id,
      NULL AS stock_id
   FROM shareholder s
     INNER JOIN direct_holder d
     ON s.shareholder_id = d.direct_holder_id
  UNION ALL
     SELECT 
      s.shareholder_id,
      s.type,
      NULL,
      NULL,
      c.NAME,
      c.place_id,
      c.stock_id
   FROM shareholder s
     INNER JOIN company c
       ON c.company_id = s.shareholder_id
;

DESC company; 
desc direct_holder;
    
SELECT * FROM shareholder_view;

DELETE FROM shareholder_view
WHERE shareholder_id = 10;

SELECT * FROM direct_holder;

DROP SEQUENCE shareholder_seq;

CREATE SEQUENCE shareholder_seq
  START WITH 20
  INCREMENT BY 1;
  
show errors TRIGGER shareholder_instead;


CREATE OR REPLACE TRIGGER shareholder_INSTEAD
   INSTEAD OF INSERT OR UPDATE OR DELETE
   ON shareholder_view
   FOR EACH ROW
DECLARE
   l_shareholder_id shareholder.shareholder_id%TYPE;
BEGIN
CASE
WHEN UPDATING THEN
   IF :NEW.TYPE = 'Company' THEN
      UPDATE company
      SET NAME = :NEW.company_name,
          place_id = :NEW.place_id,
          stock_id = :NEW.stock_id
      WHERE company_id = :OLD.shareholder_id;
  ELSE
      UPDATE direct_holder
      SET first_name = :NEW.first_name,
          last_name = :NEW.last_name
      WHERE direct_holder_id = :OLD.shareholder_id;
  END IF;
WHEN DELETING THEN
   IF :OLD.TYPE = 'Company' THEN
      DELETE FROM company
      WHERE company_id = :OLD.shareholder_id;
  ELSE
      DELETE FROM direct_holder
      WHERE direct_holder_id = :OLD.shareholder_id;
  END IF;
  DELETE FROM shareholder
  WHERE shareholder_id = :OLD.shareholder_id;

WHEN INSERTING THEN
   l_shareholder_id := shareholder_seq.nextval();
   INSERT INTO shareholder (shareholder_id, TYPE)
   VALUES (l_shareholder_id,:NEW.type);
   IF :NEW.TYPE = 'Company' THEN
      INSERT INTO company (company_id, NAME, place_id, stock_id)
      VALUES (l_shareholder_id, 
              :NEW.company_name, 
              :NEW.place_id, 
              :NEW.stock_id);
  ELSE
      INSERT INTO direct_holder (direct_holder_id, first_name, last_name)
      VALUES (l_shareholder_id, 
              :NEW.first_name, 
              :NEW.last_name);
  END IF;
END CASE;
END;
/

SELECT * FROM shareholder_view;
INSERT INTO shareholder_view (TYPE, first_name, last_name)
VALUES ('Direct_Holder','Andy','Adams');

UPDATE shareholder_view
  SET first_name = 'Joe'
WHERE shareholder_id = 20;

DELETE FROM shareholder_view
WHERE shareholder_id = 20;

SELECT * FROM direct_holder;
select * from shareholder;

INSERT INTO shareholder_view (TYPE, company_name, place_id,stock_id)
VALUES ('Company','Scotco',1,null);

UPDATE shareholder_view
  SET place_id = 2
WHERE shareholder_id = 21;

DELETE FROM shareholder_view
WHERE shareholder_id = 21;

SELECT * FROM company;
select * from shareholder;
