create database sql_project

use sql_project

--data exploration
select * from zepto

select count(*) from zepto

select top 10 * from zepto

select * from zepto where Category is null or
name is null or mrp is null or
discountPercent is null or availableQuantity is null or
discountedSellingPrice is null or weightInGms is null or
outOfStock is null or quantity is null

select distinct category from zepto

select outofstock,count(*) from zepto group by outOfStock

select name,count(*) as Number_of_SKU from zepto 
group by name having count(*)>1 order by count(*) desc

--data cleaning
select * from zepto 
where mrp=0 or discountedSellingPrice=0

delete from zepto where mrp=0

update zepto set mrp=mrp/100.0,
discountedSellingPrice = discountedSellingPrice/100.0

select mrp,discountedSellingPrice from zepto

--data analysis

-- Q1. Find the top 10 best-value products based on the discount percentage

SELECT DISTINCT TOP (10) name, mrp, discountPercent
FROM zepto
ORDER BY discountPercent DESC

--Q2.What are the Products with High MRP but Out of Stock

SELECT DISTINCT name,mrp
FROM zepto
WHERE outOfStock = 1 and mrp > 300
ORDER BY mrp DESC

--Q3.Calculate Estimated Revenue for each category

SELECT category,
SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue

-- Q4. Find all products where MRP is greater than ?500 and discount is less than 10%.

SELECT DISTINCT name, mrp, discountPercent
FROM zepto
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC

-- Q5. Identify the top 5 categories offering the highest average discount percentage.
SELECT top 5 category,
ROUND(AVG(discountPercent),2) AS avg_discount
FROM zepto
GROUP BY category
ORDER BY avg_discount DESC

-- Q6. Find the price per gram for products above 100g and sort by best value.

SELECT DISTINCT name, weightInGms, discountedSellingPrice,
ROUND(discountedSellingPrice/weightInGms,2) AS price_per_gram
FROM zepto
WHERE weightInGms >= 100
ORDER BY price_per_gram

--Q7.Group the products into categories like Low, Medium, Bulk.

SELECT DISTINCT name, weightInGms,
CASE WHEN weightInGms < 1000 THEN 'Low'
WHEN weightInGms < 5000 THEN 'Medium'
ELSE 'Bulk'
END AS weight_category
FROM zepto

--Q8.What is the Total Inventory Weight Per Category 

SELECT category,
SUM(weightInGms * availableQuantity) AS total_weight
FROM zepto
GROUP BY category
ORDER BY total_weight

--Q9.Find the top 10 products by potential revenue

SELECT TOP 10
    name,
    category,
    discountedSellingPrice,
    availableQuantity,
    (discountedSellingPrice * availableQuantity) AS potentialRevenue
FROM zepto
ORDER BY potentialRevenue DESC;

--Q10.Which categories have the highest number of out-of-stock products

SELECT category, COUNT(*) AS outOfStockCount
FROM zepto
WHERE outOfStock = '1'
GROUP BY category
ORDER BY outOfStockCount DESC