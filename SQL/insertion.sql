
DELETE FROM OrderItems;
DELETE FROM Orders;
DELETE FROM BookFormats;
DELETE FROM Books;
DELETE FROM Customers;
DELETE FROM Discounts;
DELETE FROM Authors;
DELETE FROM Publishers;
DELETE FROM Genres;


INSERT INTO Authors (firstname, lastname) VALUES
('J.R.R.', 'Tolkien'),
('George R.R.', 'Martin'),
('Jane', 'Austen'),
('Agatha', 'Christie'),
('Stephen', 'King'),
('Neil', 'Gaiman'),
('Terry', 'Pratchett'),
('Margaret', 'Atwood'),
('Gabriel Garcia', 'Marquez'),
('Haruki', 'Murakami'),
('Chimamanda Ngozi', 'Adichie');

INSERT INTO Publishers (name) VALUES
('Houghton Mifflin Harcourt'),
('Bantam Books'),
('Penguin Classics'),
('HarperCollins'),
('Scribner'),
('Bloomsbury'),
('Vintage'),
('Alfred A. Knopf'),
('Riverhead Books'),
('Faber & Faber'),
('Picador');

INSERT INTO Genres (name) VALUES
('Fantasy'),
('Science Fiction'),
('Romance'),
('Mystery'),
('Thriller'),
('Historical Fiction'),
('Contemporary'),
('Literary Fiction'),
('Young Adult'),
('Horror'),
('Science'),
('History');

INSERT INTO Books (title, isbn, author_id, publisher_id, publication_year, genre_id) VALUES
('The Hobbit', '978-0345339683', 1, 1, 1937, 1),
('The Fellowship of the Ring', '978-0618260274', 1, 1, 1954, 1),
('Alice in Borderland', '978-0618260281', 1, 1, 1954, 1),
('The Return of the King', '978-0618260298', 1, 1, 1955, 1),
('A Clash of Kings', '978-0553806957', 2, 2, 1999, 5),
('A Storm of Swords', '978-0553809903', 2, 2, 2000, 5),
('A Game of Thrones', '978-0553801471', 2, 2, 1996, 5),
('Pride and Prejudice', '978-0141439518', 3, 3, 1813, 3),
('Emma', '978-0141439519', 3, 3, 1815, 3),
('And Then There Were None', '978-0062073484', 4, 4, 1939, 4),
('The Shining', '978-0307743657', 5, 5, 1977, 10),
('Neverwhere', '978-0380789013', 6, 6, 1996, 1);

INSERT INTO BookFormats (book_id, format_type, price, stock_quantity, isbn13) VALUES
(1, 'Hardcover', 25.99, 20, '978-0547928227'),
(1, 'Paperback', 12.50, 50, '978-0345339683'),
(1, 'Ebook', 9.99, 100, '978-0307957279'),
(2, 'Hardcover', 30.00, 15, '978-0553801471'),
(2, 'Paperback', 15.75, 35, '978-0553809903'),
(2, 'Ebook', 12.99, 80, '978-0307956869'),
(3, 'Hardcover', 22.00, 40, '978-0141439532'),
(3, 'Paperback', 10.99, 60, '978-0141439518'),
(3, 'Ebook', 7.99, 120, '978-0141184995'),
(4, 'Hardcover', 28.00, 18, '978-0547928234'),
(4, 'Paperback', 14.00, 45, '978-0345339706'),
(4, 'Ebook', 11.00, 90, '978-0307957286'),
(5, 'Hardcover', 32.00, 12, '978-0547928241'),
(5, 'Paperback', 16.50, 30, '978-0345339713'),
(5, 'Ebook', 13.50, 70, '978-0307957293'),
(6, 'Hardcover', 35.00, 25, '978-0553809910'),
(6, 'Paperback', 11.50, 55, '978-0141439525'),
(6, 'Ebook', 8.50, 110, '978-0141185008'),
(7, 'Hardcover', 26.50, 22, '978-0618260274'),
(7, 'Paperback', 13.00, 58, '978-0345339690'),
(7, 'Ebook', 10.50, 105, '978-0307957262'),
(8, 'Hardcover', 29.50, 16, '978-0618260281'),
(8, 'Paperback', 15.00, 40, '978-0345339720'),
(8, 'Ebook', 12.00, 85, '978-0307957309'),
(9, 'Hardcover', 31.00, 14, '978-0618260298'),
(9, 'Paperback', 16.00, 38, '978-0345339737'),
(9, 'Ebook', 13.00, 75, '978-0307957316'),
(10, 'Hardcover', 27.00, 30, '978-0062073484'),
(10, 'Paperback', 14.50, 70, '978-0062073491'),
(11, 'Hardcover', 33.00, 28, '978-0307743657'),
(11, 'Paperback', 17.00, 60, '978-0307743664'),
(12, 'Hardcover', 24.00, 35, '978-0380789013'),
(12, 'Paperback', 11.00, 80, '978-0380789020');

