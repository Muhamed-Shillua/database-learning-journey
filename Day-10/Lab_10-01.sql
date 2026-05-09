------------------------------------------------------------
-- 1. Cursor: Increase employee salary
-- +10% if salary < 3000
-- +20% if salary >= 3000
-- Company DB
------------------------------------------------------------
USE Company_SD
GO

DECLARE C1 CURSOR
FOR
  SELECT Salary
  FROM Employee
FOR UPDATE;

DECLARE @Sal MONEY;

OPEN C1;

FETCH C1 INTO @Sal;

WHILE @@FETCH_STATUS = 0
BEGIN

  IF @Sal >= 3000
    UPDATE Employee
      SET Salary = Salary * 1.20
    WHERE CURRENT OF C1;
  ELSE
    UPDATE Employee
      SET Salary = Salary * 1.10
    WHERE CURRENT OF C1;

  FETCH C1 INTO @Sal;

END

CLOSE C1;
DEALLOCATE C1;
GO

------------------------------------------------------------
-- 2. Display Department name with Manager name using Cursor
-- ITI DB
------------------------------------------------------------
USE ITI
GO

DECLARE C1 CURSOR
FOR
  SELECT D.Dept_Name, I.Ins_Name
  FROM Department D
  JOIN Instructor I
    ON D.Dept_Manager = I.Ins_Id
FOR READ ONLY;

DECLARE @DName VARCHAR(50), @MngrName VARCHAR(50);

OPEN C1;

FETCH C1 INTO @DName, @MngrName;

WHILE @@FETCH_STATUS = 0
BEGIN
  SELECT @DName AS Department, @MngrName AS Manager;

  FETCH C1 INTO @DName, @MngrName;
END

CLOSE C1;
DEALLOCATE C1;
GO

------------------------------------------------------------
-- 3. Concatenate all student first names in one string
-- separated by comma using Cursor
------------------------------------------------------------
DECLARE C1 CURSOR
FOR
  SELECT St_Fname
  FROM Student
FOR READ ONLY;

DECLARE @SName VARCHAR(50), @AllNames VARCHAR(200) = '';

OPEN C1;

FETCH C1 INTO @SName;

WHILE @@FETCH_STATUS = 0
BEGIN
  IF LEN(@AllNames) = 0
    SET @AllNames = ISNULL(@SName,'');
  ELSE
    SET @AllNames = CONCAT(@AllNames, ',', ISNULL(@SName,''));

  FETCH C1 INTO @SName;
END

SELECT @AllNames AS Names;

CLOSE C1;
DEALLOCATE C1;
GO

------------------------------------------------------------
-- 4. Full and Differential Backup
-- SD Database (FIXED)
------------------------------------------------------------

-- Full Backup
BACKUP DATABASE Company_SD
TO DISK = 'D:\Company_SD_FULL.bak';
GO

-- Differential Backup
BACKUP DATABASE Company_SD
TO DISK = 'D:\Company_SD_DIFF.bak'
WITH DIFFERENTIAL;
GO
