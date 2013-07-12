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
				isCheckbox: false,
				fields: ['columnName', 'tableName', 'columnType', 'columnLength'],
				url: 'db/ajaxTableColumnList.do?tableName=${tableName}',
				callback: callback
			});
		});
		
		function callback(data)
		{
			fTable.build(data);
		}
	</script>
</head>
<body>
	<div class="mainContent">
		<!-- 导航条 -->
		<div class="box-positon">
			<div class="rpos">当前位置: 数据库管理 &gt; 数据表 &gt; 字段列表 &gt;  列表</div>
			<div class="clear"></div>
		</div>
		
		<div>
			<div class="fTableContent">
				<table id="fTable" cellpadding="0" cellspacing="0" class="fTable">
					<tr>
						<th></th>
						<th>
							字段名称
						</th>
						<th>
							所属表
						</th>
						<th>
							字段类型
						</th>
						<th>
							字段长度
						</th>
					</tr>
				</table>
			</div>
		</div>
	</div>
</body>
</html>