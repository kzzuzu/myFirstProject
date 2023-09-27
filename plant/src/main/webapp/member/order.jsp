<%@page import="plants.entity.PaymentType"%>
<%@page import="plants.entity.OrderItem"%>
<%@page import="plants.service.OrderService"%>
<%@page import="plants.entity.Order"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">	
		<title>訂單明細</title>
		<link rel="stylesheet" href="<%= request.getContextPath() %>/css/vgb.css">
		<style>
				#orderItems {   clear:both;
				  font-size: smaller;
				  border-collapse: collapse;
				  width: 65%; 
				  margin: 1em auto;
				  padding-top: 1em;
				}
				
				#orderItems td, #orderItems th {
				  border: 1px solid #ddd;
				  padding: 8px;
				}
				
				#orderItems tr:nth-child(even){background-color: #f2f2f2;}
				
				#orderItems tr:hover {background-color: YellowGreen;}
				
				#orderItems tbody img{width:48px;vertical-align: middle;}
				#orderItems tbody input.quantity{width:2.5em}
				
				#orderItems caption{
				  padding-top: 12px;
				  padding-bottom: 12px;				  
				  background-color: #04AA6D;
				  color: white;
				}
				
				#orderItems th{
				  padding-top: 12px;
				  padding-bottom: 12px;				  
				  background-color: darkgray;
				  color: white;
				}
				
				#orderItems tfoot td{text-align: right}
				
				#orderItems tfoot fieldset input:not([type='button']){width:70%;min-width:10em}
		
				.datafield{color: blue}
				
				.statusDiv{display: inline-block;background-color: orange;
						width:4em;line-height: 3em;text-align: center;}
		</style>	
	</head>
	<body>
		<jsp:include page="/subviews/header.jsp" >
			<jsp:param value="訂單明細" name="subtitle"/>
		</jsp:include>
		<%@ include file="/subviews/nav.jsp" %>
		<%
			String orderId = request.getParameter("orderId");
			Order order = null;
			if(orderId!=null && orderId.length()>0){
				OrderService oService = new OrderService();
				order = oService.getOrderById(member, orderId);
			}		
		%>
		<article>
		<% if(order==null) {%>
		<%}else{ %>	
		<div class='' style='float:left;width:40%'>
				<div>訂單編號: <span class='datafield'><%= order.getIdString() %></span> 
					 處理狀態: <span class='datafield'><%= order.getStatus() %></span></div>
				<div>訂購時間: <span class='datafield'><%= order.getOrderDate() %> <%= order.getOrderTime() %></span></div>
				<div>付款/取貨 <span class='datafield'><%=order.getPaymentTypeDescription() %></span>
							<% if(PaymentType.ATM.name().equals(order.getPaymentType())
									&& order.getStatus()==Order.Status.NEW.ordinal()){%>
								<a href='atm_transfer.jsp?orderId=<%= order.getId() %>'>通知已轉帳</a>
							<% }%>
							 <span class='datafield'><%=order.getShippingTypeDescription() %></span>
							 <span class='datafield'><%= order.getPaymentFee()+order.getShippingFee() %></span> 
				</div>
				<div>取貨地址: <span class='datafield'><%= order.getShippingAddress() %></span></div>			
			</div>
			<fieldset  style='float:left;width:40%'>
				<legend>收件人資料</legend>
				<label>姓名: </label><input class='datafield' value='<%= order.getRecipientName() %>'><br>
				<label>Email:</label><input class='datafield' value='<%= order.getRecipientEmail() %>'><br>
				<label>電話: </label><input class='datafield' value='<%= order.getRecipientPhone() %>'><br>				
			</fieldset>
			<div style='clear:both'>
				<h2>+ 手續費 總金額: <span class='datafield'><%= order.getTotalAmountWithFee() %>元</span></h2>				
			</div>
			<div>
				<div class='statusDiv' title='2023-03-13 14:30'>新訂單</div> > 
				<div class='statusDiv' title='2023-03-13 20:30'>處理中</div>
			</div>
			<table id='orderItems'>
				<caption>訂單明細</caption>			
				<thead>
					<tr>
					<th>名稱</th>
					<th>顏色/Size</th>
					<th>價格</th>
					<th>數量</th>
					<th>小計</th>					
					</tr>
				</thead>
				<tbody>	
					<% for(OrderItem orderItem:order.getOrderItemSet()) {%>
					<tr>				
						<td>
							<img src='<%= orderItem.getPhotoUrl()%>'>
							<%= orderItem.getProductName() %>							
						</td>
						<td><%= orderItem.getDisplayedColorSizeName() %></td>
						<td><%= orderItem.getPrice()%>元</td>
						<td><%= orderItem.getQuantity()%></td>
						<td><%= orderItem.getAmount()%></td>
						
					</tr>
					<% } %>											
				</tbody>
				<tfoot>
					<tr>
						<td colspan="3">
							共<%= order.size() %>項, <%= order.getTotalQuantity() %>件
						</td>
						<td colspan="2">
							總計: <span id='totalAmount'><%= order.getTotalAmount() %></span>元
						</td>
					</tr>
				</tfoot>	
			</table>
			<%} %>
		</article>
		<%@ include file="/subviews/footer.jsp" %>
	</body>
</html>