/* E04-a:查詢全部產品 */
SELECT id, name, unit_price, stock, description, 
	photo_url, launch_date, category, discount
    FROM products;
    
/* E04-b:用關鍵字查詢 */
SELECT id, name, unit_price, stock, description, 
	photo_url, launch_date, category, discount
    FROM products 
    WHERE name LIKE '%色鉛筆%';    
    
/* E04-c:用分類查詢 */
SELECT id, name, unit_price, stock, description, 
	photo_url, launch_date, category, discount
    FROM products WHERE category='文具';
    
/* E04-d:新品上架 */
SELECT id, name, unit_price, stock, description, 
	photo_url, launch_date, category, discount    
    FROM products 
    /*WHERE launch_date <= curdate()*/
    ORDER BY launch_date DESC LIMIT 8;    
    
/* 產品分類清單 */    
SELECT distinct category FROM products;

SELECT category, count(category) AS category_counter FROM products
	GROUP BY category;
    
/* E05檢視產品明細 */
SELECT id, name, unit_price, stock, description, photo_url, 
	launch_date, category, discount
FROM products
WHERE id='1';