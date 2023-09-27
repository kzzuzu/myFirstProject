<%@page import="plants.entity.ShippingType"%>
<%@page import="plants.entity.PaymentType"%>
<%@page import="plants.entity.CartItem"%>
<%@page import="plants.entity.ShoppingCart"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">	
		<title>結帳作業</title>
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
				
				#cart tr:hover {background-color: YellowGreen;}
				
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
				.p_s_Type{float:left;width:45%;text-align: left}
				
				#cart tfoot fieldset input:not([type='button']){width:70%;min-width:10em}
		</style>	
		<script src="https://code.jquery.com/jquery-3.0.0.js" 
			integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" 
			crossorigin="anonymous"></script>
		<script>
			function paymentChanged(){
				calculateAmountWithFee();
			}
			
			function paymentChanged(){
				calculateAmountWithFee();				
			}
			
			function shippingChanged(){
				calculateAmountWithFee();
				changeShippingAddr();
			}
			
			function calculateAmountWithFee(){
				console.log($("select[name='paymentType'] option:selected").val(), 
							$("select[name='shippingType'] option:selected").val(),
							Number($("#totalAmount").text()));
				
				var selectedPaymentOption = $("select[name='paymentType'] option:selected");
				var selectedShippingOption = $("select[name='shippingType'] option:selected");
				var total = Number($("#totalAmount").text()); 
				if(selectedPaymentOption.val().length>0){
					if(selectedPaymentOption.attr("data-fee"))
						total+=Number(selectedPaymentOption.attr("data-fee"));
				}
				
				if(selectedShippingOption.val().length>0){
					if(selectedShippingOption.attr("data-fee"))
						total+=Number(selectedShippingOption.attr("data-fee"));
				}
				
				//alert(total);
				$("#totalAmountWithFee").text(total);
			}
			
			function changeShippingAddr(){
				
				var selectedShippingOption = $("select[name='shippingType'] option:selected");
				var theShippingAddr = $("input[name='shippingAddr']");
				
				theShippingAddr.prop("readonly", false);
				theShippingAddr.attr("autocomplete", "on");				
				theShippingAddr.removeAttr("list");
				$("#chooseStoreButton").hide();
				switch(selectedShippingOption.val()){				
				case 'STORE':
					theShippingAddr.prop("readonly", true);
					theShippingAddr.attr("placeholder", "請選擇超商");
					$("#chooseStoreButton").show();
					break;
				case 'SHOP':
					theShippingAddr.attr("list", "shopList");
					theShippingAddr.attr("placeholder", "請選擇門市");
					break;
				default:
					theShippingAddr.attr("placeholder", "請輸入宅配地址");					
				}
			}
			
			function copyMember(){
				$("input[name='name']").val("${sessionScope.member.name}");
				$("input[name='email']").val("${sessionScope.member.email}");
				$("input[name='phone']").val("${sessionScope.member.phone}");				
				
				var selectedShippingOption = $("select[name='shippingType'] option:selected");
				if(selectedShippingOption.val()=='HOME'){
					$("input[name='shippingAddr']").val("${sessionScope.member.address}");
				}
			}
			
			$(init); 
			
			function init(){		
				<% if("POST".equals(request.getMethod())){%>
				repopulateForm();
				<%}%>
				//$("select[name='shippingType']").on("change", changePaymentOption);		
				//$("select[name='paymentType']").on("change", calculateAmount);	
			}
			
			function repopulateForm(){
				$("select[name='paymentType']").val('<%= request.getParameter("paymentType")%>');
				$( "select[name='paymentType']" ).trigger( "change" );
				$("select[name='shippingType']").val('<%= request.getParameter("shippingType")%>');
				$( "select[name='shippingType']" ).trigger( "change" );
				
				$("input[name='name']").val('<%= request.getParameter("name")%>');
				$("input[name='email']").val('${param.email}');
				$("input[name='phone']").val('${param.phone}');
				$("input[name='shippingAddr']").val('${param.shippingAddr}');		
			}
		</script>
	</head>
	<body>
		<jsp:include page="/subviews/header.jsp" >
			<jsp:param value="結帳作業" name="subtitle"/>
		</jsp:include>
		<%@ include file="/subviews/nav.jsp" %>	
		
		<% 
				ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
			    //Customer member = (Customer)session.getAttribute("member");
			     
				if(cart!=null && member!=null){
					cart.setMember(member);
				}
			%>
		<article>
		<% if(cart==null || cart.isEmpty() ){%>
				<h2>購物車是空的!</h2>
			<%}else{ %>
			${requestScope.errorList}
			<form id='cartForm' action='check_out.do' method='POST'><!-- http://localhost:8080/vgb/member/check_out.do -->
			<table id='cart'>
				<caption>購物明細</caption>			
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
					<% for(CartItem cartItem:cart.getCartItemSet()){%>
					<tr>				
						<td>
							<img src='<%= cartItem.getPhotoUrl() %>'>
							<%= cartItem.getProductName() %>
							<div style='font-size:smaller'>庫存:<%= cartItem.getStock() %>個</div>
						</td>
						<td>
							<%= cartItem.getColorName()%><%= cartItem.getSizeName()%>
						</td>
						<td>
							定價：<%= cart.getListPrice(cartItem) %>元<br>
							折扣：<%= cart.getDiscountString(cartItem) %><br>
							優惠價：<%= cart.getUnitPrice(cartItem) %>元
						</td>
						<td><%= cart.getQuantity(cartItem) %>
						</td>
						<td><%= cart.getAmount(cartItem) %></td>
						
					</tr>
					<% }%>												
				</tbody>
				<tfoot>
					<tr>
						<td colspan="3">
							共<%=cart.size() %>項, <%=cart.getTotalQuantity() %>件
						</td>
						<td colspan="2">
							總計: <span id='totalAmount'><%=cart.getTotalAmount() %></span>元
						</td>
					</tr>
					<tr>
						
					</tr>
					<tr>
						<td  colspan="3">
						<span class='p_s_Type' >
							<label>付款方式:</label>
							<select name='paymentType' required onchange='paymentChanged()'>
								<option value=''>請選擇...</option>
								<% for(PaymentType pType:PaymentType.values()) {%>
								<option value='<%= pType.name()%>' data-fee='<%= pType.getFee()%>'>
									<%= pType %>
								</option>
								<%} %>
							</select>
						</span>
						<span style='float:left'>
						<label>取貨方式:</label>
							<select name='shippingType' required onchange='shippingChanged()'>
								<option value=''>請選擇...</option>
								<% for(ShippingType shType:ShippingType.values()) {%>
								<option value='<%= shType.name()%>' data-fee='<%= shType.getFee()%>'>
								<%= shType %>
								</option>								
								<%} %>							
							</select>
						</span>
						</td>
						<td  colspan="2">
							+手續費 總計: <span id='totalAmountWithFee'><%=cart.getTotalAmount() %></span>元
						</td>
					</tr>
					<tr>
						<td colspan="5">
							<fieldset style='width:95%'>
								<legend>收件人資料(<a href='javascript:copyMember()'>複製訂購人</a>):</legend>
								<label>姓名:</label><input name='name' placeholder="請輸入收件人姓名" required><br>
								<label>email:</label><input type='email' name='email' placeholder="請輸入收件人Email" required><br>
								<label>電話:</label><input type='tel' name='phone' placeholder="請輸入收件人電話" required><br>
								<label>取件地址:</label><input name='shippingAddr' placeholder="請輸入宅配地址" required><br>
								<input type='button' id='chooseStoreButton' value='選擇超商' style='display:none'>
								<datalist id="shopList">
									  <option value='台北旗艦店 復興北路99號1F'>台北旗艦店 復興北路99號1F</option>
									  <option value="新竹門市">新竹門市 新竹市東區光復路二段295號3樓之2</option>
									  <option value="台中門市">台中門市 台中市西區臺灣大道二段309號2樓</option>
									  <option value="高雄門市">高雄門市 高雄市前鎮區中山二路2號25樓</option>						  
								</datalist>
							</fieldset>
						</td>
					</tr>
					<tr>
						<td  colspan="5">							
							<input type='submit' value='送出訂單'>
						</td>						
					</tr>
				</tfoot>	
			</table>
			</form>
			<% } %>
		</article>
		<%@ include file="/subviews/footer.jsp" %>
		<script>
			$("#chooseStoreButton").click(goEZShip);
			function goEZShip() {//前往EZShip選擇門市
            	if (confirm("Go EZ前，你的網址已經改用ip Address了嗎?")) {
                	alert("出發");
             	} else {
                  alert("快改網址!");
                  return;
             	}

				$("input[name='name']").val($("input[name='name']").val().trim());				
				$("input[name='email']").val($("input[name='email']").val().trim());				
				$("input[name='phone']").val($("input[name='phone']").val().trim());				
				$("input[name='shippingAddr']").val($("input[name='shippingAddr']").val().trim());
				 
				var protocol = "<%= request.getRequestURL().substring(0, request.getRequestURL().indexOf("://")) %>";				
				var ipAddress = "<%= java.net.InetAddress.getLocalHost().getHostAddress()%>";				
				var url = protocol + "://" + ipAddress + ":" + location.port + "<%=request.getContextPath()%>/member/ezship_callback.jsp";
				$("#rtURL").val(url);				
				 
				
				//$("#webPara").val($("form[action='check_out.do']").serialize());				
				$("#webPara").val($("#cartForm").serialize());				 
				
				alert('現在網址不得為locolhost: '+url); //測試用，測試完畢後請將此行comment				
				alert($("#webPara").val()) //測試用，測試完畢後請將此行comment
				
				$("#ezForm").submit();				
			}

			</script>

			<form id="ezForm" method="post" name="simulation_from" action="https://map.ezship.com.tw/ezship_map_web.jsp" >			
				<input type="hidden" name="suID"  value="test@vgb.com"> <!-- 業主在 ezShip 使用的帳號, 隨便寫 -->				
				<input type="hidden" name="processID" value="VGB202107050000005"> <!-- 購物網站自行產生之訂單編號, 隨便寫 -->				
				<input type="hidden" name="stCate"  value=""> <!-- 取件門市通路代號 -->				
				<input type="hidden" name="stCode"  value=""> <!-- 取件門市代號 -->				
				<input type="hidden" name="rtURL" id="rtURL" value=""> <!-- 回傳路徑及程式名稱 -->				
				<input type="hidden" id="webPara" name="webPara" value=""> <!-- 結帳網頁中cartForm中的輸入欄位資料。ezShip將原值回傳，才能帶回結帳網頁 -->			
			</form> 
		</script>		
	</body>	
</html>