<%@page import="plants.entity.Customer"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta charset="UTF-8">
	<meta http-equiv="refresh" content="5; url=<%=request.getContextPath() %>/"/>
	<link href='<%= request.getContextPath() %>/css/vgb.css' rel="stylesheet">
	<title>註冊成功</title>
			<style>
			</style>
	</head>
	<body>
		<header>
			<h1><a href='/vgb/'>非常好書</a>
				<sub>註冊成功</sub>
			</h1>					
			<hr>
		</header>
		<%
			//java程式
			Customer member = (Customer)session.getAttribute("member");
		%>
		<article>
			<h2><%= member==null?"尚未登入":member.getName() %>修改會員資料成功</h2>
			<p>5秒後將自動跳轉<a href='<%=request.getContextPath() %>/'>首頁</a></p>
		</article>		
		<footer>
			<hr>
			<div style='text-align: center;'>非常好書&copy;版權所有 2022-10~</div>
		</footer>
	</body>
</html>