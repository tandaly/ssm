<%@page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@include file="/WEB-INF/jsp/common/header.jsp"%>	
	<title>添加角色</title>
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
	            		<td class="need" style="width:10px;">*</td>
	            		<td style="width:70px;">角色名：</td>
	                    <td style="width:205px;">
	                    	<input type="text" value="" name="roleName" 
	                    		class="inputxt" ajaxurl="role/ajaxFormRoleName.do" datatype="*1-50" nullmsg="请输入角色名！" errormsg="角色名范围在1~50位之间！" /></td>
	                    <td><div class="Validform_checktip">角色名范围在1~50位之间！</div></td>
	            	</tr>
	            	<tr>
	            		<td class="need" style="width:10px;">&nbsp;</td>
	            		<td style="width:70px;">描&nbsp;&nbsp;述：</td>
	                    <td style="width:205px;">
	                    	<textarea rows="3" cols="10" name="remark"></textarea>
	                    </td>
	                    <td><div class="Validform_checktip"></div></td>
	            	</tr>
	                <tr>
	                    <td class="need"></td>
	                    <td></td>
	                    <td colspan="2" style="padding:10px 0 18px 0;">
	                        <input type="submit" value="提 交" class="ajaxpost" id="submit" style="display:none;"/> 
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
					url: "role/ajaxAddRole.do",
					data: $(".registerform").serialize(),
					success: function(data)
					{
						if("y" == data.status)
						{
							top.topFrame.main.window.fTable.queryForm();
							top.art.dialog.tips(data.info);
							confirmOption(data.id);
							
						}else
						{
							top.art.dialog.alert(data.info);
						}
					},
					error: function()
					{
						top.art.dialog.alert("连接服务器失败");
					}
				});
			}, function () {
			    
			});
			
			return false;
		};
	});
	
	function confirmOption(roleId)
	{
		top.art.dialog.confirm("现在要给新增角色分配权限吗", function(){
			openRolePrivilege(roleId);
			top.art.dialog({id: 'addRole'}).close();
		}, function(){
			top.art.dialog({id: 'addRole'}).close();
		});
	}
	
	//打开角色权限列表
	function openRolePrivilege(roleId)
	{
		top.art.dialog.open('role/rolePrivilegeList.do?id=' + roleId,
			    {id: 'rolePrivilege', title: '分配权限', width:850, height:500, 
				 lock: true
			    });
	}
	</script>
</body>
</html>