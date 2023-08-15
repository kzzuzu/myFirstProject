<%@page import="plants.entity.Color"%>
<%@page import="plants.entity.Outlet"%>
<%@page import="plants.entity.Product"%>
<%@page import="plants.service.ProductService"%>
<%@ page pageEncoding="UTF-8"%>
	<!-- product_data.jsp start -->
		<style>
			.productData{width:80%;margin:auto;clear:both}
			#productImg{float:left;width:40%;max-width:360px;margin:30px}
			.productInfo{float:left;width:45%;}
			.productDescription{clear:both;padding-top: 1ex;white-space: pre-line;}
			.productIcon{width:32px;vertical-align: middle;margin: 1ex}
			
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
		
		<%
			String productId=request.getParameter("productId");
			ProductService service = new ProductService();
			Product p = null;
			if(productId!=null && productId.length()>0){
				p = service.getProductById(productId);	
			}			
		%>
				
		<script>
			$(document).ready(init);
			
			function init(){
				<% if(p!=null && p.getColorCount()==0 && p.hasSize()){%>
				getSizeOption($("input[name='productId']").val(), '');
				<%}%>
			}
			
			function changeColorData(theColorIcon, hasSize){
				console.log($("input[name='productId']").val(), theColorIcon.title);				
				productImg.src = theColorIcon.dataset.photo;
				stockSpan.innerHTML = "(" + theColorIcon.title + " " + theColorIcon.dataset.stock + "個)";
				quantity.max=theColorIcon.dataset.stock;
				if(hasSize){					
					getSizeOption($("input[name='productId']").val(), theColorIcon.title);
				}		
			}
			
			function getSizeOption(productId, colorName){
				//alert("ajax查size: " + productId + "," + colorName); //for test
				$.ajax({
					url: 'get_size_option.jsp?productId=' + productId + "&colorName=" + colorName,
					method: 'GET'
				}).done(getSizeOptionDoneHandler);				
			}
			
			function getSizeOptionDoneHandler(result, textStatus, jqXhr){
				//alert(result); //for test
				console.log(result); //for test
				
				$("#size").empty();
				$("#size").append(result);
			}			
		
			function changeSizeSelect(theSize){
				var selectedSize = theSize.selectedOptions[0];			
				console.log(selectedSize.value, selectedSize.dataset.listprice, selectedSize.dataset.price, selectedSize.dataset.stock);
				if(selectedSize.value.length>0){
					var listPrice = document.getElementById("listPrice");
					if(listPrice) listPrice.innerHTML=selectedSize.dataset.listprice;
					unitPrice.innerHTML=selectedSize.dataset.price;
					sizeStockSpan.innerHTML = selectedSize.value + ":" + selectedSize.dataset.stock+"個";
					
					quantity.max=selectedSize.dataset.stock;
					$(theSize.options[0]).prop('disabled', true);
				}
			}	
			
			function addCart(e){						
				//e.preventDefault(); //無效
				
				//送出同步的submit
				//return true;				
				
				//用ajax送出非同步的POST請求
				$.ajax({
					url: $("#addCartForm").attr("action")+"?ajax=",
					method: "POST",
					data: $("#addCartForm").serialize()
				}).done(addCartDoneHandler);
				
				return false;
			}
			
			function addCartDoneHandler(result, txtStatus, xhr){
				//console.log(result); //for test
				//alert("加入購物車成功: 目前有" + result.totalQty + "個");
				toastMessage("加入購物車成功! 目前有" + result.totalQty + "個");
				$(".cartTotalQty").text(result.totalQty);
			}
			
		</script>

		<%if(p==null) {%>
				<p>查無此產品(<%= productId %>)</p>
			<%}else{ %>			
			<div class='productData'>
				<img id='productImg' src='<%= p.getPhotoUrl() %>'>
				<div class='productInfo' style='padding-top:30px'>
					<h2><%= p.getName() %></h2>		
					<% if(p instanceof Outlet) {%>			
					<div>定價：<span id='listPrice'><%= ((Outlet)p).getListPrice()  %></span>元</div>
					<% } %>	
									
					<div>優惠價：<%= p instanceof Outlet?((Outlet)p).getDiscountString():"" %> 
						<span id='unitPrice'><%= p.getUnitPrice() %></span>元</div>
					<div>庫存：<%= p.getStock() %> <span id='stockSpan'></span><span id='sizeStockSpan'></span></div>
					<form id="addCartForm" method='POST' action='./add_cart.do' onsubmit='return addCart();'>	<!-- http://localhost:8080/vgb/add_cart.do -->				
						<input type='hidden' name='productId' value='<%= productId %>' required><!-- 加入購物車要指定的產品代號 -->
						<% if(p.getColorCount()>0) {%>
						<!-- 顏色 -->
						<div>
							<label>顏色: </label>
							<% for(int i=0;i<p.getColorsList().size();i++){								
								Color color = p.getColorsList().get(i);
							%>
							<label>
								<input type='radio' name='color' required value='<%= color.getName() %>'>
								<img onclick='changeColorData(this, <%=p.hasSize() %>)' class='productIcon' title='<%= color.getName() %>'
									src='<%= color.getIconUrl()==null?color.getPhotoUrl():color.getIconUrl() %>'
									data-photo='<%= color.getPhotoUrl() %>'
									data-stock='<%= color.getStock() %>'>
							</label>
							<% } %>
						</div>
						<%} %>						
						<!-- size -->
						<% if(p.hasSize()) { %>
						<div>
							<label>Size</label>
							<select id='size' name='size' required onchange="changeSizeSelect(this)">
								<option value='' >請先選擇顏色</option>
							</select>
						</div>
						<%} %>
						<div>
							<label>數量: </label>
							<input type='number' id='quantity' name='quantity' max='<%= p.getStock() %>' min='1' required>					
						</div>
						<input type='submit' value="加入購物車" style="margin-top: 10px">						
					</form>
				</div>
				<div class='productDescription'>
				<%= p.getDescription() %>
				</div>
			</div>
			<% } %>
			<%@include file="/subviews/snackbar.jsp" %>
			<!-- product_data.jsp end -->
			