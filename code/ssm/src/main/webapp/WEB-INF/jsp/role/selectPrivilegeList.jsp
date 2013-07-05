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
			var url = "role/ajaxSelectPrivilegeList.do";
			initPageTable(url, callback);
		});
		
		function callback(data)
		{
			var list = data.list;
			buildTable('datatable',list,['privilegeName', 'remark'],true,'id','cbx_',true);
		}
		
		//分配权限
		function allotPrvilege()
		{
			var ids = checkedValue("cbx_");
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
				url: 'role/ajaxAllotRolePrivilege.do?roleId=${role.id}',
				data: {"privilegeIds": ids},
				success: function(data)
				{
					if("y" == data.status)
					{
						top.art.dialog.list['rolePrivilege'].iframe.contentWindow.window.location.href = top.art.dialog.list['rolePrivilege'].iframe.contentWindow.window.location.href;
						top.art.dialog.alert(data.info);
						top.art.dialog({id:"selectPrivilege"}).close();
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
		<div style="text-align: center;">
			<form id="queryForm" name="queryForm" onsubmit="return queryFrom()">
				<input type="hidden" name="roleId" value="${role.id}"/>
				权限名称：<input name="privilegeName" /> 
				&nbsp;
				<input value="查询" type="submit" class="button_highlight"/>
			</form>
		</div>
		<div>
			<input type="hidden" id="submit" value="提交" onclick="allotPrvilege();"/>
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