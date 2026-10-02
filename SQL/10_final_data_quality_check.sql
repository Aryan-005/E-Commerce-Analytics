USE shopsphere;


#---1. Customer count and duplicate check

SELECT
    COUNT(*) AS total_customers,
    COUNT(DISTINCT customer_id) AS unique_customer_ids
FROM customers;


#---2. Order count and duplicate check

SELECT
    COUNT(*) AS total_orders,
    COUNT(DISTINCT order_id) AS unique_order_ids
FROM orders;


#---3. Product count and duplicate check

SELECT
    COUNT(*) AS total_products,
    COUNT(DISTINCT product_id) AS unique_product_ids
FROM products;


#---4. Check orders without customers

SELECT
    o.order_id,
    o.customer_id
FROM orders o
LEFT JOIN customers c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;


#---5. Check orders without Order_Items

SELECT
    o.order_id
FROM orders o
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE oi.order_id IS NULL;


#---6. Check Order_Items without valid orders

SELECT
    oi.order_id
FROM order_items oi
LEFT JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;


#---7. Check Order_Items with invalid products

SELECT
    oi.order_id,
    oi.product_id
FROM order_items oi
LEFT JOIN products p
    ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;


#---8. Check returns with invalid orders

SELECT
    r.return_id,
    r.order_id
FROM returns r
LEFT JOIN orders o
    ON r.order_id = o.order_id
WHERE o.order_id IS NULL;


#---9. Check returns with invalid products

SELECT
    r.return_id,
    r.product_id
FROM returns r
LEFT JOIN products p
    ON r.product_id = p.product_id
WHERE p.product_id IS NULL;


#---10. Check duplicate order IDs

SELECT
    order_id,
    COUNT(*) AS duplicate_count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;


#---11. Check duplicate customer IDs

SELECT
    customer_id,
    COUNT(*) AS duplicate_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;


#---12. Check duplicate product IDs

SELECT
    product_id,
    COUNT(*) AS duplicate_count
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;


#---13. Check invalid quantities

SELECT *
FROM order_items
WHERE quantity <= 0;


#---14. Check invalid prices

SELECT *
FROM order_items
WHERE unit_price <= 0
   OR cost_price < 0
   OR revenue < 0;


#---15. Check revenue calculations

SELECT *
FROM order_items
WHERE revenue <> quantity * unit_price;


#---16. Check profit calculations

SELECT *
FROM order_items
WHERE profit <> revenue - (quantity * cost_price);


#---17. Check missing order dates

SELECT *
FROM orders
WHERE order_date IS NULL;


#---18. Check missing customer dates

SELECT *
FROM customers
WHERE signup_date IS NULL;


#---19. Check missing return dates

SELECT *
FROM returns
WHERE return_date IS NULL;


#---20. Check invalid customer ages

SELECT *
FROM customers
WHERE age < 18
   OR age > 100;


#---21. Check invalid order statuses

SELECT DISTINCT order_status
FROM orders;


#---22. Check invalid payment methods

SELECT DISTINCT payment_method
FROM orders;


#---23. Check invalid genders

SELECT DISTINCT gender
FROM customers;


#---24. Final row counts

SELECT 'Customers' AS table_name, COUNT(*) AS row_count
FROM customers

UNION ALL

SELECT 'Products', COUNT(*)
FROM products

UNION ALL

SELECT 'Orders', COUNT(*)
FROM orders

UNION ALL

SELECT 'Order_Items', COUNT(*)
FROM order_items

UNION ALL

SELECT 'Returns', COUNT(*)
FROM returns;