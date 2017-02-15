use AdventureWorks2012;

/*Activity 1. Using the HumanResource.Employee table, provide a count of the number of employees by job title.  The query should consider only current employees (the CurrentFlag must equal 1).  */
SELECT
	JobTitle, 
	COUNT(BusinessEntityID) AS NumberOfEmployees
FROM HumanResources.Employee
WHERE CurrentFlag = 1
GROUP BY JobTitle;




/*Activity 2. Modify the query you created in Activity 1 so that the output shows only those job titles for which there is more than 1 employee.  */
SELECT
	JobTitle, 
	COUNT(BusinessEntityID) AS NumberOfEmployees
FROM HumanResources.Employee
WHERE CurrentFlag = 1
GROUP BY JobTitle
HAVING COUNT(BusinessEntityID) > 1;





/*Activity 3. For each product, show its ProductID and Name (FROM the ProductionProduct table) and the location of its inventory (FROM the Product.Location table) and amount of inventory held at that location (FROM the Production.ProductInventory table).*/
SELECT 
	p.ProductID, 
	p.Name AS ProductName, 
	l.Name AS LocationName, 
	i.Quantity
FROM
	Production.ProductInventory AS i
	JOIN Production.Location AS l ON i.LocationID = l.LocationID
	JOIN Production.Product AS p ON i.ProductID = p.ProductID;
	


/*Activity 4. Find the product model IDs that have no product associated with them.  
To do this, first do an outer join between the Production.Product table and the Production.ProductModel table in such a way that the ID FROM the ProductModel table always shows, even if there is no product associate with it.  
Then, add a WHERE clause to specify that the ProductID IS NULL 
*/

SELECT 
	m.ProductModelID,
	m.Name AS ModelName
FROM Production.Product AS p
	RIGHT OUTER JOIN Production.ProductModel AS m ON p.ProductID = m.ProductModelID
WHERE p.ProductID IS NULL
ORDER BY m.ProductModelID ASC;

