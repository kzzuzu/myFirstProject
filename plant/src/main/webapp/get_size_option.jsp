<%@page import="plants.service.ProductService"%>
<%@page import="plants.entity.Size"%>
<%@page import="java.util.List"%>
<%@ page pageEncoding="UTF-8" %>
<%
	String productId=request.getParameter("productId");
    String colorName=request.getParameter("colorName");
	List<Size> list = null;
	
    if(productId!=null && colorName!=null){
    	ProductService service = new ProductService();
    	list = service.getProductSizeList(productId, colorName);
    }
    
%>
<option value=''>請選擇Size</option>
<%	
	if(list!=null && list.size()>0){
%>
	<% for(Size size:list){%>
	<option value='<%=size.getSizeName() %>' data-stock='<%= size.getStock() %>' 
					data-listprice='<%= size.getListPrice() %>' 
					data-price='<%= size.getPrice()%>'><%=size.getSizeName() %></option>
	<% } %>
<%}%>

	