USE shopsphere;

CREATE TABLE IF NOT EXISTS customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(100),
    gender VARCHAR(20),
    age INT,
    city VARCHAR(50),
    state VARCHAR(50),
    signup_date DATE
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