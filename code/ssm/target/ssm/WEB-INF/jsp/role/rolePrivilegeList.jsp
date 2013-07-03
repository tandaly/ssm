<%@page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@include file="/WEB-INF/jsp/common/header.jsp"%>	
	<!-- 分页必须 -->
	<link href="plugins/page/page.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="plugins/page/page.js"></script>
	
	
	<style type="text/css">
		<!--
		body {
			margin-left: 0px;
			margin-top: 0px;
			margin-right: 0px;
			margin-bottom: 0px;
			background-color: #EEF2FB;
		}
		-->
	</style>
	<script type="text/javascript">
	
		$(function(){
			var url = "role/ajaxRolePrivilegeList.do";
			initPageTable(url, callback);
		});
		
		function callback(data)
		{
			var list = data.list;
			buildTable('datatable',list,['privilegeName', 'remark'],true,'id','cbx_',true);
		}
		
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
			var ids = checkedValue("cbx_");
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
		<div style="text-align: center;">
			<form id="queryForm" name="queryForm" onsubmit="return queryFrom()">
				<input type="hidden" name="roleId" value="${role.id}"/>
				权限名称：<input name="privilegeName" id="privilegeName"/> 
				&nbsp;
				<input value="查询" type="submit" class="btn_gray btn_space"/>
			</form>
		</div>
		<div>
			<input type="button" value="添加权限" onclick="openSelectRolePrivilege();"/>
			<input type="button" value="删除权限" onclick="deleteRolePrivilege();"/>
			<table width="100%" border="1" cellpadding="0" cellspacing="0"
				class="content-right-column-tb" id="datatable">
				<tr style="background-color: #a9c4e8;" class="content-right-column-tb-topbg">
					<th></th>
					<th>
						<input type="checkbox" id="ckall" />
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
		<br/>
		<div style="height: 80px;">
			<div id="pageDiv"></div>
		</div>
	

</body>
</html>