INSERT INTO Customers (firstname, lastname, email, address) VALUES
('Charlie', 'Brown', 'charlie.brown@email.com', '789 Elm St'),
('Diana', 'Miller', 'diana.miller@email.com', '101 Pine Ave'),
('Ethan', 'Davis', 'ethan.davis@email.com', '222 Oak Ln'),
('Alice', 'Smith', 'alice.smith@email.com', '456 Oak Ave'),
('Bob', 'Johnson', 'bob.johnson@email.com', '123 Main St'),
('Carol', 'Williams', 'carol.williams@email.com', '789 Pine Ln'),
('David', 'Jones', 'david.jones@email.com', '101 Elm Ave'),
('Eve', 'Garcia', 'eve.garcia@email.com', '222 Oak St'),
('Frank', 'Martinez', 'frank.martinez@email.com', '345 Pine St'),
('Grace', 'Lopez', 'grace.lopez@email.com', '567 Elm Ln'),
('Henry', 'Gonzalez', 'henry.gonzalez@email.com', '890 Oak Ave');

INSERT INTO Discounts (discount_code, discount_percentage, start_date, end_date) VALUES
('SUMMER20', 20.00, '2025-06-01', '2025-08-31'),
('NEWCUSTOMER', 10.00, '2025-03-01', '2025-12-31'),
('FALL15', 15.00, '2025-09-01', '2025-11-30'),
('WEEKEND10', 10.00, '2025-03-28', '2025-03-30'),
('SPRING25', 25.00, '2025-04-01', '2025-05-31'),
('BOOKLOVER', 5.00, '2025-01-01', '2025-12-31'),
('MYSTERYFAN', 12.00, '2025-07-15', '2025-08-15'),
('SCIFIREADER', 18.00, '2025-10-01', '2025-10-31'),
('ROMANCE20', 20.00, '2025-02-01', '2025-02-28'),
('HOLIDAY30', 30.00, '2025-12-20', '2025-12-26');

INSERT INTO Orders (customer_id, discount_id) VALUES
(1, 1),
(2, 2),
(3, NULL),
(3, 2),
(2, 1),
(1, NULL),
(2, NULL),
(4, 3),
(5, 4),
(6, 5),
(7, 6),
(8, 7),
(9, 8),
(10, 9),
(11, 10);

INSERT INTO OrderItems (order_id, format_id, quantity, price_per_unit) VALUES
(1, 2, 1, 12.50),
(1, 5, 1, 15.75),
(2, 4, 1, 28.00),
(3, 16, 1, 13.00),
(3, 13, 2, 11.50),
(4, 10, 1, 14.00),
(4, 19, 1, 16.00),
(5, 1, 1, 25.99),
(5, 7, 1, 10.99),
(6, 9, 1, 26.50),
(6, 11, 1, 16.50),
(6, 3, 2, 9.99),
(7, 6, 1, 12.99),
(8, 25, 2, 14.50),
(9, 1, 1, 25.99),
(9, 2, 1, 12.50),
(10, 14, 1, 16.50),
(11, 17, 1, 13.00),
(12, 20, 1, 15.00),
(13, 23, 1, 16.00),
(14, 28, 1, 17.00),
(15, 31, 1, 11.00),
(15, 32, 1, 8.00);

-- updating the TotalAmount in Orders manually, but it will be automated with triggers
UPDATE Orders o SET total_amount = (
	SELECT SUM(OrderItems.quantity * OrderItems.price_per_unit)
    FROM OrderItems
    WHERE order_id = o.order_id
);

-- verifying data is updated
SELECT * FROM Orders;
SELECT * FROM OrderItems;
