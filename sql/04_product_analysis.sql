/*
Sales Forecasting Analysis
Product Performance Analysis
*/

--- Revenue by Product Family

SELECT
    family,
    SUM(sales) AS total_revenue
FROM sales
GROUP BY family
ORDER BY total_revenue DESC;