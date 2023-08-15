<%@page import="plants.entity.Outlet"%>
<%@page import="plants.service.ProductService"%>
<%@page import="plants.entity.Product"%>
<%@page import="java.util.List"%>
<%@page pageEncoding="UTF-8"%>
<% //request.setCharacterEncoding("UTF-8"); //用Filter來統一設定編碼%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>產品清單</title>
		<link rel="stylesheet" href="css/vgb.css">
		<style>
			#categoryDiv{margin: 10px}
		
			#productList{width:95%;max-width: 78em;min-width: 280px;margin: auto;}
			.productItem{display:inline-block;width:15em;height:260px;vertical-align: top;box-shadow: 1px 1px 2px lightgray;margin: 3px 1px}
			.productItem img{width:120px;display: block;margin: auto}
			.productItem h4, .productItem div{text-align: center;} 
		</style>
		<link rel='stylesheet' type='text/css' href='./fancybox3/jquery.fancybox.css'>
		<script src="https://code.jquery.com/jquery-3.0.0.js" 
			integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" 
			crossorigin="anonymous"></script>
		<script src='./fancybox3/jquery.fancybox.js'></script>
		<script>
			function getByCaegory(category){
				location.href='?category=' + encodeURI(category); 
			}
			
			function getProductData(pid){
				//alert('Hello, pid:' + pid); //for test
				//同步GET請求
				//location.href="product_detail.jsp?productId="+pid;
				
				//ajax送非同步GET請求
				$.ajax({
					url:"product_ajax.jsp?productId="+pid,
					method: 'GET'					
				}).done(getProductDataDoneHandler);
			}
			
			function getProductDataDoneHandler(result, txtStatus, xhr){
				//console.log(result); //for test
				//用fancybox來顯示
				$("#fancyDialog").html(result);
				$.fancybox.open({
				    src  : '#fancyDialog',
					'width':720,
                    'height':560,
				    type : 'inline',
				    opts : {
				      afterShow : function( instance, current ) {
				        console.info('done!');
			          }
			        }
			    });
			}
		</script>
	</head>
	<body>
		<jsp:include page="/subviews/header.jsp" >
			<jsp:param value="逛書店" name="subtitle"/>
		</jsp:include>
		<%@ include file="/subviews/nav.jsp" %>	
		<%
			//1.取得request中的form data
			String keyword = request.getParameter("keyword");
			String category = request.getParameter("category");
			List<Product> list;
		
			//2.呼叫商業邏輯
			ProductService service = new ProductService();			
			if(keyword!=null && keyword.length()>0){
				if(category!=null && category.length()>0){
					list = service.getProductsByKeywordAndCategory(keyword, category);
				}else{
				list = service.getProductsByKeyword(keyword);
				}
			}else if(category!=null && category.length()>0){
				list = service.getProductsByCategory(category);
			}else list = service.getAllProducts();			
			
			//3.產生回應
		%>		
		<article>
			<div id='categoryDiv' style='margin-top:20px; width:100px;'>
				<a href='javascript:getByCaegory("鹿角蕨")'>鹿角蕨</a><br>
				<a href='javascript:getByCaegory("龍舌蘭")'>龍舌蘭</a><br>
				<a href='javascript:getByCaegory("塊根植物")'>塊根植物</a><br>
				<a href='javascript:getByCaegory("多肉植物")'>多肉植物</a><br>
				<a href='javascript:getByCaegory("資材")'>資材</a><br>
				<a href='?'>全部</a>
			</div>
					
			<% if(list==null || list.size()==0){ %>
				<p>查無產品資料</p>
			<%}else{ %>
			<div id='productList' style='margin-top: 20px'>
				<% for(int i=0;i<list.size();i++) {
					Product p = list.get(i);
				%>
				<div class='productItem'>
					<a href='javascript:getProductData(<%= p.getId()%>)'>
						<img src='<%= p.getPhotoUrl() %>'>
					</a>
					<a href='products_detail.jsp?productId=<%= p.getId()%>'>
						<h4><%= p.getName() %>(<%= p.getStock() %>)</h4>
					</a>
					<div> 優惠價: 
						<% if(p instanceof Outlet){ %>
						<%= ((Outlet)p).getDiscountString()%>
						<% } %> 
						<%= p.getUnitPrice() %>元
					</div>					
				</div>
				<% }%>				
			</div>
			<% } %>
						
		</article>
		<div id='fancyDialog'></div>
		<%@ include file="/subviews/footer.jsp" %>
	</body>
</html>