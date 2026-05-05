-----------------------------------------------------
-- 1. Sales orders within a date range
-----------------------------------------------------
SELECT SalesOrderID, ShipDate
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '2002-07-28' AND '2014-07-29';


-----------------------------------------------------
-- 2. Products with StandardCost below 110
-----------------------------------------------------
SELECT ProductID, Name
FROM Production.Product
WHERE StandardCost < 110.00;


-----------------------------------------------------
-- 3. Products with unknown weight
-----------------------------------------------------
SELECT ProductID, Name
FROM Production.Product
WHERE Weight IS NULL;


-----------------------------------------------------
-- 4. Products with specific colors
-----------------------------------------------------
SELECT *
FROM Production.Product
WHERE Color IN ('Silver', 'Black', 'Red');


-----------------------------------------------------
-- 5. Products starting with B
-----------------------------------------------------
SELECT *
FROM Production.Product
WHERE Name LIKE 'B%';


-----------------------------------------------------
-- 6. Product descriptions containing underscore
-----------------------------------------------------

-- Update example (given in task)
UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3;

-- Find descriptions with underscore
SELECT *
FROM Production.ProductDescription
WHERE Description LIKE '%[_]%';


-----------------------------------------------------
-- 7. Sum of TotalDue per OrderDate (given range)
-----------------------------------------------------
SELECT
  OrderDate,
  SUM(TotalDue) AS TotalDue
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '2001-07-01' AND '2014-07-31'
GROUP BY OrderDate;


-----------------------------------------------------
-- 8. Unique Employee Hire Dates
-----------------------------------------------------
SELECT DISTINCT HireDate
FROM HumanResources.Employee;


-----------------------------------------------------
-- 9. Average of unique ListPrices
-----------------------------------------------------
SELECT AVG(ListPrice) AS AvgListPrice
FROM (
  SELECT DISTINCT ListPrice
  FROM Production.Product
) AS DistinctPrices;


-----------------------------------------------------
-- 10. Formatted product price output
-----------------------------------------------------
SELECT
  CONCAT('The ', Name, ' is only! ', ListPrice) AS ProductInfo
FROM Production.Product
WHERE ListPrice BETWEEN 100 AND 120
ORDER BY ListPrice;


-----------------------------------------------------
-- 11A. Create archive table with data
-----------------------------------------------------
SELECT
  rowguid,
  Name,
  SalesPersonID,
  Demographics
INTO Sales.Store_Archive
FROM Sales.Store;


-----------------------------------------------------
-- 11B. Create archive table structure only (no data)
-----------------------------------------------------
SELECT
  rowguid,
  Name,
  SalesPersonID,
  Demographics
INTO Sales.Store_Archive1
FROM Sales.Store
WHERE 1 = 0;


-----------------------------------------------------
-- 12. Today's date in different formats
-----------------------------------------------------
SELECT CONVERT(VARCHAR, GETDATE(), 101) AS Style_101
UNION ALL
SELECT CONVERT(VARCHAR, GETDATE(), 103)
UNION ALL
SELECT CONVERT(VARCHAR, GETDATE(), 120)
UNION ALL
SELECT CONVERT(VARCHAR, GETDATE(), 121);
