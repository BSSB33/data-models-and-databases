--------------------------------------------------------
--  File created - Saturday-April-10-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Trigger NEW_DRIVER_TRIGGER
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "ABIOWE"."NEW_DRIVER_TRIGGER" 
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
/
ALTER TRIGGER "ABIOWE"."NEW_DRIVER_TRIGGER" ENABLE;
