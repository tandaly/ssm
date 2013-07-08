<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<%
		session.setMaxInactiveInterval(300); //参数单位是秒，即在没有活动5分钟后，session将失效。 
	%>
	<jsp:forward page="login.do"></jsp:forward>
</body>
</html>