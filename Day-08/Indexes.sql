-- Clustered Index
-- CREATE CLUSTERED INDEX NameIndex
-- ON Student(ST_Fname)

CREATE NONCLUSTERED INDEX FnameIndex
ON Student(st_Fname)

CREATE NONCLUSTERED INDEX LnameIndex
ON Student(st_Lname)

SELECT *
FROM Student
WHERE St_Fname = 'Ahmed'

SELECT *
FROM Student
WHERE St_Address = 'ALEX'


-- PK is a CONSTRAINT --> Clustered Index
-- UNIQUE is a CONSTRAINT --> NON Clustered Index
CREATE TABLE Test22
( -----> 2 indexes
  Id INT PRIMARY KEY IDENTITY, ---> Index (Unique, Clustered)
  Name VARCHAR(20) UNIQUE,     ---> Index (Unique, NON Clustered)
  Age INT NOT NULL
)
-- SO that there is a code to create unique index
CREATE UNIQUE INDEX Index1
ON Test22(Name)  ---> must assign to a unique column


-- To spicify the column i want t assign an indexto it
-- 1. SQL Server Profiler --> to TRACE queries
-- 2. SQL Server Tuning Advisor --> GET most used column

SELECT *
FROM Student
WHERE St_Age = 22;
---------------------------------------------

-- Server DBs
---- master: -> All Server metadata, configs (Users, Files) without it server is fuckedup
---- model : -> Template that any new db inherites it
---- msdb  : -> Control JOBS ---> Query will run at spAcific time
---- tempdb: -> temp run time results,

--- Tables Type:
---- Local Tables: --> Session based tables
CREATE TABLE #NewTable
( --------- Query Level, in tempdb
  ID INT PRIMARY KEY,
  Name VARCHAR(20) NOT NULL
)
---- Global Tables: --> Shared Tables
CREATE TABLE ##NewTable
( --------- For all Queries, in tempdb
  ID INT PRIMARY KEY,
  Name VARCHAR(20) NOT NULL
)

