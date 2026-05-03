/*
    📘 DQL Overview
*/

-- Section 01: DQL Definition
---- Data Query Language
---- Used to retrieve/query data from database
---- Main Command:
------ SELECT


-- Section 02: SELECT Basics
---- Used to fetch data from tables

-- Select all columns
SELECT * FROM Employee;

-- Select specific columns
SELECT Emp_Name, Salary FROM Employee;


-- Section 03: Filtering Data (WHERE)
---- Used to filter rows based on conditions

SELECT * FROM Employee
WHERE Salary > 5000;

SELECT * FROM Employee
WHERE Emp_Name = 'Ahmed';


-- Section 04: Sorting Data (ORDER BY)
---- Used to sort results

-- Ascending (default)
SELECT * FROM Employee
ORDER BY Salary ASC;

-- Descending
SELECT * FROM Employee
ORDER BY Salary DESC;


-- Section 05: DISTINCT
---- Remove duplicate values

SELECT DISTINCT Salary
FROM Employee;


-- Section 06: Aliases (AS)
---- Rename columns in output only

SELECT Emp_Name AS Name
FROM Employee;


-- Section 07: Logical Operators
---- AND / OR / NOT

SELECT * FROM Employee
WHERE Salary > 5000 AND Emp_Name = 'Ahmed';

SELECT * FROM Employee
WHERE Salary > 5000 OR Emp_Name = 'Ali';

SELECT * FROM Employee
WHERE NOT Salary = 5000;


-- Section 08: IN / BETWEEN / LIKE

-- IN → multiple values
SELECT * FROM Employee
WHERE Emp_Name IN ('Ahmed', 'Ali');

-- BETWEEN → range
SELECT * FROM Employee
WHERE Salary BETWEEN 4000 AND 8000;

-- LIKE → pattern matching
SELECT * FROM Employee
WHERE Emp_Name LIKE 'A%';   -- starts with A


-- Section 09: NULL Handling

SELECT * FROM Employee
WHERE Salary IS NULL;

SELECT * FROM Employee
WHERE Salary IS NOT NULL;


-- Section 10: LIMIT (or TOP in SQL Server)

-- MySQL / PostgreSQL
SELECT * FROM Employee
LIMIT 5;

-- SQL Server
SELECT TOP 5 * FROM Employee;


-- Section 11: AGGREGATE FUNCTIONS (Basic DQL)

-- COUNT → number of rows
SELECT COUNT(*) FROM Employee;

-- AVG → average value
SELECT AVG(Salary) FROM Employee;

-- SUM → total
SELECT SUM(Salary) FROM Employee;

-- MAX / MIN
SELECT MAX(Salary) FROM Employee;
SELECT MIN(Salary) FROM Employee;