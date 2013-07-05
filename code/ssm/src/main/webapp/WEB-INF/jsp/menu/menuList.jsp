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
			var url = "menu/ajaxMenuList.do";
			initPageTable(url, callback);
		});
		
		function callback(data)
		{
			var list = data.list;
			buildTable('datatable',list,['menuNo', 'parentNo', 'menuName', 'menuUrl', 'orderNo'],true,'id','cbx_',true);
		}
		
		function deleteMenus()
		{
			var ids = checkedValue("cbx_");
			if("" == ids)
			{
				top.art.dialog.alert("请选择记录");
				return;
			}
			
			deleteMenu(ids);
		}
		
		function deleteMenu(ids)
		{
			top.art.dialog.confirm("你确定要删除吗?", function()
			{
				$.ajax({
					type:"POST",
					url:"menu/ajaxDeleteMenu.do",
					data:{"ids":ids},
					success:function(data)
					{
						if("y" != data.status)
						{
							top.art.dialog.alert(data.info);
						}else
						{
							top.art.dialog.alert(data.info);
							top.topFrame.main.document.location.href=top.topFrame.main.document.location.href;
						}
					},
					error:function()
					{
						top.art.dialog.alert("操作失败");
					}
				});
			});
		}
		
		//打开添加菜单页面
		function openAddMenu()
		{	
			var menuNode = top.topFrame.main.menuFrame.leftMenuFrame.selectTreeNode;
			if(!menuNode)
			{
				top.art.dialog.alert("请选择左侧菜单树作为父级菜单!");
				return;
			}
				
			top.art.dialog.open('menu/addMenu.do?parentNo=' + menuNode.menuNo,
				    {id: 'addMenu', title: '添加菜单', width:500, height:410, lock: true,
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
		
		//打开修改菜单页面
		function openUpdateMenu()
		{	
			var ids = checkedValue("cbx_");
			if("" == ids || ids.indexOf(",") > 0)
			{
				top.art.dialog.alert("请选择一条记录!");
				return;
			}
				
			top.art.dialog.open('menu/updateMenu.do?id=' + ids,
				    {id: 'updateMenu', title: '修改菜单', width:500, height:410, lock: true,
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
		
	</script>
</head>
<body>

		<div style="text-align: center;">
			<form id="queryForm" name="queryForm" onsubmit="return queryFrom()">
				<input type="hidden" id="parentNo" name="parentNo" value="${parentNo}"/>
				<input type="hidden" id="menuNo" name="menuNo" value="${menuNo}"/>
				菜单名称：<input id="menuName" name="menuName" /> 
				&nbsp;
				<input value="查询" type="submit" class="button_highlight"/>
			</form>
		</div>
		<div>
			<div class="toolGroup">
				<input type="button" value="新增" onclick="openAddMenu();"/>
				<input type="button" value="修改" onclick="openUpdateMenu();"/>
				<input  type="button" value="删除" onclick="deleteMenus()"/>
			</div>
			<table width="100%" border="1" cellpadding="0" cellspacing="0"
				class="content-right-column-tb" id="datatable">
				<tr style="background-color: #a9c4e8;" class="content-right-column-tb-topbg">
					<th></th>
					<th>
						<input type="checkbox" id="ckall" />
					</th>
					<th width="150px">
						菜单编号
					</th>
					<th width="150px">
						父菜单编号
					</th>
					<th width="20%">
						菜单名称
					</th>
					<th>
						菜单地址
					</th>
					<th>
						排序编号
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