CREATE INDEX idx_product_name ON products (name);
CREATE INDEX idx_customer_email ON customers (email);
CREATE INDEX idx_order_date ON orders (order_date);
CREATE INDEX idx_inventory_product_id ON inventory (product_id);
CREATE INDEX idx_order_item_order_id ON order_items (order_id);