/* E05 檢視產品明細 */
/*CROSS JOIN*/
SELECT id, name, unit_price, products.stock, description, 
	products.photo_url, launch_date, category, discount,
    product_id, color_name
FROM products JOIN product_colors 
WHERE id='1';

/*INNER JOIN*/
SELECT id, name, unit_price, products.stock, description, 
	products.photo_url, launch_date, category, discount,
    product_id, color_name, product_colors.stock AS color_stock,
    product_colors.photo_url AS color_photo,
    icon_url, ordinal
FROM products INNER JOIN product_colors
	ON id=product_id 
    WHERE id = "1"
    ORDER BY ordinal;
    
/* ***LEFT OUTER JOIN FOR E05檢視產品明細 *** */
SELECT id, name, products.unit_price, products.stock, description, 
	products.photo_url, launch_date, category, discount,
    product_colors.product_id, color_name, 
    product_colors.stock AS color_stock,
    product_colors.photo_url AS color_photo,
    icon_url, ordinal
FROM products 
	LEFT JOIN product_colors ON id=product_id     
    WHERE id = "13"
    ORDER BY id, ordinal;    
    
/* RIGHT OUTER JOIN FOR E05*/
SELECT id, name, unit_price, products.stock, description, 
	products.photo_url, launch_date, category, discount,
    product_id, color_name, product_colors.stock AS color_stock,
    product_colors.photo_url AS color_photo,
    icon_url, ordinal
FROM products RIGHT JOIN product_colors
	ON id=product_id 
    /*WHERE id = "11"*/
    ORDER BY id, ordinal;      
    
/* FULL OUTER JOIN(MySQL不支援) FOR E05*/
SELECT id, name, unit_price, products.stock, description, 
	products.photo_url, launch_date, category, discount,
    product_id, color_name, product_colors.stock AS color_stock,
    product_colors.photo_url AS color_photo,
    icon_url, ordinal
FROM products FULL JOIN product_colors
	ON id=product_id 
    ORDER BY id, ordinal;    
    
/* E05 Final Version*/
SELECT id, name, products.unit_price, 
	IFNULL(SUM(product_color_sizes.stock), products.stock)AS stock, 
    description, 
	products.photo_url, launch_date, category, discount,
    product_colors.product_id,  product_colors.color_name, 
    IFNULL(SUM(product_color_sizes.stock),product_colors.stock) AS color_stock,
    COUNT(product_color_sizes.size_name) AS size_count,    
    SUM(product_color_sizes.stock) AS size_total_stock,
    product_colors.photo_url AS color_photo,
    icon_url,  product_colors.ordinal
FROM products 
	LEFT JOIN product_colors ON id=product_id 
    LEFT JOIN product_color_sizes
			ON products.id = product_color_sizes.product_id
				AND (product_colors.color_name = product_color_sizes.color_name
					OR product_colors.color_name IS NULL )    
    WHERE id = "13"
    GROUP BY color_name
    ORDER BY id,  product_colors.ordinal;       