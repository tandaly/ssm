<%@ page contentType="text/html;charset=UTF-8"
	trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="/WEB-INF/jsp/common/header.jsp"%>	
	<!-- 分页插件 -->
	<script type="text/javascript" src="plugins/page/fTable.js"></script>
	
	<script type="text/javascript">
	
		$(function(){
			fTable = new FTable({
				fields: ['roleName','remark'],
				url: 'user/ajaxUserRoleList.do'
			});
		});
		
		//打开角色分配框
		function openSelectUserRole()
		{
			top.art.dialog.open('user/selectRoleList.do?id=${user.id}',
				    {id: 'selectRole', title: '角色列表', width:600, height:500, lock: false,
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
		
		function deleteUserRole()
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
					url:"user/ajaxDeleteUserRole.do?userId=${user.id}",
					data:{"roleIds":ids},
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
			<input type="hidden" name="userId" value="${user.id}"/>
			<span class="input-line">
				<span class="input-label">角色名称</span>
				<input name="roleName" id="roleName" class="input-text"/> 
			</span>
			<input value="查询" type="submit" class="button_highlight"/>
		</form>
	</div>
	<div>
		<div class="toolGroup">
			<input type="button" class="button" value="添加角色" onclick="openSelectUserRole();"/>
			<input type="button" class="button" value="删除角色" onclick="deleteUserRole();"/>
		</div>
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