<%@ page contentType="text/html;charset=UTF-8"
	trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="/WEB-INF/jsp/common/header.jsp"%>	
	<!-- 表格插件 -->
	<script type="text/javascript" src="plugins/page/fTable.js"></script>
	
	<!-- 单选下拉框 start (需jquery支持,必须在之前引入)-->
	<link style="text/css" rel="stylesheet" href="plugins/select/skins/style.css"/>
	<link href="plugins/select/reset.css" rel="stylesheet" type="text/css"/>
	<script type="text/javascript" src="plugins/select/js/select_split.js"></script>
	<!-- 单选下拉框 end -->
	
	<script type="text/javascript">
		var fTable;
		var fTable2;
		$(function(){
			fTable = new FTable({
				fields: ['userName','password','registerDate','status', 'remark'],
				url: 'user/ajaxUserList.do',
				callback:callback
			});
			
			fTable2 = new FTable({
				pageAlign: 'center',
				id: 'fTable2',
				skin: 'skin2',
				page: '#fPage2',
				//pageSize: 5,
				fields: ['userName','password','registerDate','status', 'remark'],
				url: 'user/ajaxUserList.do'
			});
			
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
			fTable.build(list);
		}
		
		function deleteUsers()
		{
			var ids = fTable.getCheckedValue();
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
		
		//打开修改用户页面
		function openUpdateUser()
		{	
			var ids = fTable.getCheckedValue();
			if("" == ids || ids.indexOf(",") > 0)
			{
				top.art.dialog.alert("请选择一条记录!");
				return;
			}
				
			top.art.dialog.open('user/updateUser.do?id=' + ids,
				    {id: 'updateUser', title: '修改用户', width:500, height:450, lock: true,
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
				    {id: 'addUser', title: '添加用户', width:500, height:450, lock: true,
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
			var ids = fTable.getCheckedValue();
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
		
		//启用和禁用帐号 启用或者禁用
		function changeUserStatus(status)
		{
			var ids = fTable.getCheckedValue();
			if("" == ids)
			{
				top.art.dialog.alert("请选择记录");
				return;
			}
			
			top.art.dialog.confirm("你确认要执行此操作吗？", function()
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
	<div class="mainContent">
		
		<!-- 导航条 -->
		<div class="box-positon">
			<div class="rpos">当前位置: 系统管理 &gt; 用户管理 &gt; 列表</div>
			<div class="clear"></div>
		</div>
	
	<div class="form">
		<form id="queryForm" name="queryForm" onsubmit="return fTable.queryForm();">
			<span class="input-line">
				<span class="input-label">用户名</span>
				<input type="text" name="userName" class="input-text"/> 
			</span>
			
			<span class="input-line">
				<span class="input-label">状态</span>
				<select name="status" class="select">
					<option value="">全部</option>
					<option value="启用">启用</option>
					<option value="禁用">禁用</option>
				</select>
			</span>
			<input value="查询" type="submit" class="button_highlight"/>
		</form>
	</div>
	<div>
		<div class="toolGroup">
			<input type="button" value="新增" onclick="openAddUser();" class="button"/>
			<input type="button" value="修改" onclick="openUpdateUser()" class="button"/>
			<input  type="button" value="删除" onclick="deleteUsers()" class="button"/>
			<input type="button" value="分配角色" onclick="openUserRole();" class="button"/>
			<input type="button" value="启用" onclick="changeUserStatus('启用');" class="button"/>
			<input type="button" value="禁用" onclick="changeUserStatus('禁用');" class="button"/>
		</div>
		<div class="fTableContent">
			<table id="fTable">
				<tr>
					<th></th>
					<th>
						<input type="checkbox"/>
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
		<div id="fPage"></div>
	</div>
	
	<div class="fTableContent">
			<table id="fTable2">
				<tr>
					<th></th>
					<th>
						<input type="checkbox"/>
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
		<div id="fPage2"></div>
	</div>
</body>
</html>