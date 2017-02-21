USE AdventureWorks2012; /*Set current database*/


/*1, Display the total amount collected from the orders for each order date. */

SELECT
	OrderDate,
	ROUND(SUM(TotalDue), 2) AS DailyTotalDue
FROM Sales.SalesOrderHeader
GROUP BY OrderDate
ORDER BY OrderDate;


/*2, Display the total amount collected from selling the products, 774 and 777. */

SELECT
	ProductID,
	SUM(LineTotal) AS ProductTotal
FROM Sales.SalesOrderDetail 
WHERE ProductID = 774 OR ProductID = 777
GROUP BY ProductID
ORDER BY ProductID;


/*3, Write a query to display the sales person BusinessEntityID, last name and first name of all the sales persons and the name of the territory to which they belong.*/

SELECT 
	p.BusinessEntityID,
	p.LastName,
	p.FirstName,
	t.Name AS TerritoryName
FROM Person.Person AS p
	JOIN Sales.SalesPerson AS s ON p.BusinessEntityID = s.BusinessEntityID
	JOIN Sales.SalesTerritory AS t ON s.TerritoryID = t.TerritoryID
WHERE p.PersonType LIKE 'SP'
ORDER BY p.BusinessEntityID;


/*4,  Write a query to display the Business Entities of the customers that have the 'Vista' credit card.*/
/* Tables: Sales.CreditCard, Sales.PersonCreditCard, Person.Person*/

SELECT p.BusinessEntityID
FROM
	Person.Person AS p
	JOIN Sales.PersonCreditCard AS pc ON p.BusinessEntityID = pc.BusinessEntityID
	JOIN Sales.CreditCard AS cc ON pc.CreditCardID = cc.CreditCardID
WHERE cc.CardType LIKE 'Vista'
ORDER BY p.BusinessEntityID;



/*Show the number of customers for each type of credit cards*/

SELECT 
	cc.CardType,
	COUNT(p.BusinessEntityID) AS NumberOfCustomers
FROM
	Person.Person AS p
	JOIN Sales.PersonCreditCard AS pc ON p.BusinessEntityID = pc.BusinessEntityID
	JOIN Sales.CreditCard AS cc ON pc.CreditCardID = cc.CreditCardID
GROUP BY cc.CardType;

/*5, Write a query to display ALL the country region codes along with their corresponding territory IDs*/
/* tables: Sales.SalesTerritory, Person.CountryRegion*/

SELECT
	CR.CountryRegionCode,
	ST.TerritoryID
FROM Person.CountryRegion AS CR
	LEFT JOIN Sales.SalesTerritory AS ST
	ON CR.CountryRegionCode = ST.CountryRegionCode
ORDER BY CR.CountryRegionCode;


/*6, Find out the average of the total dues of all the orders.*/

SELECT 
	AVG(TotalDue) AS AverageTotalDue
FROM Sales.SalesOrderHeader;


/*7, Write a query to report the sales order ID of those orders where the total due is greater than the average of the total dues of all the orders*/

SELECT 
	SalesOrderID,
	TotalDue
FROM Sales.SalesOrderHeader
WHERE TotalDue > (SELECT AVG(TotalDue) FROM Sales.SalesOrderHeader)
ORDER BY SalesOrderID;
