/* Basic Block Exercises */

/* 1  -
In the consultant schema, 'Vernon Schillinger' and 'Simon Adebisi' are going
to temporarily switch houses.  Although this could be accomplished with
SQL, please write the changes into a PL/SQL block. The outline given below is 
meant to help you get started.
*/
DECLARE
  l_vernon_address_id ADDRESS.ADDRESS_ID%TYPE;
  l_simon_address_id  ADDRESS.ADDRESS_ID%TYPE;
BEGIN
  null;     -- remove this when you get some code written below
  -- SELECT Vernon's address_id INTO l_vernon_address
  
  -- SELECT Simon's address_id INTO l_simon_address_id
  
  -- UPDATE Vernon's address to set it to Simon's address
  
  -- UPDATE Simon's address to set it to Vernon's address
END;
/

/******  Procedure Exercises  ********/
/* 1 - Delete an assignment
Although this could be accomplished using SQL, write a procedure
that will delete an assignment
*/
CREATE OR REPLACE PROCEDURE delete_assignment 
  (p_assignment_id IN ASSIGNMENT.ASSIGNMENT_ID%TYPE)
AS
BEGIN
   -- Delete the assignment
END;
/


/*
2 - Retire a Consultant

Write a procedure that will retire a consultant.  The procedure
should take a consultant_id as in input parameter.

When a consultant retires, we need to perform a few actions:
(1) All of the consultants records need to be archived.  The record
from the consultant table needs to be copied to a 'consultant_archive'
table, and all his or her assignments must be copied to 'assignment_archive'.
Use:   INSERT INTO consultant_archive SELECT ...  for the consultant
and    INSERT INTO assignment_archive SELECT ...  for the assigment records
Remember to set the retirement date in the archive tables.

(2) If the consultant was a boss, all of his or her direct reports must be
reassigned to the consultant's boss (thus they receive a promotion).
Step 1:  Use "SELECT boss_id INTO l_boss_id FROM ..."
to get the boss_id of the person who is retiring.
Step 2:  Use:  UPDATE consultant
                 SET boss_id = l_boss_id
               WHERE ...
to update the people who are currently reporting to the person who
is retiring.


(3) All the consultant table records and assignment records must be deleted from
the active tables.
Use:  DELETE FROM assignment WHERE ... to delete the assignments
and   DELETE FROM consultant WHERE ... to delete the consultant

After you write your procedure, test it by retiring Vernon Schillinger
(Consultant_ID = 2).
*/
/*
  HERE IS help on creating the archive tables.
This shows a cheap and dirty way to copy the structure from one table
to another.  It also adds a column for retirement date.
*/
CREATE TABLE consultant_archive
AS
SELECT 
  consultant.*,
  sysdate as Retirement_date
FROM consultant
WHERE 1 = 2;  -- no rows will be copied

-- create the assignment_archive
-- add a column for retirement_date
CREATE TABLE assignment_archive
AS
SELECT 
  assignment.*,
  sysdate AS retirement_date
FROM assignment
WHERE 1 = 2
;


-- Write your Retire_Consultant procedure here:
CREATE OR REPLACE PROCEDURE retire_consultant 
   (p_consultant_id IN NUMBER)
AS
   l_boss_id  CONSULTANT.BOSS_ID%TYPE;
BEGIN
   null;
END;
/
SHOW ERRORS PROCEDURE retire_consultant;



-- Test:  Retire Vernon Schillinger

EXEC retire_consultant(2);


