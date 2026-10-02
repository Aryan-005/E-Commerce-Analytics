USE shopsphere;

Truncate Table products;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/products.csv'
INTO TABLE shopsphere.products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(product_id, product_name, category, sub_category, cost_price, selling_price);

SELECT *
FROM products;