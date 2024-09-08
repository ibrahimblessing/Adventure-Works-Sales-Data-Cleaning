--ADEVENTURE WORK SALES DATA PREPARATION.

--combining the sales Data from 2020-2022 to form a SalesfactTable

SELECT * INTO SalesFactTable
FROM (
    SELECT * FROM [Sales Data 2020]
	UNION 
	SELECT * FROM [Sales Data 2021]
	UNION 
	SELECT * FROM [Sales Data 2022]
	) AS CombinedSalesTables;

--To view the data in the newly created Table
	SELECT * FROM SalesFactTable;

--To get th datatype and other information about the salesFactTable
	SP_HELP [SalesFactTable];

/*The next thing is to make the IDs in the SalesFacTable
Foreign Keys instead of doing it in the database Diagram*/

--Making the ProductKey a Fkey
	ALTER TABLE SalesFactTable
	ADD CONSTRAINT FK_SalesFactTable_Prouct
	FOREIGN KEY (ProductKey)
	REFERENCES DimProduct(ProductKey);

--Making the CustomerKey a Fkey
	ALTER TABLE SalesFactTable
	ADD CONSTRAINT FK_SalesFactTable_Customer
	FOREIGN KEY (CustomerKey)
	REFERENCES DimCustomer(CustomerKey);

--Making the Territory Key a Fkey
	ALTER TABLE SalesFactTable
	ADD CONSTRAINT FK_SalesFactTable_Territory
	FOREIGN KEY (TerritoryKey)
	REFERENCES DimTerritory(SalesTerritoryKey);




/* Performing Data cleaning, manipulation and preparation in the
Product Table and also combining it with the DimProducCategory 
and DimProductSubcategory to form a new table called DimProductT*/

--Merging the DimCategory and DimSubcategory to the DimProduct Table to form a new table called DimProductT
 SELECT * INTO DimProductT
 FROM (
		SELECT 
		--DimProduct
			dp.ProductKey,
			--to extract all characters before the second dash ("-") in the Product SKU column, and name it ”SKUType"
				LEFT(dp.ProductSKU,7) AS SKUType, 
			dp.ProductName,
			dp.ProductColor,
			dp.ProductSize,
			dp.ProductStyle,
			--Round both the product price and cost to 2 decimal places each
				ROUND(dp.ProductCost,2) AS ProductCost,
				ROUND(dp.ProductPrice,2) AS ProductPrice,

		--DimProductCategory
			dpc.CategoryName,
			dpc.ProductCategoryKey,

		--DimProductSubcategory
			dps.ProductSubcategoryKey,
			dps.SubcategoryName

		FROM [DimProduct ] AS dp
		INNER JOIN DimProductSubcategory AS dps
		ON dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
		INNER JOIN DimProductCategory AS dpc
		ON dps.ProductCategoryKey = dpc.ProductCategoryKey
) AS CombinedProductTable;


SELECT * FROM DimProductT;
--Replace zeros (0) in the Product Style column with “NA”.
	UPDATE [DimProduct ]
	SET ProductStyle = 'NA'
	WHERE ProductStyle = '0';

--To remove duplicates from the DimProductT Table.
With CTE AS (
	SELECT 
	*,
	ROW_NUMBER () OVER (PARTITION BY
		ProductKey,
		SKUType, 
		ProductName,
		ProductColor, 
		ProductSize, 
		ProductStyle, 
		ProductCost, 
		ProductPrice,
		CategoryName,
		ProductCategoryKey,
		ProductSubcategoryKey,
		SubcategoryName
		ORDER BY ProductKey
		) AS ROWNUM
FROM DimProductT
)

--Delete Duplicate rowswhere RowNum >1 (Keeping only the first Occurence.
DELETE FROM CTE WHERE ROWNUM >1;

--To add primary constraint to DimProductT
ALTER TABLE DimProductT
ADD CONSTRAINT PK_DimProductT PRIMARY KEY(ProductKey);

  
--To view all Columns in the Customer Table
	SELECT  
	CustomerKey,
	CONCAT(Prefix,' ',FirstName,' ',LastName) AS FullName,
	BirthDate,
	MaritalStatus,
	Gender,
	AnnualIncome,
	TotalChildren,
	EducationLevel,
	Occupation,
	HomeOwner
	FROM [DimCustomer ];


-
	
	DROP TABLE DimCalender;
--To create a DateTable.
CREATE TABLE DimCalender(
    Date DATE PRIMARY KEY,
    Day TINYINT,
    Month TINYINT,
    Year SMALLINT,
    DayOfWeek TINYINT,
    DayName VARCHAR(10),
    MonthName VARCHAR(10),
    Quarter TINYINT,
    YearMonth CHAR(7), -- Format: YYYY-MM
    IsWeekend BIT
);

-- Declare variables for data range
DECLARE @StartDate DATE = '2020-01-01';
DECLARE @EndDate DATE = '2022-12-31';

-- Clear existing data (if needed)
TRUNCATE TABLE DimCalender;

-- To populate the Date Dimension Table
;WITH DateSeries AS (
    -- Anchor member
    SELECT 
        @StartDate AS Date
    UNION ALL 
    -- Recursive member
    SELECT 
        DATEADD(DAY, 1, Date)
    FROM DateSeries
    WHERE Date < @EndDate
)

-- Insert into DimCalender table
INSERT INTO DimCalender
SELECT
    Date,
    DAY(Date) AS Day,
    MONTH(Date) AS Month,
    YEAR(Date) AS Year,
    DATEPART(WEEKDAY, Date) AS DayOfWeek,
    DATENAME(WEEKDAY, Date) AS DayName,
    DATENAME(MONTH, Date) AS MonthName,
    DATEPART(QUARTER, Date) AS Quarter, -- Changed from DATENAME to DATEPART for numeric quarter
    CONVERT(CHAR(7), Date, 126) AS YearMonth, -- Format: YYYY-MM
    CASE WHEN DATEPART(WEEKDAY, Date) IN (1, 7) THEN 1 ELSE 0 END AS IsWeekend
FROM DateSeries
OPTION (MAXRECURSION 0);

--To drop the DateKey column from the DimCalenderTable

SELECT * FROM DimCalender;




