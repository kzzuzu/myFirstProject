<%@page import="plants.entity.PaymentType"%>
<%@page import="java.time.LocalDate"%>
<%@page import="plants.service.OrderService"%>
<%@page import="plants.entity.Order"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link href='<%= request.getContextPath() %>/css/vgb.css' rel="stylesheet">
		<title>通知已轉帳</title>
		<style>
			form p label:first-child {display: inline-block;min-width: 5em}
	
}
		</style>	
	</head>
<body>
	<jsp:include page='/subviews/header.jsp'>
		<jsp:param value="通知已轉帳" name="subtitle" />		
	</jsp:include>
	<%@include file='/subviews/nav.jsp' %>
	<%			
			String orderId = request.getParameter("orderId");
			Order order = null;
			OrderService oService = new OrderService();
			if(member!=null && orderId!=null){
				order = oService.getOrderById(member, orderId);				
			}		
		%>
	<article>
		<% if(order==null || !(PaymentType.ATM.name().equals(order.getPaymentType()) && order.getStatus()==0)){%>
			<p>查無需通知轉帳的訂單資料，回<a href='orders_history.jsp'>歷史訂單</a></p>
		<% }else{%>
		<form action='atm_transfer.do' method='POST' style='width: 20em;margin: auto;'>
			<p>
				<label>訂單編號:</label>
				<input name='orderId' value='<%= orderId%>' readonly>
			</p>
			<p>
				<label>轉帳銀行:</label>
				<input name='bank' required placeholder='請輸入轉帳銀行名稱'>
			</p>
			<p>
				<label>帳號後5碼:</label>
				<input name='last5Code' required placeholder='請輸入轉帳帳號後5碼'>
			</p>
			<p>
				<label>轉帳金額:</label>
				<input name='amount' name='amount' required value='<%= order.getTotalAmountWithFee() %>' >
			</p>
			<p>
				<label>轉帳時間:</label>
				<input type='date' name='transDate' required min='<%= order.getOrderDate()%>' max='<%= LocalDate.now()%>'> 
				<input type='time' name='transTime' required> 
			</p>
			<p style='text-align:right'><input type="submit" value='確定'></p>
		</form>
		<% } %>
	</article>
	<%@include file='/subviews/footer.jsp' %>
</body>
</html>