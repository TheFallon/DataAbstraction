/*
Cursors:
A cursor is a control structure allows you to step through a result set one row at a time.

Objectives:

Implicit Cursor - SELECT INTO

FOR LOOP on an implicit cursor
FOR LOOP on an explicitly defined cursor

OPEN, FETCH, CLOSE on an explicitly defined cursor
*/

SET serveroutput on
DECLARE
   l_consultant_id consultant.consultant_id%type;
BEGIN
   -- implicit cursor
   SELECT 
      consultant_id
   INTO l_consultant_id
   FROM consultant
   WHERE first_name = 'Bill'
    AND last_name = 'Partridge'
   ;
   DBMS_OUTPUT.PUT_LINE(l_consultant_id);
END;
/

-- Good Old SQL
-- A SELECT statement gives you 
-- a result set that contains one or more rows
SELECT
  consultant_id || ' ' || first_name
FROM consultant
ORDER BY first_name;

-- A cursor allows you to handle rows in a result set
-- one row at a time.
SET serveroutput on
BEGIN
                -- implicit cursor 
   FOR item IN (SELECT consultant_id, first_name 
                FROM consultant
                ORDER BY first_name) LOOP
        DBMS_OUTPUT.PUT_LINE(item.consultant_id || ' ' || item.first_name);
  END LOOP ;
END;
/

SET serveroutput on
DECLARE
  -- explicit cursor
  CURSOR c IS SELECT consultant_id, last_name
               FROM consultant
               ORDER BY last_name;
BEGIN
   FOR item IN c LOOP
        DBMS_OUTPUT.PUT_LINE(item.consultant_id || ' ' || item.last_name);
   END LOOP;
END;
/

-- Explicit OPEN, FETCH, %FOUND, CLOSE
-- Fetching columns into scalar variables (simple variables)
SET serveroutput on
DECLARE
  CURSOR c IS SELECT consultant_id,
                      last_name || ', ' || first_name 
               FROM consultant;
  l_id NUMBER(2);
  l_name VARCHAR2(50);
BEGIN
  OPEN c;
  FETCH c INTO l_id, l_name;
  WHILE c%FOUND LOOP
        DBMS_OUTPUT.PUT_LINE(' ID: ' || l_id || ' Name: ' || l_name);
        FETCH c INTO l_id, l_name;
  END LOOP;
  CLOSE c;
END;
/

/*
Fetching columns into a complex datatype.  
*/
SET SERVEROUTPUT ON;
DECLARE 
  CURSOR cur_Result IS
   SELECT 
    p.city,
    p.country,
    co.name AS company_name
   FROM place p
     JOIN company co
      ON co.place_id = p.place_id
   WHERE city = 'London';
   
  -- declare a variable to hold the output of the cursor 
  l_record cur_Result%rowtype;
BEGIN
   OPEN cur_Result;
   FETCH cur_Result INTO l_record;
   WHILE cur_Result%Found LOOP
      dbms_output.put_line(l_record.city || ' ' || l_record.company_name);
      FETCH cur_Result INTO l_record;
   END LOOP;
        
  CLOSE cur_Result;
END;
/

/*
Exercise 1:
Write a good old SQL SELECT statement which returns
trade_id, buyer_id, seller_id and shares
*/

/*
Exercise 2:
Convert the query above to a PL/SQL block which explicitly declares a 
CURSOR and uses OPEN, FETCH, %FOUND, and CLOSE to retrieve the rows.
Use DBMS_OUTPUT.PUT_LINE to display the values.
*/















