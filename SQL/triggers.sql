
DELIMITER //

-- Order Items table

-- updating stock after a new order item is inserted
CREATE TRIGGER order_item_insert
BEFORE INSERT ON OrderItems
FOR EACH ROW
BEGIN
    UPDATE BookFormats
    SET stock_quantity = stock_quantity - NEW.quantity
    WHERE format_id = NEW.format_id;
END //

-- updating stock vefore updating an OrderItem if quantity changes
CREATE TRIGGER order_item_before_update
BEFORE UPDATE ON OrderItems
FOR EACH ROW
BEGIN
    -- If the quantity is changing
    IF NEW.quantity <> OLD.quantity THEN
        UPDATE BookFormats
        SET stock_quantity = stock_quantity + OLD.quantity - NEW.quantity
        WHERE format_id = NEW.format_id;
    END IF;
END //

-- updating stock after an order item is deleted
CREATE TRIGGER order_item_delete
BEFORE DELETE ON OrderItems
FOR EACH ROW
BEGIN
    UPDATE BookFormats
    SET stock_quantity = stock_quantity + OLD.quantity
    WHERE format_id = OLD.format_id;
END //

-- updating total_amount of an order before an item is inserted
CREATE TRIGGER order_item_insert_update_total
AFTER INSERT ON OrderItems
FOR EACH ROW
BEGIN
    UPDATE Orders
    SET total_amount = (
		SELECT SUM(oi.quantity * oi.price_per_unit)
        FROM OrderItems oi
        WHERE oi.order_id = NEW.order_id
	)
    WHERE order_id = NEW.order_id;
END //

-- updating total_amount after updating an OrderItem
CREATE TRIGGER order_item_after_update_update_total
AFTER UPDATE ON OrderItems
FOR EACH ROW
BEGIN
    UPDATE Orders
    SET total_amount = (
        SELECT SUM(oi.quantity * oi.price_per_unit)
        FROM OrderItems oi
        WHERE oi.order_id = NEW.order_id
    )
    WHERE order_id = NEW.order_id;
END //

-- updating the total amount of an order before an item is deleted
CREATE TRIGGER order_item_delete_update_total
AFTER DELETE ON OrderItems
FOR EACH ROW
BEGIN
    UPDATE Orders
    SET total_amount = (
		SELECT SUM(oi.quantity * oi.price_per_unit)
        FROM OrderItems oi
        WHERE oi.order_id = OLD.order_id
	)
    WHERE order_id = OLD.order_id;
END //


-- Orders table

-- checking on insert if discount is valid or not
CREATE TRIGGER before_insert_update_order_discount
BEFORE INSERT ON Orders
FOR EACH ROW
BEGIN
	DECLARE discount_active INT DEFAULT 0;

    IF NEW.discount_id IS NOT NULL THEN
		-- checking if discount code exists and active
        SELECT 1 INTO discount_active
        FROM Discounts
        WHERE discount_id = NEW.discount_id
          AND start_date <= CURDATE()
          AND end_date >= CURDATE();

        IF discount_active = 0 THEN
            -- discount id is invalid or expired, setting it to NULL
            SET NEW.discount_id = NULL;
        END IF;
    END IF;
END //

-- checking on update if discount is valid or not
CREATE TRIGGER before_update_order_discount
BEFORE UPDATE ON Orders
FOR EACH ROW
BEGIN
	DECLARE discount_active INT DEFAULT 0;

	-- checking if discount_id is not null AND new discount_id differ from old discount_id
    IF NEW.discount_id IS NOT NULL AND NEW.discount_id <> OLD.discount_id THEN
		-- checking if discount code exists and active
        SELECT 1 INTO discount_active
        FROM Discounts
        WHERE discount_id = NEW.discount_id
          AND start_date <= CURDATE()
          AND end_date >= CURDATE();

        IF discount_active = 0 THEN
            -- discount id is invalid or expired, setting it to NULL
            SET NEW.discount_id = NULL;
        END IF;
    END IF;
END //

DELIMITER ;
