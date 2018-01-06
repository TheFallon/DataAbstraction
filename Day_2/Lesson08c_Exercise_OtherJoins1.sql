/*  Other JOINS 1 - Outer Joins etc.

-- Consultant Schema Exercises
/* 1.	Make a listing to show all clients and the assignment ids, start dates 
and end dates for assignments for the client.  Sort the output to show all 
client records in order of client name and show all clients even if there 
have been no assignments for the client.
*/


/* 2.	List all assignment ids and the last name of the consultant if one has 
been assigned.  If no consultant has been assigned then use ‘None Assigned’ 
as the name.
*/


/* 3.	List all house numbers, streets, and towns.  Include a fourth column
which shows the name of any clients at the address (or shows 'none').
Include a fifth, and sixth column which show the first and last name of any 
consultants at the address, respectively (or show "none").
*/


/* 4.	List all consultants who are older than their boss.
*/


/* 5.	List all clients (client_id and name), consultants' full name and the 
boss's full name where the consultant worked for the same client as his or 
her boss.  (Although assignments have start and end dates, don't worry about 
checking whether the consultant and his boss worked for the client at the 
same time.)
*/


-- Trading Platform Exercises
/* 6.	For each broker (give the broker's name) list the names of the stock 
exchanges where he or she is licensed to work.  Include all brokers even 
if they are not licensed at any exchange.  Include all stock exchanges even 
if there are no brokers licensed to trade there.
*/


/* 7.	For each broker (give the broker's name) list the distinct names of 
stock exchanges where the broker has made trades.
*/


/* 8.	For each trade, list the trade_id, broker_id, trade date (Month date, 
year), currency symbol, price total, share_amount, daily share price, and 
broker's earning.
To calculate broker's earning use PRICE_TOTAL – (SHARE_AMOUNT * PRICE)
Use the trade's date to look up the daily price per share in the STOCK_PRICE 
table.
*/

