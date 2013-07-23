<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base
	href="${pageContext.request.scheme}${'://'}${pageContext.request.serverName}${':'}${pageContext.request.serverPort}${pageContext.request.contextPath}/" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	setTimeout(function(){
		top.location.href="j_spring_security_logout";
	},1000);
</script>
</head>
<body>
	<%
		//session.setMaxInactiveInterval(300); //参数单位是秒，即在没有活动5分钟后，session将失效。 
	%>
	<h1>
		spring-security:页面超时了哟！！！
	</h1>
</body>
</html>