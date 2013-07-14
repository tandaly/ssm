<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
 var temp="<%=session.getAttribute("CheckCode")%>"
function reload()
{

var x=Math.random()*(1,10000);

document.form1.myImage.src="Image/first.jpg?"+x;
temp="<%=session.getAttribute("CheckCode")%>"

}



</script>
<%
	String basePath = request.getContextPath();
	//System.out.println(basePath);
%>
</head>
<body>
	<form action="" name="form1">
		验证码：<input type="text" name="checkContent"> <img
			src="Image/first.jpg" title="点击刷新" onclick="reload()" name="myImage"><a
			href="#" onclick="reload()">看不清，换一张</a>
		<div id="di"></div>
		<br />

	</form>
</body>
</html>