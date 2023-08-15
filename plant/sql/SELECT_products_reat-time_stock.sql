SELECT stock FROM products WHERE id=1;
    
SELECT stock FROM product_colors
	WHERE product_id=11 AND color_name='淺藍';
    
SELECT stock FROM product_color_sizes
	WHERE product_id=13 AND color_name='白' AND size_name='M';