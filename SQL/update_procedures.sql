
DELIMITER //

CREATE PROCEDURE SetBookStock(
    IN format_id_param INT,
    IN new_stock_quantity INT
)
BEGIN
    START TRANSACTION;

	-- checking if new stock quantity is not negative
    IF new_stock_quantity >= 0 THEN
		-- update the stock quantity
		UPDATE BookFormats
		SET stock_quantity = new_stock_quantity
		WHERE format_id = format_id_param;

		-- checking if any row was affected
		IF ROW_COUNT() > 0 THEN
			COMMIT;
			SELECT CONCAT('Stock updated successfully for Format ID: ', format_id_param) AS Message;
		ELSE
			ROLLBACK;
			SELECT CONCAT('Error: Format ID ', format_id_param, ' not found.') AS Message;
		END IF;
	ELSE
        ROLLBACK;
        SELECT 'Error: New stock quantity cannot be less than zero.' AS Message;
    END IF;
END //


CREATE PROCEDURE AddBookStock(
    IN format_id_param INT,
    IN add_stock_quantity INT
)
BEGIN
    START TRANSACTION;

	-- checking if adding quantity is not negative
    IF add_stock_quantity >= 0 THEN
		-- update the stock quantity
		UPDATE BookFormats
		SET stock_quantity = stock_quantity + add_stock_quantity
		WHERE format_id = format_id_param;

		-- checking if any row was affected
		IF ROW_COUNT() > 0 THEN
			COMMIT;
			SELECT CONCAT('Stock updated successfully for Format ID: ', format_id_param) AS Message;
		ELSE
			ROLLBACK;
			SELECT CONCAT('Error: Format ID ', format_id_param, ' not found.') AS Message;
		END IF;
	ELSE
        ROLLBACK;
        SELECT 'Error: Adding stock quantity cannot be less than zero.' AS Message;
    END IF;
END //

-- same as trigger: before_update_order_discount
CREATE PROCEDURE SetDiscountToOrder(
    IN order_id_param INT,
    IN discount_code_param VARCHAR(20)
)
BEGIN
    DECLARE discount_id_val INT;

    START TRANSACTION;

    -- finding the discount id based on the code
    SELECT discount_id INTO discount_id_val
    FROM Discounts
    WHERE discount_code = discount_code_param
      AND start_date <= CURDATE()
      AND end_date >= CURDATE();

    -- checking if discount code is valid
    IF discount_id_val IS NOT NULL THEN
        -- applying discount to the order
        UPDATE Orders
        SET discount_id = discount_id_val
        WHERE order_id = order_id_param;

        -- checking if any row was affected
        IF ROW_COUNT() > 0 THEN
            COMMIT;
            SELECT CONCAT('Discount applied successfully to Order ID: ', order_id_param) AS Message;
        ELSE
            ROLLBACK;
            SELECT CONCAT('Error: Order ID ', order_id_param, ' not found.') AS Message;
        END IF;
    ELSE
        ROLLBACK;
        SELECT CONCAT('Error: Invalid or expired discount code: ', discount_code_param) AS Message;
    END IF;

END //


CREATE PROCEDURE SetCustomerAddress(
    IN customer_id_param INT,
    IN new_address VARCHAR(255)
)
BEGIN
    START TRANSACTION;

    -- updating the customer's address
    UPDATE Customers
    SET address = new_address
    WHERE customer_id = customer_id_param;

    -- checking if any row was affected
    IF ROW_COUNT() > 0 THEN
        COMMIT;
        SELECT CONCAT('Address updated successfully for Customer ID: ', customer_id_param) AS Message;
    ELSE
        ROLLBACK;
        SELECT CONCAT('Error: Customer ID ', customer_id_param, ' not found.') AS Message;
    END IF;

END //


CREATE PROCEDURE SetOrderItemQuantity(
    IN order_item_id_param INT,
    IN new_quantity INT
)
BEGIN
	DECLARE order_id_val INT;
    DECLARE format_id_val INT;
    DECLARE old_quantity INT;
    DECLARE current_stock INT;
    DECLARE new_stock INT;

    START TRANSACTION;

    -- checling if new quantity is not negative
    IF new_quantity > 0 THEN
        -- getting oder item info before updating
        SELECT order_id, format_id, quantity INTO order_id_val, format_id_val, old_quantity
        FROM OrderItems
        WHERE order_item_id = order_item_id_param;

        -- checking if order item exists
        IF order_id_val IS NOT NULL THEN
            -- getting the current stock quantity of the book format
            SELECT stock_quantity INTO current_stock
            FROM BookFormats
            WHERE format_id = format_id_val;

            -- calculating the new stock quantity
            SET new_stock = current_stock + old_quantity - new_quantity;

            -- checking if new stock quantity is not negative
            IF new_stock >= 0 THEN
                -- updating the quantity of the order item
                UPDATE OrderItems
                SET quantity = new_quantity
                WHERE order_item_id = order_item_id_param;

                COMMIT;
                SELECT CONCAT('Quantity updated successfully for Order Item ID: ', order_item_id_param, ' to ', new_quantity) AS Message;
            ELSE
                ROLLBACK;
                SELECT 'Error: Out of stock.' AS Message;
            END IF;
        ELSE
            ROLLBACK;
            SELECT CONCAT('Error: Order Item ID ', order_item_id_param, ' not found.') AS Message;
        END IF;
    ELSE
        ROLLBACK;
        SELECT 'Error: quantity cannot be less than one.' AS Message;
    END IF;
END //

DELIMITER ;
