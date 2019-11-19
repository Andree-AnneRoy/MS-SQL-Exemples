USE MASTER
GO

DROP DATABASE AIR_CANADA
GO

--Step 01 - Creating the database.
CREATE DATABASE AIR_CANADA
GO

--Step 02 - Using the database.
USE AIR_CANADA
GO

--Step 03 - Creating a data type (TypeCity) that is a varchar (max = 20, min = 2).
CREATE TYPE TypeCity FROM VARCHAR(20) NOT NULL
GO

--Step 04 - Creating a table PILOT without constraints.
CREATE TABLE PILOT
(NO_PILOT	INT IDENTITY(2,1),
NAME_PILOT  VARCHAR(25),
CITY	    TypeCity,
NAS		    VARCHAR(9),
SALARY		MONEY)
GO

--Step 05 - Adding constraints to the PILOT table.
ALTER TABLE PILOT
ADD CONSTRAINT PKNO_PILOT PRIMARY KEY(NO_PILOT),
CONSTRAINT UNAS UNIQUE(NAS),
CONSTRAINT CHECK_SALARY CHECK(SALARY BETWEEN 20000 AND 80000)
GO

--Step 06 - Creating table PLANE without constraints.
CREATE TABLE PLANE
(NO_PLANE  INT IDENTITY(101,1),
MODEL      CHAR(4),
CAPACITY   INT,
AIRPORT    TypeCity)
GO

--Step 07 - Adding constraints to the table PLANE.
ALTER TABLE PLANE
ADD CONSTRAINT PKNO_PLANE PRIMARY KEY (NO_PLANE),
CONSTRAINT DEF_MODEL DEFAULT ('A300') for MODEL
GO

--Step 08 - Creating a table FLIGHT without constraints.
CREATE TABLE FLIGHT
(NO_FLIGHT        INT IDENTITY(1002,1),
NO_PILOT		  INT,
NO_PLANE          INT,
T_DEPARTURE       time(0),
C_DEPARTURE       TypeCity,
T_DESTINATION	  time(0),
C_DESTINATION     TypeCity)
GO

--Step 09 - Adding constraints to the table FLIGHT.
ALTER TABLE FLIGHT
ADD CONSTRAINT PKNO_FLIGHT PRIMARY KEY(NO_FLIGHT),
CONSTRAINT REFNO_PLANE FOREIGN KEY(NO_PLANE) REFERENCES AVION(NO_PLANE),
CONSTRAINT REFNO_PILOT FOREIGN KEY(NO_PILOT) REFERENCES PILOTE(NO_PILOT),
CONSTRAINT CHECK_DEST CHECK(C_DESTINATION != C_DEPARTURE),
CONSTRAINT CHECKTIME_DEST CHECK(T_DESTINATION > T_DEPARTURE)
GO

--Step 10 - Populate the table PILOT.
INSERT INTO PILOT VALUES ('PIERRE', 'GRANBY', NULL, 72500),
						 ('PIERRE', 'SHERBROOKE', '273501344', 65000),
						 ('PICHER', 'MANIWAKI', '273501345', 25000),
						 ('GUILLAUME', 'MANIWAKI', '273501346', 25000),
						 ('PICHER', 'GRANBY', '273501347', 30000),
						 ('BENOIT','MANIWAKI','273501348', 52500),
						 ('GUILLAUME', 'SHERBROOKE', '273501349', 25000),
						 ('GUILLAUME', 'SHERBROOKE', '273501350', 40000),
						 ('SERGE', 'MANIWAKI', '273501351', 59000)
GO

SELECT *
FROM PILOT

--Step 11 - Populate the table PLANE.
INSERT INTO PLANE VALUES (DEFAULT, 300, 'MANIWAKI'),
						 ('A330', 300, 'GRANBY'),
						 (DEFAULT, 300, 'SHERBROOKE'),
						 ('A330', 300, 'MANIWAKI'),
						 ('A330', 300, 'MANIWAKI'),
						 ('A320', 300, 'GRANBY'),
						 ('A320', 300, 'MANIWAKI'),
						 ('A330', 300, 'SHERBROOKE'),
						 ('A350', 500, 'SHERBROOKE')
GO

SELECT *
FROM PLANE

--Question 12 *Peupler la table VOL.
INSERT INTO FLIGHT VALUES(3, 104, '2:00 PM', 'MANIWAKI', '2:20 PM', 'GRANBY'),
					     (4, 105, '1:00 AM', 'SHERBROOKE', '2:05 AM', 'GRANBY'),
					     (2, 101, '12:00 AM', 'SHERBROOKE', '1:00 PM', 'MANIWAKI'),
					     (3, 101, '12:00 AM', 'MANIWAKI', '12:45 PM', 'LAVAL'),
					     (4, 107, '9:00 AM', 'GRANBY', '9:20 AM', 'MANIWAKE'),
					     (5, 101, '10:00 AM', 'SHERBROOKE', '10:45 AM', 'LAVAL'),
					     (6, 101, '7:00 PM', 'LAVAL', '7:45 PM', 'MANIWAKI'),
					     (7, 106, '4:00 PM', 'SHERBROOKE', '5:00 PM', 'MANIWAKI'),
					     (2, 109, '8:00 AM', 'GRANBY', '9:00 AM', 'SHERBROOKE'),
					     (3, 107, '6:30 PM', 'GRANBY', '7:30 PM', 'SHERBROOKE'),
					     (9, 109, '1:00 AM', 'GRANBY', '3:00 AM', 'ALMA')
GO

SELECT *
FROM FLIGHT