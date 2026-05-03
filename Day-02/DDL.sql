/*
    📘 DDL Overview (Improved Version)
*/

-- Section 01: DDL Definition
---- Data Definition Language
---- Used to define and manage database structure

---- Main Commands:
------ CREATE
------ ALTER
------ DROP
------ TRUNCATE
------ RENAME (optional)


-- Section 02: CREATE
---- Used to create databases and tables

-- Create Database
CREATE DATABASE CompanyDB;

-- Create Table
CREATE TABLE Employee (
    Emp_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(50),
    Salary DECIMAL(10,2)
);


-- Section 03: ALTER
---- Used to modify existing tables

-- Add Column
ALTER TABLE Employee
ADD Email VARCHAR(100);

-- Modify Column (datatype change)
ALTER TABLE Employee
ALTER COLUMN Emp_Name VARCHAR(100);

-- Drop Column
ALTER TABLE Employee
DROP COLUMN Email;


-- Section 04: DROP
---- Used to delete objects completely (structure + data)

-- Drop Table
DROP TABLE Employee;

-- Drop Database
DROP DATABASE CompanyDB;


-- Section 05: TRUNCATE
---- Used to delete ALL rows from a table
---- Faster than DELETE
---- No WHERE condition
---- Cannot filter rows

TRUNCATE TABLE Employee;


-- Section 06: CONSTRAINTS
---- Rules applied to table columns

-- PRIMARY KEY
---- Unique + NOT NULL
CREATE TABLE Department (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(50)
);

-- FOREIGN KEY
---- Relationship between tables
CREATE TABLE Employee2 (
    Emp_ID INT PRIMARY KEY,
    Dept_ID INT,

    FOREIGN KEY (Dept_ID)
    REFERENCES Department(Dept_ID)
);

-- CHECK
---- Condition validation
CREATE TABLE Test_Check (
    Age INT CHECK (Age >= 18)
);

-- DEFAULT
---- Default value if no input provided
CREATE TABLE Test_Default (
    Status VARCHAR(20) DEFAULT 'Active'
);