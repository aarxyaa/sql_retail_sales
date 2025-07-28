--Data Analyst Project--
CREATE DATABASE retail_sales;

--create table--
CREATE TABLE retail_sales (
	transactions_id INT Primary key,
	sale_date DATE,
	sale_time TIME,
	customer_id INT,
	gender VARCHAR (20),
	age INT,
	category VARCHAR(20),
	quantity INT,
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale FLOAT
);

--TO RUN--
SELECT * FROM retail_sales;

--droping table--
DROP TABLE IF EXISTS retail_sales;


--DATA CLEANING--

--CHAECKING THE NULL VALUES--
SELECT * FROM 
	retail_sales
WHERE
	age is NULL
	OR
	category is NULL
	OR
	quantity is NULL
	OR
	price_per_unit is NULL
	OR
	cogs is NULL
	OR
	total_sale is NULL;

--TO DELETE NULL VALUES-
DELETE FROM retail_sales
WHERE
	age is NULL
	OR
	category is NULL
	OR
	quantity is NULL
	OR
	price_per_unit is NULL
	OR
	cogs is NULL
	OR
	total_sale is NULL;

--DATA EXPLORATION--
--HOW MANY SALE WE HAVE--
SELECT COUNT (*) AS total_sale
	FROM retail_sales;

--how many unique customer we have--
SELECT COUNT(DISTINCT customer_id) AS total_sale 
FROM retail_sales;

--FOR COUNT OF CATEGORY--
SELECT DISTINCT category 
FROM retail_sales;


SELECT * FROM retail_sales;

--Data exploration--

--Q1 WRITE A SQL QUERY TO RETRIVE ALL COLUMNS FOR SALES MADE ON '2022-11-05'
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';

--Q2 write a SQL query to retrive all transactions where the category is 'clothing' annd the quantity sold is more than is in the month of the Nov-2022

SELECT category, 
	SUM(quantity)
FROM retail_sales
WHERE category = 'Clothing'
GROUP BY 1;

--Q3 WRITE a SQL query to calculate the total sales (total_sale) for each category.
SELECT category,
	SUM(total_sale) AS net_sales
FROM retail_sales
GROUP BY 1;

--Q4 Write a SQL query to find the average age of customer who purchased items from the 'Beauty' category
SELECT 
	Avg(age) 
	FROM retail_sales
WHERE category = 'Beauty';

--Q5 Write a SQL query to find all transactions where the total_sale is greater than 1000
SELECT * FROM retail_sales
WHERE total_sale > 1000;

--Q6 Write a SQL query to find the total number of transactions (transactions_id) made by each gender in each category.
SELECT category,
	gender,
COUNT(*) as total_tans
FROM retail_sales
GROUP BY
 category,
  gender;

--Q7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
	EXTRACT (YEAR FROM sale_date) AS year,
	EXTRACT (MONTH FROM sale_date) AS month,
	AVG(total_sale) AS avg_sale
	FROM retail_sales
	GROUP BY 1,2
	ORDER BY 1,2
	
--Q8 Write a SQL query to find the top 5 customer based on the highest total sales
SELECT 
	customer_id,
	SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

--Q9 Write a SQL query to find the number of unique customer the purchased items from each category
SELECT 
	category,
	COUNT(DISTINCT customer_id) AS cnt_unique
	FROM retail_sales
	GROUP BY category


--Q10 Write a SQL query to  create each shift and number of order (Example Morning <=12, Afternoon between 12&17, Eve >17)
WITH hourly_sale
AS
(
SELECT *,
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time)BETWEEN 12 AND 17 THEN 'Afternoon'
		END AS shift
FROM retail_sales
)
SELECT 
	shift,
	COUNT (*) AS total_orders
	FROM hourly_sale
	GROUP BY shift


--END OF THE PROJECT--





