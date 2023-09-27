<!--<%@ page pageEncoding="UTF-8"%>-->
<!DOCTYPE html>
<%@page import="java.util.List"%>

<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>會員登入</title>
		<link rel="stylesheet" href="css/vgb.css">
		<style>
/* 			body{font-family: 'Noto Sans TC', sans-serif;} */
/* 			article{min-height: 70vh} */
			
	 		.memberform{width: 450px;margin: auto;}  
 			.memberform p label{display: inline-block;min-width:4em} 
 			#captchaImage{vertical-align: bottom;cursor: pointer;}
		</style>
		
		<script src="https://code.jquery.com/jquery-3.0.0.js" 
			integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" ></script>
			
		<script>
			$(document).ready(init);			
			
			function init(){
				repopulateFormData();	
			}
		
			function repopulateFormData(){
				<% if("POST".equalsIgnoreCase(request.getMethod())){%>
				$("input[name='id']").val('<%= request.getParameter("id")%>');
				$("#password").val('<%= request.getParameter("password")%>');
				<%}%>
			}
			
	 	    function showPassword(){
				console.log(showPwdBox.checked);
				if(showPwdBox.checked){
					password.type='text';
				}else{
					password.type='password';
				}
			}
			
			function refreshCaptcha(){
				//alert('refresh Captcha');
				captchaImage.src='images/captcha.jpg?refresh='+new Date();
			}
		</script>
	</head>
	<body>
			<%@ include file = "subviews/header.jsp" %>
			<%@ include file = "subviews/nav.jsp" %>	
		<article><!-- http://localhost:8080/vgb/login.jsp -->
			<% 
			List<String> errors=(List<String>)request.getAttribute("errors");
			%>			
			<form class='memberform' action='login.do' method='POST' autocomplete="on">
				<div><%= errors==null?"":errors %></div> <!-- 第14章的EL來取出errorList並顯示在畫面上 -->			
				<p>
					<label>帳號: </label>
					<input type='text' name='id' required placeholder="請輸入id或email"
						value='A123123123'>
					<input type="checkbox" name="auto" />記住我的帳號
				</p>
				<p>	
					<label>密碼: </label>
					<input id='password' name='password' type='password' value="12345;lkj" required placeholder="請輸入密碼(注意大小寫)">
					<input type='checkbox' id='showPwdBox' onchange="showPassword()"><label>顯示密碼</label>
				</p>
				<p>
					<label>驗證碼: </label>
					<input name='captcha' required placeholder="輸入驗證碼(不分大小寫)" value="" autocomplete="false">
					<img src='images/captcha.jpg' id='captchaImage' 
							onclick='refreshCaptcha()' title='點選即可更新圖片'>
				</p>
				<input type='submit' value='我要登入'>							
			</form>
			
		</article>		
		
	</body>
</html>