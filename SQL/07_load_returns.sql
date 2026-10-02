USE shopsphere;

TRUNCATE TABLE returns;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/returns.csv'
INTO TABLE returns
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(return_id, order_id, product_id, @return_date, return_reason)
SET return_date = CASE
    WHEN @return_date = '' THEN NULL
    ELSE STR_TO_DATE(@return_date, '%m/%d/%Y')
END;
