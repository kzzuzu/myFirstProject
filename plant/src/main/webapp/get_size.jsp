<%@ page pageEncoding="UTF-8"%>
<%
	String productId = request.getParameter("productId");
	String colorName = request.getParameter("color");
	
%>
<span style='display:none'><%= productId%>, <%= colorName%></span>
<%if("白".equals(colorName)) {%>
<input type='radio' value='S' name='size' required data-list-price='10' data-unit-price='8' data-stock='5'>
<label>S</label>

<input type='radio' value='M' name='size' required  data-list-price='15' data-unit-price='12' data-stock='8'>
<label>M</label>

<input type='radio' value='L' name='size' required data-list-price='40' data-unit-price='32' data-stock='3'>
<label>L</label>
<%}else{ %>
<input type='radio' value='S' name='size' required data-list-price='15' data-unit-price='12' data-stock='12'>
<label>S</label>

<input type='radio' value='M' name='size' required data-list-price='20' data-unit-price='16' data-stock='8'>
<label>M</label>
<% } %>