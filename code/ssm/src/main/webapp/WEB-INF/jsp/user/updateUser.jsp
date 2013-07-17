<%@page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@include file="/WEB-INF/jsp/common/header.jsp"%>	
	<title>修改用户</title>
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
	            		<td style="width:70px;">用户名：</td>
	                    <td style="width:205px;">
	                    	<input type="hidden" name="id" value="${user.id }"/>
	                    	<input type="text" value="${user.userName }" name="userName" 
	                    		class="inputxt" ajaxurl="user/ajaxFormUserName.do?id=${user.id}" datatype="*1-50" nullmsg="请输入用户名！" errormsg="用户名范围在1~50位之间！" />
	                    </td>
	                    <td><div class="Validform_checktip">用户名范围在1~50位之间！</div></td>
	            	</tr>
	            	
	                <tr>
	                    <td class="need" style="width:10px;">*</td>
	                    <td style="width:70px;">密&nbsp;&nbsp;码：</td>
	                    <td style="width:205px;">
	                    	<input type="password" value="" name="password" plugin="passwordStrength"
	                    		class="inputxt" datatype="*6-16" nullmsg="请设置密码！" errormsg="密码范围在6~16位之间！" />
	                    	<div class="passwordStrength">密码强度： <span>弱</span><span>中</span><span class="last">强</span></div>
	                    </td>
	                    <td><div class="Validform_checktip">密码范围在6~16位之间！</div></td>
	                </tr>
	                <tr>
	                    <td class="need">*</td>
	                    <td style="width:205px;">确认密码：</td>
	                    <td> 
	                    	<input type="password" value="" name="password2" 
	                    		class="inputxt" datatype="*" recheck="password" nullmsg="请再输入一次密码！" errormsg="您两次输入的账号密码不一致！" />
	                    </td>
	                    <td><div class="Validform_checktip"></div></td>
	                </tr>
	                <tr>
	                	<td class="need">*</td>
	                	<td style="width:205px;">状&nbsp;&nbsp;态：</td>
	                	<td>
	                		<select name="status" datatype="*" nullmsg="请选择状态！" class="Validform_error">
	                			<option value="">--请选择--</option>
	                			<c:if test="${user.status == '启用' }">
		                			<option value="启用" selected>启用</option>
		                			<option value="禁用">禁用</option>
	                			</c:if>
	                			<c:if test="${user.status == '禁用'}">
		                			<option value="启用">启用</option>
		                			<option value="禁用" selected>禁用</option>
	                			</c:if>
	                		</select>
	                	</td>
	                	<td><div class="Validform_checktip"></div></td>
	                </tr>
	            	<tr>
	            		<td class="need" style="width:10px;">&nbsp;</td>
	            		<td style="width:70px;">描&nbsp;&nbsp;述：</td>
	                    <td style="width:205px;">
	                    	<textarea rows="3" cols="10" name="remark">${user.remark}</textarea>
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
	<script type="text/javascript" src="plugins/validform/plugin/passwordStrength/passwordStrength-min.js"></script><!-- 密码强度验证插件 -->
	<script type="text/javascript">
	$(function(){
		initForm(".registerform", callback);
		
		function callback(form){
			top.art.dialog.confirm('你确定要提交吗？', function () {
				$.ajax({
					type: "POST",
					url: "user/ajaxUpdateUser.do",
					data: $(".registerform").serialize(),
					success: function(data)
					{
						if("y" == data.status)
						{
							top.topFrame.main.window.fTable.queryForm();
							top.art.dialog.tips(data.info);
							top.art.dialog({id: 'updateUser'}).close();
							
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
			}, function () {
			    
			});
			
			return false;
		};
	});
	</script>
</body>
</html>