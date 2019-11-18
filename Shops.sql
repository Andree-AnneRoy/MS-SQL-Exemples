USE MASTER
GO

DROP DATABASE SHOP
GO


-- Step 01 - Create the database
CREATE DATABASE SHOP
GO

-- Step 02 - Using the database
USE SHOP
GO

-- Step 03 - Creating a table CLIENT
-- Note that CITY is an INT, I will show you how to alter the city column below in this project.
-- Note that NAS (social security number) is unnecessary and is only to show how to drop a column below in this project.
CREATE TABLE CLIENT 
(NO_CLIENT INT IDENTITY(10,10),
 NAME	   VARCHAR(50),
 CITY      INT,
 NAS	   VARCHAR(9))
GO

-- Step 04 - Creating a table INVOICE
CREATE TABLE INVOICE
(NO_INVOICE INT IDENTITY(1000,1),
 NO_CLIENT	INT,
 DATE       DATE,
 COST	    MONEY)
GO

-- Step 05 - Modifying the data type of a column. *Previously we created a column CITY with INT as a data type, we will now put the correct data type.
ALTER TABLE CLIENT 
	ALTER COLUMN CITY VARCHAR(50)
GO

-- Step 06 - Deleting a column from a table.
ALTER TABLE CLIENT
DROP COLUMN NAS
GO

-- Step 07 - We are adding a column in the table CLIENT.
ALTER TABLE CLIENT
ADD PHONE VARCHAR(16)
GO

-- Step 08 - Populating the table CLIENT.
INSERT INTO CLIENT VALUES('Frigobec', 'Montreal', '514-820-1010')
INSERT INTO CLIENT VALUES('Eltrobec', 'Quebec', '819-820-2020')
INSERT INTO CLIENT VALUES('Plancherbec', 'Laval', '450-820-3030')
INSERT INTO CLIENT VALUES('Toiturebec', 'Montreal', '514-820-4040')
GO

-- Step 09 - Displaying all the data from table CLIENT.
SELECT * FROM CLIENT
GO

-- Step 10 - Populating the table INVOICE.
INSERT INTO INVOICE VALUES(10,'09 january 2014', 803.22)
INSERT INTO INVOICE VALUES(30,'04 february 2014', 1023.89)
INSERT INTO INVOICE VALUES(20,'23 february 2014', 2340)
INSERT INTO INVOICE VALUES(10,'04 march 2014', 13000.23)
INSERT INTO INVOICE VALUES(20,'01 april 2014', 2230.88)
INSERT INTO INVOICE VALUES(10,'22 april 2014', 9320.22)
GO

-- Step 11 - Displaying all the data from table INVOICE.
SELECT * FROM INVOICE
GO

-- Step 12 - Renaming a column
EXEC sp_rename 'INVOICE.DATE', 'Date_Invoice', 'COLUMN'
GO

-- Step 13 - Renaming the CLIENT table
sp_rename CLIENT, CLIENTS
GO

-- Step 14 - Deleting the table CLIENTS
DROP TABLE CLIENTS
GO

-- Step 15 - Displaying the definition of the table INVOICE
SP_HELP INVOICE
GO

select * from INVOICE
GO