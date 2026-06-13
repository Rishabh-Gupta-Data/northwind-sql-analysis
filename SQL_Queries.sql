-- Top 5 Customers by Orders

SELECT c.customer_id,
       c.contact_name,
       COUNT(o2.order_id) AS order_count
FROM customers c
JOIN orders2 o2
ON c.customer_id = o2.customer_id
GROUP BY c.customer_id, c.contact_name
ORDER BY order_count DESC
LIMIT 5;


-- Top 5 Customers by Revenue

SELECT c.customer_id,
       c.contact_name,
       SUM(od.unit_price * od.quantity * (1 - od.discount)) AS total_revenue
FROM customers c
JOIN orders2 o2
ON c.customer_id = o2.customer_id
JOIN order_details od
ON od.order_id = o2.order_id
GROUP BY c.customer_id, c.contact_name
ORDER BY total_revenue DESC
LIMIT 5;


-- Categories with Average Price Greater Than 40

SELECT c.category_id,
       AVG(p.unit_price) AS average_price
FROM categories c
JOIN products p
ON c.category_id = p.category_id
GROUP BY c.category_id
HAVING AVG(p.unit_price) > 40;
