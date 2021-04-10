--------------------------------------------------------
--  File created - Saturday-April-10-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table DRIVERS_LOG
--------------------------------------------------------

  CREATE TABLE "ABIOWE"."DRIVERS_LOG" 
   (	"LOG_DATE" DATE, 
	"ACTION" VARCHAR2(50 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
REM INSERTING into ABIOWE.DRIVERS_LOG
SET DEFINE OFF;
Insert into ABIOWE.DRIVERS_LOG (LOG_DATE,ACTION) values (to_date('10-APR-21','DD-MON-RR'),'UPDATE');
Insert into ABIOWE.DRIVERS_LOG (LOG_DATE,ACTION) values (to_date('10-APR-21','DD-MON-RR'),'INSERT');
Insert into ABIOWE.DRIVERS_LOG (LOG_DATE,ACTION) values (to_date('10-APR-21','DD-MON-RR'),'UPDATE');
