<%@page import="plants.entity.ShoppingCart"%>
<%@ page pageEncoding="UTF-8" contentType="application/json"%>
<%
	ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
%>
{
	"cartItems":[	
					{"name" : "三角洞洞色鉛筆",
					 "color" : "紅",
					 "size" : "S",
					 "qty" : 2}
	            ] 
    ,"totalQty" : ${sessionScope.cart.getTotalQuantity()}
}
