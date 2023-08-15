show variables LIKE '%sql_mode';
SET sql_mode = (SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));
show variables LIKE '%sql_mode';

/* E04-a,b,c:查詢全部產品的總庫存，查詢結果每個產品一筆 */
/* RAW Data */
SELECT id, name, product_colors.color_name, size_name, 
	products.unit_price, product_color_sizes.unit_price AS size_list_price,
    products.stock, 
	product_colors.stock AS color_stock,
    product_color_sizes.stock AS size_stock,
	description, products.photo_url, 
	launch_date, category, discount 
    FROM products LEFT JOIN product_colors
			ON id=product_id
		LEFT JOIN product_color_sizes
			ON products.id = product_color_sizes.product_id
				AND (product_colors.color_name = product_color_sizes.color_name
					OR product_colors.color_name IS NULL );
                    
/* GROUP BY products.id, 分組統計 SUM(stock)*/
SELECT id, name, group_concat(product_colors.color_name) AS color_list,  group_concat(size_name) AS size_list, 
	products.unit_price, 
    MIN(product_color_sizes.unit_price) AS min_price,
    MAX(product_color_sizes.unit_price) AS max_price,
    products.stock, 
	SUM(product_colors.stock) AS color_total_stock,
    SUM(product_color_sizes.stock) AS size_total_stock,
    IFNULL(IFNULL(SUM(product_color_sizes.stock),SUM(product_colors.stock)),products.stock) AS stock ,
	description, products.photo_url, 
	launch_date, category, discount 
    FROM products LEFT JOIN product_colors
			ON id=product_id
		LEFT JOIN product_color_sizes
			ON products.id = product_color_sizes.product_id
				AND (product_colors.color_name = product_color_sizes.color_name
					OR product_colors.color_name IS NULL )
    GROUP BY id; 

/* E04-a:查詢全部產品 , 1.建立View*/
CREATE VIEW products_view AS
	SELECT id, name, 
    IFNULL(MIN(product_color_sizes.unit_price), products.unit_price) AS unit_price,    
    IFNULL(IFNULL(SUM(product_color_sizes.stock),SUM(product_colors.stock)),products.stock) AS stock ,
	description, products.photo_url, 
	launch_date, category, discount 
    FROM products LEFT JOIN product_colors
			ON id=product_id
		LEFT JOIN product_color_sizes
			ON products.id = product_color_sizes.product_id
				AND (product_colors.color_name = product_color_sizes.color_name
					OR product_colors.color_name IS NULL )
    GROUP BY id;
    
/* E04-a:查詢全部產品 , 2.程式碼都從View查詢*/    
SELECT id, name, unit_price, stock, description, photo_url, 
	launch_date, category, discount
FROM products_view;