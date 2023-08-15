<%@page import="plants.entity.Color"%>
<%@page import="plants.entity.Outlet"%>
<%@page import="plants.service.ProductService"%>
<%@page import="plants.entity.Product"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">		
		<title>產品明細</title>
		<link rel="stylesheet" href="css/vgb.css">
		<style>
			.productData{width:85%;margin:auto}
			#productImg{width:360px}
			.productDescription{clear:both;padding-top: 1ex}
			.productIcon{width:32px;vertical-align: middle;margin: 1ex}
			#photoList{margin: auto}
			#photoList img{display: inline-block;}
			
			/* 顏色選項(radeo+img)的樣式*/ 
			/*HIDE RADIO */
			[type=radio] { 
			  position: absolute;
			  opacity: 0;
			  width: 1px;
			  height: 1px;
			}			
			/* IMAGE STYLES */
			[type=radio] + img {
			  cursor: pointer;
			}			
			/* CHECKED STYLES */
			[type=radio]:checked + img {
			  outline: 2px solid #f00;
			}
		</style>
		<script>
			
			function changeColorData(theColorIcon){
				//alert(theColorIcon.dataset.stock);				
				productImg.src = theColorIcon.dataset.photo;
				stockSpan.innerHTML = "(" + theColorIcon.title + " " + theColorIcon.dataset.stock + "個)";
				quantity.max=theColorIcon.dataset.stock;
			}
		
			function changeColorDataSelect(theColorIcon){
				//alert(theColorIcon.selectedOptions[0].dataset.stock);
			}
		
		</script>
	</head>
	<body>
		<jsp:include page="/subviews/header.jsp" >
			<jsp:param value="產品明細" name="subtitle"/>
		</jsp:include>
		<%@ include file="/subviews/nav.jsp" %>	
		<%
			String productId=request.getParameter("productId");
			ProductService service = new ProductService();
			Product p = null;
			if(productId!=null && productId.length()>0){
				p = service.getProductById(productId);	
			}
			
		%>
		<article>
			<%if(p==null) {%>
				<p>查無此產品(<%= productId %>)</p>
			<%}else{ %>			
			<div class='productData'>
				<div style='float:left;'>
				<img id='productImg' src='<%= p.getPhotoUrl() %>'>
				<div id='photoList'>
					<img src='images/book_icon.png'>
					<img src='images/book_icon.png'>
					<img src='images/book_icon.png'>
					<img src='images/book_icon.png'>					
				</div>
				</div>
				<div class='productInfo' style='float: left'>
					<h2><%= p.getName() %></h2>		
					<% if(p instanceof Outlet) {%>			
					<div>定價：<%= ((Outlet)p).getListPrice()  %>元</div>
					<% } %>	
									
					<div>優惠價：<%= p instanceof Outlet?((Outlet)p).getDiscountString():"" %> 
						<%= p.getUnitPrice() %>元</div>
					<div>庫存：<%= p.getStock() %> <span id='stockSpan'></span></div>
					<form method='POST' action='member/cart.jsp'>					
						<input type='hidden' name='productId' value='<%= productId %>' required><!-- 加入購物車要指定的產品代號 -->
						<% if(p.getColorCount()>0) {%>
						<!-- 顏色 -->
						<div>
							<label>顏色: </label>
							<% for(int i=0;i<p.getColorsList().size();i++){								
								Color color = p.getColorsList().get(i);
							%>
							<label>
								<input type='radio' name='color' reqiured value='<%= color.getName() %>'>
								<img onclick='changeColorData(this)' class='productIcon' title='<%= color.getName() %>'
									src='<%= color.getIconUrl()==null?color.getPhotoUrl():color.getIconUrl() %>'
									data-photo='<%= color.getPhotoUrl() %>'
									data-stock='<%= color.getStock() %>'>
							</label>
							<% } %>
						</div>
						<%} %>						
						<!-- size -->
<!-- 						<div> -->
<!-- 							<label>Size</label> -->
<!-- 							<select id='size' name='size' onchange="changeColorDataSelect(this)"> -->
<!-- 								<option value='' >請選擇...</option> -->
<!-- 								<option value='S' data-stock='10' data-price='8'>S</option> -->
<!-- 								<option value='M' data-stock='20' data-price='12'>M</option> -->
<!-- 								<option value='L' data-stock='2' data-price='49'>XL</option> -->
<!-- 							</select> -->
<!-- 						</div> -->
								
						<div>
							<label>數量: </label>
							<input type='number' id='quantity' name='quantity' max='<%= p.getStock() %>' min='1' required>					
						</div>
						<input type='submit' value="加入購物車">						
					</form>
				</div>
				<div class='productDescription'>
					<hr>					
					<%= p.getDescription() %>
				</div>
			</div>
			<% } %>
		</article>
		<%@ include file="/subviews/footer.jsp" %>
	</body>
</html>
