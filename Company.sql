USE MASTER
GO

DROP DATABASE COMPANY
GO

--Step 01 - Creating a database.
CREATE DATABASE COMPANY
GO

USE COMPANY
GO

--Step 02 - Creating a table EMPLOYEES
CREATE TABLE EMPLOYEES
(NO_EMP			INT PRIMARY KEY,
NAME			VARCHAR(20) NOT NULL,
SURNAME			VARCHAR(20) NOT NULL,
JOB				VARCHAR(20),
SALARY			MONEY,
DATE_HIRE		DATE,
DATE_BIRTH		DATE,
COUNTRY			VARCHAR(20))
GO

--Step 03 - Creating a procedure to populate the EMPLOYEES table.
CREATE PROC PopulateEMP
@x INT = 20,
@y INT = 1000
AS
BEGIN
DECLARE @z INT = 0
WHILE @z < @x-1
	BEGIN
		SET @y = @y+1
		INSERT INTO EMPLOYEES VALUES (@y,'NAME_'+CONVERT(varchar(30), @y),
									 'SURNAME_'+CONVERT(varchar(30), @y),
									 'JOB_'+CONVERT(varchar(30), @y),
									 10*@y,
									 DATEADD(DAY,-@y,GETDATE()),
									 DATEADD(DAY,-2*@y,GETDATE()),
									 'COUNTRY_'+CONVERT(varchar(30), @y))
		SET @z = @z + 1
	END
END
GO

--Step 04 - Command to execute the procedure  *Commande pour exécuter la procédure PeuplerEMP selon les cas précis.
TRUNCATE TABLE emp
EXECUTE PopulateEMP @x=100, @y=5
	SELECT * FROM EMPLOYEES
GO

TRUNCATE TABLE emp
EXECUTE PopulateEMP @x=200, @y=null
	SELECT * FROM EMPLOYEES
GO

TRUNCATE TABLE emp
EXECUTE PopulateEMP null, @y=30
	SELECT * FROM EMPLOYEES
GO

TRUNCATE TABLE emp
EXECUTE PopulateEMP null, null
	SELECT * FROM EMPLOYEES
GO

--Step 05 - Command to display the procedure's code.
SP_HELPTEXT PopulateEMP
GO

--Step 06 - Command to compile the procedure.
EXEC PopulateEMP WITH RECOMPILE
GO

--Step 07 - Command to delete the procedure.
DROP PROCEDURE PopulateEMP
GO

--Step 08 - Creating another procedure that allows to search an employee by its name or number.
CREATE PROCEDURE SearchEMP (@p_number INT = NULL, @p_name AS VARCHAR(20) = NULL)
AS
BEGIN

	if(@p_number = NULL AND @p_name = NULL)
	BEGIN
		PRINT 'ERROR !!! THE VALUES CANNOT BE NULL.'
	END
	ELSE
	BEGIN
		BEGIN
			select * 
			FROM EMPLOYEES
			WHERE  no_emp= isnull(@p_number,no_emp) AND name = ISNULL(@p_name, name)  
		END
	END
END
GO

--Step 09 - Creating a procedure that allows to add employees.
CREATE PROCEDURE AddEMp (@NO_EMP		AS INT,
						 @NAME			AS VARCHAR(20),
						 @SURNAME		AS VARCHAR(20),
						 @JOB			AS VARCHAR(20) = NULL,
						 @SALARY		AS MONEY = NULL,
						 @DATE_HIRE		AS DATE = NULL, 
						 @DATE_BIRTH	AS DATE = NULL,
						 @COUNTRY       AS VARCHAR(20) = NULL)
AS
	BEGIN
		INSERT INTO EMPLOYEES VALUES(@NO_EMP, 
									 @NAME, 
									 @SURNAME, 
									 @JOB, 
									 @SALARY, 
									 @DATE_HIRE, 
									 @DATE_BIRTH, 
									 @COUNTRY)
	END
GO

--Step 10 - Creating a procedure to modify an employee.
CREATE PROCEDURE  UpdateEMP @NUMBER INT = NULL
AS
	BEGIN
	DECLARE
	@EMP_JOB	 AS VARCHAR(20),
	@EMP_SALARY  AS MONEY,
	@EMP_COUNTRY AS VARCHAR(20)

		BEGIN
			IF (@NUMBER	IS NULL)
				BEGIN
					PRINT 'ERROR !!! THE VALUES CANNOT BE NULL.'
				END
			ELSE
				BEGIN
					UPDATE EMPLOYEES
					SET JOB = @EMP_JOB, SALARY = @EMP_SALARY, COUNTRY = @EMP_COUNTRY
					WHERE NO_EMP = @NUMBER
				END
		END
	END	
GO

--Step 11 - Creating a procedure to delete an employee.
CREATE PROCEDURE  DeleteEMP @NUMBER varchar = NULL
AS
	BEGIN
		IF (@NUMBER	IS NULL)
			BEGIN
				PRINT 'ERROR !!! THE VALUES CANNOT BE NULL.'
			END
		ELSE
			BEGIN
				IF (@NUMBER	 IS NOT NULL)
					BEGIN
						DELETE FROM EMPLOYEES
						WHERE NO_EMP = @NUMBER
					END
			END
	END
GO