select * from constructors;
select * from drivers where nationality = 'Hungarian';
select * from laps;
select * from races;
select * from results;

alter table races drop column "CIRCUITID";
--WHERE TO_DATE(drivers.dob, 'DD-MON-RR')> TO_DATE('01-JAN-90','DD-MON-RR'))

-- View 1: Join at least three tables and add in a where clause! 
-- Fastest Lap times for every Constructor for every race in 2010
CREATE OR REPLACE VIEW FASTEST_LAPS_OF_CONSTRUCTORS_WITH_PILOTS AS
    SELECT races.year, races.name as RaceName, constructors.name, results.fastestLapSpeed
    FROM constructors INNER JOIN (drivers INNER JOIN (races INNER JOIN results ON races.raceId = results.raceId) ON drivers.driverId = results.driverId) ON constructors.constructorId = results.constructorId
    WHERE ((races.year) = 2010);
    

-- View 2: Join at least two tables and a subquery and use somewhere a grouping with having! 
-- Drivers with podium positions of on the Hungaroring
CREATE OR REPLACE VIEW POL_POSITION_DRIVERS_ON_HUNGARORING AS
    SELECT drivers.forename, drivers.surname, drivers.nationality, ID, Position
    FROM drivers INNER JOIN (races INNER JOIN (SELECT driverId as ID, POSITIONTEXT as Position FROM results WHERE POSITIONTEXT = '1' OR POSITIONTEXT = '2' OR POSITIONTEXT = '3') ON races.raceId = ID) ON drivers.driverId = ID
    GROUP BY drivers.forename, drivers.surname, races.name, drivers.nationality, ID, Position
    HAVING (((races.name) = 'Hungarian Grand Prix'));
    
-- View 3: Query using a set operator!
-- Who drives an italian car or is an italian driver.
CREATE OR REPLACE VIEW ITALIAN_DRIVERS AS
    (SELECT DISTINCT results.driverid FROM drivers INNER JOIN results ON results.driverId = drivers.driverId WHERE drivers.nationality = 'Italian')
    UNION
    (SELECT DISTINCT results.driverid FROM constructors INNER JOIN results ON results.constructorId = constructors.constructorId WHERE constructors.nationality = 'Italian');

-- PLSQL function 1: Which queries one of your view, using parameter(s) and cursor!
-- Podium Drivers on Hungaroring by nationality.
    