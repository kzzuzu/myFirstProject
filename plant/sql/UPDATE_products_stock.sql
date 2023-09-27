/*以下為錯誤作法 UPDATE products SET stock = [現在庫存] - [客戶購買數量] WHERE id=[產品編號]*/
UPDATE products SET stock = 6 - 2	WHERE id='5';    
UPDATE products SET stock = 6 - 3	WHERE id='5';    
UPDATE products SET stock = 6 - 2	WHERE id='5';    

/*以下為正確作法 UPDATE products SET stock = stock - [客戶購買數量] WHERE id=[產品編號] AND stock>=[客戶購買數量] */
UPDATE products SET stock = stock - 3	WHERE stock>=3 AND id='5';
UPDATE products SET stock = stock - 2	WHERE stock>=2 AND id='5';
UPDATE products SET stock = stock - 2	WHERE stock>=2 AND id='5';

UPDATE product_colors SET stock = stock-3	WHERE stock>=3 AND product_id='11' AND color_name='淺藍';
UPDATE product_color_sizes SET stock = stock-1 WHERE stock>=1 AND product_id='13' AND color_name='白' AND size_name='S';

