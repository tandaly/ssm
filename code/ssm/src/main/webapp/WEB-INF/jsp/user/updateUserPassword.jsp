<%@ page contentType="text/html;charset=UTF-8"
	trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="/WEB-INF/jsp/common/header.jsp"%>	
	<title>修改密码</title>
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
	            		<td class="need" style="width:10px;"></td>
	            		<td style="width:70px;">用户名：</td>
	                    <td style="width:205px;">
	                    	<input type="text" class="inputxt" value="${user.userName}" disabled="disabled"  /></td>
	                    <td></td>
	            	</tr>
	            	<tr>
	                    <td class="need" style="width:10px;">*</td>
	                    <td style="width:70px;">旧密码：</td>
	                    <td style="width:205px;">
	                    	<input type="password" value="" name="oldPassword" ajaxurl="user/ajaxValidPassword.do"
	                    		class="inputxt" datatype="*6-16" nullmsg="请输入旧密码！" errormsg="密码范围在6~16位之间！" /></td>
	                    <td><div class="Validform_checktip">修改密码前需校验旧密码</div></td>
	                </tr>
	                <tr>
	                    <td class="need" style="width:10px;">*</td>
	                    <td style="width:70px;">密&nbsp;&nbsp;码：</td>
	                    <td style="width:205px;">
	                    	<input type="password" value="" name="password" 
	                    		class="inputxt" datatype="*6-16" nullmsg="请设置密码！" errormsg="密码范围在6~16位之间！" /></td>
	                    <td><div class="Validform_checktip">密码范围在6~16位之间！</div></td>
	                </tr>
	                <tr>
	                    <td class="need">*</td>
	                    <td style="width:205px;">确认密码：</td>
	                    <td>
	                    	<input type="password" value="" name="password2" 
	                    		class="inputxt" datatype="*" recheck="password" nullmsg="请再输入一次密码！" errormsg="您两次输入的账号密码不一致！" /></td>
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
					url: "user/ajaxUpdateUserPassword.do",
					data: $(".registerform").serialize(),
					success: function(data)
					{
						if("y" == data.status)
						{
							top.art.dialog.tips(data.info);
							top.art.dialog({id: 'updateUserPassword'}).close();
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