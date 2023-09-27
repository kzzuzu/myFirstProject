<%@page import="plants.entity.Color"%>
<%@page import="plants.entity.Outlet"%>
<%@page import="plants.service.ProductService"%>
<%@page import="plants.entity.Product"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">		
		<title>產品明細</title>
		<link rel="stylesheet" href="css/vgb.css">
		<%
			String productId=request.getParameter("productId");
			ProductService service = new ProductService();
			Product p = null;
			if(productId!=null && productId.length()>0){
				p = service.getProductById(productId);	
			}			
		%>
		<script src="https://code.jquery.com/jquery-3.0.0.js" 
			integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" 
			crossorigin="anonymous"></script>		
	</head>
	<body>
		<jsp:include page="/subviews/header.jsp" >
			<jsp:param value="產品明細" name="subtitle"/>
		</jsp:include>
		<%@ include file="/subviews/nav.jsp" %>	
		<article>
			<jsp:include page='product_data.jsp' />
		</article>
		<%@ include file="/subviews/footer.jsp" %>
	</body>
</html>
