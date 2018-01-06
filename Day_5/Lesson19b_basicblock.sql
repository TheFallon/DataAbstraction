/*  PL/SQL Basic Block 

[ DECLARE ]  -- declare local variables (optional)
BEGIN

END;
/

*/

-- SETUP accounts for a Money Transfer
DROP TABLE accounts CASCADE CONSTRAINTS;

CREATE TABLE accounts
  (accountno number(4) PRIMARY KEY,
   balance   number(6,2));

INSERT INTO accounts VALUES (1, 100);
INSERT INTO accounts VALUES (2, 0);
COMMIT;

SELECT 
  accountno,
  balance
FROM accounts;


-- PL/SQL block - Money Transfer

/*  The FDM Standard taught in the PL/SQL course is local variables should
    have names that begin with "l_"    This helps distinguish local variables
    from column names.
*/


DECLARE
  l_transfer_amount NUMBER(6,2);   -- must provide a datatype
BEGIN
  l_transfer_amount := 50;  -- Must use := in PL/SQL

  UPDATE accounts
    SET balance = balance - l_transfer_amount    -- Do not use ":="
  WHERE accountno = 1;      
                            
  UPDATE accounts
    SET balance = balance + l_transfer_amount
  WHERE accountno = 2;

  COMMIT;
END;
/

-- Check on the transfer
SELECT 
   accountno,
   balance
FROM accounts;


/********* Optional Extra Info   ***********/

/* Many trainees have asked whether a CREATE SEQUENCE statement could use a
   subquery to determine the starting value instead of hardcoding the 
   starting value.  Unfortunately, a subquery cannot be used.
   But, this task can be accomplished using EXECUTE IMMEDIATE. 

   EXECUTE IMMEDIATE takes a string as its input and executes it as
   a command.  

   In the following example we are going to build a string 
   that will create a sequence and then we will execute the string.  */


DECLARE 
  l_next_id NUMBER(6);
BEGIN
  EXECUTE IMMEDIATE 'DROP SEQUENCE broker_id_seq';
 
  SELECT MAX(broker_id)
      INTO l_next_id
  FROM broker;

  IF l_next_id IS NULL THEN
     l_next_id := 1;
  ELSE
     l_next_id := l_next_id + 1;
  END IF;
 
  EXECUTE IMMEDIATE
     'CREATE SEQUENCE broker_id_seq INCREMENT BY 1 START WITH ' || to_char(l_next_id,'999');
END;
/

SELECT 
   MAX(broker_id) 
FROM broker;


-- This will fail.  You cannot call currval until after nextval has been run.
SELECT
  broker_id_seq.currval
FROM dual;

-- Run nextval just to see the number.
-- (Of course this will lose the ID number but this is just a demo)
SELECT
  broker_id_seq.nextval
FROM dual;




