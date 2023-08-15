<%@page import="plants.entity.Customer"%>
<%@page import="plants.service.CustomerService"%>
<%@ page pageEncoding="UTF-8" contentType="application/json"%>
<%
	String id = request.getParameter("id"); 
	String email = request.getParameter("email");
	
	CustomerService cService = new CustomerService();
	
	boolean isCorrect = true;
	boolean isDuplicate = true;
	String attrName = "id";
	
	if(id!=null && id.length()==10){
		isDuplicate = cService.isDuplicateId(id);
		if(!isDuplicate){
			isCorrect = Customer.checkId(id);
		}
	}else if(email!=null && email.length()>0){
		attrName = "email";
		isDuplicate = cService.isDuplicateEmail(email);
		if(!isDuplicate){
			isCorrect = Customer.checkEmail(email);
		}
	}

%>
{
	"attrName" : "<%= attrName %>",
	"isDuplicate" : <%= isDuplicate %>,
	"isCorrect" : <%= isCorrect %>
} 