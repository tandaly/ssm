<%@page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@include file="/WEB-INF/jsp/common/header.jsp"%>	
	<title>添加菜单</title>
	<!-- 表单验证插件 -->
	<link rel="stylesheet" href="plugins/validform/css/style.css" type="text/css" media="all" />
	<link href="plugins/validform/css/form.css" type="text/css" rel="stylesheet" />
	<!-- 树形插件 -->
	<link rel="stylesheet" href="plugins/tree/css/demo.css" type="text/css"><!-- 下拉树样式 -->
	<link rel="stylesheet" href="plugins/tree/css/zTreeStyle/zTreeStyle.css" type="text/css">
	<script type="text/javascript" src="plugins/tree/js/jquery.ztree.core-3.5.js"></script>
	<!-- 树形编辑插件 -->
	<script type="text/javascript" src="plugins/tree/js/jquery.ztree.excheck-3.5.js"></script>
	<script type="text/javascript" src="plugins/tree/js/jquery.ztree.exedit-3.5.js"></script>
	
	<script type="text/javascript">
	
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
			callback: {
				onClick: onClick
				//onCheck: onCheck
			}
		};

		/* function onClick(e, treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			zTree.checkNode(treeNode, !treeNode.checked, null, true);
			return false;
		} */

		function onClick(e, treeId, treeNode) {
		/* 	var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
			nodes = treeNode;//zTree.getCheckedNodes(true),
			v = "";
			for (var i=0, l=nodes.length; i<l; i++) {
				v += nodes[i].name + ",";
			}
			if (v.length > 0 ) v = v.substring(0, v.length-1); */
			
			$("#parentName").attr("value", treeNode.menuName);
			$("#parentNo").attr("value", treeNode.menuNo);
			
			$("#parentName").focus();
		}
		
		function showMenu() {
			var cityObj = $("#parentName");
			var cityOffset = $("#parentName").offset();
			$("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");

			$("body").bind("mousedown", onBodyDown);
		}
		function hideMenu() {
			$("#menuContent").fadeOut("fast");
			$("body").unbind("mousedown", onBodyDown);
		}
		function onBodyDown(event) {
			if (!(event.target.id == "menuBtn" || event.target.id == "parentName" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
				hideMenu();
				createNewMenuNo();
			}
		}
	
	

		//初始化树
		function initTree() {
			$.ajax({  
		   		type: 'POST',  
		   		dataType : "json",
		   		async:false,
		   		url: "menu/ajaxQueryMenus.do",//请求的action路径
		   		error: function () {//请求失败处理函数  
		   			top.art.dialog.alert("请求失败");
		   		},
		   		success:function(data){ //请求成功后处理函数。  
		       		treeNodes = data;   //把后台封装好的简单Json格式赋给treeNodes 
		       		treeNodes.push({menuNo:-1, parentNo:0, menuName:"根节点", open:true});
		       		treeObj = $.fn.zTree.init($("#menusTree"), setting, treeNodes);		
		   		}  
		   		
			});   				
		}

		$(document).ready(function(){
			initTree();
		});
		
		//新生成菜单编号
		function createNewMenuNo() {
			$.ajax({  
		   		type: 'POST',  
		   		dataType : "json",
		   		async:false,
		   		url: "menu/ajaxCreateNewMenuNo.do",//请求的action路径
		   		data: {"menuNo":$("#parentNo").val()},
		   		error: function () {//请求失败处理函数  
		   			top.art.dialog.alert("请求失败");
		   		},
		   		success:function(data){ //请求成功后处理函数。  
		   			$("#menuNo").val(data.newMenuNo);
		   		}  
		   		
			});   				
		}
	</script>
</head>

<body style="background-color: #FFF">  

	<!-- 主内容 start -->
	<div class="main">
	    <div class="wraper">
	        <form id="form" name="form" class="registerform" action="" onsubmit="return false;" method="post">
	            <table width="100%" style="table-layout:fixed;padding-left: 10px;" border="0">
	            	<%-- <tr>
	            		<td class="need" style="width:10px;">&nbsp;</td>
	            		<td style="width:80px;">父菜单编号：</td>
	                    <td style="width:205px;">
	                    	<c:if test="${menu.parentNo == null || menu.parentNo == ''}">
	                    		<input type="hidden" name="parentNo" value="-1"/>
	                    		-1
	                    	</c:if>
	                    	<c:if test="${menu.parentNo != null && menu.parentNo != ''}">
	                    		<input type="hidden" name="parentNo" value="${menu.parentNo}"/>
	                    		${menu.parentNo}
	                    	</c:if>
	                    	
	                    </td>
	                    <td></td>
	            	</tr> --%>
	            	<tr>
	            		<td class="need" style="width:10px;">&nbsp;</td>
	            		<td style="width:80px;">父菜单：</td>
	                    <td style="width:205px;">
	                    	<input type="hidden" id="parentNo" name="parentNo" value="${menu.menuNo}"/>
	                    	
	                    	<input id="parentName" type="text" readonly value="${menu.menuName}" 
	                    		 nullmsg="请选择父菜单" datatype="*1-50"
	                    		onclick="showMenu();" class="inputxt" />
	                    </td>
	                    <td>
	                   		<div class="Validform_checktip">点击文本框选择</div>
	                    </td>
	            	</tr>
	            	<tr>
	            		<td class="need" style="width:10px;">*</td>
	            		<td style="width:70px;">菜单编号：</td>
	                    <td style="width:205px;">
	                    	<input type="text" value="${newMenuNo }" id="menuNo" name="menuNo" 
	                    		class="inputxt" datatype="*1-1000" nullmsg="请输入菜单编号！" errormsg="菜单编号范围在1~50位之间！" ajaxurl="menu/ajaxFormMenuNo.do"/></td>
	                    <td><div class="Validform_checktip">系统根据父菜单生成,可修改</div></td>
	            	</tr>
	            	<tr>
	            		<td class="need" style="width:10px;">*</td>
	            		<td style="width:70px;">菜单名称：</td>
	                    <td style="width:205px;">
	                    	<input type="text" value="" name="menuName" 
	                    		class="inputxt" datatype="*1-50" nullmsg="请输入菜单名称！" errormsg="菜单名称范围在1~50位之间！" ajaxurl="menu/ajaxFormMenuName.do"/></td>
	                    <td><div class="Validform_checktip"></div></td>
	            	</tr>
	            	<tr>
	            		<td class="need" style="width:10px;"></td>
	            		<td style="width:70px;">菜单地址：</td>
	                    <td style="width:205px;">
	                    	<input type="text" value="" name="menuUrl" class="inputxt" /></td>
	                    <td><div class="Validform_checktip">为空时,表示为父节点</div></td>
	            	</tr>
	            	<tr>
	            		<td class="need" style="width:10px;"></td>
	            		<td style="width:70px;">菜单图标：</td>
	                    <td style="width:205px;">
	                    	<input type="text" value="" name="icon" class="inputxt" /></td>
	                    <td><div class="Validform_checktip">为空时,系统默认</div></td>
	            	</tr>
	                <tr>
	            		<td class="need" style="width:10px;">&nbsp;</td>
	            		<td style="width:70px;">排序编号：</td>
	                    <td style="width:205px;">
	                    	<input type="text" value="" name="orderNo" class="inputxt"/></td>
	                    <td><div class="Validform_checktip">为空时，系统取菜单编号</div></td>
	            	</tr>
	            	<tr>
	                	<td class="need">*</td>
	                	<td style="width:205px;">状&nbsp;&nbsp;态：</td>
	                	<td>
	                		<select name="status" datatype="*" nullmsg="请选择状态！" class="Validform_error">
	                			<option value="">--请选择--</option>
	                			<option value="启用">启用</option>
	                			<option value="禁用">禁用</option>
	                		</select>
	                	</td>
	                	<td><div class="Validform_checktip"></div></td>
	                </tr>
	                <tr>
	                    <td class="need"></td>
	                    <td></td>
	                    <td colspan="2" style="padding:10px 0 18px 0;">
	                        <input type="submit" value="提 交" class="ajaxpost" id="submit" style="display:none;"/> 
	                        <input type="reset" value="重 置" id="reset" style="display:none;"/>
	                    </td>
	                </tr>
	            </table>
	        </form>
	    </div>
	</div>
			
	<div id="menuContent" class="menuContent" style="display:none; position: absolute;">
		<ul id="menusTree" class="ztree" style="margin-top:0; width:190px; height: 300px;"></ul>
	</div>				
	
	<!-- 表单验证 -->
	<script type="text/javascript" src="plugins/validform/Validform.js"></script>
	<script type="text/javascript" src="plugins/validform/form.js"></script>
	<script type="text/javascript">
	$(function(){
		initForm(".registerform", callback);
		
		function callback(form){
			top.art.dialog.confirm('你确定要提交吗？', function () {
				$.ajax({
					type: "POST",
					url: "menu/ajaxAddMenu.do",
					data: $(".registerform").serialize(),
					success: function(data)
					{
						if("" == data)
						{
							top.topFrame.main.contentFrame.leftFrame.window.initTree();//重新加载树
							top.topFrame.main.contentFrame.rightFrame.window.fTable.queryForm();//查询列表
							//top.topFrame.main.document.location.href=top.topFrame.main.document.location.href;
							top.art.dialog.tips('操作成功');
							top.art.dialog({id: 'addMenu'}).close();
							
						}else
						{
							top.art.dialog.alert(data);
						}
					},
					error: function()
					{
						top.art.dialog.alert("失败");
					}
				});
			}, function () {
			    
			});
			
			return false;
		};
	});
	</script>
</body>
</html>