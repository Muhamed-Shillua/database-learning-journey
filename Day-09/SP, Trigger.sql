-- Types of Procedures
--- 1. built in sp --> any procedure start with sp_
--- 2. user defined sp -->
CREATE PROCEDURE MyFirstP
AS
  SELECT * FROM Student

MyFirstP
GO

CREATE PROCEDURE GetStdByAddrs @Addrs VARCHAR(20)
AS
BEGIN
  SELECT St_Id, St_Fname, St_Address FROM Student
  WHERE St_Address = @Addrs
END
GO
EXEC GetStdByAddrs 'Alex'
GO

CREATE PROC InertStd @Id INT, @Name VARCHAR(10)
AS
  IF EXISTS(SELECT St_Id FROM Student)
    SELECT 'ERROR !'
  ELSE
    INSERT INTO Student(St_Id, St_Fname)
    VALUES(@Id, @Name)
GO

ALTER PROC InertStd @Id INT, @Name VARCHAR(10)
AS
  IF EXISTS(SELECT St_Id FROM Student WHERE St_Id = @Id)
    SELECT 'ERROR !'
  ELSE
    INSERT INTO Student(St_Id, St_Fname)
    VALUES(@Id, @Name)

EXEC InertStd 22, 'Ahmed'
EXEC InertStd 1, 'Ahmed'
GO

CREATE PROC SumNum @Num1 INT, @Num2 INT
AS
  SELECT @Num1 + @Num2

SumNum 3, 9  -- Calling by params position
SumNum @Num2 = 9, @Num1 = 3 -- Calling by params name
GO
ALTER PROC SumNum @Num1 INT = 0, @Num2 INT = 0 -- Default Value
AS
  SELECT @Num1 + @Num2

EXEC SumNum 5
EXEC SumNum
GO

CREATE PROC GetStdByAge @Age1 INT, @Age2 INT
AS
  SELECT ST_id, st_fname FROM Student
  WHERE St_Age BETWEEN @Age1 AND @Age2
GO

ALTER PROC GetStdByAge @Age1 INT, @Age2 INT
AS
  SELECT ST_id, st_fname, St_Age FROM Student
  WHERE St_Age BETWEEN @Age1 AND @Age2

EXEC GetStdByAge 22, 25;

INSERT INTO NewStd(Id, Name, Age)
EXEC GetStdByAge 22, 25

SELECT * FROM NewStd
GO

-- Return values from proc in variables
-- by put OUTPUT keyword beside the paras in proc defenition
CREATE PROC GetData @Id INT, @Age INT OUTPUT, @Name VARCHAR(10) OUTPUT
AS
  SELECT @Age = St_Age, @Name = St_Fname
  FROM Student
  WHERE St_Id = @Id

DECLARE @X INT, @Y VARCHAR(10)
EXEC GetData 6, @X OUTPUT, @Y OUTPUT
SELECT @X, @Y
GO
-- Procedure Params
--- INPUT
--- OUTPUT
--- INPUTOUTPUT
--- RETURN


-- Dynamic Query in PROC
CREATE PROC DyQuery @Col VARCHAR(10), @Tab VARCHAR(15)
AS
  EXEC('SELECT ' + @Col + ' FROM ' + @Tab)

EXEC DyQuery ST_AGE, Student
GO

--- 3.  triggers --> special type of sp
-- Can't call
-- can't send params
-- It's an implicit code running on server

-- triggers on tables
-- it listen on changes that occures on table
--- INSERT,  UPDATE, DELETE
CREATE TRIGGER T1
ON Student
AFTER INSERT
AS
  SELECT 'Welcome to iti'

INSERT INTO Student(St_Id, St_Fname)
VALUES(77, 'Ali')
GO

CREATE TRIGGER T2
ON Student
FOR UPDATE
AS
  SELECT GETDATE()

UPDATE Student
  SET St_Fname = 'Sofia'
WHERE St_Id = 77
GO

CREATE TRIGGER T3
ON Student
INSTEAD OF DELETE
AS
  SELECT 'Not allowed for user: ' + SUSER_NAME()

DELETE FROM Student
WHERE St_Id = 77
GO

CREATE TRIGGER T4
ON Department
INSTEAD OF INSERT, UPDATE, DELETE
AS
  SELECT 'NOT ALLOWED'

DELETE FROM Department
WHERE Dept_Id = 7
GO

CREATE TRIGGER T5
ON Test22
FOR UPDATE
AS
  IF UPDATE(Name)
    SELECT 'Hi'
GO

-- With every fire for triggers< engine creates 2 tables
--- 1. inserted: Contains new data
--- 2. deleted : Contains old data

CREATE TRIGGER T6
ON Test22
FOR INSERT, DELETE
AS
  SELECT * FROM inserted
  SELECT * FROM deleted

INSERT INTO Test22
VALUES('Muhamed', 11)

DELETE FROM Test22
WHERE Name = 'Muhamed'
GO

CREATE TRIGGER T10
ON Course
INSTEAD OF DELETE
AS
  IF DATENAME(dw, GETDATE()) = 'Friday'
    SELECT 'Can not delete'
  ELSE
    DELETE FROM Course
    WHERE Crs_Id = (SELECT Crs_Id FROM deleted)


DELETE FROM Course
WHERE Crs_Id = 100
GO


CREATE TABLE LogHistory
(
  _User VARCHAR(20),
  _Date DATE,
  _OldId INT,
  _NewId INT
)
GO

CREATE TRIGGER T11
ON Topic
INSTEAD OF UPDATE
AS
  IF UPDATE(Top_Id)
  BEGIN
    DECLARE @Old INT, @New INT
    SELECT @Old = Top_Id FROM deleted
    SELECT @New = Top_Id FROM inserted

    INSERT INTO LogHistory
    VALUES(
      SUSER_NAME(),
      GETDATE(),
      @Old,
      @New
    )
    END


UPDATE Topic
  SET Top_Id = 55
WHERE Top_Id = 5

SELECT * FROM Topic
WHERE Top_Id = 5

ALTER TABLE LogHistory
ALTER COLUMN _User VARCHAR(50)

SELECT * FROM LogHistory
GO
-------------------------------------

-- One Query Trigger
--- BY OUTPUT keyword
DELETE FROM Student
OUTPUT GETDATE(), deleted.St_Fname
WHERE St_Id = 77
GO
DISABLE TRIGGER T1 ON Student;
DISABLE TRIGGER T2 ON Student;
DISABLE TRIGGER T3 ON Student;
------------------------------------------------
