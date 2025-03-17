-- Bussiness Problems
-- Q1. Find Different payment method and number of transactions, number of quantity sold.
	select 
		payment_method,
        count(*) as no_of_payments,
        sum(quantity) as no_qty_sold
	from walmart_sale_analysis
    group by payment_method;
-- Q2. Identify the highest-rated category in each branch,displaying the branch , category avg rating
		select *
        from
        (   select 
				branch,
				category,
				avg(rating) as avg_rating,
				rank() over(partition by branch order by avg(rating) desc) as ranks
			from walmart_sale_analysis
			group by 1,2
		) as ranked_categories
        where ranks=1;
        
-- Q3. Identify the busiest day for each branch based on the number of transactions
			select * 
            from
			(
				select 
					branch,
					dayname(date) as bussiest_day,
					count(*) as no_transactions,
                    rank() over(partition by branch order by count(*) desc) as ranks
				from walmart_sale_analysis
				group by 1,2
			) as ranked_categories
            where ranks=1;
            
-- Q4. Calculate the total quantity of items sold per payment method. List payment_method and total_quantity.
	select 
		payment_method,
        sum(quantity) as no_qty_sold
    from walmart_sale_analysis
    group by payment_method;
    
-- Q5. Determine the average, minimum, and maximum rating of category for each city.
-- List the city, average_rating, min_rating and max_rating.
	select city,
    category,
		min(rating) as min_rating,
		max(rating) as max_rating,
		avg(rating) as avg_rating
	from walmart_sale_analysis
    group by city,category
    order by 1;
    
-- Q6. Calculate the total profit for each category by considering total_profit as 
-- 	(unit_price * quantity *profit_margin). List category & total_profit, ordered from highest to lowest profit. 
select
	category,
    sum(total_price) as total_revenue,
    sum(total_price * profit_margin) as total_profit
from walmart_sale_analysis
group by category;
    
-- Q7. Determine the most commom payment_method for each branch.
-- 	Display branch and the preferred_payment_method.
	with cte 
    as
   ( 
    select 
		branch,
		payment_method,
		count(*) as total_trans,
		rank() over(partition by branch order by count(*) desc) as ranks
	from walmart_sale_analysis
	group by branch,payment_method
    )
    select * 
    from cte 
    where ranks=1; 
    
-- Q8. Categorizes sales into 3 groups Morning, Afternoon, Evening
-- 	Find out which of the shift and number of Invoices
select 
	branch,
	case 
		when hour(time)<12 then 'Morning' 
		when hour(time) between 12 and 17 then 'Afternoon' 
		else 'Evening'
	end as day_time,
	count(*)
from walmart_sale_analysis
group by 1,2
order by 1,3 desc;


-- Q9. Identify 5 branch with highest decrease ratio in revenue compare to last year(current 2023 and last year 2022)
	-- rdr==(last_year_revenue-current_year_revenue)/last_year_revenue*100
  
   with revenue_2022
   as
    (
	    select 
			branch,
			sum(total_price) as revenue
		from walmart_sale_analysis
		where year(date) = 2022
		group by branch
    ),
    revenue_2023
   as
    (
	    select 
			branch,
			sum(total_price) as revenue
		from walmart_sale_analysis
		where year(date) = 2023
		group by branch
    )
    select 
		last_year.branch,
		last_year.revenue as last_year_revenue,
		curr_year.revenue as curr_year_revenue,
        round(
			(last_year.revenue - curr_year.revenue) / 
            last_year.revenue * 100,
            2) as revenue_decrease_ratio
    from revenue_2022 as last_year
    join revenue_2023 as curr_year
    on last_year.branch=curr_year.branch
    where 
		last_year.revenue > curr_year.revenue
	order by revenue_decrease_ratio desc
    limit 5;
    
    -- END