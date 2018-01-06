/*  PL/SQL Functions

Lesson Objectives:
Create Functions
Call Functions

*/

/*
  Functions do not perform inserts, updates and deletes.  Functions take input 
  parameters, can look up values in tables, perform calculations and return 
  results.

  Procedures *DO* things.  That is, they perform actions such as
  inserts update and deletes but procedures do not return result sets.
  
*/

/* The following example is intended to show the syntax to create a
function.  The function looks up a value in a table, performs
some manipulations and returns a result. */

-- Return a street name without the "Avenue", "Street" or "Road" etc.
CREATE OR REPLACE FUNCTION get_street_name (
  p_address_id IN address.address_id%type) RETURN address.street%type
AS
  -- Declare local variables
  l_street address.street%type;
BEGIN
  SELECT street
  INTO l_street
  FROM address
  WHERE address_id = p_address_id;
  
  l_street := SUBSTR(l_street, 1, INSTR(l_street,' ')-1);
  RETURN l_street;  
END;
/

show errors function get_street_name; 

-- To call the function
SELECT get_street_name(2)
FROM dual;


SELECT 
  consultant_id,
  first_name,
  last_name,
  get_street_name(address_id)
FROM consultant;
