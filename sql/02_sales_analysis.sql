/*
Sales Forecasting Analysis
Business Analysis Queries

Author: Marek Szostek
Dataset: Corporación Favorita Grocery Sales Forecasting
*/

-- Revenue Analysis
---Total Revenue

SELECT
    SUM(sales) AS total_revenue
FROM sales;

---Revenue by Year

SELECT
    EXTRACT(YEAR FROM date) AS year,
    ROUND(SUM(sales), 2) AS revenue
FROM sales
GROUP BY year
ORDER BY year ASC;

---Revenue by Month

SELECT
    TO_CHAR(date, 'YYYY-MM') AS year_month,
    ROUND(SUM(sales), 2) AS revenue
FROM sales
GROUP BY TO_CHAR(date, 'YYYY-MM')
ORDER BY TO_CHAR(date, 'YYYY-MM') ASC;

---Promotion Effectiveness

SELECT 
	CASE 
		WHEN onpromotion > 0 THEN 'Yes' 
		ELSE 'No' 
	END 
	AS promotion, 
    AVG(sales) AS average_revenue
FROM sales 
GROUP BY promotion;

--Seasonality Analysis
---Revenue by Month(all years combined)

SELECT 
    TO_CHAR(date, 'FMMonth') AS month, 
    SUM(sales) AS revenue 
FROM sales 
GROUP BY month 
ORDER BY revenue DESC;

---Revenue by Month and Year

SELECT 
    TO_CHAR(date, 'YYYY') AS year, 
    TO_CHAR(date, 'MM') AS month, 
    SUM(sales) AS revenue 
FROM sales 
GROUP BY year, month 
ORDER BY year, month;