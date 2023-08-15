ALTER TABLE order_items
ADD CONSTRAINT FKEY_order_items_TO_products
FOREIGN KEY (product_id) REFERENCES products(id);