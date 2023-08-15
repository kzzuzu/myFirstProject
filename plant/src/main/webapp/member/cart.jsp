<%@page import="plants.service.ProductService"%>
<%@page import="plants.entity.Customer"%>
<%@page import="plants.entity.CartItem"%>
<%@page import="plants.entity.ShoppingCart"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">	
		<title>購物車</title>
		<link rel="stylesheet" href="<%= request.getContextPath() %>/css/vgb.css">
		<style>
				#cart {
				  font-family: Arial, Helvetica, sans-serif;
				  border-collapse: collapse;
				  width: 80%;
				  margin: auto;
				}
				
				#cart td, #cart th {
				  border: 1px solid #ddd;
				  padding: 8px;
				}
				
				#cart tr:nth-child(even){background-color: #f2f2f2;}
				
				#cart tr:hover {background-color: SandyBrown;}
				
				#cart tbody img{width:56px;vertical-align: middle;float:left}
				#cart tbody input.quantity{width:2.5em}
				
				#cart caption{
				  padding-top: 12px;
				  padding-bottom: 12px;				  
				  background-color: #04AA6D;
				  color: white;
				}
				
				#cart th{
				  padding-top: 12px;
				  padding-bottom: 12px;				  
				  background-color: darkgray;
				  color: white;
				}
				
				#cart tfoot td{text-align: right}
		</style>	
	</head>
	<body>
		<jsp:include page="/subviews/header.jsp" >
			<jsp:param value="Cart" name="subtitle"/>
		</jsp:include>
		<%@ include file="/subviews/nav.jsp" %>	
		<article>
			<% 
				ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
			    //Customer member = (Customer)session.getAttribute("member");
			     
				if(cart!=null && member!=null){
					cart.setMember(member);
				}
			%>
<%-- 			<%= cart %> --%>
		
			<% if(cart==null || cart.isEmpty() ){%>
				<h2>購物車是空的!</h2>
			<%}else{ %>
			<form action='update_cart.do' method='POST'><!-- http://localhost:8080/vgb/member/update_cart.do -->
			<table id='cart'>
				<caption>購物明細</caption>			
				<thead>
					<tr>
					<th>名稱</th>
					<th>顏色/Size</th>
					<th>價格</th>
					<th>數量</th>
					<th>小計</th>
					<th>刪除</th>
					</tr>
				</thead>
				<tbody>	
					<% ProductService pService = new ProductService();
						for(CartItem cartItem:cart.getCartItemSet()){
						int stock = pService.getStock(cartItem);
					%>
					<tr>				
						<td>
							<img src='<%= cartItem.getPhotoUrl() %>'>
							<%= cartItem.getProductName() %>
							<div style='font-size:smaller'>庫存:<%= stock %>個</div>
						</td>
						<td>
							<%= cartItem.getDisplayedColorSizeName()%>
						</td>
						<td>
							定價：<%= cart.getListPrice(cartItem) %>元<br>
							折扣：<%= cart.getDiscountString(cartItem) %><br>
							優惠價：<%= cart.getUnitPrice(cartItem) %>元
						</td>
						<td><input type='number' class='quantity' name='quantity<%= cartItem.hashCode() %>' required 
							min='1' max='<%= stock %>' value='<%= cart.getQuantity(cartItem) %>'>
						</td>
						<td><%= cart.getAmount(cartItem) %></td>
						<td><input type='checkbox' name='delete<%= cartItem.hashCode() %>'></td>
					</tr>
					<% }%>												
				</tbody>
				<tfoot>
					<tr>
						<td colspan="4">
							共<%=cart.size() %>項, <%=cart.getTotalQuantity() %>件
						</td>
						<td colspan="2">
							總計: <%=cart.getTotalAmount() %>元
						</td>
					</tr>
					<tr>
						<td  colspan="6">
							<input type='submit' value='修改購物車'>
							<button type='submit' name='submit' value='checkOut'>我要結帳</button>
						</td>						
					</tr>
				</tfoot>	
			</table>
			</form>
			<% } %>
		</article>
		<%@ include file="/subviews/footer.jsp" %>
	</body>
</html>