SELECT id, name, unit_price, discount, products.stock, 
		product_id, color_name, product_colors.stock AS color_stock, 
        /*SUM(product_colors.stock), AVG(product_colors.stock), COUNT(id),*/
		products.photo_url, description, lunch_date, category,        
        product_colors.photo_url AS color_photo, icon_url
    FROM products LEFT JOIN product_colors 
		ON products.id=product_colors.product_id;
        
/* E04: 查詢產品清單: products_view */
SELECT id, name, unit_price, discount, 		
        IFNULL(SUM(product_color_sizes.stock),IFNULL(SUM(product_colors.stock),products.stock)) AS stock, 
		products.photo_url, description, lunch_date, category, 
        GROUP_CONCAT(product_colors.color_name) as color_list
    FROM products 
		LEFT JOIN product_colors ON products.id=product_colors.product_id
        LEFT JOIN product_color_sizes ON product_colors.product_id=product_color_sizes.product_id 
											AND product_colors.color_name=product_color_sizes.color_name
        GROUP BY id;

/*LEFT OUTER JOIN, E05:檢視產品明細*/
SELECT id, name, unit_price, discount, products.stock, 
		product_colors.product_id, product_colors.color_name, 
        product_colors.stock AS color_stock,         
		products.photo_url, description, lunch_date, category,        
        product_colors.photo_url AS color_photo, icon_url
    FROM products 
		LEFT JOIN product_colors ON products.id=product_colors.product_id		
        WHERE products.id=13;   
        
/*LEFT OUTER JOIN, E05:檢視產品明細(包含color,size的raw data)
  1~7,10 無顏色無size, 11:有6顏色無size, 12:有3顏色無size, 13:有2顏色有size(白: 4 sizes, 黑: 2 sizes), 14: 無顏色有2 size
*/
SELECT id, name, unit_price, discount, products.stock, 
		product_colors.product_id, product_colors.color_name, 
        product_color_sizes.product_id, product_color_sizes.color_name, size_name, 
        list_price, product_color_sizes.stock, size_ordinal,        
		products.photo_url, description, lunch_date, category,        
        product_colors.photo_url AS color_photo, icon_url
    FROM products 
		LEFT JOIN product_colors ON products.id=product_colors.product_id
		LEFT JOIN product_color_sizes ON 
				(product_colors.product_id=product_color_sizes.product_id AND product_colors.color_name=product_color_sizes.color_name)
             OR (products.id=product_color_sizes.product_id AND product_colors.color_name IS null)
        WHERE products.id=14;         

/*LEFT OUTER JOIN, E05:檢視產品明細(color+sizeCount)*/
SELECT id, name, unit_price, discount, 
		IFNULL(SUM(product_color_sizes.stock),products.stock) AS stock, 
		product_colors.product_id, product_colors.color_name, 
        IFNULL(SUM(product_color_sizes.stock),product_colors.stock) AS color_stock, 
        COUNT(product_color_sizes.size_name) AS size_counter,
		products.photo_url, description, lunch_date, category,        
        product_colors.photo_url AS color_photo, icon_url
    FROM products 
		LEFT JOIN product_colors ON products.id=product_colors.product_id
		LEFT JOIN product_color_sizes ON 
        (product_colors.product_id=product_color_sizes.product_id AND product_colors.color_name=product_color_sizes.color_name)
				OR (products.id=product_color_sizes.product_id AND product_colors.color_name IS null)
        WHERE products.id=14
         GROUP BY id, product_colors.color_name;