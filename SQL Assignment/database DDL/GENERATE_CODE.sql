--------------------------------------------------------
--  File created - Saturday-April-10-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure GENERATE_CODE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ABIOWE"."GENERATE_CODE" is
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

/
