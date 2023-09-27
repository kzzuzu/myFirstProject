<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href='<%= request.getContextPath() %>/css/vgb.css' rel="stylesheet">
<title>404</title>
</head>
<body>
	<jsp:include page='/subviews/header.jsp'>
		<jsp:param value="找不到網頁" name="subtitle" />		
	</jsp:include>
	<%@include file='/subviews/nav.jsp' %>
	<article>
		<div style='text-align: center'>
			<h1>404</h1>
			<h3>找不到網頁的網址為: <!-- 請查java servlet 4.0規格文件 p.133 -->
				<%= request.getAttribute("javax.servlet.error.request_uri")%>
			</h3>
		</div>
	</article>
	<%@include file='/subviews/footer.jsp' %>
</body>
</html>