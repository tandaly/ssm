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
			var url = "privilege/ajaxPrivilegeList.do";
			initPageTable(url, callback);
		});
		
		function callback(data)
		{
			var list = data.list;
			buildTable('datatable',list,['privilegeName', 'remark'],true,'id','cbx_',true);
		}
		
		function deletePrivileges()
		{
			var ids = checkedValue("cbx_");
			if("" == ids)
			{
				top.art.dialog.alert("请选择记录");
				return;
			}
			
			deletePrivilege(ids);
		}
		
		function deletePrivilege(ids)
		{
			top.art.dialog.confirm("你确定要删除吗?", function(){
				$.ajax({
					type:"POST",
					url:"privilege/ajaxDeletePrivilege.do",
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
						top.art.dialog.alert("操作失败");
					}
				});
			});
		}
		
		//打开添加权限页面
		function openAddPrivilege()
		{
			top.art.dialog.open('privilege/addPrivilege.do',
				    {id: 'addPrivilege', title: '添加权限', width:500, height:310, lock: true,
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
		

		//打开修改权限页面
		function openUpdatePrivilege()
		{	
			var ids = checkedValue("cbx_");
			if("" == ids || ids.indexOf(",") > 0)
			{
				top.art.dialog.alert("请选择一条记录!");
				return;
			}
				
			top.art.dialog.open('privilege/updatePrivilege.do?id=' + ids,
				    {id: 'updatePrivilege', title: '修改权限', width:500, height:410, lock: true,
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
		
		//打开权限菜单树
		function openMenuTree()
		{
			var ids = checkedValue("cbx_");
			if("" == ids || ids.indexOf(",") > 0)
			{
				top.art.dialog.alert("请选择一条记录!");
				return;
			}
			
			top.art.dialog.open('privilege/menuTree.do?id=' + ids,
				    {id: 'menuTree', title: '分配权限菜单', width:400, height:510, lock: true,
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
	</script>
</head>
<body>
		<div style="text-align: center;">
			<form id="queryForm" name="queryForm" onsubmit="return queryFrom()">
				权限名：<input name="privilegeName" /> 
				&nbsp;
				<input value="查询" type="submit" class="button_highlight"/>
			</form>
		</div>
		<div>
			<div class="toolGroup">
				<input type="button" value="新增" onclick="openAddPrivilege();"/>
				<input type="button" value="修改" onclick="openUpdatePrivilege()"/>
				<input  type="button" value="删除" onclick="deletePrivileges()"/>
				<input type="button" value="分配菜单" onclick="openMenuTree();"/>
			</div>
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