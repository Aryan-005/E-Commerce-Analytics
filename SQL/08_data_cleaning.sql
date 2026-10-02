select *
from customers 
where customer_id is null
or customer_name is null
or age is null
or state is null
or signup_date is null
;
select *
from customers 
where age < 18 or age > 100
;
select *
from products 
where cost_price < 0 or selling_price < 0 
;
select *
from order_items
where quantity <= 0 
;
select *
from orders
where customer_id is null 
or order_date is null
or order_status is null
