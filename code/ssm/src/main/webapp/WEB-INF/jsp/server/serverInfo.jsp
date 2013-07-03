<%@page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@include file="/WEB-INF/jsp/common/header.jsp"%>	
<link href="plugins/page/page.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="plugins/page/page.js"></script>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-color: #EEF2FB;
}
-->
</style>
<script type="text/javascript">
	$(function(){
		var list = [];
		list.push({name:"<font color=green>操作系统</font>", value:"${osSystem}"});
		list.push({name:"<font color=green>主机IP</font>", value:"${serverIP}"});
		list.push({name:"<font color=green>应用服务器信息</font>", value:"${appServer }"});
		list.push({name:"<font color=green>监听端口</font>", value:"${serverPort }"});
		list.push({name:"<font color=green>WEB根路径</font>", value: formatStr("${webPath }", 40)});
		list.push({name:"<font color=green>servlet版本</font>", value:"${servletVersion}"});
		list.push({name:"<font color=green>JVM版本</font>", value:"${jvmVersion }"});
		list.push({name:"<font color=green>JVM提供商</font>", value:"${jvmVendor }"});
		list.push({name:"<font color=green>JVM安装路径</font>", value:formatStr("${JVMHome }", 40)});
		list.push({name:"<font color=green>主机物理内存</font>", value:"${serverSwapSpace }"});
		list.push({name:"<font color=green>JVM可用最大内存</font>", value:"${jvmMaxMemory }"});
		
		buildTable('datatable',list,['name', 'value'],false,null,null,true);
	});
	
	function formatStr(str, limit)
	{
		var result = "";
		if(limit < str.length)
		{
			for(var i = 0; i < str.length/limit; i++)
			{
				result += str.substring(i * limit, (i+1) * limit) + "\n";
			}
			
		}
		else
		{
			result = str;
		}
		return result;
	}
</script>
</head>
<body>
	<table width="100%" border="1" cellpadding="0" cellspacing="0"
		class="content-right-column-tb" id="datatable" >
		<tr style="background-color: #a9c4e8;" class="content-right-column-tb-topbg">
			<th></th>
			<th width="120px">
				名称
			</th>
			<th>
				值
			</th>
		</tr>
	</table>
		<%-- <div>
			操作系统：${osSystem}	<br/>
			主机IP：${serverIP}	<br/>
			应用服务器信息: ${appServer } <br/>
			监听端口：${serverPort } <br/>
			WEB根路径:${webPath }<br/>
			servlet版本:${servletVersion }<br/>
			JVM版本:${jvmVersion } <br/>
			JVM提供商：${jvmVendor } <br/>
			JVM安装路径：${JVMHome }<br/>
			主机物理内存：${serverSwapSpace } <br/>
			JVM可用最大内存：${jvmMaxMemory } <br/>
			
			caption:${caption }
		</div> --%>
						
						

</body>
</html>