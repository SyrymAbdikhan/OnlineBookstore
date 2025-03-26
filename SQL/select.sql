
-- Books table

-- select all 
SELECT * FROM Books;

-- select books published before the year 1970
SELECT title, publication_year
FROM Books
WHERE publication_year < 1970;

-- select authors of the books:
SELECT b.title, CONCAT(a.firstname, ' ', a.lastname) AS author_name
FROM Books b
JOIN Authors a ON b.author_id = a.author_id;

-- select genres of the books:
SELECT b.title, g.name AS genre_name
FROM Books b
JOIN Genres g ON b.genre_id = g.genre_id;


-- BookFormats table

-- select all
SELECT * FROM BookFormats;

-- select format type and price of the book 'The Hobbit'
SELECT bf.format_type, bf.price
FROM BookFormats bf
JOIN Books b ON bf.book_id = b.book_id
WHERE b.title = 'The Hobbit';

-- select the format type and stock quantity of all ebook formats
SELECT b.title, bf.format_type, bf.stock_quantity
FROM BookFormats bf
JOIN Books b ON bf.book_id = b.book_id
WHERE format_type = 'Ebook';

-- select book with each available format
SELECT b.title, bf.format_type, bf.price
FROM Books b
JOIN BookFormats bf ON b.book_id = bf.book_id
ORDER BY b.title, bf.format_type;


-- Customers table

-- select all
SELECT * FROM Customers;

-- select customers whose first name starts with 'A' or 'D'
SELECT firstname, lastname
FROM Customers
WHERE firstname LIKE 'A%' OR firstname LIKE 'D%';

-- select customers who have placed more than or equal to 2 orders
SELECT c.firstname, c.lastname, c.email, COUNT(o.order_id) AS number_of_orders
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.firstname, c.lastname, c.email
HAVING COUNT(o.order_id) >= 2
ORDER BY number_of_orders DESC;

-- select customers who have placed orders in march 2025
SELECT c.customer_id,
	  CONCAT(c.firstname, ' ', c.lastname) AS customer_name,
      c.email
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_date >= '2025-03-01' AND o.order_date < '2025-04-01'
GROUP BY c.customer_id, c.firstname, c.lastname, c.email;


-- Orders table:

-- select customers who placed the order
SELECT c.customer_id,
       CONCAT(c.firstname, ' ', c.lastname) AS customer_name,
       COUNT(c.customer_id) AS number_of_orders
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY number_of_orders DESC;

-- select orders that used a discount
SELECT order_id, total_amount, d.discount_code
FROM Orders o
JOIN Discounts d ON o.discount_id = d.discount_id
WHERE o.discount_id IS NOT NULL;

-- count the number of orders placed by each customer
SELECT CONCAT(c.firstname, ' ', c.lastname) AS customer_name,
       COUNT(o.order_id) AS number_of_orders
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY number_of_orders DESC;


-- OrderItems table

-- select all items of the order
SELECT *
FROM OrderItems oi
WHERE oi.order_id = 1;

-- calculate total value of each order
SELECT oi.order_id, SUM(oi.quantity * oi.price_per_unit) AS order_value
FROM OrderItems oi
GROUP BY oi.order_id;

-- select order items with the price at the time of order
SELECT oi.order_id, b.title, bf.format_type, oi.quantity, oi.price_per_unit
FROM OrderItems oi
JOIN BookFormats bf ON oi.format_id = bf.format_id
JOIN Books b ON bf.book_id = b.book_id;

-- select ordered books with total quantity of each format
SELECT b.title, bf.format_type, SUM(oi.quantity) AS total_quantity_ordered
FROM OrderItems oi
JOIN BookFormats bf ON oi.format_id = bf.format_id
JOIN Books b ON bf.book_id = b.book_id
GROUP BY b.book_id, b.title, bf.format_type
ORDER BY b.title, total_quantity_ordered DESC;

-- find the most frequently ordered book
SELECT b.title, COUNT(oi.order_item_id) AS order_count
FROM OrderItems oi
JOIN BookFormats bf ON oi.format_id = bf.format_id
JOIN Books b ON bf.book_id = b.book_id
GROUP BY b.book_id, b.title
ORDER BY order_count DESC
LIMIT 1;
