<%@page import="plants.entity.Order"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">	
		<title>結帳成功</title>
		<link rel="stylesheet" href="<%= request.getContextPath() %>/css/vgb.css">
		<style>		
			#orderData{width:60%;margin: auto;min-width: 400px;}
		</style>	
	</head>
	<body>
		<jsp:include page="/subviews/header.jsp" >
			<jsp:param value="結帳成功" name="subtitle"/>
		</jsp:include>
		<%@ include file="/subviews/nav.jsp" %>
<%-- 		<div>${requestScope.theOrder}</div>		 --%>
		<%
			Order order = (Order)request.getAttribute("theOrder");
			String orderId;
			if(order!=null){
				orderId = String.valueOf(order.getId());
			}else{
				orderId = request.getParameter("orderId");
			}
		%>
		<article>
			<div id='orderData'>
			<h2>建立訂單[<a href='order.jsp?orderId=<%= orderId%>'><%= orderId%></a>]成功，感謝惠顧!</h2>
			<p>或由<a href='orders_history.jsp'>歷史訂單查詢檢視訂單內容</a></p>
			</div>			
		</article>
		<%@ include file="/subviews/footer.jsp" %>
	</body>
</html>