
SELECT transaction_date,---Column on original data set
       DAYNAME(transaction_date) AS Day_Name,-----This transaction on transaction_date extracts Day of the week eg Sunday Monday
       MONTHNAME(transaction_date) AS Month_Name,--------This transaction_date extracts the Day of the month eg Jan Feb
       COUNT(transaction_id) AS Number_of_sales,---- Counting Number pf sales
       SUM(transaction_qty) AS Units_sold,------ Number of product units sold
       COUNT(DISTINCT product_id ) AS Unique_Product_sold,-----Checking the  unique DISTINCT variety of products sold
       COUNT(store_id) AS Number_of_stores, ---Checking the number of  stores available
       SUM(transaction_qty*unit_price) AS Revenue,---Aggregating price and quantity in order to know revenue NEW column
       MAX(unit_price) AS Maximum_Price,---used to check the minimum Price on product dataset
       MIN(unit_price) AS Minimum_Price,---- used to check maxium price on product dataset 
       product_category,
       product_type,
       store_location,
       product_detail,
---Case statement creates buckets in order for us to build logic for presentations and enhance analyses
CASE 
      WHEN Day_name IN ('Sat','Sun') THEN 'Weekend'
      WHEN Day_name IN ('Mon','Tues','Wed','Thurs','Fri') THEN 'Weekdays'
END AS Day_classification,

CASE 
      WHEN unit_price BETWEEN '0'AND'5' THEN 'Low Price'
      WHEN unit_price BETWEEN '6'AND'9' THEN 'Medium Price'
      WHEN unit_price BETWEEN '10'AND'19'THEN 'High Price'
END AS Price_classification,

CASE
     WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN '01.Morning'
     WHEN transaction_time BETWEEN '12:00:00' AND '17:59:59' THEN '02.Afternoon'
     WHEN transaction_time BETWEEN '18:00:00' AND '21:59:59' THEN '03.Evening'
END AS Time_Classification
FROM `brightlearn`.`default`.`bright_coffee_shop_analysis_case_study_1`
GROUP BY transaction_date,
         product_category,
         product_type,
         store_location,
         product_detail,
         Month_Name,
         unit_price,
         transaction_time;
