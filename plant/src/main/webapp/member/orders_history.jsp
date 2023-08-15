<%@page import="plants.service.OrderService"%>
<%@page import="plants.entity.Order"%>
<%@page import="java.util.List"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">	
		<title>歷史訂單</title>
		<link rel="stylesheet" href="<%= request.getContextPath() %>/css/vgb.css">
		<style>
			#orderHistory{width:65%;min-width: 400px;margin: auto}
			thead>tr{border-bottom-color: gray}
			
		</style>	
	</head>
	<body>
		<jsp:include page="/subviews/header.jsp" >
			<jsp:param value="歷史訂單" name="subtitle"/>
		</jsp:include>
		<%@ include file="/subviews/nav.jsp" %>	
		<%
			List<Order> list = null;
			if(member!=null){
				OrderService oService = new OrderService();
				list = oService.getOrdersHistory(member);
			}
		%>
		<article>
			<% if(list==null || list.isEmpty()){%>
			查無歷史訂單
			<%}else{ %>			
			<table id='orderHistory'>
				<caption>歷史訂單查詢</caption>
				<thead>
					<tr>
						<td>訂單編號</td><td>訂購日期時間</td><td>付款/取貨</td><td>總金額(含手續費)</td>
					</tr>					
				</thead>
				<tbody>				
					<% for(Order order:list) {%>
					<tr>
						<td><a href='order.jsp?orderId=<%= order.getId() %>'><%= order.getIdString() %></a></td>
						<td><%= order.getOrderDate() %> <%= order.getOrderTime() %></td>
						<td><%= order.getPaymentTypeDescription() %>/<%= order.getShippingTypeDescription() %></td>
						<td><%= order.getTotalAmountWithFee() %></td>
					</tr>
					<% } %>
				</tbody>
			</table>
			<% } %>
		</article>
		<%@ include file="/subviews/footer.jsp" %>
	</body>
</html>