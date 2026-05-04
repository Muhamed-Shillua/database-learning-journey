=====================================
-- DQL
=====================================
-------------------------------------
-- 1) Display (Using Union Function)
-------------------------------------
SELECT
    D.Dependent_name,
    D.Sex
FROM Dependent D
JOIN Employee E
    ON D.ESSN = E.SSN
WHERE D.Sex = 'F'
AND E.Sex = 'F'

UNION

SELECT
    D.Dependent_name,
    D.Sex
FROM Dependent D
JOIN Employee E
    ON D.ESSN = E.SSN
WHERE D.Sex = 'M'
AND E.Sex = 'M';


-------------------------------------
-- 2) Total hours per project
-------------------------------------
SELECT
    P.Pname,
    SUM(W.Hours)
FROM Project P
JOIN Works_for W
    ON P.Pnumber = W.Pno
GROUP BY P.Pname;


-------------------------------------
-- 3) Department with smallest Employee ID
-------------------------------------
SELECT
    D.Dnum,
    D.Dname
FROM Departments D
JOIN Employee E
    ON D.Dnum = E.Dno
WHERE E.SSN = (SELECT MIN(SSN) FROM Employee);


-------------------------------------
-- 4) Department salary statistics
-------------------------------------
SELECT
    D.Dname,
    MAX(E.Salary),
    MIN(E.Salary),
    AVG(E.Salary)
FROM Departments D
JOIN Employee E
    ON D.Dnum = E.Dno
GROUP BY D.Dname;


-------------------------------------
-- 5) Managers with no dependents
-------------------------------------
SELECT
    E.SSN,
    E.Fname,
    E.Lname
FROM Employee E
JOIN Departments D
    ON E.SSN = D.MGRSSN
LEFT JOIN Dependent Dep
    ON Dep.ESSN = E.SSN
WHERE Dep.ESSN IS NULL;


-------------------------------------
-- 6) Departments avg salary < company avg
-------------------------------------
SELECT
    D.Dnum,
    D.Dname,
    COUNT(E.SSN)
FROM Departments D
JOIN Employee E
    ON D.Dnum = E.Dno
GROUP BY D.Dnum, D.Dname
HAVING AVG(E.Salary) < (SELECT AVG(Salary) FROM Employee);


-------------------------------------
-- 7) Employees and projects ordered
-------------------------------------
SELECT
    D.Dname,
    E.Fname,
    E.Lname,
    P.Pname
FROM Employee E
JOIN Departments D
    ON E.Dno = D.Dnum
JOIN Works_for W
    ON E.SSN = W.ESSn
JOIN Project P
    ON W.Pno = P.Pnumber
ORDER BY D.Dname, E.Lname, E.Fname;


-------------------------------------
-- 8) Max 2 salaries
-------------------------------------
SELECT DISTINCT Salary
FROM Employee E1
WHERE 2 > (
    SELECT COUNT(DISTINCT Salary)
    FROM Employee E2
    WHERE E2.Salary > E1.Salary
);


-------------------------------------
-- 9) Employees matching dependent names
-------------------------------------
SELECT DISTINCT
    E.Fname + ' ' + E.Lname
FROM Employee E
JOIN Dependent D
    ON E.Fname + ' ' + E.Lname = D.Dependent_name;


-------------------------------------
-- 10) Update salaries for Al Rabwah
-------------------------------------
UPDATE Employee
SET Salary = Salary * 1.30
WHERE SSN IN (
    SELECT ESSn
    FROM Works_for W
    JOIN Project P
        ON W.Pno = P.Pnumber
    WHERE P.Pname = 'Al Rabwah'
);


-------------------------------------
-- 11) Employees with dependents
-------------------------------------
SELECT
    E.SSN,
    E.Fname + ' ' + E.Lname
FROM Employee E
WHERE EXISTS (
    SELECT 1
    FROM Dependent D
    WHERE D.ESSN = E.SSN
);


=====================================
-- DML
=====================================

-------------------------------------
-- 1) Insert new department
-------------------------------------
INSERT INTO Departments (Dnum, Dname, MGRSSN, MGRStartDate)
VALUES (100, 'DEPT IT', 112233, '2006-11-01');


-------------------------------------
-- 2a) Update department 100
-------------------------------------
UPDATE Departments
SET MGRSSN = 968574
WHERE Dnum = 100;


-------------------------------------
-- 2b) Dept 20 manager change
-------------------------------------
UPDATE Departments
SET MGRSSN = 102672
WHERE Dnum = 20;


-------------------------------------
-- 2c) Assign employee under manager
-------------------------------------
UPDATE Employee
SET Superssn = 102672
WHERE SSN = 102660;


-------------------------------------
-- 3) Delete employee (with handling)
-------------------------------------
DELETE FROM Works_for
WHERE ESSn = 223344;

DELETE FROM Dependent
WHERE ESSN = 223344;

UPDATE Departments
SET MGRSSN = NULL
WHERE MGRSSN = 223344;

DELETE FROM Employee
WHERE SSN = 223344;
