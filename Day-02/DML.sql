/*
    📘 DML Overview
*/

-- Section 01: DML Definition
---- Data Manipulation Language
---- Used to manipulate data inside tables (NOT structure)

---- Main Commands:
------ INSERT
------ SELECT
------ UPDATE
------ DELETE


-- Section 02: INSERT
---- Used to insert data into tables

-- Insert full row
INSERT INTO Employee (Emp_ID, Emp_Name, Salary)
VALUES(1, 'Ahmed', 20000);

-- Insert multiple rows
INSERT INTO Employee (Emp_ID, Emp_Name, Salary)
VALUES 
(2, 'Ali', 6000),
(3, 'Sara', 7000);


-- Section 03: SELECT
---- Used to retrieve data from tables

-- Select all columns
SELECT * FROM Employee;

-- Select specific columns
SELECT Emp_Name, Salary FROM Employee;

-- Select with condition
SELECT * FROM Employee
WHERE Salary > 5000;

-- Sorting data
SELECT * FROM Employee
ORDER BY Salary DESC;


-- Section 04: UPDATE
---- Used to modify existing data

-- Update single row
UPDATE Employee
SET Salary = 8000
WHERE Emp_ID = 1;

-- Update multiple rows
UPDATE Employee
SET Salary = Salary + 1000
WHERE Salary < 7000;


-- Section 05: DELETE
---- Used to delete rows from table

-- Delete specific row
DELETE FROM Employee
WHERE Emp_ID = 2;

-- Delete all rows (be careful)
DELETE FROM Employee;

---- Notes:
------ DELETE can use WHERE condition
------ DELETE logs each row removal


-- Section 06: IMPORTANT NOTES
---- Difference between DELETE and TRUNCATE:

-- DELETE:
------ removes specific rows
------ can use WHERE
------ slower
------ record level

-- TRUNCATE:
------ removes all rows
------ no WHERE
------ faster
------ (DDL operation in some DBs)


-- Section 07: SELECT ADVANCED (Basics)

-- DISTINCT (remove duplicates)
SELECT DISTINCT Salary FROM Employee;

-- Aliases
SELECT Emp_Name AS Name FROM Employee;

-- Filtering with multiple conditions
SELECT * FROM Employee
WHERE Salary > 5000 AND Emp_Name = 'Ahmed';