/*
Sales Forecasting Analysis
Data Quality Validation Checks
*/
-- Row Counts

SELECT COUNT(*) FROM sales;
SELECT COUNT(*) FROM transactions;
SELECT COUNT(*) FROM stores;
SELECT COUNT(*) FROM holidays_events;

-- Null Values Check

SELECT COUNT(*) FROM sales
WHERE sales IS NULL;

SELECT COUNT(*) FROM sales
WHERE store_nbr IS NULL;

SELECT COUNT(*) FROM sales
WHERE family IS NULL;

SELECT COUNT(*) FROM sales
WHERE date IS NULL;

SELECT COUNT(*) FROM stores
WHERE store_nbr IS NULL;

SELECT COUNT(*) FROM holidays_events
WHERE type IS NULL;

SELECT COUNT(*) FROM transactions
WHERE transactions IS NULL;

-- Duplicate Check

SELECT date, store_nbr, family, COUNT(*)
FROM sales
GROUP BY date, store_nbr, family
HAVING COUNT(*) > 1;

-- Date Range Check

SELECT MIN(date) AS min_date, MAX(date) AS max_date
FROM sales;

-- Entity validation

SELECT COUNT(DISTINCT store_nbr) AS unique_stores
FROM sales;

SELECT COUNT(DISTINCT family) AS unique_product_families
FROM sales;