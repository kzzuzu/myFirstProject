<!--<%@ page pageEncoding="UTF-8"%>-->
<!DOCTYPE html>
<%@page import="plants.entity.Customer"%>
<html>
	<head>
		<meta charset="UTF-8">
		<title>註冊成功</title>
		<link rel="stylesheet" href="css/vgb.css">
		<meta http-equiv="refresh" content="5; url=./">
		
	</head>
	
	<body>
		<div style="margin-left: 1360px;">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<style type="text/css">
		
		body{margin: 0px;}
				.testdiv{
				background:#f3e5d8;
				height: 120px;
				width: 100%;
				}
			li{
				float: left;
				margin: 5px 0px;
				padding: 5px 10px;
				border-left: 1px solid white;
				}
			.lastLi{
				border-right: 10px;
				border-right: 1px solid white;
				}
				a{text-decoration: underline;}
				a:link{color: white;}
				a:visited{color: white;}
				a:hover{color: cyan;}
				a:active{color: yellow;}
			ul{
				margin: 0px;
				list-style:none;
				}
		</style>
		</div>
		
		<div style="margin-left: 0px;" class="testdiv">
		<div class="home page"> <a href="PlantsIndex.jsp"><img
				style="border: 0px solid ; width: 64px; height: 64px;" alt=""
				src="https://cdn3.iconfinder.com/data/icons/nature-emoji/50/Plants-64.png"> </a><big><big><big><big>蕨蘱</big></big></big></big>
		<ul>
			<%@ include file = "subviews/nav.jsp" %>
		</ul>
		
		</div>
		</div>
		
		
		<article>	
					<% 
					String msg = (String)request.getAttribute("msg");
					%>
					<h2><%= member==null?"尚未註冊":member.getName() %> <%= msg!=null?msg:"" %>成功</h2>
					<p>5秒後將自動跳轉<a href='PlantsIndex.jsp'>首頁</a></p>
		</article>
			<%@ include file="subviews/footer.jsp" %>
	</body>
</html>