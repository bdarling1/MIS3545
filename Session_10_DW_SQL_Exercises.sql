USE AdventureWorksDW2012;

/*Employees whose birthday is in Feburary*/

SELECT *
FROM DimEmployee
WHERE MONTH(BirthDate) = 2;

/*who are the Sales Representatives whose birthday is in Feburary?*/

SELECT
	FirstName,
	LastName,
	BirthDate
FROM DimEmployee
WHERE MONTH(BirthDate) = 2 AND Title = 'Sales Representative';

/*List all the sales processed by these Sales Representatives */

SELECT 
	FRS.*,
	E.FirstName,
	E.LastName,
	E.BirthDate,
	E.Title
FROM FactResellerSales AS FRS
	JOIN DimEmployee AS E ON FRS.EmployeeKey = E.EmployeeKey
WHERE MONTH(BirthDate) = 2 AND E.Title = 'Sales Representative';


/*who is a better sales representative that was born in Feburary?*/

SELECT 
	COUNT(FRS.SalesOrderNumber) AS CountOfSales,
	SUM(FRS.SalesAmount) AS SumOfSales,
	E.FirstName,
	E.LastName
FROM FactResellerSales AS FRS
	JOIN DimEmployee AS E ON FRS.EmployeeKey = E.EmployeeKey
WHERE MONTH(BirthDate) = 2 AND E.Title = 'Sales Representative'
GROUP BY E.FirstName, E.LastName
ORDER BY SumOfSales DESC, CountOfSales DESC;




/*total Amount of off-line sales in Massachusetts*/

SELECT SUM(FRS.SalesAmount) AS Total_Offline_Sales_MA
FROM FactResellerSales AS FRS
	JOIN DimGeography AS DG ON FRS.SalesTerritoryKey = DG.SalesTerritoryKey
WHERE DG.StateProvinceName = 'Massachusetts';


/*Total Amount of Internet Sales in 1st quarter each year in each country*/

SELECT 
	ST.SalesTerritoryCountry AS Country,
	DD.CalendarYear,
	SUM(FIS.SalesAmount) AS Q1_Internet_Sales
FROM FactInternetSales AS FIS
	JOIN DimSalesTerritory AS ST ON FIS.SalesTerritoryKey = ST.SalesTerritoryKey
	JOIN DimDate AS DD ON FIS.OrderDateKey = DD.DateKey
WHERE DD.CalendarQuarter = '1'
GROUP BY ST.SalesTerritoryCountry, DD.CalendarYear;
