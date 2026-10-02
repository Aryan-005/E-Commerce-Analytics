USE shopsphere;

TRUNCATE TABLE orders;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/orders.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(order_id, customer_id, @order_date, order_status, payment_method)
SET order_date = STR_TO_DATE(@order_date, '%m/%d/%Y');
select *
from orders;