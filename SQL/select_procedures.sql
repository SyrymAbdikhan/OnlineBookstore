
DELIMITER //

-- returns the title and author of all books that match genre
CREATE PROCEDURE GetBooksByGenreAndPublisher(
    IN genre_name VARCHAR(50),
    IN publisher_name VARCHAR(100)
)
BEGIN
    SELECT b.title, CONCAT(a.firstname, ' ', a.lastname) AS author_name
    FROM Books b
    JOIN Authors a ON b.author_id = a.author_id
    JOIN Publishers p ON b.publisher_id = p.publisher_id
    JOIN Genres g ON b.genre_id = g.genre_id
    WHERE g.name = genre_name AND p.name = publisher_name;
END //

-- returns all the orders placed by the customer, including the details of the books ordered
CREATE PROCEDURE GetOrdersByCustomerID(
    IN customer_id_param INT
)
BEGIN
    SELECT o.order_id, o.order_date, b.title, bf.format_type, oi.quantity
    FROM Orders o
    JOIN Customers c ON o.customer_id = c.customer_id
    JOIN OrderItems oi ON o.order_id = oi.order_id
    JOIN BookFormats bf ON oi.format_id = bf.format_id
    JOIN Books b ON bf.book_id = b.book_id
    WHERE o.customer_id = customer_id_param;
END //

-- returns average price of books in that specific format within that genre
CREATE PROCEDURE GetAveragePriceByFormatAndGenre(
    IN format_type_param ENUM('Hardcover', 'Paperback', 'Ebook'),
    IN genre_name VARCHAR(50)
)
BEGIN
    SELECT g.name AS genre, AVG(bf.price) AS average_price
    FROM BookFormats bf
    JOIN Books b ON bf.book_id = b.book_id
    JOIN Genres g ON b.genre_id = g.genre_id
    WHERE bf.format_type = format_type_param AND g.name = genre_name
    GROUP BY g.name;
END //

-- returns top n most popular books based on the number of times they appear in order items
CREATE PROCEDURE GetTopNPopularBooks(
    IN n INT
)
BEGIN
    SELECT b.title, COUNT(oi.order_item_id) AS order_count
    FROM OrderItems oi
    JOIN BookFormats bf ON oi.format_id = bf.format_id
    JOIN Books b ON bf.book_id = b.book_id
    GROUP BY b.book_id, b.title
    ORDER BY order_count DESC
    LIMIT n;
END //

DELIMITER ;
