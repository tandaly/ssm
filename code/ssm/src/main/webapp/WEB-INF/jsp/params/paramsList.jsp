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
				fields: ['name', 'value', 'remark'],
				url: 'params/ajaxParamsList.do'
			});
		});
		
		function deleteParams()
		{
			var ids = fTable.getCheckedValue();
			if("" == ids)
			{
				top.art.dialog.alert("请选择记录");
				return;
			}
			
			deleteParamses(ids);
		}
		
		function deleteParamses(ids)
		{
			top.art.dialog.confirm("你确定要删除吗?", function(){
				$.ajax({
					type:"POST",
					url:"params/ajaxDeleteParams.do",
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
		
		//打开添加页面
		function openAddParams()
		{
			top.art.dialog.open('params/addParams.do',
				    {id: 'addDialog', title: '添加参数', width:500, height:400, lock: true,
					 ok: function () {
				    	var iframe = this.iframe.contentWindow;
				    	if (!iframe.document.body) {
				        	return false;
				        };
				        iframe.$("#submit").click();
				       	return false;
					 },
					 button:[{
						    name: '关闭',
						    callback: function() {
						    	return true;
						    }
						}]
					 
				    });
		}
		

		//打开修改页面
		function openUpdateParams()
		{	
			var ids = fTable.getCheckedValue();
			if("" == ids || ids.indexOf(",") > 0)
			{
				top.art.dialog.alert("请选择一条记录!");
				return;
			}
				
			top.art.dialog.open('params/updateParams.do?id=' + ids,
				    {id: 'updateDialog', title: '修改参数', width:500, height:400, lock: true,
					 ok: function () {
				    	var iframe = this.iframe.contentWindow;
				    	if (!iframe.document.body) {
				        	return false;
				        };
				        iframe.$("#submit").click();
				       	return false;
					 },
					 button:[{
						    name: '关闭',
						    callback: function() {
						    	return true;
						    }
						}]
					 
				    });
		}
		
		//内存同步参数
		function synMemoryParams()
		{
			top.art.dialog.confirm("你确定要同步内存参数吗?", function(){
				$.ajax({
					type:"POST",
					url:"params/synMemoryParams.do",
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
	</script>
</head>
<body>
	<div style="text-align: center;">
		<form id="queryForm" name="queryForm" onsubmit="return fTable.queryForm();">
			名称：<input name="name" /> 
			&nbsp;
			<input value="查询" type="submit" class="button_highlight"/>
		</form>
	</div>
	<div>
		<div class="toolGroup">
			<input type="button" value="新增" onclick="openAddParams();"/>
			<input type="button" value="修改" onclick="openUpdateParams()"/>
			<input  type="button" value="删除" onclick="deleteParams()"/>
			<input type="button" value="内存同步" onclick="synMemoryParams()"/>
			<font color=red size=2>提示:维护参数后必须执行内存同步</font>
		</div>
		<div class="fTableContent">
			<table id="fTable" class="fTable" cellpadding="0" cellspacing="0">
				<tr>
					<th></th>
					<th>
						<input type="checkbox"/>
					</th>
					<th>
						名称
					</th>
					<th>
						值
					</th>
					<th>
						描述
					</th>
				</tr>
			</table>
		</div>
		<div id="fPage"></div>
	</div>

</body>
</html>