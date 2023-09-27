ALTER TABLE product_colors
	ADD CONSTRAINT fkey_product_colors_TO_products
FOREIGN KEY (product_id) REFERENCES products(id);