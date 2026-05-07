/*========================================================
TOPIC 01 → VARIABLES
========================================================*/

DECLARE @x INT
SELECT @x = 100
SELECT @x
GO

DECLARE @y INT = 500
SELECT @y
GO

DECLARE @x INT =
(
    SELECT AVG(st_age)
    FROM Student
)

SELECT @x
GO

DECLARE @x INT = 100

-- ERROR:
-- subquery returns multiple rows
SELECT @x =
(
    SELECT st_age
    FROM Student
)

SELECT @x
GO

DECLARE @x INT

SELECT @x =
(
    SELECT st_age
    FROM Student
    WHERE st_id = 2
)

SELECT @x
GO

DECLARE @x INT

SELECT @x =
(
    SELECT st_age
    FROM Student
    WHERE st_id = 22000
)

SELECT @x
GO

DECLARE @x INT = 100

SELECT @x =
(
    SELECT st_age
    FROM Student
    WHERE st_id = 22000
)

SELECT @x
GO

DECLARE @x INT,
        @name VARCHAR(20)

SELECT
    @x = st_age,
    @name = st_fname
FROM Student

SELECT @x, @name
GO

DECLARE @x INT,
        @name VARCHAR(20)

SELECT
    @x = st_age,
    @name = st_fname
FROM Student
WHERE st_id = 7

SELECT @x, @name
GO


/*========================================================
TOPIC 02 → UPDATE + VARIABLES
========================================================*/

DECLARE @z VARCHAR(20)

UPDATE Student
SET
    st_fname = 'Ali',
    @z = st_lname
WHERE st_id = 8

SELECT @z
GO


/*========================================================
TOPIC 03 → TABLE VARIABLES
========================================================*/

DECLARE @t TABLE
(
    x INT,
    y VARCHAR(20)
)

INSERT INTO @t
SELECT st_id, st_fname
FROM Student

SELECT *
FROM @t
GO


/*========================================================
TOPIC 04 → TOP WITH VARIABLE
========================================================*/

DECLARE @topCount INT = 5

SELECT TOP(@topCount) *
FROM Student
GO


/*========================================================
TOPIC 05 → DYNAMIC SQL
========================================================*/

DECLARE @col VARCHAR(20) = '*',
        @tab VARCHAR(20) = 'Student'

-- ERROR
SELECT @col
FROM @tab
GO

DECLARE @col VARCHAR(20) = '*',
        @tab VARCHAR(20) = 'Student'

EXECUTE
(
    'SELECT ' + @col + ' FROM ' + @tab
)
GO


/*========================================================
TOPIC 06 → SCHEMA TRANSFER
========================================================*/

ALTER SCHEMA dbo
TRANSFER itistud.Student
GO


/*========================================================
TOPIC 07 → GLOBAL VARIABLES
========================================================*/

SELECT @@SERVERNAME
SELECT @@VERSION
GO

UPDATE Student
SET st_age += 1

SELECT @@ROWCOUNT
GO

SELECT *
FROM stud
GO

SELECT @@ERROR
GO

SELECT @@IDENTITY
GO
