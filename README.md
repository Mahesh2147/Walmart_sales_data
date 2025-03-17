# Walmart_sales_data

**Dataset Link:** https://www.kaggle.com/datasets/najir0123/walmart-10k-sales-datasets

###  Key Operations in the Walmart Data Cleaning Notebook

* 1. Data Loading
```
import pandas as pd
data = pd.read_csv("Walmart.csv", encoding_errors='ignore')
```
   ** Loads the Walmart.csv dataset using Pandas.

* 2. Initial Exploration
```
data.describe()
data.info()
```
   ** Checks summary statistics and data types.

# Data Cleaning Steps in the Notebook

* 1. Removing Duplicates
```
data.duplicated().sum()
data.drop_duplicates(inplace=True)
data.duplicated().sum()
```
   ** Checks for duplicate rows and removes them.

* 2. Handling Missing Values
```
data.isnull().sum()
data.dropna(inplace=True)
data.isnull().sum()
```
   ** Identifies missing values and drops them.

* 3. Data Type Conversion
```
data['unit_price'] = data['unit_price'].str.replace('$', '').astype(float)
```
   ** Converts unit_price from string (with dollar signs) to float for numerical analysis.

# Additional Data Transformations

* 1. Creating a New Feature (total_price)
```
data['total_price'] = data['unit_price'] * data['quantity']
````
   ** Adds a total price column by multiplying unit price with quantity.

* 2. Exporting the Cleaned Data
```
data.to_csv("Walmart_Clean_Data.csv")
```
   ** Saves the cleaned dataset as a new CSV file.

# Summary of Walmart Data Cleaning Notebook
✅ Operations Performed:

* Loaded Walmart sales data.
* Removed duplicates to ensure data integrity.
* Handled missing values by dropping empty rows.
* Converted unit_price from string to float.
* Created a total_price column for financial analysis.
* Saved the cleaned dataset for further use.

# Schemas
-- First Create DATABASE
```
create database Walmart_data;
use Walmart_data;
```
-- Create Table
```
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
```

-- Total records in data
```
select count(*) from walmart_sale_analysis;
```

-- Find count of payment_methods
```
select 
	distinct payment_method ,
    count(*)
    from walmart_sale_analysis
    group by payment_method;
```
 
-- find the count of branch
```
select 
	count(distinct branch) 
from walmart_sale_analysis;
```

-- Find Max and Min of quantity 
```
select max(quantity) from walmart_sale_analysis;
select min(quantity) from walmart_sale_analysis;
```

# Key Business Questions & SQL Queries
1. Payment Method Analysis
```
SELECT 
    payment_method,
    COUNT(*) AS no_of_payments,
    SUM(quantity) AS no_qty_sold
FROM walmart_sale_analysis
GROUP BY payment_method;
```
   ** Identifies different payment methods used.
   ** Counts total transactions and total quantity sold per method.
  
2. Highest-Rated Product Category in Each Branch
```
SELECT * 
FROM (
    SELECT 
        branch,
        category,
        AVG(rating) AS avg_rating,
        RANK() OVER(PARTITION BY branch ORDER BY avg_rating DESC) AS ranks
    FROM walmart_sale_analysis
    GROUP BY 1,2
) AS ranked_categories
WHERE ranks = 1;
```
   ** Finds the most popular product category per store branch based on customer ratings.
   ** Uses window functions (RANK) to rank categories per branch.

3. Busiest Shopping Days by Branch
```
SELECT * 
FROM (
    SELECT 
        branch,
        DAYNAME(date) AS busiest_day,
        COUNT(*) AS no_transactions,
        RANK() OVER (PARTITION BY branch ORDER BY COUNT(*) DESC) AS ranks
    FROM walmart_sale_analysis
    GROUP BY 1,2
) AS ranked_days
WHERE ranks = 1;
```
   ** Identifies the busiest day for each Walmart branch.
   ** Helps optimize staffing and inventory management.

Potential Business Insights
✔ Popular Payment Methods → Helps Walmart improve transaction processing.
✔ Top-Rated Categories → Guides marketing and promotional efforts.
✔ Busiest Shopping Days → Assists in workforce planning and inventory restocking.
