CREATE VIEW vw_monthly_revenue AS
SELECT
    extract(year from date) AS year,
	extract(month from date) AS month,
    SUM(sales) AS monthly_revenue
FROM sales
GROUP BY EXTRACT(YEAR FROM date),
   		 EXTRACT(MONTH FROM date)
ORDER BY year, month ASC

