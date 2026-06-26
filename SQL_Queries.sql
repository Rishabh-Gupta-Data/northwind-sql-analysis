--1. Top 5 Customers by Orders

SELECT c.customer_id,
       c.contact_name,
       COUNT(o2.order_id) AS order_count
FROM customers c
JOIN orders2 o2
ON c.customer_id = o2.customer_id
GROUP BY c.customer_id, c.contact_name
ORDER BY order_count DESC
LIMIT 5;


--2. Top 5 Customers by Revenue

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


--3.  Categories with Average Price Greater Than 40

SELECT c.category_id,
       AVG(p.unit_price) AS average_price
FROM categories c
JOIN products p
ON c.category_id = p.category_id
GROUP BY c.category_id
HAVING AVG(p.unit_price) > 40;


--4.  Find best-selling products.
SELECT p.product_id, p.product_name, SUM(od.quantity) AS Total_quantity_sold 
FROM products p
JOIN order_details od
ON p.product_id = od.product_id 
GROUP BY p.product_id, p.product_name
ORDER BY Total_quantity_sold DESC;
LIMIT 1;


--5.  Find repeat customers.
SELECT c.customer_id, c.contact_name, COUNT(o2.order_id) AS total_order
FROM customers c
JOIN orders2 o2
ON c.customer_id = o2.customer_id 
GROUP BY c.customer_id, c.contact_name
HAVING COUNT(o2.order_id) >1
ORDER BY total_order DESC;


--6.  Show monthly order counts.
SELECT EXTRACT(MONTH FROM order_date) AS MONTH,
		COUNT(order_id) AS order_count
FROM orders2
GROUP BY  EXTRACT(MONTH FROM order_date)
ORDER BY MONTH ASC;

--7.  Find sales by ship country.
SELECT o2.ship_country, SUM(od.unit_price * od.quantity * (1-od.discount)) AS total_sales 
FROM orders2 o2
JOIN order_details od
ON o2.order_id = od.order_id
GROUP BY o2.ship_country
ORDER BY total_sales DESC;

--8.  Find top 10 revenue-generating customers.
SELECT c.customer_id, c.contact_name, SUM(od.unit_price * od.quantity * (1-od.discount)) AS Total_revenue 
FROM customers c
JOIN orders2 o2
ON c.customer_id = o2.customer_id
JOIN order_details od
ON O2.order_id = od.order_id 
GROUP BY c.customer_id, c.contact_name
ORDER BY Total_revenue DESC
LIMIT 10;

--9.  Find customers who never placed an order.
SELECT c.contact_name AS customers_name, 
        o2.order_id AS order_details
FROM customers c
INNER JOIN Orders2 o2
ON c.customer_id = o2.customer_id
WHERE o2.order_id IS NULL;

--10. Best-performing employees
SELECT e4.employee_id, e4.first_name || ' ' || e4.last_name AS Employees_name, 
		COUNT(o2.order_id) AS Total_order
FROM employees4 e4
JOIN orders2 o2
ON e4.employee_id = o2.employee_id
GROUP BY e4.employee_id, 
		e4.first_name,
		e4.last_name
ORDER BY Total_order DESC;










