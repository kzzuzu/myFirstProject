<%@page import="plants.service.ProductService"%>
<%@page import="plants.entity.Size"%>
<%@page import="java.util.List"%>
<%@ page pageEncoding="UTF-8" contentType="application/json"%>
<%
	String productId=request.getParameter("productId");
    String colorName=request.getParameter("colorName");
	List<Size> list = null;
	
    if(productId!=null && colorName!=null){
    	ProductService service = new ProductService();
    	list = service.getProductSizeList(productId, colorName);
    }
    
%>  
[   
<%	if(list!=null && list.size()>0){%> 
	<% for(int i=0;i<list.size();i++){
		Size size = list.get(i);
	%>
	{"sizeName":"<%= size.getSizeName() %>",
	 "stock":<%= size.getStock() %>,
	 "listPrice":<%= size.getListPrice() %>,
	 "price":<%= size.getPrice() %>}<%=i<(list.size()-1)?",":"" %>	
	<% } %>
<%} %>
]