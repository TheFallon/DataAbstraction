/*
Explore the WHERE clause.
Look through the examples in Lesson04e_WHERE.sql and attempt the following.
Objectives:  
=, >, < etc.  
“BETWEEN x AND y”, “NOT BETWEEN x AND y”
IN, NOT IN
Logical: AND, OR, and NOT
*/

/* 
1.	Show the first name, last name and birth date for the consultant 
with a consultant_id of 5.
*/
SELECT
  con.first_name||' '||con.last_name AS "Consultant",
  con.birth_date AS "D.O.B."
FROM consultant con 
WHERE con.consultant_id = 5
;


/* 2.	WHERE also works with >, <, >=, <=, <>, and !=.   
Show all consultants WHERE consultant_id > 5.
*/
SELECT
  con.first_name||' '||con.last_name AS "Consultant"
FROM consultant con
WHERE consultant_id > 5
;

/* 3.	“NOT” can be applied to any conditional.  Show all consultants 
WHERE NOT consultant_id > 5
*/
SELECT
  con.first_name||' '||con.last_name AS "Consultant"
FROM consultant con
WHERE NOT consultant_id > 5
;

/* 4.	Show all consultants WHERE consultant_id BETWEEN 5 AND 8.
*/
SELECT
  con.first_name||' '||con.last_name AS "Consultant"
FROM consultant con
WHERE con.consultant_id > 5
  AND con.consultant_id < 8
;

/* 5.	Show all consultants WHERE consultant_id >= 5 
  AND consultant_id <= 8.
*/
SELECT
  con.first_name||' '||con.last_name AS "Consultant"
FROM consultant con
WHERE con.consultant_id >= 5
  AND con.consultant_id <= 8
;

/* 6.	Show all consultants with consultant_id NOT BETWEEN 5 AND 8.
*/
SELECT
  con.first_name||' '||con.last_name AS "Consultant"
FROM consultant con
WHERE consultant_id NOT BETWEEN 5 AND 8
;

/* 7.	Show all consultants with consultant_id < 5 OR consultant_id > 8.
*/
SELECT
  con.first_name||' '||con.last_name AS "Consultant"
FROM consultant con
  WHERE consultant_id < 5
  OR consultant_id > 8
;

/* 8.	Show all consultants with consultant_id IN (1,3,5,7,8). */
SELECT
  con.first_name||' '||con.last_name AS "Consultant"
FROM consultant con
  WHERE consultant_id IN (1,3,5,7,8)
;

/* 9.	Show all consultants with consultant_id NOT IN (1,3,5,7,8).
*/
SELECT
  con.first_name||' '||con.last_name AS "Consultant"
FROM consultant con
  WHERE consultant_id NOT IN (1,3,5,7,8)
;

/* 10.  Show all assignments where a consultant has not been allocated. */
SELECT
  assign.assignment_id AS "Assignment ID",
  assign.comments AS "Assignment"
FROM
  assignment assign
WHERE assign.consultant_id IS NULL
;

/* 11.  Show all assignments where a consultant has been assigned but 
        the pay has not been specified. */
SELECT
  assign.assignment_id AS "Assignment ID",
  assign.comments AS "Assignment"
FROM assignment assign
WHERE assign.pay IS NULL
;


/*******  Exploring Date Functions   *********
/*
Look through the examples in Lesson04f_DateFunctions.sql and attempt the following.
Objectives:
SYSDATE,
TO_CHAR(), TO_DATE()
Date and Time Formatting:
	HH:MI:SSAM,  HH24:MI:SS,  hh:mi:ss
	DD, DY, Dy, dy, DAY, Day, day, fmDay
	Ddspth, fmDdspth
	MM, MONTH, Month, fmMonth, Mon, mon
	YYYY, YY, YEAR, Year
	WW   - number for week of the year
	Q   - quarter
TRUNC()
Trunc Format:
	SS, MI, HH, DD, MM, YYYY
NVL
Date Arithmetic
NEXT_DAY(), LAST_DAY()
ADD_MONTHS(), MONTHS_BETWEEN()
*/

/* 12.	Try this:         SELECT to_char(SYSDATE,'HH:MI:SSAM') 
                          FROM dual;
*/
SELECT to_char(SYSDATE,'HH:MI:SSAM') 
FROM dual
;


/* 13.	Show consultants birthdates in the form 
'fmDay "the" fmDdspth "of" fmMonth, fmYear'
*/
SELECT 
  TO_CHAR(con.birth_date,'fmDay "the" fmDdspth "of" fmMonth, fmYear') AS "D.O.B."
FROM consultant con
;

/* 14.	Try this:         
SELECT to_date('January 1, 2000','Month dd, yyyy') 
FROM dual;
*/
SELECT to_date('January 1, 2000','Month dd, yyyy') 
FROM dual
;

/* 15.	What was the day (Monday, Tuesday) that you were born?  
You will have to write a string for your birth date and use TO_DATE 
to convert it to date and then use TO_CHAR to convert that date to 
the string format you need.  You will have to select this from dual.
*/


/* 16.	Select the SYSDATE AND display THE numbers FOR EACH OF THE 
FOLLOWING: YEAR, MONTH, DAY, HOUR, MINUTE, AND SECOND.
*/ 



/* 17.	What IS THE meaning OF 
    to_char(trunc(SYSDATE,'dd'),'yyyy mm dd hh:mi:ss') ? 
Try selecting it from dual.  
Also try these abbreviations inside the trunc:  mi,  hh, dd, yyyy.
*/


