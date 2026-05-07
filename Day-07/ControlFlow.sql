/*========================================================
TOPIC 08 → CONTROL FLOW
========================================================*/

DECLARE @rowsAffected INT

UPDATE Student
SET st_age += 1

SELECT @rowsAffected = @@ROWCOUNT

IF @rowsAffected > 0
BEGIN
    SELECT 'multiple rows affected'
END
ELSE
BEGIN
    SELECT 'no rows affected'
END
GO


/*========================================================
TOPIC 09 → EXISTS / NOT EXISTS
========================================================*/

IF EXISTS
(
    SELECT name
    FROM sys.tables
    WHERE name = 'Student'
)
BEGIN
    SELECT 'table exists'
END

ELSE
BEGIN
    CREATE TABLE Student
    (
        id INT,
        name NVARCHAR(20)
    )
END
GO

IF NOT EXISTS
(
    SELECT Dept_Id
    FROM Student
    WHERE dept_id = 20
)

AND NOT EXISTS
(
    SELECT dept_id
    FROM Instructor
    WHERE dept_id = 20
)

BEGIN

    DELETE FROM Department
    WHERE dept_id = 20

END

ELSE
BEGIN
    SELECT 'related rows exist'
END
GO


/*========================================================
TOPIC 10 → TRY / CATCH
========================================================*/

BEGIN TRY

    DELETE FROM Department
    WHERE dept_id = 20

END TRY

BEGIN CATCH

    SELECT 'error happened'

    SELECT
        ERROR_LINE(),
        ERROR_NUMBER(),
        ERROR_MESSAGE()

END CATCH
GO


/*========================================================
TOPIC 11 → LOOPS
========================================================*/

DECLARE @counter INT = 10

WHILE @counter <= 20
BEGIN

    SET @counter += 1

    IF @counter = 14
        CONTINUE

    IF @counter = 16
        BREAK

    SELECT @counter

END
GO


/*========================================================
TOPIC 12 → IIF FUNCTION
========================================================*/

SELECT IIF
(
    COUNT(dept_id) < 20,
    'true = less',
    'false = more'
)
FROM Department
GO


/*========================================================
TOPIC 13 → CASE STATEMENT
========================================================*/

SELECT
    OrderID,
    Quantity,

CASE

    WHEN Quantity > 30
        THEN 'greater than 30'

    WHEN Quantity = 30
        THEN 'equal to 30'

    ELSE 'under 30'

END

FROM OrderDetails
GO

SELECT CustomerName, City, Country
FROM Customers

ORDER BY
(
    CASE

        WHEN City IS NULL
            THEN Country

        ELSE City

    END
)
GO


/*========================================================
TOPIC 14 → BATCH & SCRIPT
========================================================*/

CREATE TABLE parent
(
    id INT PRIMARY KEY
)

CREATE TABLE child
(
    fid INT FOREIGN KEY REFERENCES parent(id)
)
GO

INSERT INTO parent(id) VALUES(1)
INSERT INTO parent(id) VALUES(2)
INSERT INTO parent(id) VALUES(3)
GO

INSERT INTO child(fid) VALUES(1)
INSERT INTO child(fid) VALUES(4)
INSERT INTO child(fid) VALUES(3)
GO

CREATE TABLE temp(id INT)
GO

DROP TABLE temp
GO


/*========================================================
TOPIC 15 → TRANSACTIONS
========================================================*/

BEGIN TRANSACTION

    INSERT INTO child(fid) VALUES(1)
    INSERT INTO child(fid) VALUES(4)
    INSERT INTO child(fid) VALUES(3)

COMMIT
GO

BEGIN TRANSACTION

    INSERT INTO child(fid) VALUES(1)
    INSERT INTO child(fid) VALUES(2)
    INSERT INTO child(fid) VALUES(3)

ROLLBACK
GO

BEGIN TRY

    BEGIN TRANSACTION

        INSERT INTO child(fid) VALUES(1)
        INSERT INTO child(fid) VALUES(2)
        INSERT INTO child(fid) VALUES(3)

    COMMIT

END TRY

BEGIN CATCH

    ROLLBACK

END CATCH
GO
