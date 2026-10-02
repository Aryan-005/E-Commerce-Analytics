USE shopsphere;

TRUNCATE TABLE customers;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(customer_id, customer_name, gender, @age, city, state, @signup_date)
SET
    age = NULLIF(@age, ''),
    signup_date = CASE
        WHEN @signup_date = '' THEN NULL
        ELSE STR_TO_DATE(@signup_date, '%m/%d/%Y')
    END;

DELETE FROM customers
WHERE customer_id = '';

SELECT COUNT(*) AS total_customers
FROM customers;