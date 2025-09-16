select * from retail_sales;

select * from retail_sales
where 
     transactions_id is NULL
     or
     sale_date is NULL
     Or
     sale_time is null
     or
     customer_id is null
     or
     gender is null
     or
     category is null
     or
     quantity is null
     or
     price_per_unit is null
     or 
     cogs is null
     or
     total_sale is null;

     --Delete
     delete from retail_sales
     where 
     transactions_id is NULL
     or
     sale_date is NULL
     Or
     sale_time is null
     or
     customer_id is null
     or
     gender is null
     or
     category is null
     or
     quantiy is null
     or
     price_per_unit is null
     or 
     cogs is null
     or
     total_sale is null;

     select * from retail_sales;

     exec sp_rename 'retail_sales.quantiy', 'quantity','COLUMN';

 --Data Exploration 
-- How many sales we have ?
select count(*) as number_of_sales
from retail_sales;

 --How many customers we have?
select  count( distinct customer_id) as customer_numbers
from retail_sales;

 -- How many categories we have ?
select count(distinct category) as number_of_category
from retail_sales;

- list  all the unique categories ?
select distinct category as All_category
from retail_sales;


--Data Analysis & Business Key problems & Answers
--Q.1 write a SQL query to retrieve all columns for sales made on '2022-11-05'
select *
from retail_sales
where sale_date ='2022-11-05';

--Q.2 write a SQL Query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022.
SELECT *
FROM retail_sales
WHERE Category = 'Clothing'
  AND Quantity > 4
  AND sale_date >= '2022-11-01'
  AND sale_date < '2022-12-01';

  --Q.3 write a SQL query to calculate the total sales (total_sales) for each category
  select 
       category,
       sum(total_sale) as total_sales
from retail_sales
group by category;

--Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select 
      category,
      avg(age) as Avg_age
from retail_sales
group by category 
having category = 'Beauty'

--Q.5 write a SQL query to find all transactions where the total_sale is greater than 1000.
select * 
from retail_sales
where total_sale >1000;


-- Q.6 write  a SQL query to find the total number of transactions(transaction_id) made by each gender in each category.
select 
     category,
     gender,
     count(*) as Total_transactions
from retail_sales
group by category,gender;


-- Q.7 Write a SQL query to calculate the average sale for each month . find out the best selling month in each year.

select year, month, avg_sale
from
(
    select
        year(sale_date) as year,
        month(sale_date) as month,
        avg(total_sale) as avg_sale,
        rank() over(partition by year(sale_date) order by avg(total_sale) desc) as rnk
    from retail_sales
    group by year(sale_date), month(sale_date)
) as t
where rnk = 1;


--Q.8  Write a SQL query to find the top 5 customers based on the highest total sales
select 
     top 5
     customer_id,
     sum(total_sale) as total_sales
from retail_sales
group by customer_id
order by sum(total_sale) desc ;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select 
      category,
      count(distinct customer_id) as unique_customers
from retail_sales
group by category;


--Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
with hourly_sale as
(
select *,
     case
      when DatePart(hour,sale_time) <12 then 'Morning'
      when datePart(hour,sale_time) between 12 and 17 then 'Afternoon'
      else 'Evening'
end as shift
from retail_sales
)
select
      shift,
      count(*) as total_orders
from hourly_sale
group by shift;



--END OF PROJECT
