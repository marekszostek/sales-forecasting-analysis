/*
Sales Forecasting Analysis
Dashboard Views for Business Reporting
*/

-- Monthly Revenue View

CREATE VIEW vw_monthly_revenue AS
SELECT
    extract(year from date) AS year,
	extract(month from date) AS month,
    SUM(sales) AS monthly_revenue
FROM sales
GROUP BY EXTRACT(YEAR FROM date),
   		 EXTRACT(MONTH FROM date);

-- Promotion Performance View

CREATE VIEW vw_promotion_performance AS
SELECT 
	CASE 
		WHEN onpromotion > 0 THEN 'Yes' 
		ELSE 'No' 
	END 
	AS promotion_status, 
	COUNT(*) AS record_count,
    ROUND(AVG(sales), 2) AS average_revenue
FROM sales 
GROUP BY CASE 
		WHEN onpromotion > 0 THEN 'Yes' 
		ELSE 'No' 
	END;

-- Product Family Performance View

CREATE VIEW vw_product_family_performance AS
WITH family_revenue AS (
    SELECT family, SUM(sales) AS revenue_per_family
    FROM sales
    GROUP BY family
),
total_revenue AS (
    SELECT SUM(sales) AS revenue
    FROM sales
)
SELECT family, revenue_per_family, ROUND((revenue_per_family/revenue)*100,2) AS revenue_share_prc
FROM family_revenue
CROSS JOIN total_revenue;

-- Store Performance View

CREATE VIEW vw_store_performance AS
WITH transac AS 
		(SELECT store_nbr, 	
			SUM(transactions) AS total_transactions 
		FROM transactions 
		GROUP BY store_nbr), 
	sales_revenue AS 
		(SELECT store_nbr, 
			SUM(sales) AS total_revenue 
		FROM sales GROUP BY store_nbr) 
SELECT 
	t.store_nbr, city, total_revenue, total_transactions, round(total_revenue/total_transactions, 2) AS revenue_per_transaction 
FROM transac t 
JOIN sales_revenue s 
	ON t.store_nbr = s.store_nbr 
JOIN stores st
	ON s.store_nbr = st.store_nbr