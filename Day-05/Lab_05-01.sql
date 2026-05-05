------------------------------------------------------------------
-- 1. Retrieve number of students who have a value in their age
------------------------------------------------------------------
SELECT COUNT(St_Age) AS StudentsWithAge
FROM Student
WHERE St_Age IS NOT NULL;


------------------------------------------------------------------
-- 2. Get all instructors Names without repetition
------------------------------------------------------------------
SELECT DISTINCT Ins_Name
FROM Instructor;


------------------------------------------------------------------
-- 3. Get all students with full name and department id (USE ISNULL)
------------------------------------------------------------------
SELECT
  ISNULL(St_Fname, '') + ' ' + ISNULL(St_Lname, '') AS StudentFullName,
  ISNULL(Dept_Id, -1) AS DepartmentId
FROM Student;


------------------------------------------------------------------
-- 4. Display instructor Name and Department Name
-- even if instructor does not belong to any department
------------------------------------------------------------------
SELECT
  I.Ins_Name AS InstructorName,
  D.Dept_Name AS DepartmentName
FROM Instructor I
LEFT JOIN Department D
  ON I.Dept_Id = D.Dept_Id;


------------------------------------------------------------------
-- 5. Student full name and course name (only courses with grade)
------------------------------------------------------------------
SELECT
  S.St_Fname + ' ' + S.St_Lname AS StudentFullName,
  C.Crs_Name AS CourseName
FROM Student S
JOIN Stud_Course SC
  ON S.St_Id = SC.St_Id
JOIN Course C
  ON C.Crs_Id = SC.Crs_Id
WHERE SC.Grade IS NOT NULL;


------------------------------------------------------------------
-- 6. Number of courses for each topic name
------------------------------------------------------------------
SELECT
  T.Top_Name AS TopicName,
  COUNT(C.Crs_Id) AS NumberOfCourses
FROM Course C
JOIN Topic T
  ON C.Top_Id = T.Top_Id
GROUP BY T.Top_Name;


------------------------------------------------------------------
-- 7. Max and Min salary for instructors
------------------------------------------------------------------
SELECT
  MAX(Salary) AS MaxSalary,
  MIN(Salary) AS MinSalary
FROM Instructor;


------------------------------------------------------------------
-- 8. Instructors with salary less than average salary
------------------------------------------------------------------
SELECT Ins_Name, Salary
FROM Instructor
WHERE Salary < (
  SELECT AVG(Salary)
  FROM Instructor
);


------------------------------------------------------------------
-- 9. Department that contains instructor with minimum salary
------------------------------------------------------------------
SELECT DISTINCT D.Dept_Name AS DepartmentName
FROM Department D
JOIN Instructor I
  ON I.Dept_Id = D.Dept_Id
WHERE I.Salary = (
  SELECT MIN(Salary)
  FROM Instructor
);


------------------------------------------------------------------
-- 10. Select max two salaries in Instructor table
------------------------------------------------------------------

-- Solution 1
SELECT DISTINCT Salary
FROM Instructor I1
WHERE (
  SELECT COUNT(DISTINCT Salary)
  FROM Instructor I2
  WHERE I1.Salary < I2.Salary
) < 2;

-- Solution 2
SELECT DISTINCT TOP (2) Salary
FROM Instructor
ORDER BY Salary DESC;

-- Solution 3
SELECT Salary
FROM (
  SELECT Salary,
         ROW_NUMBER() OVER (ORDER BY Salary DESC) AS RowNum
  FROM Instructor
) AS SubQuery
WHERE RowNum <= 2;


------------------------------------------------------------------
-- 11. Instructor name and salary or bonus (COALESCE)
------------------------------------------------------------------
SELECT
  Ins_Name,
  COALESCE(Salary, Bonus) AS SalaryOrBonus
FROM Instructor;


------------------------------------------------------------------
-- 12. Average salary for instructors
------------------------------------------------------------------
SELECT AVG(Salary) AS AvgSalary
FROM Instructor;


------------------------------------------------------------------
-- 13. Student name and supervisor data
------------------------------------------------------------------
SELECT
  S1.St_Fname AS StudentFirstName,
  S2.*
FROM Student S1
JOIN Student S2
  ON S1.St_super = S2.St_Id
WHERE S1.St_super IS NOT NULL;


------------------------------------------------------------------
-- 14. Highest two salaries in each department
-- (Using Ranking Function)
------------------------------------------------------------------
SELECT *
FROM (
  SELECT
    I.*,
    ROW_NUMBER() OVER (
      PARTITION BY Dept_Id
      ORDER BY Salary DESC
    ) AS RowNum
  FROM Instructor I
) AS SubQuery
WHERE RowNum <= 2;


------------------------------------------------------------------
-- 15. Random student from each department
-- (Using Ranking Function)
------------------------------------------------------------------
SELECT *
FROM (
  SELECT
    S.*,
    ROW_NUMBER() OVER (
      PARTITION BY Dept_Id
      ORDER BY NEWID()
    ) AS RowNum
  FROM Student S
) AS SubQuery
WHERE RowNum = 1;
