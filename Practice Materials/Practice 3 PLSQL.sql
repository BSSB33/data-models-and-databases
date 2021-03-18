drop table emp_tmp;
create table emp_tmp as (select * from emp);

drop table dept_tmp;
create table dept_tmp as (select * from dept);

drop table SAL_CAT_TMP;
CREATE TABLE SAL_CAT_TMP AS (SELECT * FROM NIKOVITS.SAL_CAT)

SELECT * FROM emp_tmp;
SELECT * FROM dept_tmp;
SELECT * FROM SALGRADE_TMP;

-----------
-- PLSQL
-----------
SET SERVEROUTPUT ON;

--CREATE OR REPLACE PROCEDURE PROCEDURE_NAME
--IS
--    VARIABLE_NAME TYPE := 'VALUE';
--BEGIN
--    DBMS_OUTPUT.PUT_LINE();
--END;

--CREATE OR REPLACE FUNCTION FUNCTION_NAME(N INTEGER)
--RETURN NUMBER
--BEGIN
--END;

-- 1 Create a procedure that outputs „Hello world!”!
CREATE OR REPLACE PROCEDURE PRINT_HELLO IS
    MESSAGE varchar2(40) := 'Hello World!';
BEGIN
    DBMS_OUTPUT.PUT_LINE(MESSAGE);
END;

CALL PRINT_HELLO();

-- 2 Create a function which decides if the given number is a prime!
CREATE OR REPLACE FUNCTION PRIME(N INTEGER) RETURN NUMBER
IS
    i NUMBER := 0;
BEGIN
    IF N < 2 THEN 
        RETURN 0;
    END IF;
    
    FOR I IN 2..N/2 LOOP
        IF MOD(N, I) = 0 THEN
            RETURN 0;
        END IF;
    END LOOP;
    RETURN 1;
END;
    
SELECT PRIME(2), PRIME(3), PRIME(5), PRIME(6), PRIME(7) FROM DUAL;


-- 3 Create a function which calculates the factorial of a number!
CREATE OR REPLACE FUNCTION factorial (n POSITIVE) RETURN POSITIVE
  AUTHID DEFINER
IS
BEGIN
  IF n = 1 THEN                 -- terminating condition
    RETURN n;
  ELSE
    RETURN n * factorial(n-1);  -- recursive invocation
  END IF;
END;

-- 3 OUR SOLUTION
CREATE OR REPLACE FUNCTION MY_FACTORIAL (n INTEGER) RETURN INTEGER IS
    I NUMBER;
    RES INTEGER := 1;
BEGIN
    FOR I IN 1..N LOOP
        RES := RES * I;
    END LOOP;
    RETURN RES;
END;

SELECT MY_FACTORIAL(5) FROM DUAL;

-- 4 Create a function which calculates how many times a string occurres in another string!
CREATE OR REPLACE FUNCTION STRING_MATCH(P1 VARCHAR2, P2 VARCHAR2)
RETURN INTEGER IS
    I INT;
    RES INT := 0;
BEGIN
    FOR I IN 1..(length(p1)-length(p2)+1) LOOP
        IF SUBSTR(P1, I, LENGTH(P2)) = P2 THEN
            RES := RES + 1;
        END IF;
    END LOOP;
    RETURN RES;
END;

SELECT SUBSTR('SOMETHING', 5, 5) FROM DUAL;
SELECT STRING_MATCH('ab c ab ab de ab fg a', 'ab') from dual;


-- 5
CURSOR CURS_NAME IS SELECT SOMETHING FROM SOMEWHERE;
REC CURS_NAME%ROWTYPE
OPEN CURS_NAME;
LOOP
    FETCH CURS_NAME INTO REC;
    EXIT WHEN CURS_NAME%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(REC.COLUMN_NAME);
END LOOP;
CLOSE CURS_NAME;


CURSOR CURS_NAME IS SELECT SOMETHING FROM SOMEWHERE;
FOR REC IN CURS_NAME LOOP
    DBMS_OUTPUT.PUTLINE(REC.COLUMN_NAME)
END LOOP;

-- Querry for example: 'Williams'
ACCEPT VARIABLENAME CHAR PROMT 'Give me the value for variablename!';
SELECT * FROM EMP_TMP WHERE ENAME = '&VARIABLE';