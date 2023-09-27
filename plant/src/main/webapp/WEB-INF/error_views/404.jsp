<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">	
		<title>網址不正確</title>
		<link rel="stylesheet" href="<%= request.getContextPath() %>/css/vgb.css">
		<style>
		</style>	
	</head>
	<body>
		<jsp:include page="/subviews/header.jsp" >
			<jsp:param value="找不到檔案" name="subtitle"/>
		</jsp:include>
		<%@ include file="/subviews/nav.jsp" %>	
		<article>
			<div style='width:100%;text-align: center;color:darkred;font-weight: bolder;'>
			<img style='display: block;width:60%;max-width:500px;margin: auto' 
				src='<%= request.getContextPath()%>/images/404.png'>
			
				<%= request.getAttribute("javax.servlet.error.request_uri") %>
			</div>
		</article>
		<%@ include file="/subviews/footer.jsp" %>
	</body>
</html>