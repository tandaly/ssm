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
				fields: ['menuNo', 'parentNo', 'menuName', 'menuUrl', 'orderNo', 'status', 'options'],
				url: 'menu/ajaxMenuList.do',
				callback: callback
			});
		});
		
		function callback(data)
		{
			var list = data.list;
			
			if(list)
			{
				for(var i = 0; i < list.length; i++)
				{
					if(list[i].status == '启用')
					{
						list[i].status = '<font color=green>' + list[i].status + '</font>';
					}else
					{
						list[i].status = '<font color=red>' + list[i].status + '</font>';
					}
					list[i].options = '<a href="javascript:openDetailMenu('+list[i].id+')">详情</a>';
				}
			}
			fTable.build(list);
		}
		
		//打开详情页面
		function openDetailMenu(id)
		{	
			top.art.dialog.open('menu/detailMenu.do?id=' + id,
				    {id: 'detailDialog', title: '查看菜单', width:500, height:450, lock: true,
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
		
		function deleteMenus()
		{
			var ids = fTable.getCheckedValue();
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
							//top.topFrame.main.document.location.href=top.topFrame.main.document.location.href;
							top.topFrame.main.contentFrame.leftFrame.window.initTree();//重新加载树
							top.topFrame.main.contentFrame.rightFrame.window.fTable.queryForm();//查询列表
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
			var menuNode = parent.parent.contentFrame.leftFrame.selectTreeNode;
			/* if(!menuNode)
			{
				top.art.dialog.alert("请选择左侧菜单树作为父级菜单!");
				return;
			} */
			var menuNo = '';
			if(menuNode)
				menuNo = menuNode.menuNo;
			var url = 'menu/addMenu.do?menuNo=' + menuNo;
			
			top.art.dialog.open(url,
				    {id: 'addMenu', title: '添加菜单', width:500, height:450, lock: true,
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
			var ids = fTable.getCheckedValue();
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
<body style="height:90%;">
	<div>
		<div class="form">
			<form id="queryForm" name="queryForm" onsubmit="return fTable.queryForm();">
				<input type="hidden" id="parentNo" name="parentNo" value="${parentNo}"/>
				<input type="hidden" id="menuNo" name="menuNo" value="${menuNo}"/>
				<span class="input-line">	
					<span class="input-label">菜单名称</span>
					<input id="menuName" name="menuName" class="input-text"/> 
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
				<input type="button" value="新增" onclick="openAddMenu();"/>
				<input type="button" value="修改" onclick="openUpdateMenu();"/>
				<input  type="button" value="删除" onclick="deleteMenus()"/>
			</div>
			<div class="fTableContent">
				<table id="fTable" class="fTable" cellpadding="0" cellspacing="0">
					<tr>
						<th></th>
						<th>
							<input type="checkbox" />
						</th>
						<th width="100px">
							菜单编号
						</th>
						<th width="100px">
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
						<th>
							状态
						</th>
						<th>
							操作
						</th>
					</tr>
				</table>
			</div>
			<div id="fPage"></div>
		</div>
	</div>
</body>
</html>