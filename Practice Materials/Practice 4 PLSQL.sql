drop table emp_tmp;
create table emp_tmp as (select * from emp);

drop table dept_tmp;
create table dept_tmp as (select * from dept);

drop table SAL_CAT_TMP;
CREATE TABLE SAL_CAT_TMP AS (SELECT * FROM NIKOVITS.SAL_CAT)

SELECT * FROM emp_tmp;
SELECT * FROM dept_tmp;
SELECT * FROM SALGRADE_TMP;

SELECT ENAME, SAL FROM EMP JOIN SAL_CAT_TMP 
    ON EMP.SAL >= SAL_CAT_TMP.LOWEST_SAL AND EMP.SAL < SAL_CAT_TMP.HIGHEST_SAL
    WHERE SAL_CAT_TMP.CATEGORY = 1;

-- 5 . Create a function which returns the average salary of employees in a department! Use cursor!
create or replace function cat_avg(n integer)
return number
is
    cursor curs1 is select ename, sal from emp join sal_cat 
        on emp.sal >= sal_cat.lowest_sal and emp.sal < sal_cat.highest_sal
        where sal_cat.category = n;
    rec curs1%ROWTYPE;
    s float;
    c int;
BEGIN
    s := 0.0;
    c := 0;
    OPEN curs1;
    LOOP
        FETCH curs1 INTO rec;
        EXIT WHEN curs1%NOTFOUND;
        c := c + 1;
        s := s + rec.sal;
    END LOOP;
    CLOSE curs1;
    return round((s/c),2);
END;

select cat_avg(2) from dual;

-- 6 Create a procedure which takes the employees in alphabetical order and outputs the name and salary of the ones with odd rownumber! Use cursor!
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE PROC6 IS
    CURSOR CURS1 IS SELECT ENAME, SAL FROM EMP ORDER BY ENAME;
    REC CURS1%ROWTYPE;
BEGIN
    OPEN CURS1;
    LOOP
        FETCH CURS1 INTO REC;
        EXIT WHEN CURS1%NOTFOUND;
        IF CURS1%ROWCOUNT MOD 2 = 1 THEN
            DBMS_OUTPUT.PUTLINE(REC.ENAME || '-' || REC.SAL);
        END IF;
    END LOOP;
    CLOSE CURS1;
END;
    
CALL PROC6();

-- 7 - WORKS Create the table ’emp2’ from the table ’emp’ and add a row_num column to it! Create a procedure, which fills this column with increasing number in lexicongraphical order of the employees for every employee in emp2! Use cursor!

create table emp2 as select 1 row_num, emp.* from emp;

select * from emp2 order by ename;

create or replace procedure proc7 is
    cursor curs1 is select * from emp2 order by ename for update;
    rec curs1%ROWTYPE;
    c int := 0;
BEGIN
    for rec in curs1 loop
        c := c + 1;
        update emp2 set row_num = c where current of curs1;
    end loop;
END;

call proc7();

-- 8 Create a procedure that increases the salary of those employees in ’emp2’ by 50% who have a prime number in the row_num column! Use cursor!
select * from emp2 where prime(row_num) = 1;

create or replace procedure proc8 is
    cursor curs2 is select * from emp2 where prime(row_num) = 1 for update;
    rec curs2%ROWTYPE;
begin
    for rec in curs2 loop
        update emp2 set sal = sal * 1.5 where current of curs2;
    end loop;
end;

call proc8();

-- 9 Create a procedure which deletes employees of a given department from the table ’emp2’! Use cursor!
drop table emp2;
create table emp2 as select 1 row_num, emp.* from emp;
select * from emp2 order by ename;

create or replace procedure proc9(n integer) is
    cursor curs is select * from emp2 join sal_cat_tmp
        on sal between lowest_sal and highest_sal
        where category = n for update;
begin
    for rec in curs loop
        --dbms_output.putline(rec.ename);
        delete from emp2 where rec.ename = emp2.ename;
    end loop;
    commit;
end;
        
call proc9(3);

-- 10 Create a procedure that increases the salary of the employees, who work in the given department, by 1! After the modification, output the modified average of salary!
-- Not done


-- View
create or replace view boston_or_chicago as
    select empno, ename, deptno, dname, loc
    from emp natural join dept
    where loc = 'BOSTON' or loc = 'CHICAGO';
    
create or replace trigger boston_chicago_trigger
    instead of insert on boston_or_chicago
    for each row
begin
    insert into emp(empno, ename, deptno) values(:new.empno, :new.ename, :new.deptno);
    insert into dept(deptno, dname, loc) values(:new.deptno, :new.dname, :new.loc);
    dbms_output.put_line('Successfully inserted into emp and dept!');
end;

insert into boston_or_chicago(empno, ename, deptno, dname, loc)
values(6, 'Ename6', 10, 'Deptname10', 'BOSTON');

select * from emp;

-- Trigger

create or replace trigger deptno_trigger
    after insert or update on emp
    for each row
declare 
    c integer;
begin
    select count(*) into c from dept where deptno = :new.deptno;
    if c = 0 then
        insert into dept(deptno) values(:new.deptno);
        dbms_output.put_line('New department inserted too');
    end if;
end;

select * from emp;

update emp set deptno = 5 where ename = 'Ename5';

select * from dept;

        