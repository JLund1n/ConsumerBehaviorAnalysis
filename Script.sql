SELECT gender, sum(purchase_amount) as revenue
FROM mydb.customeranalysis
group by gender;

SELECT customer_id, purchase_amount
FROM mydb.customeranalysis
where discount_applied = 'Yes' and purchase_amount >= (select AVG(purchase_amount) from mydb.customeranalysis);

SELECT item_purchased, ROUND(AVG(review_rating),2) as 'Average Product Rating'
FROM mydb.customeranalysis
group by item_purchased
order by avg(review_rating) desc LIMIT 5;

select shipping_type, ROUND(AVG(purchase_amount),2)
FROM mydb.customeranalysis
where shipping_type in ('Standard', 'Express')
group by shipping_type;

SELECT subscription_status, COUNT(customer_id) as total_customers, ROUND(AVG(purchase_amount),2) as average, ROUND(SUM(purchase_amount),2) as total
FROM mydb.customeranalysis
group by subscription_status
order by total, average desc;

SELECT item_purchased, ROUND(SUM(CASE WHEN discount_applied = 'Yes' THEN 1 ELSE 0 END)/COUNT(*)*100,2) as discount_rate 
FROM mydb.customeranalysis
group by item_purchased
order by discount_rate desc
limit 5;

with customer_type AS(
SELECT customer_id, previous_purchases,
CASE
	WHEN previous_purchases = 1 then 'New'
	WHEN previous_purchases BETWEEN 2 and 10 then 'Returning'
	ELSE 'Loyal'
	END AS customer_segment
from mydb.customeranalysis
)
SELECT customer_segment, count(*) as "Number of Customers"
from customer_type 
group by customer_segment;