<!--<%@ page pageEncoding="UTF-8"%>-->
<!DOCTYPE html>
<%@page import="plants.entity.VIP"%>
<%@page import="plants.entity.BloodType"%>
<%@page import="java.time.LocalDate"%>
<%@page import="plants.entity.Customer"%>
<%@page import="java.util.List"%>
<% request.setCharacterEncoding("UTF-8"); //用Filter來統一設定編碼 %>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">		
		<title>會員修改</title>
		<link rel="stylesheet" href="../css/vgb.css">
		<style>
/* 			body{font-family: 'Noto Sans TC', sans-serif;} */
/* 			article{min-height: 70vh} */
			
	 		.memberform{width: 450px;margin: auto;}  
 			.memberform p label{display: inline-block;min-width:3.5em} 
 			#captchaImage{cursor: pointer;vertical-align: middle} 
		</style>
		<script src="https://code.jquery.com/jquery-3.0.0.js" 
			integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" 
			crossorigin="anonymous"></script>
		<script>
	 	    function showPassword(){
				console.log(showPwdBox.checked);
				if(showPwdBox.checked){
					$(".password").attr("type", "text");
				}else{
					$(".password").attr("type", 'password');					
				}
			}
			
			function refreshCaptcha(){
				//alert('refresh Captcha');
				captchaImage.src='../images/register_captcha.jpg?refresh=' + new Date(); //ajax
			}
		</script>
	</head>
	<body>
		<jsp:include page="/subviews/header.jsp" >
			<jsp:param value="會員修改" name="subtitle"/>
		</jsp:include>
		<%@ include file="/subviews/nav.jsp" %>
		<article><!-- http://localhost:8080/vgb/register.html -->
			<% 
				List<String> errors=(List<String>)request.getAttribute("errors");
			%>			
			<form class='memberform' action='update.do' method='POST' autocomplete="on">
				<p><%= errors==null?"":errors %></p>
				<div name='errorList'></div> <!-- 第14章的EL來取出errorList並顯示在畫面上 -->			
				<p>
					<label>帳號: </label>
					<input type='text' name='id' placeholder="請輸入中華民國身分證號" readonly pattern='<%= Customer.ID_PATTERN %>'>
					<% if(member instanceof VIP) {%>
					<input type='checkbox' checked disabled>VIP,享有優惠折扣<%=((VIP)member).getDiscountString() %>
					<%} %>
						
				</p>
				<p>	
					<label>密碼: </label>
					<input class='password' name='password' type='password' required placeholder="請輸入密碼才能修改成功">
				</p>
				<p>
					<label>email: </label>
					<input type='email' name="email"  placeholder="請輸入email"  required>										
				</p>
				<fieldset>
					<legend>
						<input type='checkbox' name='changePwd'>修改密碼
					</legend>
					<p>	
						<label>密碼: </label>
						<input class='password updatePassword' name='password1' type='password' disabled placeholder="請輸入密碼(注意大小寫)">
						<input type='checkbox' id='showPwdBox'><label>顯示密碼</label>
						<br><label>確認: </label>
						<input class='password updatePassword' name='password2' type='password' disabled placeholder="請再輸入密碼(注意大小寫)">
					</p>
				</fieldset>
				<p>
					<label>姓名: </label>
					<input type='text' name="name"  placeholder="請輸入姓名"  required >					
				</p>
				<p>
					<label>生日: </label>
					<input type='date' id='birthday' name="birthday"  required>					
				</p>
				<p>
					<label>性別: </label>
					<input type='radio' required name='gender' value='<%=Customer.MALE %>'><label>男</label>					
					<input type='radio' required name='gender' value='<%=Customer.FEMALE %>'><label>女</label>
					<input type='radio' required name='gender' value='<%=Customer.UNKNOWN %>'><label>其他</label>
				</p>
				
				<p>
					<label>地址: </label>
					<textarea name="address"></textarea>
				</p>
				<p>
					<label>電話: </label>
					<input type='tel' name="phone" >					
				</p>
				
				<p>
					<label>血型: </label>
					<select name='bloodType'>
						<option value=''>請選擇...</option>
						<% for(int i=0;i<BloodType.values().length;i++) {
							BloodType bType = BloodType.values()[i];
						%>
						<option value='<%=bType.name()%>'><%=bType%></option>
						<% } %>					
					</select>
					 &nbsp; &nbsp; &nbsp;<input type='checkbox' name='subscribed'>
					 <label>是否訂閱電子報</label>					
				</p>							
				<p>
					<label>驗證碼: </label>
					<input name='captcha' required placeholder="輸入驗證碼(不分大小寫)" autocomplete="false">
					<img src='../images/register_captcha.jpg' id='captchaImage' onclick='refreshCaptcha()' title='點選即可更新圖片'>
				</p>
				<input type='submit' value='確定'>				
			</form>
		</article>		
		<%@ include file="/subviews/footer.jsp" %>
	</body>
	<script>		
		function updatePassword(){
			var enablePasswordUpdate = $(this).prop('checked');			
			$(".updatePassword").prop("disabled", !enablePasswordUpdate);
			if($(".updatePassword").prop("disabled")){
				$(".updatePassword").val('');	
			}
		}
		
		$(document).ready(init);		
		
		function init(){
			$("#showPwdBox").click(showPassword);
			$("input[name='changePwd']").click(updatePassword);
			
			$("input[name='id']").attr('maxlength', <%= Customer.MAX_ID_LENGTH %>);
			$("input[type='password']").attr('minlength', <%= Customer.MIN_PWD_LENGTH %>);
			$("input[type='password']").attr('maxlength', <%= Customer.MAX_PWD_LENGTH %>);
			$("input[name='name']").attr('minlength', <%= Customer.MIN_NAME_LENGTH %>);
			$("input[name='name']").attr('maxlength', <%= Customer.MAX_NAME_LENGTH %>);
			birthday.setAttribute("max", '<%= LocalDate.now().minusYears(Customer.MIN_AGE) %>');
			
			repopulateFormData();				
		}
		
		function repopulateFormData(){
			<% if("POST".equalsIgnoreCase(request.getMethod())){   //修改失敗帶入上次輸入的資料%>
				//帶入gender資料(radio)				
				$("input[value='<%=request.getParameter("gender")%>']").prop('checked', true);
				
				$("input[name='id']").val('${param.id}');
				$("input[name='email']").val('<%= request.getParameter("email")%>');
				$("input[name='password1']").val('<%= request.getParameter("password1")%>');
				$("input[name='password2']").val('<%= request.getParameter("password2")%>');
				$("input[name='name']").val('<%= request.getParameter("name")%>');				
				$("#birthday").val('<%= request.getParameter("birthday")%>');
								
				$("textarea[name='address']").val('<%= request.getParameter("address")%>');
				$("input[name='phone']").val('<%= request.getParameter("phone")%>');
				
				//bloodtype(select option)
				var bloodtypeData = '<%= request.getParameter("bloodType") %>';
				if(bloodtypeData!=''){
					$("select[name='bloodType'] option[value='"+bloodtypeData+"']").prop('selected', true);
				}
				
				//subscribed(checkbox)
				$("input[name='subscribed']").prop("checked", <%= request.getParameter("subscribed")!=null%>);
				
				alert("資料錯誤，請修改錯誤的欄位再修改");		
			<% }else if(member==null){ %>
				alert("請先登入後才能修改!");
			<% }else{  //修改時先帶入session範圍的member資料 %>
				//帶入gender資料(radio)				
				$("input[value='<%=member.getGender()%>']").prop('checked', true);
				
				$("input[name='id']").val('${sessionScope.member.id}');
				$("input[name='email']").val('<%= member.getEmail()%>');
				//$("input[name='password1']").val('');
				//$("input[name='password2']").val('');
				$("input[name='name']").val('<%= member.getName()%>');				
				$("#birthday").val('<%= member.getBirthday() %>');
								
				$("textarea[name='address']").val('<%= member.getAddress()%>');
				$("input[name='phone']").val('<%=  member.getPhone() %>');
				
				//bloodtype(select option)
				
				var bloodtypeData = '<%= member.getBloodType()==null?"":member.getBloodType().name() %>';
				if(bloodtypeData!=''){
					$("select[name='bloodType'] option[value='"+bloodtypeData+"']").prop('selected', true);
				}
				
				//subscribed(checkbox)
				$("input[name='subscribed']").prop("checked", <%= member.isSubscribed() %>);
			<% } %>
		}
	</script>
</html>