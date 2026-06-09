DROP TABLE IF EXISTS retail_sales;

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

SELECT  * FROM retail_sales;

SELECT COUNT(*)FROM retail_sales;

--- finding null


SELECT * FROM retail_sales
WHERE transaction_id IS NULL
OR
sale_date IS NULL
OR
sale_time IS NULL
OR
customer_id IS NULL
OR
gender IS NULL
OR
age IS NULL
OR
category IS NULL
OR
quantity IS NULL
OR
price_per_unit IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL;

--deleting null

DELETE FROM retail_sales
WHERE transaction_id IS NULL
OR
sale_date IS NULL
OR
sale_time IS NULL
OR
customer_id IS NULL
OR
gender IS NULL
OR
age IS NULL
OR
category IS NULL
OR
quantity IS NULL
OR
price_per_unit IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL;

--data exploration

How many sales we have?
SELECT COUNT(*) as totsl_sales FROM retail_sales;

--How many unique customers do we have?
SELECT COUNT(DISTINCT customer_id) as totsl_sales FROM retail_sales;

----Data Analysis: Business Key Problems and Answers/



--Write a SQL query to retrieve all columns for sales made on 2022-11-05
SELECT * FROM retail_sales
WHERE sale_date='2022-11-05';

--Write a SQL query to retrieve all transactions where the category is clothing and the quantity sold is more than 4 in the month of November 2022.

SELECT *
FROM retail_sales
WHERE category= 'clothing'
AND
sale_date >= '2022-07-09'
AND
sale_date < '2022-11-05'
AND
quantity > 2


--write a SQL query to calculate total sales for each category. 


SELECT category ,
SUM(total_sale)as net_sale,
COUNT(*)AS total_orders
FROM retail_sales
GROUP BY 1 ;

--Write a SQL query to find the average age of customers who purchased items from the Beauty category. 

SELECT ROUND(AVG(age) , 2)as average_age
FROM retail_sales
WHERE category='Beauty'

--Write a SQL query to find all transactions where the total sale is greater than 1000. 

SELECT * FROM retail_sales
WHERE total_sale>1000

--write-a SQL for it to find the total number of transactions made by each gender in each category 

SELECT

category,
gender,
COUNT(*) as total_trans

FROM retail_sales

GROUP BY
category, gender
ORDER BY 1

--Write an SQL query to calculate average sales for each month. Find out the best selling month in each year.


SELECT 
    year,
    month,
    avg_sale
FROM (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM sale_date) 
            ORDER BY AVG(total_sale) DESC
        ) AS rnk
    FROM retail_sales
    GROUP BY 1, 2
) t
WHERE rnk = 1;

---A find out the top five customers based on the highest total sales

SELECT

category,

COUNT (DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales

GROUP BY category


--Write an SQL query to create each shift and number of orders. Example Morning <= 12 Afternoon between 12 and 17 Evening > 17

WITH hourly_sale AS (
    SELECT *,
        CASE
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)

SELECT 
    shift,
    COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;


--END OF THE PROJECT