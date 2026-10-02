use shopsphere;
CREATE TABLE IF NOT EXISTS customers(
     customer_id varchar(10) primary key,
     customer_name varchar(100),
     gender varchar(20),
     age int,
     city varchar(50),
     state varchar(50),
     signup_date date
     );
CREATE TABLE IF NOT EXISTS products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    cost_price DECIMAL(10,2),
    selling_price DECIMAL(10,2)
);
CREATE TABLE IF NOT EXISTS orders (
    order_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10),
    order_date DATE,
    order_status VARCHAR(30),
    payment_method VARCHAR(30)
);
CREATE TABLE IF NOT EXISTS order_items (
    order_id VARCHAR(10),
    product_id VARCHAR(10),
    quantity INT,
    unit_price DECIMAL(10,2),
    revenue DECIMAL(10,2),
    cost_price DECIMAL(10,2),
    profit DECIMAL(10,2)
);

CREATE TABLE IF NOT EXISTS returns (
    return_id VARCHAR(10) PRIMARY KEY,
    order_id VARCHAR(10),
    product_id VARCHAR(10),
    return_date DATE,
    return_reason VARCHAR(100)
);
SET GLOBAL local_infile = 1 ;
SHOW VARIABLES LIKE 'local_infile';
LOAD DATA LOCAL INFILE 'C:/data analyst project/e commerce analy/data/Customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(customer_id, customer_name, gender, age, city, state, signup_date);