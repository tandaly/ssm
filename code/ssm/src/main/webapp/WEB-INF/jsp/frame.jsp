<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>框架页</title>
<meta http-equiv=Content-Type content=text/html;charset=utf-8>
</head>
<frameset rows="108,*" frameborder="no" border="0" framespacing="0" style="background-color: #EEF2FB;">
	<frame src="top.do" noresize="noresize" frameborder="0" name="topFrame"
		scrolling="no" marginwidth="0" marginheight="0" target="main" />
	<frameset cols="200,10,*" id="contentFrameset" framespacing="0">
		<frame src="left.do" name="leftFrame" noresize="noresize"
			marginwidth="0" marginheight="0" frameborder="0" scrolling="yes"
			target="main" />
		<frame src="changeScreen.do" name="changeFrame" noresize="noresize"
			marginwidth="0" marginheight="0" frameborder="0" scrolling="no" />
		<frame src="main.do" name="main" marginwidth="0" marginheight="0"
			frameborder="0" scrolling="auto" target="_self" />
	</frameset>
</frameset>
<noframes>
	<body></body>
</noframes>
</html>