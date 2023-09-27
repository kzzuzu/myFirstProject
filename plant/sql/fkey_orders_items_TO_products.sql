/*
ALTER TABLE order_items 
	DROP CONSTRAINT fkey_orders_items_TO_products;
*/

ALTER TABLE order_items
	ADD CONSTRAINT fkey_order_items_TO_products
    FOREIGN KEY (product_id) REFERENCES products(id);