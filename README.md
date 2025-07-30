Project Overview 

This is a project based on an e-commerce inventory dataset scraped from Zepto — one of India’s fastest-growing quick-commerce startups. This project simulates real analyst workflows, from raw data exploration to business-focused data analysis.

Dataset Overview

The dataset was sourced from Kaggle and was originally scraped from Zepto’s official product listings.Each row represents a unique SKU (Stock Keeping Unit) for a product. Duplicate product names exist because the same product may appear multiple times in different package sizes, weights, discounts, or categories to improve visibility – exactly how real catalog data looks.


🧾 Columns:

1. sku_id: Unique identifier for each product entry (Synthetic Primary Key)

2. name: Product name as it appears on the app

3. category: Product category like Fruits, Snacks, Beverages, etc.

4. mrp: Maximum Retail Price (originally in paise, converted to ₹)

5. discountPercent: Discount applied on MRP

6. discountedSellingPrice: Final price after discount (also converted to ₹)

7. availableQuantity: Units available in inventory

8. weightInGms: Product weight in grams

9. outOfStock: Boolean flag indicating stock availability

10. quantity: Number of units per package (mixed with grams for loose produce)


Questions 


Data Exploration
1. Counted the total number of records in the dataset

2. Viewed a sample of the dataset to understand structure and content

3. Checked for null values across all columns

4. Identified distinct product categories available in the dataset

5. Compared in-stock vs out-of-stock product counts

6. Detected products present multiple times, representing different SKUs

 Data Cleaning
7. Identified and removed rows where MRP or discounted selling price was zero

8. Converted mrp and discountedSellingPrice from paise to rupees for consistency and readability

Business Insights
9. Found top 10 best-value products based on discount percentage

10. Identified high-MRP products that are currently out of stock

11. Estimated potential revenue for each product category

12. Filtered expensive products (MRP > ₹500) with discount < 10%

13. Ranked top 5 categories offering highest average discounts

14. Calculated price per gram to identify value-for-money products

15. Grouped products based on weight into Low, Medium, and Bulk categories

16. Measured total inventory weight per product category


Queries 

DATABASE CREATION 
```sql
CREATE DATABASE SQL_PROJECT_1;
```

TABLE CREATION
```sql
CREATE TABLE sql_project_1.Zepto
(
Sku_id INT auto_increment PRIMARY KEY,
Category	VARCHAR(100),
name	VARCHAR(100),
mrp	  INT,
discountPercent	 INT,
availableQuantity	INT,
discountedSellingPrice	INT,
weightInGms	INT,
outOfStock	TINYINT(1),
quantity  INT);
```

Total number of records in the dataset
```sql
SELECT COUNT(*) FROM sql_project_1.zepto AS Total_records;
```

Sample of the dataset to understand structure and content
```sql
SELECT * FROM sql_project_1.zepto;
```

Checked for null values across all columns
```sql
SELECT * FROM sql_project_1.zepto
WHERE 
Category IS NULL OR	
name	IS NULL  OR
mrp	  IS NULL OR
discountPercent	IS NULL OR
availableQuantity IS NULL OR
discountedSellingPrice	IS NULL OR
weightInGms	IS NULL OR
outOfStock	IS NULL OR
quantity IS NULL;
```

DATA EXPLORATION & ANALYSIS

Identified distinct product categories available in the dataset
```sql
SELECT DISTINCT(Category) AS Unique_Categories FROM sql_project_1.zepto
ORDER BY Category;
```

Compared in-stock vs out-of-stock product counts
```sql
SELECT COUNT(Sku_id) AS in_stock , SUM(outofstock) AS out_of_stock FROM sql_project_1.zepto
GROUP BY outOfStock;
```

Product names present multiple times 
```sql
SELECT name , COUNT(sku_id) AS No_of_sku
FROM sql_project_1.zepto
GROUP BY name 
HAVING COUNT(Sku_id) > 1
ORDER BY COUNT(Sku_id) DESC;
```

To delete safe mode
```sql
SET SQL_SAFE_UPDATES = 0;
```

Identified and removed rows where MRP or discounted selling price was zero
```sql
DELETE FROM sql_project_1.zepto
WHERE mrp = 0 or discountedsellingprice = 0 ;
```

Converted mrp and discountedSellingPrice from paise to rupees for consistency and readability
```sql
UPDATE sql_project_1.zepto
SET mrp = mrp/100.0 , 
discountedSellingPrice = discountedSellingPrice/100.0;
```
```sql
Top 10 best-value products based on discount percentage
SELECT Category, name , discountPercent FROM sql_project_1.zepto 
ORDER BY discountPercent DESC
LIMIT 10;
```

Identify high-MRP products that are currently out of stock
```sql
SELECT distinct(name) , mrp FROM sql_project_1.zepto
WHERE outOfStock = 1
ORDER BY mrp DESC
LIMIT 10;
```

Estimated potential revenue for each product category
```sql
SELECT Category , SUM(discountedSellingPrice*availableQuantity) AS potential_revenue 
FROM sql_project_1.zepto
group by Category;
```

Filtered expensive products (MRP > ₹500) with discount 10%
```sql
SELECT name , mrp FROM sql_project_1.zepto
WHERE mrp > 500 AND discountPercent < 10;
```

Ranked top 5 categories offering highest average discount percent
```sql
SELECT Category, ROUND(AVG(discountpercent),2) AS average_discount FROM sql_project_1.zepto
GROUP BY Category
ORDER BY AVG(discountPercent) DESC
LIMIT 5;
```

Calculate price per gram to identify value-for-money products
```sql
SELECT Category , name , ROUND(discountedsellingprice/weightingms,2) AS Value_for_money_products
FROM sql_project_1.zepto;
```

Grouped products based on weight into Low, Medium, and Bulk categories
```sql
SELECT Category ,
(
CASE 
WHEN WEIGHTINGMS < 1000 THEN "low_Category" 
WHEN WEIGHTINGMS < 5000 THEN "Medium_Category"
WHEN WEIGHTINGMS > 5000 THEN "Bulk_Category" END ) AS Stock 
FROM sql_project_1.ZEPTO;
```

Measured total inventory weight per product category
```sql
SELECT Category , SUM(weightingms*availableQuantity) AS inventory_weight 
FROM sql_project_1.zepto
GROUP BY Category;
```
-- END OF PROJECT --




