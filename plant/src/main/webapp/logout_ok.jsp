<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href='<%= request.getContextPath() %>/css/vgb.css' rel="stylesheet">
<title>登出成功</title>
</head>
<body>
	<jsp:include page='/subviews/header.jsp'>
		<jsp:param value="會員登出" name="subtitle" />		
	</jsp:include>
	<%@include file='/subviews/nav.jsp' %>
	<article>

	</article>
	<%@include file='/subviews/footer.jsp' %>
</body>
</html>