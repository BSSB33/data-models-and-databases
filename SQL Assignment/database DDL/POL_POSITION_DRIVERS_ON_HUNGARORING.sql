--------------------------------------------------------
--  File created - Saturday-April-10-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for View POL_POSITION_DRIVERS_ON_HUNGARORING
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "ABIOWE"."POL_POSITION_DRIVERS_ON_HUNGARORING" ("FORENAME", "SURNAME", "NATIONALITY", "ID", "POSITION") AS 
  SELECT drivers.forename, drivers.surname, drivers.nationality, ID, Position
    FROM drivers INNER JOIN (races INNER JOIN (SELECT driverId as ID, POSITIONTEXT as Position FROM results WHERE POSITIONTEXT = '1' OR POSITIONTEXT = '2' OR POSITIONTEXT = '3') ON races.raceId = ID) ON drivers.driverId = ID
    GROUP BY drivers.forename, drivers.surname, races.name, drivers.nationality, ID, Position
    HAVING (((races.name) = 'Hungarian Grand Prix'))
;
REM INSERTING into ABIOWE.POL_POSITION_DRIVERS_ON_HUNGARORING
SET DEFINE OFF;
Insert into ABIOWE.POL_POSITION_DRIVERS_ON_HUNGARORING (FORENAME,SURNAME,NATIONALITY,ID,POSITION) values ('Ayrton','Senna','Brazilian',102,'1');
Insert into ABIOWE.POL_POSITION_DRIVERS_ON_HUNGARORING (FORENAME,SURNAME,NATIONALITY,ID,POSITION) values ('Jacky','Ickx','Belgian',235,'2');
Insert into ABIOWE.POL_POSITION_DRIVERS_ON_HUNGARORING (FORENAME,SURNAME,NATIONALITY,ID,POSITION) values ('Jacky','Ickx','Belgian',235,'1');
Insert into ABIOWE.POL_POSITION_DRIVERS_ON_HUNGARORING (FORENAME,SURNAME,NATIONALITY,ID,POSITION) values ('Johnny','Herbert','British',65,'1');
Insert into ABIOWE.POL_POSITION_DRIVERS_ON_HUNGARORING (FORENAME,SURNAME,NATIONALITY,ID,POSITION) values ('Ayrton','Senna','Brazilian',102,'3');
Insert into ABIOWE.POL_POSITION_DRIVERS_ON_HUNGARORING (FORENAME,SURNAME,NATIONALITY,ID,POSITION) values ('Johnny','Herbert','British',65,'2');
Insert into ABIOWE.POL_POSITION_DRIVERS_ON_HUNGARORING (FORENAME,SURNAME,NATIONALITY,ID,POSITION) values ('Timo','Glock','German',10,'3');
Insert into ABIOWE.POL_POSITION_DRIVERS_ON_HUNGARORING (FORENAME,SURNAME,NATIONALITY,ID,POSITION) values ('Johnny','Herbert','British',65,'3');
Insert into ABIOWE.POL_POSITION_DRIVERS_ON_HUNGARORING (FORENAME,SURNAME,NATIONALITY,ID,POSITION) values ('Didier','Pironi','French',202,'1');
Insert into ABIOWE.POL_POSITION_DRIVERS_ON_HUNGARORING (FORENAME,SURNAME,NATIONALITY,ID,POSITION) values ('Didier','Pironi','French',202,'3');
Insert into ABIOWE.POL_POSITION_DRIVERS_ON_HUNGARORING (FORENAME,SURNAME,NATIONALITY,ID,POSITION) values ('Tim','Schenken','Australian',314,'3');
Insert into ABIOWE.POL_POSITION_DRIVERS_ON_HUNGARORING (FORENAME,SURNAME,NATIONALITY,ID,POSITION) values ('Timo','Glock','German',10,'2');
Insert into ABIOWE.POL_POSITION_DRIVERS_ON_HUNGARORING (FORENAME,SURNAME,NATIONALITY,ID,POSITION) values ('Ayrton','Senna','Brazilian',102,'2');
Insert into ABIOWE.POL_POSITION_DRIVERS_ON_HUNGARORING (FORENAME,SURNAME,NATIONALITY,ID,POSITION) values ('Didier','Pironi','French',202,'2');
Insert into ABIOWE.POL_POSITION_DRIVERS_ON_HUNGARORING (FORENAME,SURNAME,NATIONALITY,ID,POSITION) values ('Jacky','Ickx','Belgian',235,'3');
