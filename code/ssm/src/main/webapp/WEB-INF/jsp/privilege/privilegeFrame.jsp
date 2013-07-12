<%@page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@include file="/WEB-INF/jsp/common/header.jsp"%>	
</head>
<body>
	<!-- 导航条 -->
	<div class="box-positon">
		<div class="rpos">当前位置: 权限中心 &gt; 权限管理 &gt; 列表</div>
		<div class="clear"></div>
	</div>
	
	<!-- 主体 start -->
	<div style="width:100%;height:92%;">
		<iframe name="contentFrame" id="contentFrame" src="privilege/frame.do" style="margin:0px;" frameborder="0" width="100%" height="100%"></iframe>
	</div>
	<!-- 主体 end -->
</body>
</html>