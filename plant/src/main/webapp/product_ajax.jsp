<%@ page pageEncoding="UTF-8"%>		
	<!-- product_ajax.jsp start -->
		<div style='font-size: smaller'>
		<jsp:include page="/subviews/header.jsp" >
			<jsp:param value="產品明細" name="subtitle"/>
		</jsp:include>
		<div>
			<a href='<%= request.getContextPath() %>/member/cart.jsp' style='float:right'>
				<img class='cartPng' src='<%= request.getContextPath() %>/images/cart.png'>
				<span class='cartTotalQty' >
					<%-- <%= cart!=null?cart.getTotalQuantity():""%> --%>
					${sessionScope.cart.getTotalQuantity()}
				</span>
			</a>
		</div>
		<jsp:include page='product_data.jsp' />
		</div>	
	<!-- product_ajax.jsp end-->