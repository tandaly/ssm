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
</head>

<body style="background-color: #FFF">  

	<!-- 主内容 start -->
	<div class="main">
	    <div class="wraper">
	        <form id="form" name="form" class="registerform" action="" onsubmit="return false;" method="post">
	            <table width="100%" style="table-layout:fixed;padding-left: 10px;" border="0">
	            	<tr>
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
	            	</tr>
	            	<tr>
	            		<td class="need" style="width:10px;">*</td>
	            		<td style="width:70px;">菜单编号：</td>
	                    <td style="width:205px;">
	                    	<input type="text" value="" name="menuNo" 
	                    		class="inputxt" datatype="*1-50" nullmsg="请输入菜单编号！" errormsg="菜单编号范围在1~50位之间！" ajaxurl="menu/ajaxFormMenuNo.do"/></td>
	                    <td><div class="Validform_checktip"></div></td>
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
	            		<td class="need" style="width:10px;">&nbsp;</td>
	            		<td style="width:70px;">排序编号：</td>
	                    <td style="width:205px;">
	                    	<input type="text" value="" name="orderNo" class="inputxt"/></td>
	                    <td><div class="Validform_checktip">为空时，系统取菜单编号</div></td>
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
							top.topFrame.main.document.location.href=top.topFrame.main.document.location.href;
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