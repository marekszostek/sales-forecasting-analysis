/*
Sales Forecasting Analysis
Store Performance Analysis
*/
---Revenue by Store

SELECT 
    store_nbr, 
    SUM(sales) AS revenue 
FROM sales 
GROUP BY store_nbr 
ORDER BY SUM(sales) DESC 
LIMIT 10;

---Transactions by Store

SELECT 
    store_nbr, 
    SUM(transactions) AS total_transactions 
FROM transactions 
GROUP BY store_nbr 
ORDER BY SUM(transactions) DESC;

---Revenue per Transaction by Store

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
	t.store_nbr, total_transactions, total_revenue, round(total_revenue/total_transactions, 2) AS revenue_per_transaction 
FROM transac t 
JOIN sales_revenue s 
	ON t.store_nbr = s.store_nbr 
ORDER BY revenue_per_transaction DESC 
LIMIT 10;