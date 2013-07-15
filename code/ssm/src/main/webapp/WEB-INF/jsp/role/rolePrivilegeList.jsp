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
				fields: ['privilegeName','remark'],
				url: 'role/ajaxRolePrivilegeList.do'
			});
		});
		
		//打开权限选择框
		function openSelectRolePrivilege()
		{
			top.art.dialog.open('role/selectPrivilegeList.do?id=${role.id}',
				    {id: 'selectPrivilege', title: '权限列表', width:600, height:500, lock: false,
					 okVal: '分配',
					 ok: function () {
				    	var iframe = this.iframe.contentWindow;
				    	if (!iframe.document.body) {
				        	return false;
				        };
				        iframe.$("#submit").click();
				       	return false;
					 },
					 cancel:true
					 
				    });
		}
		
		function deleteRolePrivilege()
		{
			var ids = fTable.getCheckedValue();
			if("" == ids)
			{
				top.art.dialog.alert("请选择记录");
				return;
			}
			
			top.art.dialog.confirm("你确定要删除吗?", function(){
				$.ajax({
					type:"POST",
					url:"role/ajaxDeleteRolePrivilege.do?roleId=${role.id}",
					data:{"privilegeIds":ids},
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
<body >
		<div class="form">
			<form id="queryForm" name="queryForm" onsubmit="return fTable.queryForm();">
				<input type="hidden" name="roleId" value="${role.id}"/>
				<span class="input-line">	
					<span class="input-label">权限名称</span>
					<input name="privilegeName" id="privilegeName" class="input-text"/> 
				</span>
				<input value="查询" type="submit" class="button_highlight"/>
			</form>
		</div>
		<div>
			<div class="toolGroup">
				<input type="button" class="button" value="添加权限" onclick="openSelectRolePrivilege();"/>
				<input type="button" class="button" value="删除权限" onclick="deleteRolePrivilege();"/>
			</div>
			<div class="fTableContent">
				<table id="fTable" class="fTable" cellpadding="0" cellspacing="0">
					<tr>
						<th></th>
						<th>
							<input type="checkbox"/>
						</th>
						<th width="200px">
							权限名称
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