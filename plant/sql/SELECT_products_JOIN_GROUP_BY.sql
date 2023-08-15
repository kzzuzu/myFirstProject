/*Raw data*/
SELECT id, name, unit_price, products.stock, color_name, product_colors.stock AS color_stock,
	description, products.photo_url, launch_date, category, discount
    FROM products LEFT JOIN product_colors
		ON id=product_id;
        
/*如果sql_mode有ONLY_FULL_GROUP_BY, 以下指令會錯, 要把color_name改成group_concat(color_name ORDER BY ordinal)*/
SELECT id, name, unit_price, products.stock, color_name, SUM(product_colors.stock) AS color_stock,
	description, products.photo_url, launch_date, category, discount
    FROM products LEFT JOIN product_colors
		ON id=product_id
        GROUP BY id; 
        
/*如果sql_mode有ONLY_FULL_GROUP_BY, 以下指令會對, 已把color_name改成group_concat(color_name ORDER BY ordinal)*/
SELECT id, name, unit_price, products.stock, color_name,
	count(color_name) AS color_count, 
	group_concat(color_name ORDER BY ordinal) AS color_list, 
    SUM(product_colors.stock) AS color_stock, MIN(product_colors.stock) AS min_color_stock,
	description, products.photo_url, launch_date, category, discount
    FROM products LEFT JOIN product_colors ON id=product_id 
    GROUP BY id;     

/*如果sql_mode有ONLY_FULL_GROUP_BY, 以下指令會錯, columns list只能保留sum欄位*/    
/*查詢全部產品的總庫存，查詢結果只有一筆 */
SELECT id, name, unit_price, products.stock, product_colors.stock, 
	SUM(IFNULL(product_colors.stock, products.stock)) as real_stock,
	description, products.photo_url, launch_date, category, discount
    FROM products LEFT JOIN product_colors ON id=product_id;

/* E04-a:查詢全部產品的總庫存，查詢結果每個產品一筆 */
/* RAW Data */
SELECT id, name, product_colors.color_name,products.unit_price, 
    products.stock, 
	product_colors.stock AS color_stock,    
	description, products.photo_url, 
	launch_date, category, discount 
    FROM products LEFT JOIN product_colors
			ON id=product_id;
SELECT id, name, unit_price, products.stock AS p_stock, group_concat(product_colors.stock) AS color_stock,
	(IFNULL(SUM(product_colors.stock), products.stock)) AS stock,
	description, products.photo_url, launch_date, category, discount
    FROM products LEFT JOIN product_colors ON id=product_id    
    GROUP BY id ; 

/* E04-a:查詢全部產品 , 1.建立View*/
CREATE VIEW products_view AS
	SELECT id, name, unit_price, 
	(IFNULL(SUM(product_colors.stock), products.stock)) AS stock,
	description, products.photo_url, launch_date, category, discount
    FROM products LEFT JOIN product_colors ON id=product_id    
    GROUP BY id;
    
/* E04-a:查詢全部產品 , 2.程式碼都從View查詢*/    
SELECT id, name, unit_price, stock, description, photo_url, 
	launch_date, category, discount
FROM products_view;

show variables LIKE '%sql_mode';
SET sql_mode = (SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));
show variables LIKE '%sql_mode';

/* E04-a:查詢全部產品 */
SELECT id,name,color_name, group_concat(color_name ORDER BY ordinal) AS color_list, SUM(products.stock),SUM(product_colors.stock) AS color_stock    
    FROM products LEFT JOIN product_colors
		ON id=product_id GROUP BY id;
    /*sql_mode=only_full_group_by*/