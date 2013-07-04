<%@page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@include file="/WEB-INF/jsp/common/header.jsp"%>	

<link rel="stylesheet" href="plugins/tree/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<script type="text/javascript"
	src="plugins/tree/js/jquery.ztree.core-3.5.js"></script>

<script type="text/javascript">
	var treeObj;//菜单树
	var selectTreeNode;//选中的结点

	var setting = {
		data : {
			simpleData : {
				enable : true, //设置是否使用简单数据模式(Array)
				idKey : "menuNo", //设置节点唯一标识属性名称
				pIdKey : "parentNo" //设置父节点唯一标识属性名称
			},
			key : {
				name : "menuName",
				title : "menuName"
			}
		},
		/* async: {
			enable: true,//开启异步加载
			url:"admin/system/popedom/menu/ajaxGetSysLeftMenuTreeChild.do",//设置异步获取节点的 URL 地址
			autoParam:["treeId"]//设置父节点数据需要自动提交的参数
		}, */
		callback : {
			onClick : function(event, treeId, treeNode) {
				selectTreeNode = treeNode;
				//turnPage(treeNode.linkUrl);
				var mNo = $("#rightFrame").contents().find("#menuNo");
				var pNo = $("#rightFrame").contents().find("#parentNo");
				var mName = $("#rightFrame").contents().find("#menuName");
				mName.val("");
				if (treeNode.isParent) {//是父节点
					mNo.val("");
					pNo.val(treeNode.menuNo == null ? "-1" : treeNode.menuNo);
				} else {
					pNo.val("");
					mNo.val(treeNode.menuNo);
				}
				$("#rightFrame").contents().find("#queryForm").submit();

				//$("#rightFrame").attr("src", "menu/menuList.do?parentNo="+(treeNode.menuNo == null?"-1":treeNode.menuNo));

			}
		}
	};

	//初始化树
	function initTree() {
		$.ajax({
			type : 'POST',
			dataType : "json",
			async : false,
			url : "menu/ajaxQueryMenus.do",//请求的action路径
			error : function() {//请求失败处理函数  
				top.art.dialog.alert("请求失败");
			},
			success : function(data) { //请求成功后处理函数。  
				treeNodes = data; //把后台封装好的简单Json格式赋给treeNodes 
				treeNodes.push({
					menuNo : -1,
					parentNo : 0,
					menuName : "根节点",
					open : true
				});
				treeObj = $.fn.zTree.init($("#menusTree"), setting, treeNodes);
			}

		});
	}

	$(document).ready(function() {
		initTree();
	});
</script>

</head>
<body>

	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td width="17" valign="top" background="images/mail_leftbg.gif"><img
				src="images/left-top-right.gif" width="17" height="29" /></td>
			<td valign="top" background="images/content-bg.gif"><table
					width="100%" height="31" border="0" cellpadding="0" cellspacing="0"
					class="left_topbg" id="table2">
					<tr>
						<td height="31"><div class="titlebt">菜单管理</div></td>
					</tr>
				</table></td>
			<td width="16" valign="top" background="images/mail_rightbg.gif"><img
				src="images/nav-right-bg.gif" width="16" height="29" /></td>
		</tr>
		<tr>
			<td valign="middle" background="images/mail_leftbg.gif">&nbsp;</td>
			<td valign="top" bgcolor="#F7F8F9">
				<table width="98%" border="0" align="center" cellpadding="0"
					cellspacing="0">
					<tr>
						<td colspan="2" valign="top">&nbsp;</td>
						<td>&nbsp;</td>
						<td valign="top">&nbsp;</td>
					</tr>
					<tr>
						<td colspan="4" valign="top" style="">
							<!-- 主体 start -->
							<div style="width: 100%; height: 650px;">
								<iframe name="menuFrame" id="menuFrame" src="menu/frame.do"
									style="margin: 0px;" frameborder="0" width="100%" height="100%"></iframe>
							</div> <!-- 主体 end -->

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