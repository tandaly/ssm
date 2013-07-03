<%@ page contentType="text/html;charset=UTF-8"
	trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@ include file="/WEB-INF/jsp/common/header.jsp"%>	
	<title>添加用户</title>
	<link rel="stylesheet" href="plugins/validform/css/style.css" type="text/css" media="all" />
	<link href="plugins/validform/css/form.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="plugins/date/WdatePicker.js"></script>
	<link href="plugins/date/skin/WdatePicker.css" rel="stylesheet" type="text/css">
	<link href="images/skin.css" rel="stylesheet" type="text/css" />
	<style type="text/css">
		<!--
		body {
			margin-left: 0px;
			margin-top: 0px;
			margin-right: 0px;
			margin-bottom: 0px;
			background-color: #EEF2FB;
		}
		-->
	</style>
	<style>
		.registerform li{padding-bottom:20px;}
		.Validform_checktip{margin-left:10px;}
		.registerform .label{display:inline-block; width:70px;}
		.action{padding-left:92px;}
	</style>
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
						<td height="31"><div class="titlebt">添加用户</div></td>
					</tr>
				</table></td>
			<td width="16" valign="top" background="images/mail_rightbg.gif"><img
				src="images/nav-right-bg.gif" width="16" height="29" /></td>
		</tr>
		<tr>
			<td valign="middle" background="images/mail_leftbg.gif">&nbsp;</td>
			<td valign="top" bgcolor="#F7F8F9">
				<table width="98%" border="0" align="center"
					cellpadding="0" cellspacing="0">
					<tr>
						<td colspan="2" valign="top">&nbsp;</td>
						<td>&nbsp;</td>
						<td valign="top">&nbsp;</td>
					</tr>
					<tr>
						<td colspan="4" valign="top" style="">
							<!-- 主内容 start -->
							<div class="main">
							    <div class="wraper">
							    <p class="tr"><a href="user/toUserList.do" class="blue ml10 fz12">返回列表»</a></p>
							        <form class="registerform" action="" onsubmit="return false;" method="post">
							            <table width="100%" style="table-layout:fixed;">
							            	<tr>
							            		<td class="need" style="width:10px;">*</td>
							            		<td style="width:70px;">用户名：</td>
							                    <td style="width:205px;">
							                    	<input type="text" value="" name="userName" 
							                    		class="inputxt" datatype="*1-50" nullmsg="请输入用户名！" errormsg="用户名范围在1~50位之间！" /></td>
							                    <td><div class="Validform_checktip"></div></td>
							            	</tr>
							                <tr>
							                    <td class="need" style="width:10px;">*</td>
							                    <td style="width:70px;">密码：</td>
							                    <td style="width:205px;">
							                    	<input type="password" value="" name="password" 
							                    		class="inputxt" datatype="*6-16" nullmsg="请设置密码！" errormsg="密码范围在6~16位之间！" /></td>
							                    <td><div class="Validform_checktip"></div></td>
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
							                	<td class="need">*</td>
							                	<td style="width:205px;">状态：</td>
							                	<td>
							                		<select name="status" datatype="*" nullmsg="请选择状态！" class="Validform_error">
							                			<option value="">--请选择--</option>
							                			<option value="1">启用</option>
							                			<option value="2">禁用</option>
							                		</select>
							                	</td>
							                	<td><div class="Validform_checktip"></div></td>
							                </tr>
							                <!-- <tr>
							                 	<td class="need">*</td>
							                    <td style="width:205px;">注册日期：</td>
							                    <td>
							                    	<input type="text" class="Wdate"  name="registerDate"  onclick="WdatePicker()"
							                    		 /></td>
							                    <td></td>
							                </tr>
							                 <tr>
							                 	<td class="need">*</td>
							                    <td style="width:205px;">时间：</td>
							                    <td>
							                    	<input type="text" class="Wdate"  name="testTime"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
							                    		 /></td>
							                    <td></td>
							                </tr> -->
							                <tr>
							                    <td class="need"></td>
							                    <td></td>
							                    <td colspan="2" style="padding:10px 0 18px 0;">
							                        <input type="submit" value="提 交" class="ajaxpost"/> 
							                        <input type="reset" value="重 置" />
							                    </td>
							                </tr>
							            </table>
							        </form>
							    </div>
							</div>
							<!-- 主内容 end -->
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
	
	<!-- 表单验证 -->
	<script type="text/javascript" src="plugins/validform/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="plugins/validform/Validform.js"></script>
	<script type="text/javascript" src="plugins/validform/form.js"></script>
	<script type="text/javascript">
	$(function(){
		initForm(".registerform", callback);
		
		function callback(form){
			var check=confirm("您确定要提交吗？");
			if(check){
				$.ajax({
					type: "POST",
					url: "user/ajaxAddUser.do",
					data: $(".registerform").serialize(),
					success: function(data)
					{
						if("" == data)
						{
							alert("添加用户成功");
							location.href="${pageContext.request.contextPath}/user/toUserList.do";
						}else
						{
							alert(data);
						}
					},
					error: function()
					{
						alert("失败");
					}
				});
			}
			
			return false;
		};
	});
	</script>
</body>
</html>