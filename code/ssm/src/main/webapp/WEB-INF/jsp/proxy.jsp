<%@page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>代理页面(外链地址 解决ie的跨域问题)</title>
	<style type="text/css">
		<!--
		html, body {
			height:100%;
		}
		-->
	</style>
</head>
<body style="overflow: hidden;">
	<!-- 主体 start -->
	<div style="width: 100%;height:100%">
		<iframe name="contentFrame" id="contentFrame" src="${url}"
			style="margin: 0px;" frameborder="0" width="100%" height="100%"></iframe>
	</div> 
	<!-- 主体 end -->
</body>
</html>