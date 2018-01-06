--UNION, INTERSECT, MINUS
/*
1.	Combine the addresses (address_id and town) from the 
consultant schema together with the places (place_id and city) 
from the stock trading schema into one result set that shows 
all results (even duplicates).*/


/*
2.	What column names are shown in the result set for question 1? 
Can we apply a column alias?  Do we put the column aliases 
in the first query or the second? */


/*
3.	Try to modify your query from question 1 to include the 
(place_id, city, and country) from the place table but still 
uses only the (address_id, town) from the address table.  
Does this work?  Why or why not? */

/*
4.	Try to combine the place_id from the place table together 
in a single column with the town from the address table.  
Does this work?  Why or why not? */


/*
5.	Combine the (first_name, last_name) from brokers together 
with the (last_name, first_name) from consultants.  (That is, 
intentionally combine the first names with last names and 
last names with first names.)  
Does this work? Why or why not? */


/*
6.	Use MINUS to display all address_ids (just the address_id 
alone) that have no consultants at that address. */


/*
7.	Use MINUS twice to display all address_ids that have neither 
consultants nor clients at that address. */

