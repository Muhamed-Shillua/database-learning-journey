-------------------------------------------------
-- Create User Defined Datatype + Rule
-------------------------------------------------
CREATE TYPE loc FROM NCHAR(2);
GO

CREATE RULE loc_rule AS @value IN ('NY','DS','KW');
GO

EXEC sp_bindrule loc_rule, 'loc';
GO

-------------------------------------------------
-- Department Table
-------------------------------------------------
CREATE TABLE Department
(
    DeptNo CHAR(2) PRIMARY KEY,
    DeptName VARCHAR(50),
    Location loc DEFAULT 'NY'
);

INSERT INTO Department VALUES
('d1','Research','NY'),
('d2','Accounting','DS'),
('d3','Marketing','KW');

-------------------------------------------------
-- Employee Table
-------------------------------------------------
CREATE RULE salary_rule AS @value < 6000;
GO

CREATE TABLE Employee
(
    EmpNo INT PRIMARY KEY,
    EmpFname VARCHAR(50) NOT NULL,
    EmpLname VARCHAR(50) NOT NULL,
    DeptNo CHAR(2),
    Salary INT UNIQUE,
    CONSTRAINT FK_Dept FOREIGN KEY (DeptNo)
        REFERENCES Department(DeptNo)
);

EXEC sp_bindrule salary_rule, 'Employee.Salary';

INSERT INTO Employee VALUES
(25348,'Mathew','Smith','d3',2500),
(10102,'Ann','Jones','d3',3000),
(18316,'John','Barrimore','d1',2400),
(29346,'James','James','d2',2800),
(9031,'Lisa','Bertoni','d2',4000),
(2581,'Elisa','Hansel','d2',3600),
(28559,'Sybl','Moser','d1',2900);

-------------------------------------------------
-- Project Table
-------------------------------------------------
CREATE TABLE Project
(
    ProjectNo CHAR(2) PRIMARY KEY,
    ProjectName VARCHAR(50) NOT NULL,
    Budget MONEY NULL
);

INSERT INTO Project VALUES
('p1','Apollo',120000),
('p2','Gemini',95000),
('p3','Mercury',185600);

-------------------------------------------------
-- Works_on Table
-------------------------------------------------
CREATE TABLE Works_on
(
    EmpNo INT NOT NULL,
    ProjectNo CHAR(2) NOT NULL,
    Job VARCHAR(50) NULL,
    Enter_Date DATE NOT NULL DEFAULT GETDATE(),
    PRIMARY KEY (EmpNo, ProjectNo),
    FOREIGN KEY (EmpNo) REFERENCES Employee(EmpNo),
    FOREIGN KEY (ProjectNo) REFERENCES Project(ProjectNo)
);

INSERT INTO Works_on VALUES
(10102,'p1','Analyst','2006-10-01'),
(10102,'p3','Manager','2012-01-01'),
(25348,'p2','Clerk','2007-02-15'),
(18316,'p2',NULL,'2007-06-01'),
(29346,'p2',NULL,'2006-12-15'),
(2581,'p3','Analyst','2007-10-15'),
(9031,'p1','Manager','2007-04-15'),
(28559,'p1',NULL,'2007-08-01');

-------------------------------------------------
-- Table Modification
-------------------------------------------------
ALTER TABLE Employee ADD TelephoneNumber VARCHAR(20);
ALTER TABLE Employee DROP COLUMN TelephoneNumber;

-------------------------------------------------
-- Schemas
-------------------------------------------------
CREATE SCHEMA Company;
CREATE SCHEMA HR;

ALTER SCHEMA Company TRANSFER dbo.Department;
ALTER SCHEMA Company TRANSFER dbo.Project;
ALTER SCHEMA HR TRANSFER dbo.Employee;

-------------------------------------------------
-- Display Constraints
-------------------------------------------------
SELECT *
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'Employee';

-------------------------------------------------
-- Synonym
-------------------------------------------------
CREATE SYNONYM Emp FOR HR.Employee;

-------------------------------------------------
-- Queries
-------------------------------------------------

-- 5. Increase budget by 10%
UPDATE Project
SET Budget = Budget * 1.1
WHERE ProjectNo IN (
    SELECT ProjectNo
    FROM Works_on
    WHERE EmpNo = 10102
);

-- 6. Change department name to Sales for employee James
UPDATE Company.Department
SET DeptName = 'Sales'
WHERE DeptNo IN (
    SELECT DeptNo
    FROM HR.Employee
    WHERE EmpFname = 'James'
);

-- 7. Update Enter_Date
UPDATE Works_on
SET Enter_Date = '2007-12-12'
WHERE ProjectNo = 'p1'
AND EmpNo IN (
    SELECT EmpNo
    FROM HR.Employee E
    JOIN Company.Department D
    ON E.DeptNo = D.DeptNo
    WHERE D.DeptName = 'Sales'
);

-- 8. Delete employees in KW departments
DELETE FROM Works_on
WHERE EmpNo IN (
    SELECT EmpNo
    FROM HR.Employee E
    JOIN Company.Department D
    ON E.DeptNo = D.DeptNo
    WHERE D.Location = 'KW'
);
