use master
go

use AIR_CANADA
go


INSERT INTO PLANE(NO_PLANE,MODEL,CAPACITY,AIRPORT) VALUES (101, DEFAULT,300,'Maniwaki'),
														  (102, 'A330',300,'Granby'),
														  (103, DEFAULT,300,'Sherbrooke'),
														  (104, 'A330',300,'Maniwaki'),
														  (105, 'A330',300,'Maniwaki'),
														  (106, 'A320',300,'Granby'),
														  (107, 'A320',300,'Maniwaki'),
														  (108, 'A330',300,'Sherbrooke'),
														  (109, 'A350',500,'Sherbrooke')


--Step 01 - Creating a view containing planes from Maniwaki (without CHECK).
DROP VIEW AvionManiwaki
GO

CREATE VIEW AvionManiwaki
AS
SELECT *
FROM PLANE
WHERE AIRPORT = 'MANIWAKI'
GO


--Step 02 - SQL query to display all data from a view.
SELECT *
FROM AvionManiwaki
GO


--Step 03 - Creating a view containing all planes from Granby with CHECK).
DROP VIEW AvionGranby
GO

CREATE VIEW AvionGranby
AS
SELECT *
FROM PLANE
WHERE AIRPORT = 'GRANBY'
WITH CHECK OPTION
GO


--Step 04 - SQL query to display all data from a view.
SELECT *
FROM AvionGranby
GO


--Step 05 - Updating a line in a view.
UPDATE AvionManiwaki
SET AIRPORT = 'MANIWAKI'
WHERE NO_PLANE = 104
GO


--Step 06 - Updating a line that does not belong to the view.
UPDATE AvionManiwaki
SET AIRPORT = 'MANIWAKI'
WHERE NO_PLANE = 106
GO


--Step 07 - Adding data using a view.
INSERT INTO AvionManiwaki VALUES(700,'CRJ1',120,'Maniwaki')
GO


--Step 08 - Adding data using a view.
INSERT INTO AvionManiwaki VALUES(800,'CRJ',130,'Granby') 
GO


--Step 09 - Adding data using a view.
INSERT INTO AvionGranby VALUES(900,'DASH',140,'Montréal')
GO


--Step 10 - Deleting data using a view.
DELETE FROM AvionManiwaki
WHERE NO_PLANE = 108
GO


--Step 11 - Creating a view FlightDetails that returns : #, model, pilot, salary.
DROP VIEW FlightDetails
GO

CREATE VIEW FlightDetails
AS
SELECT F.NO_FLIGHT, PL.MODEL, P.NAME_PILOT, P.SALARY
FROM FLIGHT F	
	INNER JOIN PILOT P ON F.NO_PILOT = P.NO_PILOT
	INNER JOIN PLANE PL ON F.NO_PLANE = PL.NO_PLANE
GO

SELECT * FROM FlightDetails
GO


--Step 12 - Adding data using a view.
INSERT FlightDetails VALUES (2000,'A330','Picher')
GO


--Step 13 - Increasing the salary of all pilots by 10% using the view FlightDetails.
UPDATE FlightDetails
SET SALARY = SALARY * 1.10
GO

SELECT *
FROM FlightDetails
GO