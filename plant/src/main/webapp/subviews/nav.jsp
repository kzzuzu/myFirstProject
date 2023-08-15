<%@page import="plants.entity.ShoppingCart"%>
<%@page import="plants.entity.Customer"%>
<%@ page pageEncoding="UTF-8"%>
<!-- nav.jsp start -->
	<%		
		Customer member = (Customer)session.getAttribute("member");
	%>
		<nav>		
			<a href='<%= request.getContextPath() %>/product_list.jsp'>商店</a> |			
			<% if(member==null) {%> <!-- 尚未登入 -->
				<a href='<%= request.getContextPath() %>/login.jsp'>登入</a> |
				<a href='<%= request.getContextPath() %>/register.jsp'>註冊</a> |						
			<%}else{ %> <!-- 已登入 -->
				<a href='<%= request.getContextPath() %>/member/update.jsp'>會員修改</a> | 
				<a href='<%= request.getContextPath() %>/member/orders_history.jsp'>歷史訂單</a> |
				<a href='<%= request.getContextPath() %>/logout.do'>登出</a> | <!-- http://localhost:8080/vgb/logout.do --> 
			<% }%>			
			<span style='float:right;font-size: smaller'>
				<a href='<%= request.getContextPath() %>/member/cart.jsp'>
					<img class='cartPng' height="20px" width="20px" src='<%= request.getContextPath() %>/images/cart.png'>
					<span class='cartTotalQty'>
<%-- 						<% ShoppingCart cart = (ShoppingCart)session.getAttribute("cart"); %> --%>
<%-- 						<%= cart!=null?cart.getTotalQuantity():""%> --%>
						${not empty sessionScope.cart?"(".concat(sessionScope.cart.getTotalQuantity()).concat(")"):""}
					</span>					
				</a>			
				<span id='memberName'><%= member!=null?member.getName():"" %></span> 
				你好				
			</span>
			<hr>
		</nav>
<!-- nav.jsp end -->		