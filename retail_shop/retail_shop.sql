create table retail_sales(
transcations_id int primary key,
sale_date date,
sale_time time,
customer_id int,
gender varchar(15),
age int,
category varchar(15),
quantity int,
price_per_unit float,
cogs float,
total_sale float
)

select * from retail_sales
-- we imported the data by editing the table so that it was easy for us to add the data from exccel file--

select count(*) from retail_sales

-- cleaing the data( removing all the null values)

--viewing the null--
SELECT * 
FROM retail_sales
WHERE
	transcations_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL
   
   -- now cleaning the data by deleting the null values--

   delete from retail_sales
   WHERE
	transcations_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL

   select * from retail_sales
   select count(*) from retail_sales-- from 2000 column 3 have been deleted coz of null values (1987)--

 
/*3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:*/


 --1. Write a SQL query to retrieve all columns for sales made on '2022-11-05'--

 select * from retail_sales
 where sale_date='2022-11-05'

 

/* 2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' 
and the quantity sold is more than 4 in the month of Nov-2022**:*/


SELECT * 
FROM retail_sales
WHERE category = 'clothing'
  AND FORMAT(sale_date, 'yyyy-MM') = '2022-11'
  AND quantity <= 4


--3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:--

select SUM(total_sale) as total_sales,category from retail_sales
group by category
order by total_sales


--4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:--


select avg(age) as avg_age, category from retail_sales
where category='Beauty'
group by category


--5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:--

select * from retail_sales
where total_sale>1000

--6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:--

select count(transcations_id) as coun_trans, gender ,category from retail_sales
group by gender,category
order by coun_trans

--7. **Write a SQL query to find the top 5 customers based on the highest total sales **:--

select sum(total_sale) as high_tot , customer_id  from retail_sales
group by customer_id
order by high_tot desc

--8. **Write a SQL query to find the number of unique customers who purchased items from each category.**:--
select count(distinct customer_id) as unq_count ,category from retail_sales
group by category
order by unq



--9. **Write a SQL query to create each shift and number of orders
--(Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:--

with hourly_sale
as 
(
select *,shiftu=
case
when DATEPART(HOUR, sale_time)<12 then 'morning'
when DATEPART(hour, sale_time) between 12 and 17 then 'afternoon'
else 'evening'
end
from retail_sales
)
select shiftu,
count(*) as total_orders
from
hourly_sale
group by shiftu


