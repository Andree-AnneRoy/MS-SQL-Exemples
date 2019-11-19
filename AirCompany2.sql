USE master

USE AIR_CANADA
GO


--Step 01 - Creating the table MAINTENANCE without constraints.
CREATE TABLE MAINTENANCE
(
NO_PLANE	INT NOT NULL,
DATE		DATETIME NOT NULL,
SERVICING	VARCHAR(50)
)
GO


--Step 02 - Adding constraints to MAINTENANCE table.
ALTER TABLE MAINTENANCE 
ADD CONSTRAINT PK_MAINTENANCE PRIMARY KEY (NO_PLANE, DATE),
CONSTRAINT REF_MAINTENANCE1 FOREIGN KEY(NO_PLANE) REFERENCES PLANE(NO_PLANE)
GO


--Step 03 - Populating the MAINTENANCE table.
ALTER TABLE MAINTENANCE 
DROP CONSTRAINT REF_MAINTENANCE1
GO

DECLARE @COMPTEUR INT
DECLARE @NOPLANE INT
SET @COMPTEUR=1
SET @NOPLANE=108

WHILE(@NOPLANE < 112)
BEGIN
	INSERT INTO MAINTENANCE VALUES(@NOPLANE, GETDATE() - @COMPTEUR, 'MAINTENANCE OF THE MOTOR'),
								  (@NOPLANE, GETDATE() - @COMPTEUR+2, 'MAINTENANCE OF THE BREAKS'),
								  (@NOPLANE, GETDATE() - @COMPTEUR+1, 'MAINTENANCE OF HYDRAULIC SYSTEM'),
								  (@NOPLANE, GETDATE() - @COMPTEUR+3, 'MAINTENANCE OF NAVIGATION SYSTEM')
	SET @NOPLANE=@NOPLANE+1
	SET @COMPTEUR=@COMPTEUR+1
END
GO

SELECT *
FROM MAINTENANCE
GO


--Step 04 - Flights completed by pilot #2 & #4.
SELECT F.NO_FLIGHT,
	   F.C_DEPARTURE
FROM FLIGHT F INNER JOIN PILOT P
ON (F.NO_PILOT = P.NO_PILOT) 
	AND (F.NO_PILOT = 2 OR F.NO_PILOT = 4)
GO


--Step 05 - Flight completed by a plane that isn't in Granby.
SELECT F.NO_FLIGHT
FROM FLIGHT F INNER JOIN PLANE P
ON (F.NO_PLANE = P.NO_PLANE) 
	AND (P.AIRPORT != 'GRANBY')
GO


--Step 06 - Display pilots (# and name) that are doing at least 1 flight from Granby with a plane that has 300+ seats.
SELECT P.NO_PILOT,
	   P.NAME_PILOT
FROM FLIGHT F INNER JOIN PILOT P
				ON F.NO_PILOT = P.NO_PILOT
		   INNER JOIN PLANE PL 
				ON F.NO_PLANE = PL.NO_PLANE
WHERE F.C_DEPARTURE = 'GRANBY'
AND PL.CAPACITY > 300
GO


--Step 07 - Display pilots that resides in Sherbrooke that doing a Granby flight with a plane A350.
SELECT P.NAME_PILOT
FROM FLIGHT F INNER JOIN PILOT P 
				ON F.NO_PILOT = P.NO_PILOT
		   INNER JOIN PLANE PL 
				ON F.NO_PLANE = PL.NO_PLANE
WHERE P.CITY = 'SHERBROOKE'
AND F.C_DEPARTURE = 'GRANBY'
AND PL.MODEL = 'A350'
GO


--Step 08 - Display flight numbers completed by a pilot from Sherbrooke, departure or arrival from Granby, with a plane from Sherbrooke.
SELECT F.NO_FLIGHT
FROM FLIGHT F INNER JOIN PILOT P 
				ON F.NO_PILOT = P.NO_PILOT
		   INNER JOIN PLANE PL 
				ON F.NO_PLANE = PL.NO_PLANE
WHERE P.CITY = 'SHERBROOKE'
AND F.C_DEPARTURE = 'GRANBY'
AND PL.AIRPORT = 'SHERBROOKE'
GO


--Step 09 - Display pilots (# and name) living in the same city has pilot #7.
SELECT P.NO_PILOT,
	   P.NAME_PILOT
FROM PILOT P
WHERE CITY = (SELECT CITY FROM PILOT WHERE NO_PILOT = 7) 
AND NO_PILOT != 7
GO


--Step 10 - Number of the pilots in service except pilot #7.
SELECT DISTINCT F.NO_PILOT
FROM FLIGHT F
WHERE F.NO_PILOT != 7
GO


--Step 11 - Plane numbers localized in the same city as plane #104.
SELECT NO_PLANE
FROM PLANE
WHERE AIRPORT = (SELECT AIRPORT FROM PLANE WHERE NO_PLANE = 104)
GO


--Step 12 - Numbers and name of pilots living in the same city as pilot #7, with a salary superior then pilot #7.
SELECT NO_PILOT,
	   NAME_PILOT
FROM PILOT
WHERE CITY = (SELECT CITY FROM PILOT WHERE NO_PILOT = 7)
AND SALARY > (SELECT SALARY FROM PILOT WHERE NO_PILOT = 7)
GO


--Step 13 - Numbers and names of pilotes that did a flight from the city where they live.
SELECT P.NO_PILOT,
	   P.NAME_PILOT
FROM PILOT P INNER JOIN FLIGHT F 
ON P.NO_PILOT = F.NO_PILOT
WHERE P.CITY = F.C_DEPARTURE
GO


--Step 14 - Display the number of occurences for each pilots.
SELECT NAME_PILOT, COUNT(NAME_PILOT) AS 'Compteur'
FROM PILOT
GROUP BY NAME_PILOT
ORDER BY 2 ASC
GO


--Step 15 - Display the number of maintenances per planes.
SELECT NO_PLANE, COUNT(SERVICING) AS 'Nb of maintenances'
FROM MAINTENANCE
WHERE NO_PLANE IS NOT NULL
GROUP BY NO_PLANE
ORDER BY 2 ASC
GO


--Step 16 - Display all maintenances per planes.
SELECT M.NO_PLANE, M.SERVICING
FROM MAINTENANCE M INNER JOIN PLANE P 
ON M.NO_PLANE = P.NO_PLANE
ORDER BY M.NO_PLANE
GO


--Step 17 - Display all maintenances including planes that don't have any.
SELECT P.NO_PLANE, M.SERVICING
FROM PLANE P LEFT OUTER JOIN MAINTENANCE M
ON P.NO_PLANE = M.NO_PLANE
GO


--Step 18 - Display all maintenance including those with null value.
SELECT P.NO_PLANE, M.SERVICING
FROM PLANE P RIGHT OUTER JOIN MAINTENANCE M
ON P.NO_PLANE = M.NO_PLANE
AND P.NO_PLANE IS NULL
GO


--Step 19 - Display all maintenances (with and without and null value).
SELECT P.NO_PLANE, M.SERVICING
FROM PLANE P FULL OUTER JOIN MAINTENANCE M
ON P.NO_PLANE = M.NO_PLANE
AND P.NO_PLANE IS NULL
GO


--Step 20 - Display the cartesian product of the tables PLANE & MAINTENANCE.
SELECT P.NO_PLANE, M.SERVICING
FROM PLANE P CROSS JOIN MAINTENANCE M
GO