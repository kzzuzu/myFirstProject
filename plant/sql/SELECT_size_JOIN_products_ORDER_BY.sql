SELECT product_id, color_name, size_name, product_color_sizes.stock, 
	product_color_sizes.unit_price AS list_price, 
    (product_color_sizes.unit_price * (100-discount) / 100) as price, 
    ordinal 
	FROM product_color_sizes
		JOIN products ON product_color_sizes.product_id = products.id
    WHERE product_id='13' AND color_name='白'
    ORDER BY ordinal;