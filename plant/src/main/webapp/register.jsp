<!--<%@ page pageEncoding="UTF-8"%>-->
<!DOCTYPE html>
<%@page import="java.time.LocalDate"%>
<%@page import="plants.entity.Customer"%>
<%@page import="java.util.List"%>
<% request.setCharacterEncoding("UTF-8"); //用Filter來統一設定編碼 %>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">		
		<title>會員註冊</title>
		<link rel="stylesheet" href="css/vgb.css">
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
			//window.addEventListener("load", init);
			//window.onload=init;
			$(document).ready(init);			
			
			function init(){	
				$("#showPwdBox").click(showPassword);
<%-- 				$("input[name='id']").attr('pattern','<%= Customer.ID_PATTERN %>'); --%>
				$("input[name='id']").attr('maxlength', <%= Customer.MAX_ID_LENGTH %>);
				$("input[type='password']").attr('minlength', <%= Customer.MIN_PWD_LENGTH %>);
				$("input[type='password']").attr('maxlength', <%= Customer.MAX_PWD_LENGTH %>);
				$("input[name='name']").attr('minlength', <%= Customer.MIN_NAME_LENGTH %>);
				$("input[name='name']").attr('maxlength', <%= Customer.MAX_NAME_LENGTH %>);
				birthday.setAttribute("max", '<%= LocalDate.now().minusYears(Customer.MIN_AGE) %>');
				
				repopulateFormData();				
			}
			
			function repopulateFormData(){
				<% if("POST".equalsIgnoreCase(request.getMethod())){%>
				//帶入gender資料(radio)				
				$("input[value='<%=request.getParameter("gender")%>']").prop('checked', true);
				
				$("input[name='id']").val('<%= request.getParameter("id")%>');
				$("input[name='email']").val('<%= request.getParameter("email")%>');
				$("input[name='password1']").val('<%= request.getParameter("password1")%>');
				$("input[name='password2']").val('<%= request.getParameter("password2")%>');
				$("input[name='name']").val('<%= request.getParameter("name")%>');				
				$("#birthday").val('<%= request.getParameter("birthday")%>');
								
				$("textarea[name='address']").val('<%= request.getParameter("address")%>');
				$("input[name='phone']").val('<%= request.getParameter("phone")%>');
				
				<%--	//bloodtype(select option)
				var bloodtypeData = '<%= request.getParameter("bloodType") %>';
				//if(bloodtypeData!=''){
					//$("select[name='bloodType'] option[value='"+bloodtypeData+"']").prop('selected', true);
				//}--%>
				
				//subscribed(checkbox)
				$("input[name='subscribed']").prop("checked", <%= request.getParameter("subscribed")!=null%>);
				
				alert("資料錯誤，請修改錯誤的欄位再註冊");		
				<% } %>
			}
			
			function bye(){
				alert('Bye');				
			}			
			 
	 	    function showPassword(){
				console.log(showPwdBox.checked);
				if(showPwdBox.checked){
					password1.type='text';
					password2.type='text';
				}else{
					password1.type='password';
					password2.type='password';
				}
			}
	 	   <%--
			function refreshCaptcha(){
				//alert('refresh Captcha');
				captchaImage.src='images/register_captcha.jpg?refresh=' + new Date(); //ajax
			}--%>
			
			function checkId(){
				if($("input[name='id']").val().length>0){
					var queryString = "id=" + $("input[name='id']").val();					
					checkIdOREmail(queryString);					
				}
			}
			
			function checkEmail(){
				if($("input[name='email']").val().length>0){
					var queryString = "email=" + $("input[name='email']").val();
					checkIdOREmail(queryString);					
				}
			}
			
			function checkIdOREmail(queryString){
				var url = "check_customer_id_or_email.jsp?"+queryString;
				//console.log(url); //for test
				var xhr = $.ajax({
					url: url		
				}).done(checkIdOREmailDoneHandler);				
			}
			
			function checkIdOREmailDoneHandler(result, txtStatus,xhr){
				alert(result.attrName 
						+ (result.isDuplicate?"已重複": ("未重複"+(result.isCorrect?"且正確":"但格式不正確"))
					));
			}
		</script>
	</head>
	<body>
		<jsp:include page="/subviews/header.jsp" >
			<jsp:param value="會員註冊" name="subtitle"/>
		</jsp:include>
		<%@ include file="/subviews/nav.jsp" %>	
		<article><!-- http://localhost:8080/vgb/register.html -->
			<% 
				List<String> errors=(List<String>)request.getAttribute("errors");
			%>			
			<form class='memberform' action='register.do' method='POST' autocomplete="on">
				<p><%= errors==null?"":errors %></p>
				<div name='errorList'></div> <!-- 第14章的EL來取出errorList並顯示在畫面上 -->			
				<p>
					<label>帳號: </label>
					<input type='text' name='id' placeholder="請輸入中華民國身分證號" required pattern='<%= Customer.ID_PATTERN %>'>
					<input type='button' value='檢查帳號是否重複' onclick='checkId()'>					
				</p>
				<p>
					<label>email: </label>
					<input type='email' name="email"  placeholder="請輸入email"  required>
					<input type='button' value='檢查email是否重複' onclick='checkEmail()'>					
				</p>
				<p>	
					<label>密碼: </label>
					<input id='password1' name='password1' type='password' required placeholder="請輸入密碼(注意大小寫)">
					<input type='checkbox' id='showPwdBox'><label>顯示密碼</label>
					<br><label>確認: </label>
					<input id='password2' name='password2' type='password' required placeholder="請再輸入密碼(注意大小寫)">
				</p>
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
					<label>驗證碼: </label>
					<input name='captcha' required placeholder="輸入驗證碼(不分大小寫)" autocomplete="false">
					<img src='images/register_captcha.jpg' id='captchaImage' onclick='refreshCaptcha()' title='點選即可更新圖片'>
				</p>
				<input type='submit' value='確定'>				
			</form>
		</article>		
		<%@ include file="/subviews/footer.jsp" %>
	</body>
	<script>
		
		//showPwdBox.onchange=showPassword;
	</script>
</html>