<%@page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@include file="/WEB-INF/jsp/common/header.jsp"%>	
	<title></title>
</head>
<frameset cols="65%,*">
	<frame src="privilege/privilegeList.do" name="leftFrame" frameborder="0" scrolling="auto" style="border:1px #CCCCCC solid;padding:12px;" marginWidth=0 marginHeight=0 >
	<frame src="privilege/privilegeDetailList.do" name="rightFrame" frameborder="0" scrolling="auto" style="border:1px #CCCCCC solid;padding:12px;" marginWidth=0 marginHeight=0 >
</frameset>
</html>