SELECT  product_id, color_name, size_name, list_price
	, discount, (list_price*(100.0-discount)/100.0) as unit_price
    , product_color_sizes.stock, size_ordinal
	FROM product_color_sizes JOIN products
		ON product_color_sizes.product_id = products.id
    WHERE product_id='13' AND color_name='白'
    ORDER BY product_id,color_name,size_ordinal;
    
/*E05: 檢視產品明細 取得size資料 */
SELECT  product_id, color_name, size_name, list_price
	, discount, (list_price*(100.0-discount)/100.0) AS unit_price
    , product_color_sizes.stock, size_ordinal
	FROM product_color_sizes JOIN products
		ON product_color_sizes.product_id = products.id    
    ORDER BY product_id,color_name,size_ordinal;    
    
/*E05: 檢視產品明細 用view取得size資料 */
SELECT product_id, color_name, size_name, list_price, discount, unit_price, stock, size_ordinal 
	FROM product_color_sizes_view 
    WHERE product_id=? AND color_name=?;
