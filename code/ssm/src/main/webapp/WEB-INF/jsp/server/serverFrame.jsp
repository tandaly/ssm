<%@page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@include file="/WEB-INF/jsp/common/header.jsp"%>	
	<title></title>
</head>
<body>
	<!-- 导航条 -->
	<div class="box-positon">
		<div class="rpos">当前位置: 运行监控 &gt; 服务器监控</div>
		<div class="clear"></div>
	</div>
	
	<!-- 主体 start -->
	<div style="width:100%;height:90%;">
		<iframe name="contentFrame" id="contentFrame" src="server/frame.do" style="margin:0px;" frameborder="0" width="100%" height="100%"></iframe>
	</div>
	<!-- 主体 end -->
						
</body>
</html>