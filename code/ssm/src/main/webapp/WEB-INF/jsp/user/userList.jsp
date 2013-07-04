<%@ page contentType="text/html;charset=UTF-8"
	trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="/WEB-INF/jsp/common/header.jsp"%>	
	<!-- 分页插件 -->
	<link href="plugins/page/page.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="plugins/page/page.js"></script>
	
	<!-- 单选下拉框 start (需jquery支持,必须在之前引入)-->
	<link style="text/css" rel="stylesheet" href="plugins/select/skins/style.css"/>
	<link href="plugins/select/reset.css" rel="stylesheet" type="text/css"/>
	<script type="text/javascript" src="plugins/select/js/select_split.js"></script>
	<!-- 单选下拉框 end -->
	
	<script type="text/javascript">
	
		$(function(){
			var url = "user/ajaxUserList.do";
			initPageTable(url, callback);
		});
		
		function callback(data)
		{
			var list = data.list;
			
			if(list){
				for(var i = 0 ; i < list.length ; i++){
					var registerDate = list[i].registerDate;
					list[i].registerDate = registerDate.substring(0, 10);
					var status = list[i].status;
					if('启用' == status)
					{
						list[i].status = "<font color=green>启用</font>";
					}else
					{
						list[i].status = "<font color=red>禁用</font>";
					}
					
					//if(list[i].relieveReason.length > 10)list[i].relieveReason = list[i].relieveReason.substring(0,10)+"...";
					//list[i].options = "<a title='删除' href='javascript:deleteUser("+list[i].id+")'>删除</a>";
				}
			}
			
			buildTable('datatable',list,['userName','password','registerDate','status', 'remark'],true,'id','cbx_',true);
		}
		
		function deleteUsers()
		{
			var ids = checkedValue("cbx_");
			if("" == ids)
			{
				top.art.dialog.alert("请选择记录");
				return;
			}
			
			deleteUser(ids);
		}
		
		function deleteUser(ids)
		{
			top.art.dialog.confirm("删除用户的同时会删除用户关联的角色关系，你确定要删除吗?", function()
			{
				$.ajax({
					type:"POST",
					url:"user/ajaxDeleteUser.do",
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
		
		//打开修改用户页面
		function openUpdateUser()
		{	
			var ids = checkedValue("cbx_");
			if("" == ids || ids.indexOf(",") > 0)
			{
				top.art.dialog.alert("请选择一条记录!");
				return;
			}
				
			top.art.dialog.open('user/updateUser.do?id=' + ids,
				    {id: 'updateUser', title: '修改用户', width:500, height:410, lock: true,
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
		
		//打开添加用户页面
		function openAddUser()
		{
			top.art.dialog.open('user/addUser.do',
				    {id: 'addUser', title: '添加用户', width:500, height:400, lock: true,
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
		
		//打开用户角色表
		function openUserRole()
		{
			var ids = checkedValue("cbx_");
			if("" == ids || ids.indexOf(",") > 0)
			{
				top.art.dialog.alert("请选择一条记录!");
				return;
			}
			
			top.art.dialog.open('user/userRoleList.do?id=' + ids,
				    {id: 'userRole', title: '分配角色', width:850, height:500, 
					 lock: true
				    });
		}
		
		//启用和禁用帐号 1为启用 0为禁用
		function changeUserStatus(status)
		{
			var ids = checkedValue("cbx_");
			if("" == ids)
			{
				top.art.dialog.alert("请选择记录");
				return;
			}
			
			top.art.dialog.confirm("此操作会影响用户,你确认要执行次操作吗？", function()
			{
				$.ajax({
					type:"POST",
					url:"user/ajaxChangeUserStatus.do",
					data:{"status": status, "userIds":ids},
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
						top.art.dialog.alert("操作失败");
					}
				});
			});
		}
	</script>
</head>
<body >

	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td width="17" valign="top" background="images/mail_leftbg.gif"><img
				src="images/left-top-right.gif" width="17" height="29" /></td>
			<td valign="top" background="images/content-bg.gif"><table
					width="100%" height="31" border="0" cellpadding="0" cellspacing="0"
					class="left_topbg" id="table2">
					<tr>
						<td height="31"><div class="titlebt">用户管理</div></td>
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
									用户名：<input name="userName" /> <input type="hidden" name="pageSize" value="15"/>
									状态：
									<select name="status">
										<option value="">--请选择--</option>
										<option value="启用">启用</option>
										<option value="禁用">禁用</option>
									</select>
									&nbsp;
									<input value="查询" type="submit" />
								</form>
							</div>
							<div>
								<div class="toolGroup">
									<input type="button" value="新增" onclick="openAddUser();"/>
									<input type="button" value="修改" onclick="openUpdateUser()"/>
									<input  type="button" value="删除" onclick="deleteUsers()"/>
									<input type="button" value="分配角色" onclick="openUserRole();"/>
									<input type="button" value="启用" onclick="changeUserStatus('启用');"/>
									<input type="button" value="禁用" onclick="changeUserStatus('禁用');"/>
								</div>
								<table width="100%" border="1" cellpadding="0" cellspacing="0"
									class="content-right-column-tb" id="datatable">
									<tr style="background-color: #a9c4e8;" class="content-right-column-tb-topbg">
										<th></th>
										<th>
											<input type="checkbox" id="ckall" />
										</th>
										<th width="20%">
											用户名
										</th>
										<th width="20%">
											密码
										</th>
										<th width="20%">
											注册日期
										</th>
										<th width="10%">
											状态
										</th>
										<th>
											备注
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