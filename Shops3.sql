USE MASTER
GO

-- Step 01 - Using an existing database.
USE SHOP
GO


-- Step 02 - Displaying NAME & Client number (NO_CLIENT) that don't have invoices.
--Method 1
SELECT NAME, NO_CLIENT
FROM CLIENTS
WHERE NO_CLIENT not in (SELECT NO_CLIENT FROM INVOICE)
GO

--Method 2
SELECT NO_CLIENT, 
	   NAME
FROM CLIENTS
WHERE NOT EXISTS (SELECT * FROM INVOICE WHERE NO_CLIENT = CLIENTS.NO_CLIENT)



-- Step 03 - For client #10, we are displaying its name and city + cost of its invoices.
--Method 1
SELECT NAME, CITY
FROM CLIENTS
WHERE NO_CLIENT = 10
GO

SELECT NO_INVOICE, COST
FROM INVOICE
WHERE NO_CLIENT = 10
GO

--Method 2
SELECT T1.NAME, T1.CITY, T2.NO_INVOICE, T2.COST
FROM CLIENTS T1, INVOICE T2
WHERE T1.NO_CLIENT = 10
AND T2.NO_CLIENT = 10
GO



-- Step 04 - Displaying name and client number (no_client) that has at least 1 invoice.
-- Method 1
SELECT NAME, NO_CLIENT
FROM CLIENTS
WHERE NO_CLIENT IN (SELECT NO_CLIENT FROM INVOICE)
GO

--Method 2
SELECT NAME, NO_CLIENT 
FROM CLIENTS
WHERE NO_CLIENT = ANY (SELECT NO_CLIENT FROM INVOICE)
GO

--Method 3
SELECT NO_CLIENT, 
	   NAME
FROM CLIENTS
WHERE EXISTS (SELECT * FROM INVOICE WHERE NO_CLIENT = CLIENTS.NO_CLIENT)



-- Step 05 - Displaying Name, city, invoice + cost of client #20 & #30.
--Method 1
SELECT NAME, CITY
FROM CLIENTS
WHERE NO_CLIENT=20 OR NO_CLIENT=30
GO

SELECT NO_INVOICE, COST
FROM INVOICE
WHERE NO_CLIENT=20 OR NO_CLIENT=30
GO

--Method 2
SELECT T1.NAME, T1.CITY, T2.NO_INVOICE, T2.COST
FROM CLIENTS T1, INVOICE T2
WHERE T1.NO_CLIENT=20 OR T1.NO_CLIENT=30
AND T2.NO_CLIENT=20 OR T2.NO_CLIENT=30
GO



-- Step 06 - Displaying Name, city, invoice + cost of clients in Montreal and Laval.
--Method 1
SELECT T1.NAME, T1.CITY, T2.NO_INVOICE, T2.COST
FROM CLIENTS T1, INVOICE T2
WHERE T1.CITY='Laval' OR T1.CITY='Montreal'
GO

--Method 2
SELECT T1.NAME, T1.CITY, T2.NO_INVOICE, T2.COST
FROM CLIENTS T1, INVOICE T2
WHERE T1.CITY='Laval'
UNION
SELECT T1.NAME, T1.CITY, T2.NO_INVOICE, T2.COST
FROM CLIENTS T1, INVOICE T2
WHERE T1.CITY='Montreal'
GO



-- Step 07 - Displaying name, city, invoice + cost of clients that are not in Brossard.
--Method 1
SELECT T1.NAME, T1.CITY, T2.NO_INVOICE, T2.COST
FROM CLIENTS T1, INVOICE T2
WHERE T1.CITY != 'Brossard'
GO

--Method 2
SELECT T1.NAME, T1.CITY, T2.NO_INVOICE, T2.COST
FROM CLIENTS T1, INVOICE T2
WHERE T1.CITY <> 'Brossard'
GO



-- Step 08 - Displaying all the invoices where the cost are between 1000$ & 9000$.
--Method 1
SELECT *
FROM INVOICE
WHERE COST >= '1000' AND COST <= '9000'
GO

--Method 2
SELECT *
FROM INVOICE
WHERE COST BETWEEN '1000' AND '9000'
GO



-- Step 09 - Displaying all the invoices where the cost isn't between 1000$ & 9000$.
--Method 1
SELECT *
FROM INVOICE
WHERE COST <= '1000' OR COST >= '9000'
GO

--Method 2
SELECT *
FROM INVOICE
WHERE COST NOT BETWEEN '1000' AND '9000'
GO

