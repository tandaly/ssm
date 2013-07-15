<%@page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@include file="/WEB-INF/jsp/common/header.jsp"%>	
	<!-- 分页插件 -->
	<script type="text/javascript" src="plugins/page/fTable.js"></script>
	
	<script type="text/javascript">
	
		$(function(){
			fTable = new FTable({
				fields: ['name','dicKey', 'value', 'remark', 'status'],
				url: 'dictionary/ajaxDictionaryList.do',
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
					if(list[i].status == '启用')
					{
						list[i].status = '<font color=green>' + list[i].status + '</font>';
					}else
					{
						list[i].status = '<font color=red>' + list[i].status + '</font>';
					}
				}
			}
			fTable.build(list);
		}
		
		function deleteDictionarys()
		{
			var ids = fTable.getCheckedValue();
			if("" == ids)
			{
				top.art.dialog.alert("请选择记录");
				return;
			}
			
			deleteDictionary(ids);
		}
		
		function deleteDictionary(ids)
		{
			top.art.dialog.confirm("你确定要删除吗?", function(){
				$.ajax({
					type:"POST",
					url:"dictionary/ajaxDeleteDictionary.do",
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
		

		//打开修改页面
		function openUpdateDictionary()
		{	
			var ids = fTable.getCheckedValue();
			if("" == ids || ids.indexOf(",") > 0)
			{
				top.art.dialog.alert("请选择一条记录!");
				return;
			}
				
			top.art.dialog.open('dictionary/updateDictionary.do?id=' + ids,
				    {id: 'updateDictionary', title: '修改字典', width:500, height:410, lock: true,
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
		
		//打开添加页面
		function openAddDictionary()
		{
			top.art.dialog.open('dictionary/addDictionary.do',
				    {id: 'addDictionary', title: '添加字典', width:500, height:400, lock: true,
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
	</script>
</head>
<body>
	<div class="mainContent">
		<!-- 导航条 -->
		<div class="box-positon">
			<div class="rpos">当前位置: 基础数据维护 &gt; 字典维护 &gt; 列表</div>
			<div class="clear"></div>
		</div>
		<div class="form">
			<form id="queryForm" name="queryForm" onsubmit="return fTable.queryForm();">
				<span class="input-line">
					<span class="input-label">名称</span>
					<input name="name" class="input-text"/> 
				</span>
				<input value="查询" type="submit" class="button_highlight"/>
			</form>
		</div>
		<div>
			<div class="toolGroup">
				<input type="button" value="新增" onclick="openAddDictionary();"/>
				<input type="button" value="修改" onclick="openUpdateDictionary()"/>
				<input  type="button" value="删除" onclick="deleteDictionarys()"/>
				<input  type="button" value="启用" onclick=""/>
				<input  type="button" value="禁用" onclick=""/>
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
							键
						</th>
						<th>
							值
						</th>
						<th>
							描述
						</th>
						<th>
							状态
						</th>
					</tr>
				</table>
			</div>
			<div id="fPage"></div>
		</div>
	</div>
</body>
</html>