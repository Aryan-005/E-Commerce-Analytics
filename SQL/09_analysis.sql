use shopsphere;
select sum(revenue) as total_revenue
from order_items
;
select sum(profit) as total_profit
from order_items
;
select count(*) as total_orders
from orders
;
select count(*) as total_customer
from customers
;
SELECT 
    SUM(revenue) / COUNT(DISTINCT order_id) AS average_order_value
FROM order_items
;
select 
product_id,sum(revenue) as total_revenue 
from order_items
group by product_id
order by total_revenue desc
;
select p.category,
       sum(oi.revenue) as total_revenue
from order_items as oi
join products as p 
     on oi.product_id = p.product_id
group by category
order by total_revenue desc
;
select p.category,
	   sum(oi.profit) as total_profit
from products as p
join order_items as oi
	 on p.product_id = oi.product_id
group by category
order by total_profit desc
;
select c.customer_id,
c.customer_name,
sum(oi.revenue) as total_revenue
from customers as c
join orders as o 
	  on c.customer_id = o.customer_id
join order_items as oi 
     on o.order_id = oi.order_id
group by c.customer_id,c.customer_name
order by total_revenue desc
;

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_orders DESC
;
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(DISTINCT o.order_id) > 1
ORDER BY total_orders DESC
;
SELECT
    o.payment_method,
    SUM(oi.revenue) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.payment_method
ORDER BY total_revenue DESC
;
SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC
;
SELECT
    YEAR(o.order_date) AS year,
    MONTH(o.order_date) AS month,
    SUM(oi.revenue) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY YEAR(o.order_date), MONTH(o.order_date)
ORDER BY year, month
;
#----Advanced Customer Analysis
#------Advanced Customer Analysis
SELECT
    c.customer_id,
    c.customer_name,
    SUM(oi.revenue) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(oi.revenue) > (
    SELECT AVG(customer_revenue)
    FROM (
        SELECT
            o.customer_id,
            SUM(oi.revenue) AS customer_revenue
        FROM orders o
        JOIN order_items oi
            ON o.order_id = oi.order_id
        GROUP BY o.customer_id
    ) AS customer_sales
)
ORDER BY total_revenue DESC
;
#---Top 5 Products by Revenue
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.revenue) AS total_revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue DESC
LIMIT 5
;
#---Products with the highest profit
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.profit) AS total_profit
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_profit DESC
;
#---Products with low profit margin
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.revenue) AS total_revenue,
    SUM(oi.profit) AS total_profit,
    ROUND(SUM(oi.profit) / SUM(oi.revenue) * 100, 2) AS profit_margin
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
HAVING profit_margin < 20
ORDER BY profit_margin
;
#---Total returns
select count(*) as total_returns
from returns
;
#---Total returns
SELECT
    return_reason,
    COUNT(*) AS total_returns
FROM returns
GROUP BY return_reason
ORDER BY total_returns DESC
;
#---Products with the most returns
SELECT
    p.product_id,
    p.product_name,
    COUNT(r.return_id) AS total_returns
FROM returns r
JOIN products p
    ON r.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_returns DESC
;
#----Return rate by product
SELECT
    p.product_id,
    p.product_name,
    COUNT(DISTINCT r.return_id) AS total_returns,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    ROUND(
        COUNT(DISTINCT r.return_id) /
        COUNT(DISTINCT oi.order_id) * 100,
        2
    ) AS return_rate
FROM products p
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
LEFT JOIN returns r
    ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name
ORDER BY return_rate DESC
;
#---Revenue and profit by order status
SELECT
    o.order_status,
    SUM(oi.revenue) AS total_revenue,
    SUM(oi.profit) AS total_profit
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.order_status
ORDER BY total_revenue DESC
;
#---Revenue and profit by order status
SELECT
    o.order_status,
    SUM(oi.revenue) AS total_revenue,
    SUM(oi.profit) AS total_profit
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.order_status
ORDER BY total_revenue DESC
;
#---Customer Revenue
WITH customer_sales AS (
    SELECT
        o.customer_id,
        SUM(oi.revenue) AS total_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY o.customer_id
)
select * 
 from customer_sales
 order by total_revenue desc
 ;
 #---Customer order sequence
 SELECT
    o.customer_id,
    o.order_id,
    o.order_date,
    ROW_NUMBER() OVER (
        PARTITION BY o.customer_id
        ORDER BY o.order_date
    ) AS order_number
FROM orders o
;
#---Rank products by revenue
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.revenue) AS total_revenue,
    RANK() OVER (
        ORDER BY SUM(oi.revenue) DESC
    ) AS revenue_rank
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
;
#---Rank products by profit
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.profit) AS total_profit,
    RANK() OVER (
        ORDER BY SUM(oi.profit) DESC
    ) AS profit_rank
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
;
#---Customer revenue + overall average
WITH customer_sales AS (
    SELECT
        o.customer_id,
        SUM(oi.revenue) AS total_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY o.customer_id
)

SELECT
    customer_id,
    total_revenue,
    ROUND(AVG(total_revenue) OVER (), 2) AS average_customer_revenue
FROM customer_sales
ORDER BY total_revenue DESC
;
#---Customer revenue rank
WITH customer_sales AS (
    SELECT
        o.customer_id,
        SUM(oi.revenue) AS total_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY o.customer_id
)

SELECT
    customer_id,
    total_revenue,
    RANK() OVER (
        ORDER BY total_revenue DESC
    ) AS customer_rank
FROM customer_sales
;
#---Running monthly revenue
WITH monthly_sales AS (
    SELECT
        YEAR(o.order_date) AS year,
        MONTH(o.order_date) AS month,
        SUM(oi.revenue) AS monthly_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY YEAR(o.order_date), MONTH(o.order_date)
)

SELECT
    year,
    month,
    monthly_revenue,
    SUM(monthly_revenue) OVER (
        ORDER BY year, month
    ) AS cumulative_revenue
FROM monthly_sales
ORDER BY year, month
;
#---Top 3 products by category
WITH product_sales AS (
    SELECT
        p.category,
        p.product_id,
        p.product_name,
        SUM(oi.revenue) AS total_revenue
    FROM products p
    JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY
        p.category,
        p.product_id,
        p.product_name
),

ranked_products AS (
    SELECT
        category,
        product_id,
        product_name,
        total_revenue,
        RANK() OVER (
            PARTITION BY category
            ORDER BY total_revenue DESC
        ) AS product_rank
    FROM product_sales
)

SELECT *
FROM ranked_products
WHERE product_rank <= 3
ORDER BY category, product_rank
;
