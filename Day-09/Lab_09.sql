------------------------------------------------------------
-- 1. Create a stored procedure without parameters
-- that displays the number of students per department name
-- using ITI database
------------------------------------------------------------
CREATE PROC CountStd
AS
  SELECT
    COUNT(S.St_Id) AS NumberOfStudents,
    D.Dept_Name
  FROM ITI.dbo.Student S
  JOIN ITI.dbo.Department D
    ON S.Dept_Id = D.Dept_Id
  GROUP BY D.Dept_Name;
GO

EXEC CountStd
GO

------------------------------------------------------------
-- 2. Create a stored procedure that checks the number of employees
-- in project "AL Solimaniah"
--
-- If number of employees >= 3:
-- print a message saying the project has 3 or more employees
--
-- Otherwise:
-- print a message followed by the full names of all employees
-- working on that project
-- (Using Company database)
------------------------------------------------------------
CREATE PROC PROC_CountEmps
AS
BEGIN
  DECLARE @EmpsCounter INT

  SELECT @EmpsCounter = COUNT(E.SSN)
  FROM Company_SD.dbo.Employee E
  JOIN Company_SD.dbo.Works_for W
    ON E.SSN = W.ESSn
  JOIN Company_SD.dbo.Project P
    ON W.Pno = P.Pnumber
  WHERE P.Pname = 'AL Solimaniah'

  IF @EmpsCounter >= 3
    SELECT 'The number of employees in the project AL Solimaniah is 3 or more'

  ELSE
  BEGIN
    SELECT 'The following employees work for the project AL Solimaniah' AS Message

    UNION ALL

    SELECT
      E.Fname + ' ' + E.Lname
    FROM Company_SD.dbo.Employee E
    JOIN Company_SD.dbo.Works_for W
      ON E.SSN = W.ESSn
    JOIN Company_SD.dbo.Project P
      ON W.Pno = P.Pnumber
    WHERE P.Pname = 'AL Solimaniah'
  END
END
GO

EXEC PROC_CountEmps
GO

------------------------------------------------------------
-- 3. Create a stored procedure that replaces an old employee
-- with a new employee in a specific project.
--
-- The procedure takes:
-- Old employee number
-- New employee number
-- Project number
--
-- and updates the Works_for table accordingly
------------------------------------------------------------
CREATE PROC Proc_Manage
  @OldEmpSSN INT,
  @NewEmpSSN INT,
  @ProjectNum INT
AS
BEGIN
  UPDATE Company_SD.dbo.Works_for
    SET ESSn = @NewEmpSSN
  WHERE ESSn = @OldEmpSSN
    AND Pno  = @ProjectNum

  IF @@ROWCOUNT > 0
    SELECT 'Employee replaced successfully'
  ELSE
    SELECT 'No rows updated'
END
GO

EXEC Proc_Manage 968574, 102672, 700;
GO

------------------------------------------------------------
-- 4. Add a new column (Budget) to Project table
-- then create an Audit table to track any update on Budget
--
-- The audit table stores:
-- Project number, user name, modification date,
-- old budget value, and new budget value
--
-- The trigger should work only when Budget column is updated
------------------------------------------------------------
ALTER TABLE Company_SD.dbo.Project
ADD Budget MONEY
GO

CREATE TABLE Company_SD.dbo.Audit
(
  ProjectNo INT,
  UserName VARCHAR(50),
  ModifiedDate DATE,
  Budget_Old MONEY,
  Budget_New MONEY
)
GO

CREATE TRIGGER Proc_Logs
ON Company_SD.dbo.Project
AFTER UPDATE
AS
BEGIN

  -- Ensure the trigger runs only when Budget column is updated
  IF UPDATE(Budget)
  BEGIN
    INSERT INTO Company_SD.dbo.Audit
    SELECT
      i.Pnumber,
      SUSER_NAME(),
      GETDATE(),
      d.Budget,
      i.Budget
    FROM inserted i
    JOIN deleted d
      ON i.Pnumber = d.Pnumber
  END

END
GO

------------------------------------------------------------
-- 5. Create a trigger to prevent inserting any new record
-- into Department table in ITI database
-- and show a message to the user
------------------------------------------------------------
CREATE TRIGGER Control_Edits
ON ITI.dbo.Department
INSTEAD OF INSERT
AS
BEGIN
  SELECT 'You can’t insert a new record in that table'
END
GO

------------------------------------------------------------
-- 6. Create a trigger that prevents inserting new employees
-- during the month of March
-- (Company database)
------------------------------------------------------------
CREATE TRIGGER Mange_Insert
ON Company_SD.dbo.Employee
INSTEAD OF INSERT
AS
BEGIN

  IF DATENAME(MONTH, GETDATE()) = 'March'
  BEGIN
    SELECT 'Can not insert at this time'
  END
  ELSE
  BEGIN
    INSERT INTO Company_SD.dbo.Employee
    SELECT * FROM inserted
  END

END
GO

------------------------------------------------------------
-- 7. Create an AFTER INSERT trigger on Student table
-- to log every inserted row into StudentAudit table
--
-- The audit message should include:
-- username, date, and inserted student key value
------------------------------------------------------------
CREATE TABLE ITI.dbo.StudentAudit
(
  UserName VARCHAR(30),
  AuditDate DATE,
  Note VARCHAR(75)
)
GO

CREATE TRIGGER Trig_Student
ON ITI.dbo.Student
AFTER INSERT
AS
BEGIN

  INSERT INTO ITI.dbo.StudentAudit(UserName, AuditDate, Note)
  SELECT
    SUSER_NAME(),
    GETDATE(),
    SUSER_NAME() + ' Insert New Row with Key='
    + CAST(St_Id AS VARCHAR(10))
    + ' in table Student'
  FROM inserted

END
GO

INSERT INTO ITI.dbo.Student(St_Id, St_Fname)
VALUES (50, 'Ahmed')
GO

------------------------------------------------------------
-- 8. Create an INSTEAD OF DELETE trigger on Student table
-- to prevent actual deletion and instead log the attempt
--
-- The audit table should store:
-- username, date, and message indicating delete attempt
------------------------------------------------------------
CREATE TRIGGER Trig_Student_Del
ON ITI.dbo.Student
INSTEAD OF DELETE
AS
BEGIN

  INSERT INTO ITI.dbo.StudentAudit(UserName, AuditDate, Note)
  SELECT
    SUSER_NAME(),
    GETDATE(),
    SUSER_NAME() + ' try to delete Row with Key='
    + CAST(St_Id AS VARCHAR(10))
    + ' in table Student'
  FROM deleted

END
GO


------------------------------------------------
-- 2. Create a trigger that prevents users from
-- altering any table in Company database.
------------------------------------------------
CREATE TRIGGER PreventAlterTable
ON DATABASE
FOR ALTER_TABLE
AS
BEGIN
  PRINT 'Can NOT alter table'

  ROLLBACK;
END
GO
