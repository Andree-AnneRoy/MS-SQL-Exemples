USE MASTER
GO

USE SHOP
GO

-- C == CLIENTS
-- I == INVOICES

-- Step 01 - Displaying the total cost of invoices of client per city.
SELECT SUM(COST),CITY
FROM CLIENTS C INNER JOIN INVOICE I
ON C.NO_CLIENT = I.NO_CLIENT
GROUP BY CITY
GO

-- Step 02 - Displaying the maximum cost of an invoice of a client per city.
SELECT MAX(COST), CITY
FROM CLIENTS C INNER JOIN INVOICE I
ON C.NO_CLIENT = I.NO_CLIENT
GROUP BY CITY
GO

-- Step 03 - Displaying minimum cost of an invoice of a client per city.
SELECT MIN(COST), CITY
FROM CLIENTS C INNER JOIN INVOICE I
ON C.NO_CLIENT = I.NO_CLIENT
GROUP BY CITY
GO

-- Step 04 - Displaying the average cost of an invoice of a client per city.
SELECT AVG(COST), CITY
FROM CLIENTS C INNER JOIN INVOICE I
ON C.NO_CLIENT = I.NO_CLIENT
GROUP BY CITY
GO

-- Step 05 - Displaying the name of the clients that has an invoice above the average.
SELECT C.NAME
FROM CLIENTS C INNER JOIN INVOICE I
ON C.NO_CLIENT = I.NO_CLIENT
WHERE I.COST > (SELECT AVG(COST) FROM INVOICE)
GO

-- Step 06 - Displaying the clients that don't have invoices.
SELECT C.*
FROM CLIENTS C INNER JOIN INVOICE I
ON C.NO_CLIENT = I.NO_CLIENT
WHERE C.NO_CLIENT NOT IN (SELECT NO_CLIENT FROM INVOICE)
GO

-- Step 07 - Displaying the total number of invoices from clients in Laval.
SELECT COUNT(I.NO_INVOICE)
FROM INVOICE I INNER JOIN CLIENTS C
ON I.NO_CLIENT = C.NO_CLIENT
WHERE C.CITY = 'Laval'
GO

-- Step 08 - Displaying invoices that don't belong to a client.
SELECT *
FROM INVOICE
WHERE NO_CLIENT IS NULL
GO

-- Step 09 - Displaying a report. Client number (no_client) + Invoice number (no_invoice).
SELECT C.NAME, I.NO_INVOICE
FROM CLIENTS C INNER JOIN INVOICE I
ON C.NO_CLIENT = I.NO_CLIENT
WHERE C.NO_CLIENT NOT IN (SELECT NO_CLIENT FROM INVOICE) 
OR C.NO_CLIENT IS NULL 
OR C.NO_CLIENT IN (SELECT NO_CLIENT FROM INVOICE)