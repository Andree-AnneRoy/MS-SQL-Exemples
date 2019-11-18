-- Step 01 - Using an existing database.
USE SHOP
GO

-- Step 02 - Adding a new client to CLIENTS table and displaying the data.
INSERT INTO CLIENTS VALUES('Sqlbec', 'Quebec', null)
GO

SELECT *
FROM CLIENTS

-- Step 03- Adding invoices in the table INVOICE.
INSERT INTO INVOICE VALUES(10, '23 august 2014', 42.33)
INSERT INTO INVOICE VALUES(10, '15 september 2014', 999.44)
GO

-- Step 04 - Displaying the client number (no_client) and name of all data currently in the database.
SELECT NO_CLIENT, NAME
FROM CLIENTS

-- Step 05 - Displaying all the data from the table INVOICE.
SELECT *
FROM INVOICE

-- Step 06 - Displaying all the clients with an invoice dating from 15/09/2014.
SELECT *
FROM INVOICE
WHERE Date_Invoice = '15 september 2014'

-- Step 07 - Displaying all the clients in Montreal.
SELECT *
FROM CLIENTS
WHERE CITY = 'Montreal'

-- Step 08 - Displaying all the clients that are outside of Montreal.
SELECT *
FROM CLIENTS
WHERE CITY != 'Montréal'

-- Step 09 - Displaying all the clients with no phone number.
SELECT *
FROM CLIENTS
WHERE PHONE is null

-- Step 10 - Displaying all the clients with a phone number.
SELECT *
FROM CLIENTS
WHERE PHONE is not null

-- Step 11 - Displaying the name and city of all the clients.
SELECT CITY, NAME
FROM CLIENTS

-- Step 12 - Ordering all clients by city (Ascending order).
SELECT *
FROM CLIENTS
ORDER BY CITY ASC

-- Step 13 - Ordering all clients by city (ascending) and name (descending).
SELECT *
FROM CLIENTS
ORDER BY CITY ASC, NAME DESC

-- Step 14 - Displaying a different column name in the display then the actual column name.
select CITY as City_of_client, NAME
from CLIENTS

-- Step 15 - Displaying the 2 first clients of the table CLIENTS.
SELECT TOP 2 * FROM [dbo].[CLIENTS]

-- Step 16 - Displaying 50% of the INVOICE table.
SELECT TOP 50 PERCENT * FROM [dbo].[INVOICE]