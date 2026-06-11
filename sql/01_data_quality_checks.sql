-- Row Counts

select count(*) from sales;
select count (*) from transactions;
select count (*) from stores;
select count (*) from holidays_events;

-- Null Values Check

select count(*) from sales
where sales is null;

select count(*) from sales
where store_nbr is null;

select count(*) from sales
where family is null;

select count(*) from sales
where date is null;

select count(*) from stores
where store_nbr is null;

select count(*) from holidays_events
where type is null;

select count(*) from transactions
where transactions is null;

-- Duplicate Check

select date, store_nbr, family, count(*)
from sales
group by date, store_nbr, family
having count(*) > 1;

-- Date Range Check

select min(date) as min_date, max(date) as max_date
from sales;

-- Entity validation

select count(distinct store_nbr) as unique_stores
from sales;

select count(distinct family) as unique_product_families
from sales;