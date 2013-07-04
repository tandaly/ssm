<%@ page contentType="text/html;charset=UTF-8"
	trimDirectiveWhitespaces="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/jsp/common/header.jsp"%>	
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script type="text/javascript">
	function setsitebar()
	{
		var obj = top.topFrame.document.getElementsByTagName("frameset")[1].cols;
		if(obj == "0,10,*")
		{
			top.topFrame.document.getElementsByTagName("frameset")[1].cols = "200,10,*";
			$("#sitebarimg").attr("src", "images/sbhide.gif");
		}
		else
		{
			top.topFrame.document.getElementsByTagName("frameset")[1].cols = "0,10,*";
			$("#sitebarimg").attr("src", "images/sbshow.gif");
		}
	}
</script>
</head>
<body>
	<div style="padding-top:200px">
		<a href="javascript:">
        	<img id="sitebarimg" src="images/sbhide.gif" onclick="javascript:setsitebar();">
        </a>
	</div>
	
</body>
</html>