<%@page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@include file="/WEB-INF/jsp/common/header.jsp"%>	
	<!--表格插件 -->
	<script type="text/javascript" src="plugins/page/fTable.js"></script>
	<style type="text/css">
		.tb_list_ed_txt {
			border: 0px;
			height: 30px;
			width:220px;
			background-color: transparent; //背景色透明
		}
	</style>
	<script type="text/javascript">
	$(function(){
		var list = [];
		list.push({name:"<font color=green>操作系统</font>", value: "<input type='text' class='tb_list_ed_txt' value='${osSystem}' title='' />"});
		list.push({name:"<font color=green>主机IP</font>", value:"<input type='text' value='${serverIP}' title='${serverIP}' class='tb_list_ed_txt'/>"});
		list.push({name:"<font color=green>应用服务器信息</font>", value:"<input type='text' value='${appServer }' title='${appServer }' class='tb_list_ed_txt'/>"});
		list.push({name:"<font color=green>监听端口</font>", value:"<input type='text' value='${serverPort }' title='${serverPort }' class='tb_list_ed_txt'/>"});
//		list.push({name:"<font color=green>WEB根路径</font>", value: formatStr("${webPath }", 40)});
		list.push({name:"<font color=green>WEB根路径</font>", value: "<input type='text' value='${webPath }' title='${webPath }' class='tb_list_ed_txt'/>"});
		list.push({name:"<font color=green>servlet版本</font>", value:"<input type='text' value='${servletVersion}' title='${servletVersion}' class='tb_list_ed_txt'/>"});
		list.push({name:"<font color=green>JVM版本</font>", value:"<input type='text' value='${jvmVersion }' title='${jvmVersion }' class='tb_list_ed_txt'/>"});
		list.push({name:"<font color=green>JVM提供商</font>", value:"<input type='text' value='${jvmVendor }' title='${jvmVendor }' class='tb_list_ed_txt'/>"});
		list.push({name:"<font color=green>JVM安装路径</font>", value:"<input type='text' value='${JVMHome }' title='${JVMHome }' class='tb_list_ed_txt'/>"});
		list.push({name:"<font color=green>主机物理内存</font>", value:"<input type='text' value='${serverSwapSpace }' title='${serverSwapSpace }' class='tb_list_ed_txt'/>"});
		list.push({name:"<font color=green>JVM可用最大内存</font>", value:"<input type='text' value='${jvmMaxMemory }' title='${jvmMaxMemory }' class='tb_list_ed_txt'/>"});
		
		//buildTable('datatable',list,['name', 'value'],false,null,null,true);
		
		fTable = new FTable({
			//skin: 'skin2',
			trHeight: '40px',
			isPage: false,
			isCheckbox: false,
			isBuild: false,
			fields: ['name', 'value']
		});
		fTable.build(list);
	});
	
	function formatStr(str, limit)
	{
		return str;
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
<body style="height:90%;">
	<table id="fTable" class="fTable" cellpadding="0" cellspacing="0">
		<tr>
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