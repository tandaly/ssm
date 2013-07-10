<%@page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@include file="/WEB-INF/jsp/common/header.jsp"%>	
	<!-- 表格插件 -->
	<script type="text/javascript" src="plugins/page/fTable.js"></script>
	
	<script type="text/javascript">
	
		$(function(){
			fTable = new FTable({
				fields: ['activeTime', 'userName', 'costTime', 'description', 'requestPath', 'methodName'],
				url: 'monitor/ajaxEventList.do'
			});
		});
		
		function deleteRows()
		{
			var ids = fTable.getCheckedValue();
			if("" == ids)
			{
				top.art.dialog.alert("请选择记录");
				return;
			}
			
			deleteRow(ids);
		}
		
		function deleteRow(ids)
		{
			top.art.dialog.confirm("你确定要删除吗?", function(){
				$.ajax({
					type:"POST",
					url:"monitor/ajaxDeleteEvent.do",
					data:{"ids":ids},
					success:function(data)
					{
						if("y" != data.status)
						{
							top.art.dialog.alert(data.info);
						}else
						{
							top.art.dialog.alert(data.info);
							fTable.queryForm();
						}
					},
					error:function()
					{
						top.art.dialog.alert("操作失败");
					}
				});
			});
		}
		
		function clearEvent()
		{
			top.art.dialog.confirm("一旦清空，所有的记录不可恢复，请谨慎操作", function(){
				if(confirm("再次确认你要清空事件日志吗?"))
				{
					$.ajax({
						type:"POST",
						url:"monitor/ajaxClearEvent.do",
						success:function(data)
						{
							if("y" != data.status)
							{
								top.art.dialog.alert(data.info);
							}else
							{
								top.art.dialog.alert(data.info);
								fTable.queryForm();
							}
						},
						error:function()
						{
							top.art.dialog.alert("操作失败");
						}
					});
				}
			});
		}
		

	</script>
</head>
<body>
	<div style="text-align: center;">
		<form id="queryForm" name="queryForm" onsubmit="return fTable.queryForm();">
			<input type="hidden" name="pageSize" value="15"/>
			用户名：<input name="userName" /> 
			&nbsp;
			<input value="查询" type="submit" class="button_highlight"/>
		</form>
	</div>
	<div>
		<div class="toolGroup">
			<input  type="button" value="删除" onclick="deleteRows()"/>
			<input  type="button" value="清空" onclick="clearEvent()"/>
		</div>
		<div class="fTableContent">
			<table id="fTable" class="fTable" cellpadding="0" cellspacing="0">
				<tr>
					<th></th>
					<th>
						<input type="checkbox"/>
					</th>
					<th width="120px">
						激活时间
					</th>
					<th>
						用户名
					</th>
					<th>
						耗时(毫秒)
					</th>
					<th>
						描述
					</th>
					<th>
						请求路径
					</th>
					<th>
						请求方法
					</th>
				</tr>
			</table>
		</div>
		<div id="fPage"></div>
	</div>

</body>
</html>