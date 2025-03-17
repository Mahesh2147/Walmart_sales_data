-- First Create DATABASE
create database Walmart_data;
use Walmart_data;

-- Create Table
create table walmart_sale_analysis
(
	invoice_id bigint primary key,
    branch varchar(35) not null,
    city varchar(35) not null,
    category varchar(35) not null,
    unit_price DOUBLE PRECISION not null,
    quantity int not null,
    date Date not null,
    time Time  not null,
    payment_method varchar(35) not null,
    rating DOUBLE PRECISION,
    profit_margin DOUBLE PRECISION,
    total_price DOUBLE PRECISION NOT NULL
);

-- Total records in data
select count(*) from walmart_sale_analysis;

-- Find count of payment_methods
select 
	distinct payment_method ,
    count(*)
    from walmart_sale_analysis
    group by payment_method;
    
-- find the count of branch
select 
	count(distinct branch) 
from walmart_sale_analysis;

-- Find Max and Min of quantity 
select max(quantity) from walmart_sale_analysis;
select min(quantity) from walmart_sale_analysis;

