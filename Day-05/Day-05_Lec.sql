SELECT TOP(3) *
FROM Student

SELECT TOP(3) St_Fname
FROM Student

SELECT TOP(3) *
FROM Student
WHERE St_Address = 'ALEX'

SELECT TOP(3) Salary
FROM Instructor
ORDER BY Salary DESC


SELECT TOP(3) WITH TIES *
FROM Student
ORDER BY St_Age


SELECT TOP(7) WITH TIES St_Fname, St_Age
FROM Student
ORDER BY St_Age;


SELECT NEWID() -- Global Unique Identifier (GUID) generator in SQL Server

SELECT St_Fname, NEWID() AS RandomID
FROM Student
ORDER BY NEWID() -- Randomize the order of results using NEWID()

SELECT
  St_Fname + ' ' + St_Lname AS FullName
FROM Student
ORDER BY FullName;

SELECT
  St_Fname + ' ' + St_Lname AS FullName
FROM Student
-- WHERE FullName LIKE 'A%' -- Logical error: FullName is not recognized in the WHERE clause

---- Exection Order:
------ 1. FROM     -> Determine the source tables.
------ 2. JOIN     -> Combine rows from multiple tables based on related columns.
------ 3. ON       -> Specify the join condition for combining tables.
------ 4. WHERE    -> Filter rows based on specified conditions.
------ 5. GROUP BY -> Group rows that have the same values in specified columns into summary rows.
------ 6. HAVING   -> Filter groups based on specified conditions (used with GROUP BY).
------ 7. SELECT [DISTINCT, Aggregate]   -> Determine which columns to include in the final result set.
------ 8. ORDER BY -> Sort the result set based on specified columns.
------ 9. TOP      -> Limit the number of rows returned by the query.


-- FIX SELECT Execution Order Error:
SELECT
  St_Fname + ' ' + St_Lname AS FullName
FROM Student
WHERE St_Fname + ' ' + St_Lname LIKE 'A%' -- Corrected


-- DB Objects:
-- 1. Tables: Store data in rows and columns (e.g., Student, Instructor).
-- 2. Views: Virtual tables created by a query (e.g., StudentView).
-- 3. Stored Procedures: Precompiled SQL code that can be executed with parameters (e.g., GetStudentByID).
-- 4. Functions: Reusable SQL code that returns a value (e.g., CalculateAge).
-- Rules: Define constraints and conditions on data (e.g., CHECK constraint on age).

-- Fully Qualified Object Name:
-- [ServerName].[DatebaseName].[SchemaName].[ObjectName]

-- Example of Fully Qualified Object Name:
SELECT *
FROM [MUHAMED-SHILLUA].[ITI].[dbo].[Student]

-- Using Fully Qualified Object Name to access a different database:
SELECT *
FROM [MUHAMED-SHILLUA].[Company_SD].[dbo].[Project]

-- Creating a new table by selecting data from an existing table:
SELECT * INTO NewStudent
FROM Student

-- Creating a new table in a different database
SELECT * INTO Company_SD.DBO.NewStudent
FROM Student


-- Creating an empty table with the same structure as an existing table:
SELECT * INTO NewStudent
FROM Student
WHERE 1 = 0; -- Always false condition to prevent data insertion

-- Creating a new table with specific columns and data types:
SELECT St_Id, St_Fname, St_Lname, St_Age INTO NewStudent
FROM Student

-- Insert Based on SELECT:
INSERT INTO NewStudent
SELECT St_Id, St_Fname, St_Lname, St_Age
FROM Student
WHERE St_Age > 20; -- Insert only students older than 20 into NewStudent

