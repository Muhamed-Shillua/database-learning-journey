------------------------------------------------------------
-- 1. Create a scalar function that takes date and returns Month name of that date.
------------------------------------------------------------
CREATE FUNCTION getMonth(@inDate DATE)
RETURNS VARCHAR(10)
BEGIN
  DECLARE @result VARCHAR(10)
  SET @result = DATENAME(MONTH, @inDate)
  RETURN @result
END
GO

SELECT dbo.getMonth('2026-05-07');
GO

------------------------------------------------------------
-- 2. Create a multi-statements table-valued function that takes 2 integers and returns the values between them.
------------------------------------------------------------
CREATE FUNCTION GetNumbersInRange(@First INT, @Last INT)
RETURNS @NumbersInRange TABLE (Number INT)
AS
BEGIN
  DECLARE @Counter INT = @First

  WHILE @Counter <= @Last
  BEGIN
    INSERT INTO @NumbersInRange(Number)
    VALUES(@Counter)

    SET @Counter = @Counter + 1
  END

  RETURN
END
GO

SELECT *
FROM dbo.GetNumbersInRange(5, 10);
GO

------------------------------------------------------------
-- 3. Create inline function that takes Student No and returns Department Name with Student full name.
------------------------------------------------------------
CREATE FUNCTION GetStdInfo(@StdId INT)
RETURNS TABLE
AS
RETURN
(
  SELECT
    S.St_Fname + ' ' + S.St_Lname AS FullName,
    D.Dept_Name AS DepartmentName
  FROM Student S
  JOIN Department D
    ON S.Dept_Id = D.Dept_Id
  WHERE S.St_Id = @StdId
)
GO

SELECT *
FROM dbo.GetStdInfo(10);
GO

------------------------------------------------------------
-- 4. Create a scalar function that takes Student ID and returns a message to user
-- a. If first name and Last name are null then display 'First name & last name are null'
-- b. If First name is null then display 'first name is null'
-- c. If Last name is null then display 'last name is null'
-- d. Else display 'First name & last name are not null'
------------------------------------------------------------
CREATE FUNCTION CheckName(@StdId INT)
RETURNS VARCHAR(50)
BEGIN
  DECLARE @Message VARCHAR(50),
          @FirstName VARCHAR(10),
          @LastName VARCHAR(10)

  SELECT @FirstName = S.St_Fname, @LastName = S.St_Lname
  FROM Student S
  WHERE S.St_Id = @StdId

  IF @FirstName IS NULL AND @LastName IS NULL
    SET @Message = 'First name & last name are null'
  ELSE IF @FirstName IS NULL
    SET @Message = 'First name is null'
  ELSE IF @LastName IS NULL
    SET @Message = 'last name is null'
  ELSE
    SET @Message = 'First name & last name are not null'

  RETURN @Message
END
GO

SELECT dbo.CheckName(10)
GO

------------------------------------------------------------
-- 5. Create inline function that takes integer which represents manager ID and displays department name, Manager Name and hiring date
------------------------------------------------------------
CREATE FUNCTION GetDeptInfo(@MngrId INT)
RETURNS TABLE
AS
RETURN
(
  SELECT
    D.Dname AS DepartmentName,
    E.Fname + ' ' + E.Lname AS ManagerName,
    D.[MGRStart Date] AS HiringDate
  FROM Company_SD.dbo.Departments D
  JOIN Company_SD.dbo.Employee E
    ON D.MGRSSN = E.SSN
  WHERE D.MGRSSN = @MngrId
)
GO

SELECT * FROM dbo.GetDeptInfo(223344)
GO

------------------------------------------------------------
-- 6. Create multi-statements table-valued function that takes a string
-- If string='first name' returns student first name
-- If string='last name' returns student last name
-- If string='full name' returns Full Name from student table
-- Note: Use ISNULL function
------------------------------------------------------------
CREATE FUNCTION GetName(@Format VARCHAR(10))
RETURNS @StdName TABLE(NAME VARCHAR(20))
AS
BEGIN
  IF @Format = 'first name'
    INSERT INTO @StdName
    SELECT ISNULL(S.St_Fname, 'Uuknown') FROM Student S

  ELSE IF @Format = 'last name'
    INSERT INTO @StdName
    SELECT ISNULL(S.St_Lname, 'Uuknown') FROM Student S

  ELSE IF @Format = 'full name'
    INSERT INTO @StdName
    SELECT
      ISNULL(S.St_Fname, 'Uuknown') + ' ' + ISNULL(S.St_Lname, 'Uuknown')
    FROM Student S

  ELSE
    INSERT INTO @StdName
    SELECT 'Invalid Format'

  RETURN
END
GO

SELECT * FROM dbo.GetName('first name')
SELECT * FROM dbo.GetName('last name')
SELECT * FROM dbo.GetName('full name')
GO

------------------------------------------------------------
-- 7. Write a query that returns the Student No and Student first name without the last char
------------------------------------------------------------
SELECT St_Id,
  SUBSTRING(St_Fname, 1, (LEN(St_Fname) - 1))
FROM Student

------------------------------------------------------------
-- 8. Write query to delete all grades for the students Located in SD Department
------------------------------------------------------------
UPDATE SC
SET SC.Grade = NULL
FROM Stud_Course SC
JOIN Student S ON SC.St_Id = S.St_Id
JOIN Department D ON S.Dept_Id = D.Dept_Id
WHERE D.Dept_Name = 'SD';

SELECT * FROM Stud_Course
GO

------------------------------------------------------------
-- Bonus:
-- Create a batch that inserts 3000 rows in the employee table.
-- The values of the emp_no column should be unique and between 1 and 3000.
-- All values of emp_lname, emp_fname, and dept_no should be 'Jane', 'Smith', 'd1'
------------------------------------------------------------
DECLARE @RowsCounter INT = 1

WHILE @RowsCounter <= 3000
BEGIN
  INSERT INTO Company_SD.dbo.Employee (SSN, Fname, Lname, Dno)
  VALUES (@RowsCounter, 'Jane', 'Smith', 'D1')

  SET @RowsCounter = @RowsCounter + 1
END
