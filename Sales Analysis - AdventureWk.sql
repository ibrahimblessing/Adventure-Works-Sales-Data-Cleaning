--SALES ANALYSIS

--To view the salesFactable and DimproductT table
	SELECT *
	FROM DimProductT;

	SELECT *
	FROM SalesFactTable;

--To get total cost, total revenue and profits.
	SELECT
	
	--Total Cost = $14,56,986.32
		CONVERT(varchar, 
            CAST(SUM(sf.OrderQuantity * dp.ProductCost) AS money), 
            1)  AS TotalCost,

	--Total Revenue = $24,914,567.18
		CONVERT(varchar, 
            CAST(SUM(sf.OrderQuantity * dp.ProductPrice) AS money), 
            1)  AS TotalRevenue,

	--Total profit = $10,457,580.86
			CONVERT(varchar, 
            CAST(SUM((sf.OrderQuantity * dp.ProductPrice)-(sf.OrderQuantity * dp.ProductCost)) AS money), 
            1)  AS TotalProfit


	FROM SalesFactTable AS sf
	LEFT JOIN DimproductT AS dp
	ON sf.ProductKey = dp.ProductKey;



--Orders placed so far = 56,046
	SELECT
		COUNT(OrderNumber) AS TotalOrders
	FROM SalesFactTable;



--Profit grouped by product category to know the product group with most generated profit.
	SELECT
      dp.CategoryName,
	
	--Total profit = $10,457,580.86
			CONVERT(varchar, 
            CAST(SUM((sf.OrderQuantity * dp.ProductPrice)-(sf.OrderQuantity * dp.ProductCost)) AS money), 
            1)  AS TotalProfit


	FROM SalesFactTable AS sf
	LEFT JOIN DimproductT AS dp
	ON sf.ProductKey = dp.ProductKey

	GROUP BY dp.CategoryName
	ORDER BY TotalProfit DESC
;  -- Most of the profits were generated from the accessories 'bikes'.



--CUSTOMER ANALYSIS
--View DimCustomer Table.
	SELECT * 
	FROM [DimCustomer ];


--Top 10 Customers based on orders placed
	SELECT TOP(10)
		CONCAT(dc.Prefix,' ',dc.FirstName,' ',dc.LastName) AS FullName,
		COUNT(sf.OrderNumber) AS TotalOrders

	FROM SalesFactTable AS sf
	LEFT JOIN [DimCustomer ] AS dc
	ON sf.CustomerKey = dc.CustomerKey

	GROUP BY  CONCAT(dc.Prefix,' ',dc.FirstName,' ',dc.LastName) 
	ORDER BY TotalOrders DESC
;

/*-Ggroup the customers into different income levels. If annual income is >= $150,000, Very High, 
If annual income is >= $100,000, High , If annual income is >= $50,000, Average,
Otherwise, Income Level = Low.*/
	SELECT 
		CustomerKey,
		CONCAT(Prefix,' ',FirstName,' ',LastName) AS FullName,
		AnnualIncome,
		CASE
			WHEN AnnualIncome >= 150000 THEN 'Very High'
			WHEN AnnualIncome >= 100000 THEN 'High'
			WHEN AnnualIncome >= 50000 THEN 'Average'
			ELSE 'Low'
			END AS IncomeLevel
	
	FROM [DimCustomer ] 
;

	--Orders based on the income level
	SELECT 
		
		CASE
			WHEN dc.AnnualIncome >= 150000 THEN 'Very High'
			WHEN dc.AnnualIncome >= 100000 THEN 'High'
			WHEN dc.AnnualIncome >= 50000 THEN 'Average'
			ELSE 'Low'
			END AS IncomeLevel,
	COUNT(sf.OrderNumber) AS TotalOrders

	FROM SalesFactTable AS sf
	LEFT JOIN [DimCustomer ] AS dc
	ON sf.CustomerKey = dc.CustomerKey

	GROUP BY CASE
			WHEN dc.AnnualIncome >= 150000 THEN 'Very High'
			WHEN dc.AnnualIncome >= 100000 THEN 'High'
			WHEN dc.AnnualIncome >= 50000 THEN 'Average'
			ELSE 'Low'
			END 
			ORDER BY TotalOrders DESC
	; --Most of the customers that placed orders were average income earners.



--Total Number of orders placed based on occupation of Customers.
	SELECT
		dc.Occupation,
		COUNT(sf.OrderNumber) AS TotalOrders

	FROM SalesFactTable AS sf
	LEFT JOIN [DimCustomer ] AS dc
	ON sf.CustomerKey = dc.CustomerKey

	GROUP BY dc.Occupation
	ORDER BY TotalOrders DESC
; --Most of the orders were placed by professionals.



--To view the territory Table
 SELECT * 
 FROM DimTerritory;


--Country that generated the most revenue and the least revenue.
	SELECT 
	dt.Country,
	CONVERT(varchar, 
            CAST(SUM(sf.OrderQuantity * dp.ProductPrice) AS money), 
            1)  AS TotalRevenue
	
	FROM SalesFactTable AS sf
	LEFT JOIN DimTerritory as dt
	ON sf.TerritoryKey = dt.SalesTerritoryKey
	LEFT JOIN DimProductT AS dp
	ON sf.ProductKey = dp.ProductKey

	GROUP BY dt.Country
	ORDER BY TotalRevenue DESC
	;
--United state generates the most revenue while Canada generates the least revenue.





