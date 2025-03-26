
SELECT * FROM BookFormats WHERE format_id in (2, 5);

CALL SetBookStock(2, 60);
CALL SetBookStock(5, 25);
CALL SetBookStock(999, 10);
CALL SetBookStock(2, -5);

CALL AddBookStock(2, 60);
CALL AddBookStock(5, 25);
CALL AddBookStock(999, 10);
CALL AddBookStock(2, -5);


SELECT * FROM Orders WHERE order_id in (3, 7, 4);

CALL SetDiscountToOrder(3, 'BOOKLOVER');
CALL SetDiscountToOrder(7, 'NEWCUSTOMER');
CALL SetDiscountToOrder(4, 'INVALIDCODE');
CALL SetDiscountToOrder(999, 'SUMMER20');


SELECT * FROM Customers WHERE customer_id in (1, 3);

CALL SetCustomerAddress(1, '123 Updated Main St');
CALL SetCustomerAddress(3, '456 New Oak Ave');
CALL SetCustomerAddress(999, 'Some Address');


SELECT * FROM OrderItems WHERE order_item_id = 1;

SELECT * FROM Orders o
WHERE o.order_id = (SELECT oi.order_id
					FROM OrderItems oi
					WHERE order_item_id = 1);

SELECT * FROM BookFormats bf
WHERE bf.format_id = (SELECT oi.format_id
					  FROM OrderItems oi
					  WHERE order_item_id = 1);

CALL SetOrderItemQuantity(1, 10);
CALL SetOrderItemQuantity(5, 10);
CALL SetOrderItemQuantity(999, 3);
CALL SetOrderItemQuantity(1, -1);
CALL SetOrderItemQuantity(1, 1000);
