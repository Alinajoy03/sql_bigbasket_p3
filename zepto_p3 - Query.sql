-- DATABASE CREATION 
CREATE DATABASE SQL_PROJECT_1;

-- TABLE CREATION
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

-- Total number of records in the dataset
SELECT COUNT(*) FROM sql_project_1.zepto AS Total_records;

-- Viewed a sample of the dataset to understand structure and content
SELECT * FROM sql_project_1.zepto;

-- Checked for null values across all columns
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

-- DATA EXPLORATION & ANALYSIS

-- Identified distinct product categories available in the dataset
SELECT DISTINCT(Category) AS Unique_Categories FROM sql_project_1.zepto
ORDER BY Category;

-- Compared in-stock vs out-of-stock product counts
SELECT COUNT(Sku_id) AS in_stock , SUM(outofstock) AS out_of_stock FROM sql_project_1.zepto
GROUP BY outOfStock;

-- Product names present multiple times 
SELECT name , COUNT(sku_id) AS No_of_sku
FROM sql_project_1.zepto
GROUP BY name 
HAVING COUNT(Sku_id) > 1
ORDER BY COUNT(Sku_id) DESC;

-- To delete safe mode
SET SQL_SAFE_UPDATES = 0;

-- Identified and removed rows where MRP or discounted selling price was zero
DELETE FROM sql_project_1.zepto
WHERE mrp = 0 or discountedsellingprice = 0 ;

-- Converted mrp and discountedSellingPrice from paise to rupees for consistency and readability
UPDATE sql_project_1.zepto
SET mrp = mrp/100.0 , 
discountedSellingPrice = discountedSellingPrice/100.0;

-- Top 10 best-value products based on discount percentage
SELECT Category, name , discountPercent FROM sql_project_1.zepto 
ORDER BY discountPercent DESC
LIMIT 10;

-- Identify high-MRP products that are currently out of stock
SELECT distinct(name) , mrp FROM sql_project_1.zepto
WHERE outOfStock = 1
ORDER BY mrp DESC
LIMIT 10;

-- Estimated potential revenue for each product category
SELECT Category , SUM(discountedSellingPrice*availableQuantity) AS potential_revenue 
FROM sql_project_1.zepto
group by Category;

-- Filtered expensive products (MRP > ₹500) with discount 10%
SELECT name , mrp FROM sql_project_1.zepto
WHERE mrp > 500 AND discountPercent < 10;

-- Ranked top 5 categories offering highest average discount percent
SELECT Category, ROUND(AVG(discountpercent),2) AS average_discount FROM sql_project_1.zepto
GROUP BY Category
ORDER BY AVG(discountPercent) DESC
LIMIT 5;

-- Calculate price per gram to identify value-for-money products
SELECT Category , name , ROUND(discountedsellingprice/weightingms,2) AS Value_for_money_products
FROM sql_project_1.zepto;

-- Grouped products based on weight into Low, Medium, and Bulk categories
SELECT Category ,
(
CASE 
WHEN WEIGHTINGMS < 1000 THEN "low_Category" 
WHEN WEIGHTINGMS < 5000 THEN "Medium_Category"
WHEN WEIGHTINGMS > 5000 THEN "Bulk_Category" END ) AS Stock 
FROM sql_project_1.ZEPTO;

-- Measured total inventory weight per product category
SELECT Category , SUM(weightingms*availableQuantity) AS inventory_weight 
FROM sql_project_1.zepto
GROUP BY Category;

-- END OF PROJECT --




