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
				fields: ['roleName','remark'],
				url: 'role/ajaxRoleList.do'
			});
		});
		
		function deleteRoles()
		{
			var ids = fTable.getCheckedValue();
			if("" == ids)
			{
				top.art.dialog.alert("请选择记录");
				return;
			}
			
			deleteRole(ids);
		}
		
		function deleteRole(ids)
		{
			top.art.dialog.confirm("删除角色的同时会删除关联的权限和用户关系，你确定要删除吗?", function(){
				$.ajax({
					type:"POST",
					url:"role/ajaxDeleteRole.do",
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
						top.art.dialog.alert("连接服务器失败");
					}
				});
			});
		}
		

		//打开修改角色页面
		function openUpdateRole()
		{	
			var ids = fTable.getCheckedValue();
			if("" == ids || ids.indexOf(",") > 0)
			{
				top.art.dialog.alert("请选择一条记录!");
				return;
			}
				
			top.art.dialog.open('role/updateRole.do?id=' + ids,
				    {id: 'updateRole', title: '修改角色', width:500, height:410, lock: true,
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
		
		//打开添加角色页面
		function openAddRole()
		{
			top.art.dialog.open('role/addRole.do',
				    {id: 'addRole', title: '添加角色', width:500, height:310, lock: true,
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
		
		//打开角色权限列表
		function openRolePrivilege()
		{
			var ids = fTable.getCheckedValue();
			if("" == ids || ids.indexOf(",") > 0)
			{
				top.art.dialog.alert("请选择一条记录!");
				return;
			}
			
			top.art.dialog.open('role/rolePrivilegeList.do?id=' + ids,
				    {id: 'rolePrivilege', title: '分配权限', width:850, height:500, 
					 lock: true
				    });
		}
	</script>
</head>
<body>
	<div class="mainContent">
		<!-- 导航条 -->
		<div class="box-positon">
			<div class="rpos">当前位置: 系统管理 &gt; 角色管理 &gt; 列表</div>
			<div class="clear"></div>
		</div>
		
		<div class="form">
			<form id="queryForm" name="queryForm" onsubmit="return fTable.queryForm();">
				<span class="input-line">
					<span class="input-label">角色名</span>
					<input name="roleName" class="input-text" /> 
				</span>
				<input value="查询" type="submit" class="button_highlight"/>
			</form>
		</div>
		<div>
			<div class="toolGroup">
				<input type="button" value="新增" onclick="openAddRole();"/>
				<input type="button" value="修改" onclick="openUpdateRole()"/>
				<input  type="button" value="删除" onclick="deleteRoles()"/>
				<input type="button" value="分配权限" onclick="openRolePrivilege();"/>
			</div>
			<div class="fTableContent">
				<table id="fTable" cellpadding="0" cellspacing="0" class="fTable">
					<tr>
						<th></th>
						<th>
							<input type="checkbox"/>
						</th>
						<th width="40%">
							角色名
						</th>
						<th>
							描述
						</th>
					</tr>
				</table>
			</div>
		</div>
		<div id="fPage"></div>
	</div>
</body>
</html>