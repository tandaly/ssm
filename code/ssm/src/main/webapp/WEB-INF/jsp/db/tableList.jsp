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
				//isCheckbox: false,
				pageSize: 15,
				fields: ['tableSchema',  'tableName', 'tableRows', 'dataLength', 'tableType', 'autoIncrement', 'createTime', 'tableComment'],
				url: 'db/ajaxTableList.do',
				callback: callback
			});
		});
		
		function callback(data)
		{
			var list = data.list;
			if(list)
			{
				for(var i = 0; i < list.length; i++)
				{
					list[i].tableName = '<a href="javascript:openTableColumnList(\''+list[i].tableName+'\');">'+list[i].tableName+'</a>'; 
				}
			}
			fTable.build(list);
		}
		
		//打开表字段列表信息
		function openTableColumnList(tableName)
		{
			top.art.dialog.open('db/tableColumnList.do?tableName=' + tableName,
				    {id: 'openDialog', title: '表['+tableName+']字段列表', width:'100%', height:'100%', 
					 lock: true
				    });
		}
		
		//备份表
		function bakTables()
		{
			var ids = fTable.getCheckedValue();
			if("" == ids)
			{
				top.art.dialog.alert("请选择记录");
				return;
			}
			
			top.art.dialog.alert(ids);
		}
	</script>
</head>
<body>
	<div class="mainContent">
		<!-- 导航条 -->
		<div class="box-positon">
			<div class="rpos">当前位置: 数据库管理 &gt; 数据表 &gt; 列表</div>
			<div class="clear"></div>
		</div>
		<div class="form">
			<form id="queryForm" name="queryForm" onsubmit="return fTable.queryForm();">
				<span class="input-line">
					<span class="input-label">库名</span>
					<input type="text" name="tableSchema" class="input-text" value="share"/> 
				</span>
				
				<input value="查询" type="submit" class="button_highlight"/>
			</form>
		</div>
		<div>
			<div class="toolGroup">
				<input type="button" value="备份" onclick="bakTables();" class="button"/>
			</div>
			<div class="fTableContent">
				<table id="fTable" cellpadding="0" cellspacing="0" class="fTable">
					<tr>
						<th></th>
						<th>
							<input type="checkbox"/>
						</th>
						<th>
							库名
						</th>
						<th>
							名称
						</th>
						<th>
							记录数
						</th>
						<th>
							大小
						</th>
						<th>
							类型
						</th>
						<th>
							自动增长值(当前)
						</th>
						<th>
							创建时间
						</th>
						<th>
							描述
						</th>
					</tr>
				</table>
			</div>
			<div id="fPage"></div>
		</div>
	</div>
</body>
</html>