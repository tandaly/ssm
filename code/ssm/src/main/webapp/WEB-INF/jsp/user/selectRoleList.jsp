<%@page contentType="text/html;charset=UTF-8"
	trimDirectiveWhitespaces="true"%>
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
				fields: ['roleName','remark'],
				url: 'user/ajaxSelectRoleList.do'
			});
		});
		
		//分配角色
		function allotRole()
		{
			var ids = fTable.getCheckedValue();
			if("" == ids)
			{
				top.art.dialog.alert("请选择记录");
				return;
			}
			//alert('${role.id}');
			//alert(top.art.dialog.list['rolePrivilege'].iframe.contentWindow.window.location.href);
			//alert(top.art.dialog.list['rolePrivilege'].iframe.contentWindow.document.getElementById("privilegeName").value);
			//top.art.dialog.list['rolePrivilege'].iframe.contentWindow.window.location.href = top.art.dialog.list['rolePrivilege'].iframe.contentWindow.window.location.href;
			//top.art.dialog.list['rolePrivilege'].iframe.contentWindow.$("#queryForm").submit();
			//top.art.dialog({id:"selectPrivilege"}).close();
			//return;
			$.ajax({
				type: "POST",
				url: 'user/ajaxAllotUserRole.do?userId=${user.id}',
				data: {"roleIds": ids},
				success: function(data)
				{
					if("y" == data.status)
					{
						top.art.dialog.list['userRole'].iframe.contentWindow.window.location.href = top.art.dialog.list['userRole'].iframe.contentWindow.window.location.href;
						top.art.dialog.alert(data.info);
						top.art.dialog({id:"selectRole"}).close();
					}else
					{
						top.art.dialog.alert(data.info);
					}
				},
				error: function()
				{
					top.art.dialog.alert("操作失败");
				}
			});
		}
		
	</script>
</head>
<body>
	<div class="form">
		<form id="queryForm" name="queryForm" onsubmit="return fTable.queryForm();">
			<input type="hidden" name="userId" value="${user.id}"/>
			<span class="input-line">
				<span class="input-label">角色名称</span>
				<input name="roleName" class="input-text"/> 
			</span>
			<input value="查询" type="submit" class="button_highlight"/>
		</form>
	</div>
	<div>
		<input type="hidden" id="submit" value="提交" onclick="allotRole();"/>
		<div class="fTableContent">
			<table id="fTable" cellpadding="0" cellspacing="0" class="fTable">
				<tr>
					<th></th>
					<th>
						<input type="checkbox"/>
					</th>
					<th width="200px">
						角色名称
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