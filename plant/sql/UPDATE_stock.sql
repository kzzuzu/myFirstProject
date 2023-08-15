/* 1/x/x products.stock: 5, qty:2
   11/紅/x product_colors.stock: 2 qty:1
   11/綠/x product_colors.stock: 3 qty:1
   13/白/S product_color_sizes.stock: 10 qty:1
   14/x/24支 product_color_sizes.stock: 15 qty:2
*/

UPDATE products SET stock= 5-2
	WHERE id=1;
    
UPDATE product_colors SET stock= 2-1
	WHERE product_id=11 AND color_name='紅';    
    
UPDATE product_colors SET stock= 3-1
	WHERE product_id=11 AND color_name='綠'; 
    
UPDATE product_color_sizes SET stock= 10-1
	WHERE product_id=13 AND color_name='白' AND size_name='S';
    
UPDATE product_color_sizes SET stock= 15-2
	WHERE product_id=14 AND color_name='' AND size_name='24支';
    
    
UPDATE products SET stock= stock-1
	WHERE id=1 AND stock>=1;  
    
UPDATE products SET stock= stock-2
	WHERE id=1 AND stock>=2;
UPDATE products SET stock= stock-3
	WHERE stock>=3 AND id=1 ;
    
UPDATE product_colors SET stock= stock-10
	WHERE stock>=10 AND product_id=11 AND color_name='紅' ;    
    
UPDATE product_colors SET stock= stock-1
	WHERE stock>=1 AND product_id=11 AND color_name='綠'; 
    
UPDATE product_color_sizes SET stock= stock-1
	WHERE stock>=1 AND product_id=13 AND color_name='白' AND size_name='S';
    
UPDATE product_color_sizes SET stock= stock-2
	WHERE stock>=2 AND product_id=14 AND color_name='' AND size_name='24支'; 
    
/* E08 結帳庫存管理 */
/* 1/x/x products.stock: 5, qty:2*/
UPDATE products SET stock= stock-?
	WHERE stock>=? AND id=? ;   

/*   11/紅/x product_colors.stock: 2 qty:1*/
UPDATE product_colors SET stock= stock-?
	WHERE stock>=? AND product_id=? AND color_name=? ;   
   
/*   13/白/S product_color_sizes.stock: 10 qty:1*/
UPDATE product_color_sizes SET stock= stock-?
	WHERE stock>=? AND product_id=? AND color_name=? AND size_name=?;
   
/*   14/x/24支 product_color_sizes.stock: 15 qty:2*/
UPDATE product_color_sizes SET stock= stock-2
	WHERE stock>=2 AND product_id=14 AND color_name='' AND size_name='24支'; 