
CREATE INDEX idx_customer_email ON Customers (email);
CREATE INDEX idx_orders_customer_id ON Orders (customer_id);
CREATE UNIQUE INDEX idx_bookformats_isbn ON BookFormats (isbn);
