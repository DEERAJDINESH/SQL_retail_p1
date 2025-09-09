
create database sql_project_p1;
 create table Retail
( transactions_id int  primary key  ,	
sale_date date,
sale_time time,
customer_id	int,
gender varchar(100),
age int,	
category varchar(100),
quantiy	int ,
price_per_unit float ,	
cogs float,	
total_sale float
)

Alter table  retail
Rename column quantiy to quantity;


-- Data Cleaning
select * from retail
where transactions_id is null;


select * from retail
where 
transactions_id is null
or
sale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null
or
age is null
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


delete from retail
where 
transactions_id is null
or
sale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null
or
age is null
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

select count(*)
 from retail;

--Data Exploration

-- How many sales we have ?

select count(total_sale) from retail;

--How many  unique customers we have ?

 select count(distinct customer_id) from retail

 
--How many  unique categories  we have ?

 select distinct category from retail;

 --Data analysis & Business problems

-- Write a sql query that retrieve all columns for sales made on 2022-11-05 ?

select * from retail where sale_date = '2022-08-05' 

-- Write a sql query  to  retrieve all transactions where the category is 'Clothing' andthe quantity sold is more than 10 in the month of Nov-2022 ?

select *
from retail
where
category= 'Clothing'
and
to_char(sale_date, 'yyyy-mm')= '2022-11'
and
quantity >= 4 ;

--Write a sql query  to calculate the total sale (total_sale) for each category.

select 
 category,
 sum(total_sale) as net_sale ,
 count (*) as total_orders
from retail 
group by 1

--Write a sql query to find the average age of customers who purchased  items from the 'Beauty' category

  select round(avg(age),2)
  from retail where category = 'Beauty'

--Write a sql query to find all the transactions  where the  total_sale is greater than  1200.

select * from retail
where total_sale > 1200

--Write a sql query to find the total number of transactions(transactions_id) made by each gender in each category.
select 
category,gender,count(*)
from retail
group by 1,2
order by 1


--Write a sql query to calculate the average sale for  each month. find out the best selling month in each year


select 
     year, month ,avg_sale
	 from
(
select
extract(year from sale_date) as year ,
extract(month from sale_date) as month ,
avg(total_sale) as avg_sale,
rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc ) as rank
from retail
group by 1,2) as t1
 where rank=1


--Write a sql query to find the top 5 customers  based on the highest total sales.

select 
customer_id,
sum(total_sale ) as total_sales
from retail
group by 1 
order by 2 Desc
limit 5

--Write a sql query to find out the unique customers who purchased items from each category.

select 
category,
count(distinct customer_id) as unique_cus
from retail
group by 1

--Write a sql query to creat each shift  and number of orders(eg: Morning<= 12,Afternoon between 12 & 17,Evening>17)
with hourly_sales
as
(
 select *,
  case
   when extract (hour from sale_time)<12 then 'Morning'
   when extract (hour from sale_time) between  12 and 17 then 'Afternoon'
   else 'Evening'
   end  as shift
  from retail
  )
  select
  shift,
  count(*) as total_orders
  from hourly_sales
  group  by shift

  -- End of project