# Sales Analysis 

### Project Overview:
The goal is to gain important insights into a range of business variables, such as profitability, business
 performance, and product and customer specifics.

### Data Source:
1. SalesData: This is a combination of sales made from 2020-2022, The files are 'Sales Data 2020.CSV','Sales Data 2021' and Sales Data 2022.
2. Customer Lookup: This file containes information about the customers. The file name is 'Customer lookup.Csv'.
3. Product Categories Lookup: This file contains details about the product category. The file name is 'Product Categories Lookup.Csv".
4. Product Subcategories Lookup: This file contains details about the product subcategoies. The file name is 'Product Subcategories Lookup'.
5. Product Lookup: This files contains details about the products. fil name is 'Product Lookup.Csv'.
6.Territory Lookup: This file contains details about the locations were products were sold.

### Tool Used:
- SQL

### Data Preparation:
In the initial data  preparation phase, the following task were performed:
- Data Loading and inspection.
- Appended all the three sales table to form a whole salesFactTable.
- Merged the product Lookup table with the Product Categories Lookup and Subcategories Lookup  to from a whole DimProduct Table.
- Created a new table for  date named DimCalender.
- Handled missing and replaced values in both the DimproductT and  DimCustomer  Table.


### Objectives:
- How much revenue and profits have been generated so far?
- How Many orders have been placed so far ?
- What Product Category generated the most profit?
- Who are the top 10 customers based on the orders placed in the company and what straategies can be used to keep them?
-Group the customers into different income levels. If annual income is >= $150,000, Very High, If annual income is >= $100,000, High , If annual income is >= $50,000,
 Average . Otherwise, Income Level = Low and let us know based on the income level of the customers, how many orders were placed?
- How many orders were placed on the the occupation of customers.
-  Examine the countries in which the business generated the most and least revenue. Investigate methods for raising sales in areas where they were low.


### Result:
- The total cost is $14,56,986.32 while the total revenue is  $24,914,567.18 and the total profits made so far is  $10,457,580.86.
- A total of  56,046 orders has been placed so far.
- The most profit was generated from the bike category with a total of $9,726,169.08.
- The top 10 customers are
MR. FERNANDO BARNES,
MRS. ASHLEY HENDERSON	
MRS. JENNIFER SIMMONS	
MR. CHARLES JACKSON	
MR. DALTON PEREZ	
MRS. SAMANTHA JENKINS	
MR. RYAN THOMPSON	
MS. APRIL SHAN	
MR. HENRY GARCIA	
MRS. HAILEY PATTERSON	
With Mr. Fernando Barnes as the customer who placed the most orders.
- Most of the orders were placed by average income earners while the least orders were placed by the very High income earners.
- Most of the orders were placed by professionals while least was placed by manuals.
- The most revenue was made in united State while the least was made in Canada.



### Recoomendation:
- Conducting a location analysis can reveal insights into the factors contributing to low sales, such as demographics and local economic conditions.
- Providing additional sales training or support to the sales team operating in the low-sales location can enhance their performance.
-  Offering incentives like discounts can incentivize customers and boost sales in the low-performing location.
- Gathering feedbacks from customers in the low-sales location helps understand their needs better and adjust strategies accordingly.



### Challenge:
The only challege I had was when I was trying to debug an error i encountered while creating the dimCalender Table. I was getting this error for over a week only to find out changing a data type could fix it.😭


