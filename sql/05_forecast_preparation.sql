/*
Sales Forecasting Analysis
Forecast Preparation Queries
*/

-- Monthly Revenue Dataset
SELECT
    TO_CHAR(date, 'YYYY-MM') AS year_month,
    ROUND(SUM(sales), 2) AS revenue
FROM sales
GROUP BY TO_CHAR(date, 'YYYY-MM')
ORDER BY TO_CHAR(date, 'YYYY-MM') ASC;

-- Monthly Revenue by Store Dataset
SELECT
    TO_CHAR(date, 'YYYY-MM') AS year_month,
	store_nbr, 
    ROUND(SUM(sales), 2) AS revenue
FROM sales
GROUP BY TO_CHAR(date, 'YYYY-MM'), store_nbr
ORDER BY TO_CHAR(date, 'YYYY-MM') ASC;

-- Monthly Revenue by Product Family Dataset
SELECT
    TO_CHAR(date, 'YYYY-MM') AS year_month,
	family, 
    ROUND(SUM(sales), 2) AS revenue
FROM sales
GROUP BY TO_CHAR(date, 'YYYY-MM'), family
ORDER BY TO_CHAR(date, 'YYYY-MM') ASC;