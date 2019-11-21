USE MASTER
GO

DROP DATABASE BANK
GO


--Step 01 - Creating the database.
CREATE DATABASE BANK
GO

USE BANK
GO


--Step 02 - Create table CLIENT.
CREATE TABLE CLIENT
(NO_CLIENT INT PRIMARY KEY,
SURNAME	   VARCHAR(20),
NAME	   VARCHAR(20),
ADRESS	   VARCHAR(20),
CITY	   VARCHAR(20))
GO


--Step 03 - Creating table ACCOUNT.
CREATE TABLE ACCOUNT
(NO_ACCOUNT		INT PRIMARY KEY,
NO_CLIENT		INT,
DATE_OPENING	DATE,
FUND			MONEY)
GO


--Step 04 - Creating a trigger on ACCOUNT table that valids that the FUND stays >= to 0.
CREATE TRIGGER TRG_SOLDE
ON ACCOUNT 
AFTER INSERT,UPDATE
AS
SET NOCOUNT ON
 IF EXISTS(SELECT FUND FROM ACCOUNT WHERE FUND < 0)
 BEGIN
		RAISERROR ('Impossible to do the transaction. INSUFISANT FUNDS',10,1)
		ROLLBACK TRANSACTION
 END
GO


--Step 05 - Inserting data in the CLIENT table.
INSERT INTO CLIENT VALUES (1,'Bourget','Pierre','23, rue des Plaines','Montreal')
INSERT INTO CLIENT VALUES (2,'Marois','Julie','40, rue des Pins','Laval')
GO


--Step 06 - Inserting data in the ACCOUNT table.
INSERT INTO ACCOUNT VALUES (1000,1,'29 April 2017',0)
INSERT INTO ACCOUNT VALUES (2000,2,'29 April 2017',0)
GO


--Step 07 - Creating a procedure DEPOSIT that allows a client to do a deposit in his account.
CREATE PROC DEPOSIT(@P_DEPOSIT AS INT, @P_NO_CLIENT AS INT)
AS
BEGIN
UPDATE ACCOUNT
	SET FUND = FUND + @P_DEPOSIT
	WHERE [NO_CLIENT] = @P_NO_CLIENT
END
GO


--Step 08 - Creating a procedure that allows a client to take out money of his account.
CREATE PROC RETRAIT(@P_RETRAIT AS INT, @P_NO_CLIENT AS INT)
AS
BEGIN
UPDATE ACCOUNT
	SET FUND = FUND - @P_RETRAIT
	WHERE [NO_CLIENT] = @P_NO_CLIENT
END
GO


--Step 09 - Using the procedure Deposit to put 300$ in the account of Pierre Bourget.
EXECUTE DEPOSIT 300,1
GO

SELECT * FROM ACCOUNT
GO


--Step 10 - Using the procedure Deposit to put 200$ in the account of Julie Marois.
EXECUTE DEPOSIT 200,2
GO

SELECT * FROM ACCOUNT
GO


--Steps 11 - Creating a procedures that allows transfers between 2 accounts.
CREATE PROC TRANSFERS(@P_AMOUNT AS MONEY,@COMPTE_DEPART AS INT,@COMPTE_DEST AS INT)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			EXECUTE RETRAIT @P_AMOUNT, @COMPTE_DEPART
			EXECUTE DEPOSIT @P_AMOUNT, @COMPTE_DEST
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		RAISERROR('Impossible transaction',10,1)
		ROLLBACK TRANSACTION
	END CATCH
END
GO


--Step 12 - Using procedure TRANSFERS to transfer 200$ from Pierre to Julie.
EXECUTE TRANSFERT 200,1,2
GO

SELECT * FROM ACCOUNT
GO


--Step 13 - Using procedure TRANSFERS to transfer 150$ from Pierre to Julie.
EXECUTE TRANSFERT 150,1,2
GO

SELECT * FROM ACCOUNT
GO