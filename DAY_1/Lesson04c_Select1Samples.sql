/*
Lesson Objectives:
==================
SELECT from a single table

Column Aliases

Filter rows to find NULL values
NVL - Substitute for null

ORDER BY

DISTINCT

SELECT FROM dual
*/


/*
Here is one of the most basic queries. 
*/
SELECT * 
FROM consultant ;

-- Show the specific columns from the table
SELECT 
   consultant_id, 
   first_name, 
   last_name, 
   birth_date
FROM consultant;





/*  Column ALIAS  */

-- If want to rename a column, you can supply an alias.

SELECT 
   consultant_id AS id,             -- id will come out as ID in the result
   first_name    AS "First Name",   -- double quotes allow spaces
   last_name     AS "LastName"      -- double quotes preserve case
FROM consultant;




/*  Filter rows to find NULL values */

-- NULL has a special meaning.  
-- It means "I don't know. I do not have an answer"


-- find consultant(s) who do not have a boss 
SELECT 
   consultant_id,
   first_name,
   last_name,
   boss_id
FROM consultant
WHERE boss_id IS NULL;


-- find consultant(s) who do have a boss
SELECT 
   consultant_id,
   first_name,
   last_name,
   boss_id
FROM consultant
WHERE boss_id IS NOT NULL;


-- this also finds consultants who do have a boss
SELECT 
   consultant_id,
   first_name,
   last_name,
   boss_id
FROM consultant
WHERE NOT boss_id IS NULL;



/*  NVL  */

-- The nvl function substitutes a different value for NULL


-- Replace a NULL string

-- If there is not comment, return "No comment given"
-- (To see the output formatted in a table, use Run Statement)
SELECT 
  assignment_id,
  comments,
  nvl(comments, 'No comment given')
FROM assignment;

-- Replace a NULL number
SELECT 
    consultant_id,
    first_name,
    last_name,
    boss_id,
    nvl(boss_id,0)  -- boss_id is numeric. The replacement must be numeric
FROM consultant;

-- However, if you convert to character first (nested inside the nvl) then 
-- the replacement can be string
SELECT 
    first_name,
    last_name,
    boss_id,
    nvl(to_char(boss_id),'N/A') AS "Boss ID"
FROM consultant;

    

/*  ORDER BY  */

/*  The only way to ensure that your result set is sorted the way you
    want is to use an ORDER BY clause.
*/
-- Show the first_name, last_name and birth_date for all consultants sorted.
SELECT 
   first_name, 
   last_name,
   birth_date
FROM consultant
ORDER BY last_name, first_name;



/*     DISTINCT  */
/*
   Default is to return all rows  
   If you do not specify DISTINCT then you will get ALL records
   including duplicated records
*/

-- Show all the rows
SELECT
   first_name
FROM consultant
ORDER BY first_name;

/*
DISTINCT
If you specify DISTINCT then the server will eliminate 
duplicate rows. 
*/
SELECT DISTINCT 
   first_name
FROM consultant
ORDER BY first_name;

SELECT DISTINCT 
   last_name
FROM consultant
ORDER BY last_name;

/*
DISTINCT is applied to the whole row (not just a single column)
*/
SELECT DISTINCT 
   first_name,
   last_name
FROM consultant
ORDER BY first_name;




/*  DUAL
--  Selecting from "Thin air"
--  You can use dual for testing bits of code.
*/

SELECT
  123 * 321
FROM dual;

-- SYSDATE is a system function that returns the date.
-- To use the function you must "select" it from "somewhere".
SELECT 
   SYSDATE  
FROM dual;

-- You can select constant values from dual
SELECT 
  'Hello', 
  1,  
  SYSDATE  
FROM dual;


-- You can use constants or functions in queries and they will simply 
-- repeat the information for each row that is returned from the table.   
SELECT 
   first_name, 
   'hello'   AS "Text", 
   1         AS "Number",   
   SYSDATE   AS "Date" 
FROM consultant;


