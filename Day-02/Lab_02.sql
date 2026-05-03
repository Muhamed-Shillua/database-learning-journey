------------------------------------------------------------
-- 1) Display All Employees Data
------------------------------------------------------------
SELECT *
FROM Employee;


------------------------------------------------------------
-- 2) Employee First Name, Last Name, Salary, Department No
------------------------------------------------------------
SELECT 
    Fname AS First_Name,
    Lname AS Last_Name,
    Salary,
    Dno AS Department_No
FROM Employee;


------------------------------------------------------------
-- 3) Projects Names, Locations, and Responsible Department
------------------------------------------------------------
SELECT 
    P.Pname AS Project_Name,
    P.Plocation AS Location,
    D.Dname AS Department_Name
FROM Project P
JOIN Department D 
    ON P.Dnum = D.Dnum;


------------------------------------------------------------
-- 4) Employee Full Name and Annual Commission (10%)
------------------------------------------------------------
SELECT 
    Fname + ' ' + Lname AS Full_Name,
    Salary * 12 * 0.10 AS ANNUAL_COMM
FROM Employee;


------------------------------------------------------------
-- 5) Employees Earning More Than 1000 Monthly
------------------------------------------------------------
SELECT 
    SSN AS Employee_ID,
    Fname + ' ' + Lname AS Employee_Name
FROM Employee
WHERE Salary > 1000;


------------------------------------------------------------
-- 6) Employees Earning More Than 10000 Annually
------------------------------------------------------------
SELECT 
    SSN AS Employee_ID,
    Fname + ' ' + Lname AS Employee_Name
FROM Employee
WHERE Salary * 12 > 10000;


------------------------------------------------------------
-- 7) Female Employees Names and Salaries
------------------------------------------------------------
SELECT 
    Fname + ' ' + Lname AS Employee_Name,
    Salary
FROM Employee
WHERE Sex = 'F';


------------------------------------------------------------
-- 8) Departments Managed by Manager ID = 968574
------------------------------------------------------------
SELECT 
    Dnum AS Department_ID,
    Dname AS Department_Name
FROM Department
WHERE MGRSSN = 968574;


------------------------------------------------------------
-- 9) Projects Controlled by Department 10
------------------------------------------------------------
SELECT 
    Pnumber AS Project_ID,
    Pname AS Project_Name,
    Plocation AS Location
FROM Project
WHERE Dnum = 10;