/*========================================================
TOPIC 16 → USER DEFINED FUNCTIONS
========================================================*/

CREATE FUNCTION FirstName(@id INT)

RETURNS VARCHAR(20)

BEGIN

    DECLARE @name VARCHAR(20)

    SELECT @name = st_fname
    FROM Student
    WHERE st_id = @id

    RETURN @name

END
GO

SELECT dbo.FirstName(2)
GO

CREATE FUNCTION GetInstructor(@did INT)

RETURNS TABLE

AS

RETURN
(
    SELECT
        ins_name,
        salary * 12 AS YearSalary

    FROM Instructor

    WHERE dept_id = @did
)
GO

SELECT *
FROM GetInstructor(10)
GO

CREATE FUNCTION GetStudent(@format VARCHAR(20))

RETURNS @t TABLE
(
    id INT,
    studentName VARCHAR(20)
)

AS

BEGIN

    IF @format = 'first'

        INSERT INTO @t
        SELECT st_id, st_fname
        FROM Student


    ELSE IF @format = 'last'

        INSERT INTO @t
        SELECT st_id, st_lname
        FROM Student


    ELSE IF @format = 'full'

        INSERT INTO @t
        SELECT
            st_id,
            st_fname + ' ' + st_lname
        FROM Student

    RETURN

END
GO

SELECT *
FROM GetStudent('FULL')
GO


/*========================================================
TOPIC 17 → WINDOW FUNCTIONS
========================================================*/

SELECT
    st_fname,
    grade,

    x = LAG(st_fname)
        OVER(ORDER BY grade),

    y = LEAD(st_fname)
        OVER(ORDER BY grade)

FROM Stud_Course

INNER JOIN Student
ON Student.st_id = Stud_Course.st_id
GO

SELECT
    st_fname,
    grade,

    x = LAG(st_fname)
        OVER(PARTITION BY crs_id ORDER BY grade),

    y = LEAD(st_fname)
        OVER(PARTITION BY crs_id ORDER BY grade)

FROM Stud_Course

INNER JOIN Student
ON Student.st_id = Stud_Course.st_id
GO

SELECT
    st_fname,
    grade,
    crs_id,

    x = LAG(st_fname)
        OVER(ORDER BY grade),

    y = LEAD(st_fname)
        OVER(ORDER BY grade),

    firstValue = FIRST_VALUE(st_fname)
        OVER(ORDER BY grade),

    lastValue = LAST_VALUE(st_fname)
        OVER(ORDER BY grade)

FROM Stud_Course

INNER JOIN Student
ON Student.st_id = Stud_Course.st_id
GO

SELECT
    st_fname,
    grade,
    crs_id,

    x = LAG(st_fname)
        OVER(PARTITION BY crs_id ORDER BY grade),

    y = LEAD(st_fname)
        OVER(PARTITION BY crs_id ORDER BY grade),

    firstValue = FIRST_VALUE(st_fname)
        OVER(PARTITION BY crs_id ORDER BY grade),

    lastValue = LAST_VALUE(st_fname)
        OVER(PARTITION BY crs_id ORDER BY grade)

FROM Stud_Course

INNER JOIN Student
ON Student.st_id = Stud_Course.st_id
GO
