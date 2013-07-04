<%@page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@include file="/WEB-INF/jsp/common/header.jsp"%>	
	<!-- 分页插件 -->
	<link href="plugins/page/page.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="plugins/page/page.js"></script>
	
	<script type="text/javascript">
	
		$(function(){
			var url = "role/ajaxRoleList.do";
			initPageTable(url, callback);
		});
		
		function callback(data)
		{
			var list = data.list;
			buildTable('datatable',list,['roleName', 'remark'],true,'id','cbx_',true);
		}
		
		function deleteRoles()
		{
			var ids = checkedValue("cbx_");
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
							queryFrom();
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
			var ids = checkedValue("cbx_");
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
			var ids = checkedValue("cbx_");
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

	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td width="17" valign="top" background="images/mail_leftbg.gif"><img
				src="images/left-top-right.gif" width="17" height="29" /></td>
			<td valign="top" background="images/content-bg.gif"><table
					width="100%" height="31" border="0" cellpadding="0" cellspacing="0"
					class="left_topbg" id="table2">
					<tr>
						<td height="31"><div class="titlebt">角色管理</div></td>
					</tr>
				</table></td>
			<td width="16" valign="top" background="images/mail_rightbg.gif"><img
				src="images/nav-right-bg.gif" width="16" height="29" /></td>
		</tr>
		<tr>
			<td valign="middle" background="images/mail_leftbg.gif">&nbsp;</td>
			<td valign="top" bgcolor="#F7F8F9">
				<table width="98%" border="0" align="center"
					cellpadding="0" cellspacing="0">
					<tr>
						<td colspan="2" valign="top">&nbsp;</td>
						<td>&nbsp;</td>
						<td valign="top">&nbsp;</td>
					</tr>
					<tr>
						<td colspan="4" valign="top" style="">
							
							<div style="text-align: center;">
								<form id="queryForm" name="queryForm" onsubmit="return queryFrom()">
									角色名：<input name="roleName" /> 
									&nbsp;
									<input value="查询" type="submit" class="btn_gray btn_space"/>
								</form>
							</div>
							<div>
								<div class="toolGroup">
									<input type="button" value="新增" onclick="openAddRole();"/>
									<input type="button" value="修改" onclick="openUpdateRole()"/>
									<input  type="button" value="删除" onclick="deleteRoles()"/>
									<input type="button" value="分配权限" onclick="openRolePrivilege();"/>
								</div>
								<table width="100%" border="1" cellpadding="0" cellspacing="0"
									class="content-right-column-tb" id="datatable">
									<tr style="background-color: #a9c4e8;" class="content-right-column-tb-topbg">
										<th></th>
										<th>
											<input type="checkbox" id="ckall" />
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
							<br/>
							<div style="height: 80px;">
								<div id="pageDiv"></div>
							</div>
						</td>
					</tr>
				</table>
			</td>
			<td background="images/mail_rightbg.gif">&nbsp;</td>
		</tr>
		<tr>
			<td valign="bottom" background="images/mail_leftbg.gif"><img
				src="images/buttom_left2.gif" width="17" height="17" /></td>
			<td background="images/buttom_bgs.gif"><img
				src="images/buttom_bgs.gif" width="17" height="17"></td>
			<td valign="bottom" background="images/mail_rightbg.gif"><img
				src="images/buttom_right2.gif" width="16" height="17" /></td>
		</tr>
	</table>

</body>
</html>