<%@page import="plants.entity.Customer"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String prevURI = (String)request.getAttribute("prevURI");
	if(prevURI==null || prevURI.length()==0) {
		prevURI="./";
	}else{
		String prevQueryString = (String)request.getAttribute("prevQueryString");
		if(prevQueryString!=null) prevURI+="?"+prevQueryString;
	}
	System.out.printf(prevURI);
%>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta charset="UTF-8">
	<title>登入成功</title>
	<link rel="stylesheet" href="css/vgb.css">
	<meta http-equiv="refresh" 
		content="5;url=<%=prevURI%>">
	<style>
/* 		body{color:blue}	 */
	</style>	
</head>
<body>
		<jsp:include page="/subviews/header.jsp" >
			<jsp:param value="會員登入成功" name="subtitle"/>
		</jsp:include>			
	<% 		
		Customer member = (Customer)session.getAttribute("member");
		String msg = (String)request.getAttribute("msg");
		if(msg==null)msg="登入";
	%>
	<article>		
		<h2><%= member==null?"尚未"+msg:member.getName() %> <%= msg!=null?msg:"" %>成功</h2>
		<p><span id='secCounter'>5</span>秒後將自動跳轉<a href='<%= prevURI %>'>指定網頁或首頁</a></p>
	</article>	 
	<%@ include file="/subviews/footer.jsp" %>
	
</body>
</html>