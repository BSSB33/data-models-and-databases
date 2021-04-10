select * from constructors;
select * from drivers where nationality = 'Hungarian';
select * from drivers2;
select * from laps;
select * from races;
select * from results;

alter table races drop column "CIRCUITID";
--WHERE TO_DATE(drivers.dob, 'DD-MON-RR')> TO_DATE('01-JAN-90','DD-MON-RR'))

-- View 1: Join at least three tables and add in a where clause! 
-- Fastest Lap times for every Constructor for every race in 2010
CREATE OR REPLACE VIEW FASTEST_LAPS_OF_CONSTRUCTORS_WITH_PILOTS AS
    SELECT races.year, races.name as RaceName, constructors.name, results.fastestLapSpeed
    FROM constructors INNER JOIN 
        (drivers INNER JOIN 
            (races INNER JOIN results ON races.raceId = results.raceId) 
        ON drivers.driverId = results.driverId) 
    ON constructors.constructorId = results.constructorId
    WHERE ((races.year) = 2010);
    

-- View 2: Join at least two tables and a subquery and use somewhere a grouping with having! 
-- Drivers with podium positions of on the Hungaroring
CREATE OR REPLACE VIEW POL_POSITION_DRIVERS_ON_HUNGARORING AS
    SELECT drivers.forename, drivers.surname, drivers.nationality, ID, Position
    FROM drivers INNER JOIN 
        (races INNER JOIN 
            (SELECT driverId as ID, POSITIONTEXT as Position FROM 
            results WHERE POSITIONTEXT = '1' OR POSITIONTEXT = '2' OR POSITIONTEXT = '3') 
        ON races.raceId = ID) 
    ON drivers.driverId = ID
    GROUP BY drivers.forename, drivers.surname, races.name, drivers.nationality, ID, Position
    HAVING (((races.name) = 'Hungarian Grand Prix'));
    
    
-- View 3: Query using a set operator!
-- Who is an italian driver or drives an italian car
CREATE OR REPLACE VIEW ITALIAN_DRIVERS AS
    (SELECT DISTINCT results.driverid FROM drivers 
        INNER JOIN results ON results.driverId = drivers.driverId 
        WHERE drivers.nationality = 'Italian')
    UNION
        (SELECT DISTINCT results.driverid FROM constructors 
        INNER JOIN results ON results.constructorId = constructors.constructorId 
        WHERE constructors.nationality = 'Italian');


-- PLSQL function : Which queries one of your view, using parameter(s) and cursor!
-- Podium Drivers on Hungaroring by nationality.
CREATE OR REPLACE FUNCTION hungaroring_filter(nationality_param VARCHAR2)
RETURN NUMBER
is
    CURSOR curs1 IS SELECT forename, surname, nationality, id, position 
    FROM POL_POSITION_DRIVERS_ON_HUNGARORING WHERE nationality = nationality_param;
    rec curs1%ROWTYPE;
    counter int;
BEGIN
    OPEN curs1;
    LOOP
        FETCH curs1 INTO rec;
            EXIT WHEN curs1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(rec.forename || ', ' || rec.surname || ', -' || rec.nationality || '-, Position: ' || rec.position);
    END LOOP;
    counter := curs1%ROWCOUNT;
    CLOSE curs1;
    RETURN counter;
END;

SET SERVEROUTPUT ON 
select hungaroring_filter('Belgian') from dual;
select hungaroring_filter('German') from dual;


-- PLSQL Procedure: PLSQL procedure which modifies your database, using parameter(s) and cursor
-- Generate name code for drivers
create or replace procedure generate_code is
    cursor curs1 is 
        select * from drivers 
            where drivers.code is null 
            or 
            drivers.code !=  UPPER(SUBSTR(drivers.surname,1,3))
    for update;
    rec curs1%ROWTYPE;
BEGIN
    for rec in curs1 loop
        update drivers set drivers.code = UPPER(SUBSTR(drivers.surname,1,3)) 
        where current of curs1;
    end loop;
END;

call generate_code();

-- 1 Complex trigger: Log and generate drivercode
CREATE OR REPLACE TRIGGER NEW_DRIVER_TRIGGER 
AFTER INSERT OR UPDATE ON DRIVERS
BEGIN
  IF INSERTING THEN
    DBMS_OUTPUT.PUT_LINE('New Driver is begin added');
    INSERT INTO DRIVERS_LOG (log_date, action) VALUES (SYSDATE, 'INSERT');
    generate_code();
  ELSIF UPDATING THEN
    DBMS_OUTPUT.PUT_LINE('A Driver is begin modified');
    INSERT INTO DRIVERS_LOG (log_date, action) VALUES (SYSDATE, 'UPDATE');
    generate_code();
  END IF;
END;