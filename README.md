# Walmart_sales_data

**Dataset Link:** https://www.kaggle.com/datasets/najir0123/walmart-10k-sales-datasets

#  Key Operations in the Walmart Data Cleaning Notebook

* 1.Data Loading
```
import pandas as pd
data = pd.read_csv("Walmart.csv", encoding_errors='ignore')
```
  * Loads the Walmart.csv dataset using Pandas.

* 2.Initial Exploration
```
data.describe()
data.info()
```
  * Checks summary statistics and data types.

# Data Cleaning Steps in the Notebook

* 1.Removing Duplicates
```
data.duplicated().sum()
data.drop_duplicates(inplace=True)
data.duplicated().sum()
```
  * Checks for duplicate rows and removes them.

* 2.Handling Missing Values
```
data.isnull().sum()
data.dropna(inplace=True)
data.isnull().sum()
```
  * Identifies missing values and drops them.

* 3.Data Type Conversion
```
data['unit_price'] = data['unit_price'].str.replace('$', '').astype(float)
```
  * Converts unit_price from string (with dollar signs) to float for numerical analysis.

# Additional Data Transformations

* 1.Creating a New Feature (total_price)
```
data['total_price'] = data['unit_price'] * data['quantity']
````
  * Adds a total price column by multiplying unit price with quantity.

* 2.Exporting the Cleaned Data
```
data.to_csv("Walmart_Clean_Data.csv")
```
  * Saves the cleaned dataset as a new CSV file.

Summary of Walmart Data Cleaning Notebook
✅ Operations Performed:

* Loaded Walmart sales data.
* Removed duplicates to ensure data integrity.
* Handled missing values by dropping empty rows.
* Converted unit_price from string to float.
* Created a total_price column for financial analysis.
* Saved the cleaned dataset for further use.

