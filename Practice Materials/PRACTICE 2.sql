CREATE TABLE EMP AS (SELECT * FROM nikovits.emp);
CREATE TABLE DEPT AS (SELECT * FROM NIKOVITS.dept);

SELECT * FROM DEPT

-- SIMPLE QUERIES
-- 1 Who has any commission? (NOT NULL) 
SELECT * FROM EMP WHERE COMM IS NOT NULL

-- 2 Which employees work on a department not located at Boston or Chicago? (MINUS) 
(SELECT * FROM EMP NATURAL JOIN DEPT)
MINUS
(SELECT * FROM EMP NATURAL JOIN DEPT WHERE LOC = 'BOSTON' OR LOC = 'CHICAGO')

-- 3 Who earns more than 3000 or works on dept. 30? (UNION) 
(SELECT ENAME FROM EMP WHERE deptno = 30)
UNION
(SELECT ENAME FROM EMP WHERE SAL > 3000)

-- 4 Who was hired before 01-06-1981? (DATE TYPE, FUNCTIONS) 
SELECT * FROM EMP WHERE TO_DATE('01-06-1981', 'DD-MM-YYYY') > HIREDATE;

-- 5 How much is the maximal salary of the employees? (MAX)
SELECT MAX(SAL) FROM EMP;

-- 6 How much is the sum of the salary of the employees? (SUM)
SELECT SUM(SAL) FROM EMP;

-- 7 How much is the average salary of the employees of department 20? (AVG)
SELECT AVG(SAL) FROM EMP WHERE DEPTNO = 20;

-- 8 How many different jobs are there amongst the employees? (DISTINCT)
SELECT COUNT(DISTINCT JOB) FROM EMP;

-- 9  How many employees has greater salary than 2000? (COUNT)
SELECT COUNT(*) FROM EMP WHERE SAL > 2000;

-- 10 List the average of the salary grouped by the departments! (GROUP BY)
SELECT DEPTNO, ROUND(AVG(SAL), 2) FROM EMP GROUP BY DEPTNO;

-- 11 List the number of workers for each departments! (COUNT(*))
SELECT DEPTNO, COUNT(*) FROM EMP GROUP BY DEPTNO;

-- 12 List the average salary of those departments which has average salary greater than 2000! (AS AVERAGE)
SELECT DEPTNO, ROUND(AVG(SAL), 2) AS AVERAGE FROM EMP GROUP BY DEPTNO HAVING ROUND(AVG(SAL), 2) > 2000;

-- 13  List the average salary of those departments which has more than 4 workers! (HAVING)
SELECT DEPTNO, ROUND(AVG(SAL), 2) AS AVERAGE FROM EMP GROUP BY DEPTNO HAVING COUNT(*) > 4;


-- SUBQUERIES AND JOINTS
-- 14 Who has the same salary and works on the same department than MARTIN (SUBQUERRIES)
SELECT * FROM EMP 
WHERE SAL = (SELECT SAL FROM EMP WHERE ENAME = 'MARTIN')
AND
DEPTNO = (SELECT DEPTNO FROM EMP WHERE ENAME = 'MARTIN')
AND NOT ENAME = 'MARTIN';

-- 14 Who has the same salary and works on the same department than MARTIN (CROSS JOIN)
SELECT E.* FROM EMP E CROSS JOIN (SELECT * FROM EMP WHERE ENAME = 'MARTIN') MARTIN
WHERE E.SAL = MARTIN.SAL AND E.DEPTNO = MARTIN.DEPTNO
AND NOT E.ENAME = 'MARTIN';

-- 15 Which employees work on a department located at Boston or Chicago? (NATURAL JOIN - KEEPS ONLY ONE ID)
SELECT ENAME FROM EMP NATURAL JOIN DEPT WHERE LOC = 'BOSTON' OR LOC = 'CHICAGO';

-- 15 Which employees work on a department located at Boston or Chicago? (JOIN - KEEPS TWO OF THE COMMON ATTRIBUTES)
SELECT * FROM EMP JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO 
WHERE LOC = 'BOSTON' OR LOC = 'CHICAGO';

-- 16 Who earns more than ALLEN? (SUBQUERRY)
SELECT * FROM EMP WHERE SAL > (SELECT SAL FROM EMP WHERE ENAME = 'ALLEN');

-- 17 Select the employees with their job who have the lowest/highest salary! (HIGHEST/LOWEST SALARY)
SELECT ENAME, JOB FROM EMP 
WHERE SAL = (SELECT MIN(SAL) FROM EMP)
OR SAL = (SELECT MAX(SAL) FROM EMP);

-- 18 List the lowest salary for every department where the lowest salary is below the lowest salary of dept. 30 (SOUNDS DIFFICULT)
SELECT DEPTNO, MIN(SAL) FROM EMP  GROUP BY DEPTNO HAVING
(SELECT MIN(SAL) FROM EMP WHERE DEPTNO = 30) > MIN(SAL);

-- 19 Who earns less than any/every CLERK? 
SELECT ENAME FROM EMP WHERE 
SAL < ANY(SELECT SAL FROM EMP WHERE JOB = 'CLERK')
OR SAL < ALL(SELECT SAL FROM EMP WHERE JOB = 'CLERK');

-- 19 ? Who earns less than any/every CLERK? 
SELECT ENAME FROM EMP WHERE 
SAL < ANY(SELECT SAL FROM EMP WHERE JOB = 'CLERK');

SELECT ENAME FROM EMP WHERE 
SAL < ALL(SELECT SAL FROM EMP WHERE JOB = 'CLERK');

-- 20 Which dept. has no employee? 
SELECT DNAME FROM DEPT D LEFT OUTER JOIN EMP E 
ON E.DEPTNO = D.DEPTNO GROUP BY D.DNAME HAVING COUNT(E.EMPNO) = 0;

-- EXAMPLE FOR LEF OUTER JOIN
SELECT * FROM DEPT D LEFT OUTER JOIN EMP E ON E.DEPTNO = D.DEPTNO;
SELECT * FROM DEPT D RIGHT OUTER JOIN EMP E ON E.DEPTNO = D.DEPTNO;

-- 21 Determine the number of employees for every deptartment! (0 where the dept has no employee) 
SELECT DNAME, COUNT(E.EMPNO) FROM DEPT D FULL OUTER JOIN EMP E
ON E.DEPTNO = D.DEPTNO GROUP BY D.DNAME;

SELECT DNAME, COUNT(E.EMPNO) FROM DEPT D RIGHT OUTER JOIN EMP E
ON E.DEPTNO = D.DEPTNO GROUP BY D.DNAME;

SELECT DNAME, COUNT(E.EMPNO) FROM DEPT D LEFT OUTER JOIN EMP E
ON E.DEPTNO = D.DEPTNO GROUP BY D.DNAME;
