--------------------------------------------------------
--  File created - Saturday-April-10-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Function HUNGARORING_FILTER
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ABIOWE"."HUNGARORING_FILTER" (nationality_param VARCHAR2)
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

/
