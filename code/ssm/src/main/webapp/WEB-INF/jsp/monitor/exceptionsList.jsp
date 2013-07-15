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
				fields: ['activeTime', 'className', 'methodName', 'description', 'options'],
				url: 'monitor/ajaxExceptionsList.do',
				callback:callback
			});
		});
		
		function callback(data)
		{
			var list = data.list;
			if(list)
			{
				for(var i = 0; i < list.length; i++)
				{
					list[i].description = "<font color=red>" + cutFormatStr(list[i].description, 50) +"</font>";
					list[i].options = '<a href="javascript:openDetailExceptions('+list[i].id+')">详情</a>';
				}
			}
			fTable.build(list);
		}
		/* 
		function formatStr(str, limit)
		{
			var result = "";
			if(limit < str.length)
			{
				result += str.substring(0, limit) + "...";
			}
			else
			{
				result = str;
			}
			return result;
		} */
		
		//打开详情页面
		function openDetailExceptions(id)
		{	
			top.art.dialog.open('${base}monitor/detailExceptions.do?id=' + id,
				    {id: 'detailDialog', title: '查看异常', width:'100%', height:'100%', lock: true,
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
					url:"monitor/ajaxDeleteExceptions.do",
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
		
		//清空异常日志
		function clearExceptions()
		{
			top.art.dialog.confirm("一旦清空，所有的记录不可恢复，请谨慎操作", function(){
				if(confirm("再次确认你要清空异常日志吗?"))
				{
					$.ajax({
						type:"POST",
						url:"monitor/ajaxClearExceptions.do",
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
	<div class="mainContent">
		<!-- 导航条 -->
		<div class="box-positon">
			<div class="rpos">当前位置: 运行监控 &gt; 异常监控 &gt; 列表</div>
			<div class="clear"></div>
		</div>
		<div class="form">
			<form id="queryForm" name="queryForm" onsubmit="return fTable.queryForm();">
				<span class="input-line">
					<span class="input-label">类名</span>
					<input name="className" class="input-text"/> 
				</span>
				<input value="查询" type="submit" class="button_highlight"/>
			</form>
		</div>
		<div>
			<div class="toolGroup">
				<input  type="button" value="删除" onclick="deleteRows()"/>
				<input  type="button" value="清空" onclick="clearExceptions()"/>
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
							类名
						</th>
						<th>
							方法
						</th>
						<th>
							描述
						</th>
						<th width="50px">
							操作
						</th>
					</tr>
				</table>
			</div>
			<div id="fPage"></div>
		</div>
	</div>
</body>
</html>