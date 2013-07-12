<%@page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@include file="/WEB-INF/jsp/common/header.jsp"%>	
	
	<link rel="stylesheet" href="plugins/tree/css/zTreeStyle/zTreeStyle.css" type="text/css">
	<script type="text/javascript" src="plugins/tree/js/jquery-1.4.4.min.js"></script>
	<script type="text/javascript" src="plugins/tree/js/jquery.ztree.core-3.5.js"></script>
	
		<script type="text/javascript">
			var treeObj;//菜单树
			var selectTreeNode;//选中的结点
			
			var setting = {
				data: {
					simpleData: {
						enable: true,	//设置是否使用简单数据模式(Array)
						idKey: "menuNo",	//设置节点唯一标识属性名称
						pIdKey: "parentNo"		//设置父节点唯一标识属性名称
					},
					key: {
						name: "menuName",
						title: "menuName"				
					}
				},
				/* async: {
					enable: true,//开启异步加载
					url:"admin/system/popedom/menu/ajaxGetSysLeftMenuTreeChild.do",//设置异步获取节点的 URL 地址
					autoParam:["treeId"]//设置父节点数据需要自动提交的参数
				}, */
				callback: {
					onClick: function (event, treeId, treeNode){
						selectTreeNode = treeNode;
						//turnPage(treeNode.linkUrl);
						//$("#rightFrame").contents().find("#parentNo");
						
						if($.trim(treeNode.menuUrl) != '')
						{
							top.topFrame.main.window.location.href = treeNode.menuUrl;
						}
						
						return;
						var mNo = $(top.topFrame.main.menuFrame.menuListFrame.$.find("#menuNo"));
						var pNo = $(top.topFrame.main.menuFrame.menuListFrame.$.find("#parentNo"));
						var mName = $(top.topFrame.main.menuFrame.menuListFrame.$.find("#menuName"));
						mName.val("");
						if(treeNode.isParent)
						{//是父节点
							mNo.val("");
							pNo.val(treeNode.menuNo == null?"-1":treeNode.menuNo);
						}else
						{
							pNo.val("");
							mNo.val(treeNode.menuNo);
						}
						$(top.topFrame.main.menuFrame.menuListFrame.$.find("#queryForm")).submit();
						
						//$("#rightFrame").attr("src", "menu/menuList.do?parentNo="+(treeNode.menuNo == null?"-1":treeNode.menuNo));
						
					}
				}
			};
			
			//初始化树
			function initTree() {
				$.ajax({  
			   		type: 'POST',  
			   		dataType : "json",
			   		async:false,
			   		url: "ajaxLeftMenus.do",//请求的action路径
			   		error: function () {//请求失败处理函数  
			   			top.art.dialog.alert("请求失败");
			   		},
			   		success:function(data){ //请求成功后处理函数。  
			       		treeNodes = data;   //把后台封装好的简单Json格式赋给treeNodes 
			       		//treeNodes.push({menuNo:-1, parentNo:0, menuName:"根节点", open:true});
			       		treeObj = $.fn.zTree.init($("#menusTree"), setting, treeNodes);		
			   		}  
			   		
				});   				
			}
	
			$(document).ready(function(){
				initTree();
			});
		</script>
		
</head>
<body style="height:90%;">
	
	<div style="float:left; overflow-y: auto; overflow-x: auto;">
		<ul id="menusTree" class="ztree"></ul>
	</div>
						
</body>
</html>