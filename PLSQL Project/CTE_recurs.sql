
/* Recursion and recusive algorithms.
Recursion  is when you call yourself (or a procedure/function calls itself.

Classic Example: factorial
factorial (5) = 5 * 4 * 3* 2* 1  
factorial (n) = n * (n-1) * (n-2) * ... * 1 

a recursive definition and algorithm would be
factorial (n) = n * factorial(n-1)

-- pseudocode
create procedure factorial (int n)
as
  if n = 1 then
     return 1
  else
     return n * factorial(n-1)
  end if
end

*/

/* Below is an  example of when we want to use recursion.  The goal is to generate
a list of managers, and  their employees, and THEIR employees and so on...

--------------
|employee         |
| -----------     |
| employeeid  PK  |
| contactid       |
| managerid    Foreign key to the employee table 
*/

WITH DirectReports (consultant_id, first_name, last_name, boss_id, lvl)
AS
(
-- Anchor member definition
    SELECT 
       e.consultant_id,
       e.first_name, 
       e.last_name, 
       e.boss_id, 
       1 AS Lvl
    FROM consultant e
    WHERE boss_id IS NULL
    UNION ALL
 -- Recursive member definition
    SELECT 
       sub_e.consultant_id,
       sub_e.first_name, 
       sub_e.last_name,
       sub_e.boss_id,
       d.lvl + 1
    FROM consultant sub_e
      INNER JOIN DirectReports d
      ON d.consultant_id = sub_e.boss_id
)
-- Statement that executes the CTE
SELECT *
FROM DirectReports;


  
  
-- What is the maximum level?
WITH DirectReports (consultant_id, first_name, last_name, boss_id, lvl)
AS
(
-- Anchor member definition
    SELECT 
       e.consultant_id,
       e.first_name, 
       e.last_name, 
       e.boss_id, 
       1 AS lvl
    FROM consultant e
    WHERE boss_id IS NULL
    UNION ALL
 -- Recursive member definition
    SELECT 
       sub_e.consultant_id,
       sub_e.first_name, 
       sub_e.last_name,
       sub_e.boss_id,
       d.lvl + 1
    FROM consultant sub_e
      INNER JOIN DirectReports d
      ON d.consultant_id = sub_e.boss_id
)
-- Statement that executes the CTE
SELECT MAX(lvl)
FROM DirectReports;