/* 18.	Display records in the assignment table.  Show records which have 
a start date, but have no end date.
*/

/* 19.	If you subtract one date from another, Oracle will tell you the number 
of days difference.  How many days between 'Mar 1, 2012' and 'Feb 1, 2012'?
*/


/* 20.	Use the MONTHS_BETWEEN() function to determine the number of months 
difference. How many months between ‘Mar 1, 2013’ and ‘Feb 1, 2013’?  Does 
Oracle know about leap years?
*/




/*******    String Manipulation   ********/
/*  Look through the examples in Lesson04g_StringFunctions.sql and 
attempt the following. 

Objectives:
||
NVL
LIKE %, _
UPPER(), LOWER(), INITCAP(), LENGTH(), 
INSTR(), SUBSTR()
LTRIM, RTRIM, TRIM, LPAD, RPAD
*/

/* 21.	Use || to concatenate the consultant's first name together 
with his or her last name with a space in between.
*/


/* 22.	Show all consultants with a first name that comes after 
‘Bill’ (in alphabetical order).
*/


/* 23.	Display all comments in the assignment table.  If the comment is 
null then display "No comment given".
*/


/* 24.	Character data can be searched using wildcards and a LIKE 
expression.  % is a wildcard which means “match any number of 
characters including 0 characters”.  Show all consultants with 
first name LIKE 'S%'.
*/


/* 25.	Underscore '_' in a LIKE expression means “match one 
character (and there must be a character there to match).  
Show all consultants with first_name LIKE 'S___n'   (Three underscores.)
*/


/* 26.	CREATE A QUERY that will LIST consultants WITH THE initials 
'PB' OR 'BP'.
*/


/* 27.	Create a query that will list consultants with a last_name that 
begins with an S and has first name of Susan or Bill.
*/


/* 28.	Show all consultants with first_name IN ('Bill','Simon')
*/


/* 29.	Oracle has a little known feature that allows you to search for 
groups of columns in a list of groups of entries.  Show all consultants 
with (first_name, last_name) IN (('Bill','Sykes'),('Simon','Adebisi'))
*/


/* 30.	Investigate UPPER(), LOWER(), INITCAP().
*/


/* 31.	Investigate INSTR().  Use INSTR() to determine the position of the 
space ' ' in all the street names in the address table.
*/


/* 32.	Investigate SUBSTR(). Use SUBSTR() to separate the name from the 
designation (“street”, “lane”, “avenue” or whatever it is.)  
Display the name and the designation as separate columns.
*/



/**********  Numeric Functions   ***********/
/* Look through the examples in Lesson04h_NumberFunctions.sql 
and attempt the following.

Objectives:
TO_NUMBER(), TO_CHAR()
Numeric Formats:
	‘9,999,999.9’
ABS(), SIGN(),
CEIL(), FLOOR(), ROUND(), TRUNC()
GREATEST(), LEAST()
*/


/* 33.	Try this:   
SELECT to_char(1234567,'9,999,999') FROM dual;
*/


/* 34.	Try this:   
SELECT to_number('1230','9999')+4 FROM dual;
*/


/* 35.	Try this:   
SELECT greatest(1,5,10,15,11,6) FROM dual;
Greatest returns the greatest number from a “row”.
*/


/* 36.	What is the difference between 
CEIL(), FLOOR(), ROUND() and TRUNC() ? Investigate
*/


/* 37.	Display all the Pay amounts in the assignment table.  
If the pay amount is NULL then display 1000000 instead.
*/


/**********  DECODE and CASE   *********/
/* Look through the examples in Lesson04i_DecodeCase.sql 
and attempt the following.

Objectives:
DECODE()  
CASE (Two Forms)
*/

/* 38.  DECODE Example:
SELECT
   first_name,
   consultant_id, 
   DECODE(consultant_id, 1,'Consultant Number 1', 2, 'Second Consultant', 'another one')
FROM consultant
ORDER BY first_name;
Try the statement to see what it does.
*/


/* 39.	What happens if you remove 'another one' so that the 
DECODE function uses only 5 parameters instead of six?
*/


/* 40.	Add two more parameters so that if the consultant_id is 3 
then the DECODE will return 'Third Consultant'
*/


/* 41.	Try the following:
SELECT 
DECODE(consultant_id,1,'Bill',1,'Joe','Unknown')
FROM consultant;
Will the DECODE return 'Bill' or 'Joe' for consultant_id = 1?
*/



/* 42.	CASE Example 1:
SELECT 
   first_name,
   consultant_id,
   CASE consultant_id
    WHEN 1 THEN 'First Consultant'
    WHEN 2 THEN 'Second Consultant'
   ELSE 'Another one'
   END
FROM consultant
ORDER BY first_name;

42a:  Try the statement to see what it does.
*/



/* 42b.	What happens if you remove the line containing 
 "ELSE 'Another one'"  ?
*/


/* 42c.	Can you add more WHEN options?
*/



/* 43.
CASE Example 2:
SELECT 
   CASE 
      WHEN pay >= 650 THEN 'Equal or above 650'
      WHEN pay >= 500 THEN 'Equal or above 500 but less than 650'
      WHEN pay >= 400 THEN 'Equal or above 400 but less than 500'
      ELSE 'less than 400'
   END AS pay_range
FROM assignment

How is this case statement different from the previous one?
*/



