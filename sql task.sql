CREATE DATABASE if not exists ecommerce_db;
USE ecommerce_db;


SELECT 
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_orders DESC;



SELECT 
    p.product_id,
    p.name,
    SUM(oi.quantity) AS total_quantity_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.name
ORDER BY total_quantity_sold DESC
LIMIT 5;



SELECT 
    p.product_id,
    p.name,
    SUM(oi.quantity * oi.price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.name
ORDER BY revenue DESC;



SELECT 
    o.order_id,
    c.name,
    c.address,
    o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE c.address LIKE '%Chennai%';



SELECT 
    payment_method,
    COUNT(*) AS total_payments,
    SUM(amount) AS total_amount
FROM payments
GROUP BY payment_method
ORDER BY total_amount DESC;


CREATE VIEW customer_order_summary AS
SELECT 
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders,
    SUM(p.amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.customer_id, c.name;


SELECT 
    name, 
    customer_id,
    total_spent
FROM customer_order_summary
WHERE total_spent > (
    SELECT AVG(total_spent) FROM customer_order_summary
);


CREATE INDEX idx_order_customer ON orders(customer_id);










































