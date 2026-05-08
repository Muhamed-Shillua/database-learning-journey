------------------------------------------------------------
-- 1. Create a view that displays student full name,
-- course name if the student has a grade more than 50.
------------------------------------------------------------
CREATE VIEW StdInfo(StdName, CourseName)
AS
  SELECT
    S.St_Fname + ' ' + S.St_Lname AS FullName,
    C.Crs_Name AS CourseName
  FROM Student S
  JOIN Stud_Course SC
    ON S.St_Id = SC.St_Id
  JOIN Course C
    ON C.Crs_Id = SC.Crs_Id
  WHERE SC.Grade > 50
GO

SELECT *
FROM StdInfo
GO

------------------------------------------------------------
-- 2. Create an Encrypted view that displays manager names
-- and the topics they teach.
------------------------------------------------------------
CREATE VIEW InsInfo
WITH ENCRYPTION
AS
  SELECT
    I.Ins_Name AS ManagerName,
    C.Crs_Name AS CourseName
  FROM Instructor I
  JOIN Department D
    ON I.Ins_Id = D.Dept_Manager
  JOIN Ins_Course IC
    ON I.Ins_Id = IC.Ins_Id
  JOIN Course C
    ON C.Crs_Id = IC.Crs_Id
GO

SELECT *
FROM InsInfo
GO

------------------------------------------------------------
-- 3. Create a view that will display Instructor Name,
-- Department Name for the ‘SD’ or ‘Java’ Department
------------------------------------------------------------
CREATE VIEW InsInfoD
AS
  SELECT
    I.Ins_Name AS InsName,
    D.Dept_Name AS DepartmentName
  FROM Instructor I
  JOIN Department D
    ON I.Dept_Id = D.Dept_Id
  WHERE D.Dept_Name IN ('SD', 'Java')
GO

SELECT *
FROM InsInfoD
GO

------------------------------------------------------------
-- 4. Create a view “V1” that displays student data for
-- student who lives in Alex or Cairo.
--
-- Note: Prevent the users to run the following query:
-- Update V1
-- SET st_address = 'tanta'
-- WHERE st_address = 'alex';
------------------------------------------------------------
CREATE VIEW V1
AS
  SELECT *
  FROM Student
  WHERE St_Address IN ('Cairo', 'Alex')
WITH CHECK OPTION
GO

UPDATE V1
SET st_address = 'tanta'
WHERE st_address = 'alex';
GO

------------------------------------------------------------
-- 5. Create a view that will display the project name
-- and the number of employees work on it.
-- "Use Company DB"
------------------------------------------------------------
CREATE VIEW ProjectV
AS
  SELECT
    P.Pname AS ProkectName,
    COUNT(E.SSN) AS NumberOfEmps
  FROM Company_SD.dbo.Project P
  JOIN Company_SD.dbo.Works_for WF
    ON P.Pnumber = WF.Pno
  JOIN Company_SD.dbo.Employee E
    ON WF.ESSn = E.SSN
  GROUP BY P.Pname
GO

SELECT *
FROM ProjectV
GO

------------------------------------------------------------
-- 6. Create index on column (Hiredate) that allow u to
-- cluster the data in table Department.
-- What will happen?
------------------------------------------------------------
CREATE CLUSTERED INDEX HiredateIN
ON Company_SD.dbo.Departments([MGRStart Date])

-- Running this command as-is might fail
-- if the PK was already created as CLUSTERED
GO

------------------------------------------------------------
-- 7. Create index that allow u to enter unique ages
-- in student table.
-- What will happen?
------------------------------------------------------------
CREATE UNIQUE INDEX IX_StudentAge
ON Student(St_Age)

-- The command will fail if duplicate ages already exist
-- because SQL Server cannot create a UNIQUE index
-- on duplicated values.
GO

------------------------------------------------------------
-- 8. Using MERGE statement between the following
-- two tables [User ID, Transaction Amount]
------------------------------------------------------------

CREATE TABLE database11.dbo.DailyTransactions
(
  UserId INT PRIMARY KEY,
  Amount MONEY
)

INSERT INTO database11.dbo.DailyTransactions
VALUES
  (1, 1000),
  (2, 2000),
  (3, 1000)

CREATE TABLE database11.dbo.LastTransactions
(
  UserId INT PRIMARY KEY,
  Amount MONEY
)

INSERT INTO database11.dbo.LastTransactions
VALUES
  (1, 1000),
  (4, 2000),
  (2, 1000)

MERGE INTO database11.dbo.LastTransactions AS TRGT
USING database11.dbo.DailyTransactions AS SRC
ON (TRGT.UserId = SRC.UserId)

WHEN MATCHED THEN
  UPDATE
  SET TRGT.Amount = SRC.Amount

WHEN NOT MATCHED BY TARGET THEN
  INSERT (UserId, Amount)
  VALUES (SRC.UserId, SRC.Amount)

WHEN NOT MATCHED BY SOURCE THEN
  DELETE;
GO
