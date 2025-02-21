# netflix_sql
Netflix Data Analysis using SQL


![نيتفلكس1](https://github.com/user-attachments/assets/0cc1a531-8e05-4a34-ac2b-4e469de169fd)
Project Overview
Title: Retail Sales Analysis
Database: SQL - Retail_Sales_Analysis

This project aims to analyze retail sales data using SQL to extract valuable insights into sales performance, customer behavior, and key business trends. The project includes database setup, data cleaning, execution of analytical queries, and the creation of detailed reports to help business owners make data-driven decisions.

Project Objectives
✅ Setting up a structured database and organizing data.
✅ Cleaning the data and ensuring it is error-free.
✅ Analyzing data to answer key business questions.
✅ Creating reports to support data-driven decision-making.

Project Structure
1. Database Setup
The project begins by creating the retail_sales table within the Retail_Sales_Analysis database, containing details of each sales transaction, such as transaction ID, date, customer details, category, price, cost, and total sales value.

sql
Copy
Edit
-- SQL Retail Sales Analysis

-- Drop the table if it already exists
DROP TABLE IF EXISTS retail_sales;

-- Create the retail_sales table
CREATE TABLE retail_sales (
    transaction_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(50),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);

-- Retrieve the first 10 records
SELECT TOP 10 * FROM retail_sales;
2. Data Cleaning
This step involves checking for and removing missing values to maintain data integrity.

sql
Copy
Edit
-- Identify missing values
SELECT * FROM retail_sales WHERE 
    transaction_id IS NULL OR 
    sale_date IS NULL OR 
    sale_time IS NULL OR 
    gender IS NULL OR 
    category IS NULL OR 
    quantity IS NULL OR 
    cogs IS NULL OR 
    total_sale IS NULL;

-- Delete records with missing values
DELETE FROM retail_sales WHERE 
    transaction_id IS NULL OR 
    sale_date IS NULL OR 
    sale_time IS NULL OR 
    gender IS NULL OR 
    category IS NULL OR 
    quantity IS NULL OR 
    cogs IS NULL OR 
    total_sale IS NULL;
3. Data Exploration
Initial data analysis includes:
✅ Determining the total number of sales transactions.
✅ Counting the number of unique customers.
✅ Listing different product categories.

sql
Copy
Edit
-- Total number of transactions
SELECT COUNT(*) AS total_sales FROM retail_sales;

-- Number of unique customers
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

-- Different product categories
SELECT DISTINCT category FROM retail_sales;
4. Data Analysis & Business Insights
Q1: Retrieve all sales transactions for a specific date
sql
Copy
Edit
SELECT * FROM retail_sales WHERE sale_date = '2023-01-05';
Q2: Retrieve all transactions where category is "Clothing" and quantity sold is more than 10 in November 2023
sql
Copy
Edit
SELECT * FROM retail_sales 
WHERE category = 'Clothing' 
AND sale_date BETWEEN '2023-11-01' AND '2023-11-30' 
AND quantity > 10;
Q3: Calculate total sales for each product category
sql
Copy
Edit
SELECT category, SUM(quantity * price_per_unit) AS total_sales 
FROM retail_sales 
GROUP BY category;
Q4: Determine the average age of customers who purchased beauty products
sql
Copy
Edit
SELECT AVG(age) AS average_age 
FROM retail_sales 
WHERE category = 'Beauty';
Q5: Retrieve all high-value transactions where total sales exceed $1000
sql
Copy
Edit
SELECT transaction_id, total_sale 
FROM retail_sales 
WHERE total_sale > 1000;
Q6: Count total transactions by gender and product category
sql
Copy
Edit
SELECT COUNT(transaction_id) AS total_transactions, gender, category 
FROM retail_sales 
GROUP BY gender, category;
Q7: Calculate average sales per month and determine the best-selling month each year
sql
Copy
Edit
SELECT TOP 3 
    YEAR(sale_date) AS year, 
    MONTH(sale_date) AS month, 
    AVG(quantity) AS avg_sales 
FROM retail_sales 
GROUP BY YEAR(sale_date), MONTH(sale_date) 
ORDER BY avg_sales DESC;
Q8: Find the top 5 customers with the highest total purchases
sql
Copy
Edit
SELECT TOP 5 
    customer_id, 
    SUM(total_sale) AS total_sales 
FROM retail_sales 
GROUP BY customer_id 
ORDER BY total_sales DESC;
Q9: Determine the number of unique customers for each product category
sql
Copy
Edit
SELECT category, COUNT(DISTINCT customer_id) AS unique_customers 
FROM retail_sales 
GROUP BY category;
Q10: Categorize sales into different time-based shifts (Morning, Afternoon, Evening) and count the number of orders in each shift
sql
Copy
Edit
SELECT 
    CASE 
        WHEN DATEPART(HOUR, sale_time) <= 12 THEN 'Morning' 
        WHEN DATEPART(HOUR, sale_time) <= 17 THEN 'Afternoon' 
        ELSE 'Evening' 
    END AS shift, 
    COUNT(*) AS total_orders 
FROM retail_sales 
GROUP BY 
    CASE 
        WHEN DATEPART(HOUR, sale_time) <= 12 THEN 'Morning' 
        WHEN DATEPART(HOUR, sale_time) <= 17 THEN 'Afternoon' 
        ELSE 'Evening' 
    END 
ORDER BY total_orders DESC;
Findings
📌 Top-performing categories can help optimize marketing and inventory management.
📌 Peak sales hours show when customer traffic is highest.
📌 Demographic trends allow for personalized customer targeting.
📌 Top-spending customers can be targeted with exclusive offers.

Reports Available
📊 Daily Sales Summary
📊 Most Profitable Product Categories
📊 Monthly Sales Trends
📊 Customer Demographics Analysis
📊 Top-Spending Customers Report

Conclusion
This project provides a comprehensive analysis of retail sales, extracting key insights into sales trends and customer behavior. Business owners can leverage these findings to enhance their strategies and make data-driven decisions.

How to Use
1️⃣ Run queries to extract relevant insights.
2️⃣ Analyze results to generate accurate reports.
3️⃣ Modify and extend by adding advanced analytics.


