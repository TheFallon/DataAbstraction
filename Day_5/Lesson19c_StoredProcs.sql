/*  PL/SQL Procedures

Lesson Objectives:
How to create procedures
How to call procedures
*/

/*  Stored Procedures
The purpose of procedures is to DO things such as INSERT, UPDATE and DELETE,
but this first example simply uses PUT_LINE to display a message.
*/

CREATE OR REPLACE PROCEDURE HelloWorld AS
BEGIN
  DBMS_OUTPUT.PUT_LINE('Hello World!');
END;
/
SHOW ERROR PROCEDURE HelloWorld;


/* To execute a procedure outside of a PL/SQL
   block use the exec command */
SET SERVEROUTPUT ON;
EXEC HelloWorld;

-- This is a PL/SQL block
SET SERVEROUTPUT ON;
BEGIN
  HelloWorld();
  HelloWorld;
END;
/

-- INPUT PARAMETERS
/* The FDM Standard taught in the PL/SQL Course is give parameters names
that start with p_   This help distinguish parameters from local variables
and columns. */

--  Here is an example of a procedure that performs a money transfer
CREATE OR REPLACE PROCEDURE transfer 
  (p_from_account IN accounts.accountno%TYPE,  -- can use datatype from table
   p_to_account IN accounts.accountno%TYPE,
   p_transfer_amount IN NUMBER)                -- can use datatype without size
AS
BEGIN
  UPDATE accounts
   SET balance = balance - p_transfer_amount
  WHERE accountno = p_from_account;
  
  UPDATE accounts
    SET balance = balance + p_transfer_amount
  WHERE accountno = p_to_account;
  
  COMMIT;
END;
/
show errors PROCEDURE transfer;   

INSERT INTO accounts VALUES (2,100);
SELECT * FROM accounts;
exec transfer(2,1,25);

/* -- Ampersand Variables
When you use an Ampersand variable, Oracle will prompt for input.
When input is done, Oracle will rewrite the call to include the values
that were entered and then execute the command.
*/
SELECT 
 first_name,
 last_name
FROM consultant
WHERE consultant_id = &id;

exec transfer(&from_account,&to_account,&amount_to_transfer);


/*
A procedure to insert a new broker.
We could and should use a sequence to generate ID
numbers.  
*/

CREATE OR REPLACE PROCEDURE insert_broker (
  p_first_name IN broker.first_name%type,
  p_last_name IN broker.last_name%type)
AS
  -- Declare local variables
  l_broker_id NUMBER(6,2) NULL;
BEGIN
  SELECT MAX(broker_id)
  INTO l_broker_id
  FROM broker;
  
  -- Example of IF statement
  IF l_broker_id IS NULL THEN
     l_broker_id := 1;
  ELSE
     l_broker_id := l_broker_id + 1;
  END IF;
  
  INSERT INTO broker (broker_id, first_name, last_name)
  VALUES (l_broker_id, p_first_name, p_last_name);
  
  COMMIT;
END;
/

show errors procedure insert_broker; 


SELECT * FROM broker;

-- To call the procedure
EXEC insert_broker('Joe','Duff');

EXEC insert_broker('Jane','Duff');

-- Ampersand Variables - Lets you write what you want into the query.
EXEC insert_broker('&first_name','&last_name');


-- Check on the new brokers
SELECT 
   broker_id,
   first_name,
   last_name
FROM broker;


/* In Class exercise:   Rewrite the INSERT_BROKER procedure to use
a sequence object rather than SELECT MAX(broker_id) INTO a local
variable.

Your procedure must assume that the sequence object already exists 
and will provide a correct number for the next broker_id.

Be sure to test your procedure */ 





