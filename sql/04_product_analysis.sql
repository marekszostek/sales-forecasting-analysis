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

--- Revenue Share by Product Family

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
from family_revenue
CROSS JOIN total_revenue
ORDER BY revenue_share_prc DESC