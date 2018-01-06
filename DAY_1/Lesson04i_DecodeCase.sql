/*
Objectives:

DECODE
CASE  - two forms of CASE statement

*/

-- DECODE
-- decode(var,if1,then1,if2,then2,if3,then3,else)

SELECT
  first_name         AS "decode input",
  decode(first_name,   
       'Bill','Hello Bill',
       'Alan','Hi Alan',
       'Bill','Hello Again Bill',
       'yeah whatever') AS "decode output"
from consultant;


-- Decode can take numbers and return text
-- Run with F9 or Run Statement to see the output in table format
SELECT 
   consultant_id                                      AS "numeric decode Input",
   decode(consultant_id, 1, 'a', 2,'b',consultant_id) AS "text decode output"
FROM consultant;


/******* CASE STATEMENTS  **********/
-- This is one version of a CASE statement
-- Between the word CASE and the first WHEN you place an input.
SELECT --distinct
  first_name       AS "case input",
  CASE first_name
     WHEN 'Bill' THEN 'Hello Bill'
     WHEN 'Alan' THEN 'Hi Alan'
     WHEN 'Bill' THEN 'Hello Again Bill'
     ELSE 'yeah whatever'
  END              AS "case output" 
from consultant;

-- This is the other version of a case statement.
-- There is no input between the word CASE and the first WHEN.
-- Each WHEN statement must return true or false.
select
  first_name,
  CASE 
     WHEN first_name = 'Bill'  AND last_name = 'Partridge' THEN 'Hello Bill P.'
     WHEN first_name = 'Alan' THEN 'Hi Alan'
     WHEN first_name = 'Bill' THEN 'Who are you?'
     ELSE 'yeah whatever'
  END AS "case output"
FROM consultant;

SELECT 
  consultant_id,
  client_id,
  pay,
  CASE 
     WHEN pay > 650 THEN 'High'
     WHEN pay >= 400 THEN 'Medium'
     ELSE 'Low'
  END as "Rate"
FROM assignment;


-- Case Used in an Update statement
UPDATE  consultant
 SET FIRST_NAME =  
         CASE UPPER(first_name)
            WHEN 'BILL' THEN 'William'
            WHEN 'ALAN' THEN 'Al'
            WHEN 'SIMON' THEN 'Scott'
         ELSE first_name
        END,
        last_name = 'Rumirez'
WHERE first_name IN ('Bill','Alan','Simon');

SELECT 
  consultant_id,
  first_name,
  last_name
FROM consultant;

ROLLBACK;

