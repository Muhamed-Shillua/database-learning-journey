-- Select all columns from the Student table and assign a row number based on the age in descending order
SELECT *, ROW_NUMBER() OVER (ORDER BY S.ST_AGE DESC) AS RowNum
FROM Student S

-- Select all columns from the Student table and assign a rank based on the age in descending order
SELECT *, DENSE_RANK() OVER (ORDER BY S.ST_AGE DESC) AS RowNum
FROM Student S

-- Select all columns from the Student table and assign a rank based on the age in descending order, allowing for ties
SELECT *, RANK() OVER (ORDER BY S.ST_AGE DESC) AS RowNum
FROM Student S

-- Select all columns from the Student table and divide the rows into 3 groups based on the age in descending order
SELECT *, NTILE(3) OVER (ORDER BY S.ST_AGE DESC) AS RowNum
FROM Student S


-- Select the top 2 rows from the Student table based on the age in descending order
SELECT *
FROM (
  SELECT *, ROW_NUMBER() OVER (ORDER BY S.ST_Age DESC) AS RowNum
  FROM Student S
) AS SubQuery
WHERE RowNum <= 2;


-- Select the top 3 rows from the Student table based on the age in descending order, allowing for ties
SELECT *
FROM
(
  SELECT *, DENSE_RANK() OVER (ORDER BY S.St_Age DESC) AS DenseRank
  FROM Student S
) AS SubQuery
WHERE DenseRank <= 3;


-- Select top 1 row for each department
SELECT *
FROM (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY S.Dept_Id ORDER BY S.ST_Age DESC) AS RowNum
  FROM Student S
) AS SubQuery
WHERE RowNum = 1;

-- Select top 1 age for each department
SELECT *
FROM
(
  SELECT *, DENSE_RANK() OVER (PARTITION BY S.Dept_Id ORDER BY S.St_Age DESC) AS DenseRank
  FROM Student S
) AS SubQuery
WHERE DenseRank = 1;


