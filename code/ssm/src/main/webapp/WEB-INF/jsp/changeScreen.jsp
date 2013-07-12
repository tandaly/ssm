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
		var topObject = top.topFrame.document.getElementsByTagName("frameset")[0].rows;
		if(topObject == "0,*")
		{
			top.topFrame.document.getElementsByTagName("frameset")[0].rows = "90,*";
		}
		
		var obj = top.topFrame.document.getElementsByTagName("frameset")[1].cols;
		if(obj == "0,10,*")
		{
			top.topFrame.document.getElementsByTagName("frameset")[1].cols = "190,10,*";
			$("#sitebarimg").attr("src", "images/sbhide.gif");
		}
		else
		{
			top.topFrame.document.getElementsByTagName("frameset")[1].cols = "0,10,*";
			$("#sitebarimg").attr("src", "images/sbshow.gif");
		}
	}
</script>
<style type="text/css">
	#sitebarimg {
		position: absolute;
		cursor: pointer;
		overflow: hidden;
		z-index: 1210;
	}
</style>
</head>
<body>
	<div style="padding-top:200px">
        <img id="sitebarimg" src="images/sbhide.gif" onclick="javascript:setsitebar();">
	</div>
	
</body>
</html>