--  Q1. Conditional Update with IF/CASE
-- Increase loyalty_points by:
-- 50 if total_amount > 5000
-- 20 if total_amount between 2000 and 5000
-- 10 otherwise
-- for all orders with status = 'Delivered'. */

UPDATE Customers c
SET loyalty_points = loyalty_points +
    CASE
        WHEN o.total_amount > 5000 THEN 50
        WHEN o.total_amount BETWEEN 2000 AND 5000 THEN 20
        ELSE 10
    END
FROM Orders o
WHERE c.customer_id = o.customer_id
  AND o.status = 'Delivered';


-- Q2. Update Stock Quantity After Order Shipment
-- When an order is shipped (status = 'Pending'), reduce Products.stock_quantity based on Order_Details.quantity.

update Products p
set stock_quantity = stock_quantity - o.order_details.quantity
from order_details o where p.product_id = o.product_id 
and o.order_id in (select order_id from Orders where status = 'Pending');

-- Mark Orders as 'Shipped' If Stock Is Available
-- If all products in an order have stock_quantity >= quantity, change status to 'Shipped'.

update Orders o 
set status = 'Shipped'
from Products p join order_details od on p.product_id = od.product_id
where  o.order_id = od.order_id
and p.stock_quantity >= od.quantity;

-- Add a New Column and Set Values Based on Condition
-- Add a column customer_type in Customers:
-- 'Platinum' if loyalty_points >= 200
-- 'Gold' if loyalty_points >= 100 and < 200
-- 'Silver' otherwise.

alter table Customers add column customer_type varchar(20);

update Customers
set customer_type =
CASE
    when loyalty_points >= 200 then 'Platinum'
    when loyalty_points >= 100 then 'Gold'
    else 'Silver'
    END;

--  Give 10% Discount to Orders from 'Delhi' if Total Amount > 2000

update Orders o
set total_amount = total_amount * 0.9
from  Customers c where c.customer_id = o.customer_id
and c.city = 'Delhi' and o.total_amount > 2000;

--Increase Price of 'Electronics' Products if Stock < 20
-- Increase by:
-- 15% if stock < 10
-- 10% if stock between 10 and 19.

update Products
set price = 
case 
    when stock_quantity < 10 then price * 1.10
    when stock_quantity between 10 and then 19 price * 1.15
    end;


-- Categorize Orders by Amount
-- Add a column order_category to Orders:
-- 'High Value' if total_amount > 5000
-- 'Medium Value' if between 2000 and 5000
-- 'Low Value' otherwise

alter table Orders add column order_category varchar(20);

update Orders
set order_category = 
case
when total_amount > 5000 then 'High Value'
when total_amount between 2000 and 5000 then 'Medium Value'
else 'Low Value'
end;


--  Update Status Based on Payment
-- If order total is 0, set status = 'Cancelled';
-- If order total < 1000, set status = 'Low Payment';
-- Else 'Processed'.

update Orders
set status = 
case
    when total_amount = 0 then 'Cancelled'
    when total_amount < 1000 then 'Low Payment'
    else 'Processed'
    end;


-- Customer Loyalty Tier Update
-- Change customer_type in Customers table:
-- 'Diamond' if loyalty_points > 300
-- 'Platinum' if > 200 and ≤ 300
-- 'Gold' if > 100 and ≤ 200
-- 'Silver' otherwise.