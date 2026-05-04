------------------------------------------------------------
-- 1) Department info + Manager info
------------------------------------------------------------
SELECT 
    D.Dnum AS Dept_ID,
    D.Dname AS Dept_Name,
    E.SSN AS Manager_ID,
    E.Fname + ' ' + E.Lname AS Manager_Name
FROM Departments D
JOIN Employee E 
    ON D.MGRSSN = E.SSN;


------------------------------------------------------------
-- 2) Departments and their Projects
------------------------------------------------------------
SELECT 
    D.Dname AS Department_Name,
    P.Pname AS Project_Name
FROM Departments D
JOIN Project P 
    ON D.Dnum = P.Dnum;


------------------------------------------------------------
-- 3) Dependents + Employee they belong to
------------------------------------------------------------
SELECT 
    D.*,
    E.Fname + ' ' + E.Lname AS Employee_Name
FROM Dependent D
JOIN Employee E 
    ON D.ESSN = E.SSN;


------------------------------------------------------------
-- 4) Projects in Cairo or Alex
------------------------------------------------------------
SELECT 
    P.Pnumber AS ID,
    P.Pname,
    P.Plocation
FROM Project P
WHERE P.City IN ('Cairo', 'Alex');


------------------------------------------------------------
-- 5) Projects starting with 'A'
------------------------------------------------------------
SELECT *
FROM Project
WHERE Pname LIKE 'A%';


------------------------------------------------------------
-- 6) Employees in Dept 30 with salary 1000–2000
------------------------------------------------------------
SELECT *
FROM Employee
WHERE Dno = 30
AND Salary BETWEEN 1000 AND 2000;


------------------------------------------------------------
-- 7) Employees in Dept 10 working ≥10 hours on AL Rabwah
------------------------------------------------------------
SELECT 
    E.Fname + ' ' + E.Lname AS Employee_Name
FROM Employee E
JOIN Works_for W ON E.SSN = W.ESSn
JOIN Project P ON W.Pno = P.Pnumber
WHERE E.Dno = 10
AND P.Pname = 'AL Rabwah'
AND W.Hours >= 10;


------------------------------------------------------------
-- 8) Employees supervised by Kamel Mohamed
------------------------------------------------------------
SELECT 
    E1.Fname + ' ' + E1.Lname AS Employee_Name
FROM Employee E1
JOIN Employee E2 
    ON E1.Superssn = E2.SSN
WHERE E2.Fname = 'Kamel'
AND E2.Lname = 'Mohamed';


------------------------------------------------------------
-- 9) Employees + Projects (sorted by Project Name)
------------------------------------------------------------
SELECT 
    E.Fname + ' ' + E.Lname AS Employee_Name,
    P.Pname AS Project_Name
FROM Employee E
JOIN Works_for W ON E.SSN = W.ESSn
JOIN Project P ON W.Pno = P.Pnumber
ORDER BY P.Pname;


------------------------------------------------------------
-- 10) Cairo Projects + Department + Manager details
------------------------------------------------------------
SELECT 
    P.Pnumber AS Project_Number,
    D.Dname AS Department_Name,
    E.Lname AS Manager_Last_Name,
    E.Address,
    E.Bdate
FROM Project P
JOIN Departments D 
    ON P.Dnum = D.Dnum
JOIN Employee E 
    ON D.MGRSSN = E.SSN
WHERE P.City = 'Cairo';


------------------------------------------------------------
-- 11) All Managers Data
------------------------------------------------------------
SELECT E.*
FROM Departments D
JOIN Employee E 
    ON D.MGRSSN = E.SSN;


------------------------------------------------------------
-- 12) Employees + Dependents (even if no dependents)
------------------------------------------------------------
SELECT 
    E.*,
    D.*
FROM Employee E
LEFT JOIN Dependent D 
    ON E.SSN = D.ESSN;


------------------------------------------------------------
-- DML
-- 1) Insert yourself as employee (dept 30)
------------------------------------------------------------
INSERT INTO Employee 
(SSN, Fname, Lname, Bdate, Address, Sex, Salary, Superssn, Dno)
VALUES 
(102672, 'Muhamed', 'Shillua', '1999-11-01', 'Cairo', 'M', 3000, 112233, 30);


------------------------------------------------------------
-- 2) Insert friend (no salary, no Superssn)
------------------------------------------------------------
INSERT INTO Employee 
(SSN, Fname, Lname, Bdate, Address, Sex, Dno)
VALUES
(102660, 'Yahia', 'Saleh', '2000-01-01', 'Cairo', 'M', 30);


------------------------------------------------------------
-- 3) Increase salary by 20%
------------------------------------------------------------
UPDATE Employee
	SET Salary = Salary * 1.20
WHERE SSN = 102672;