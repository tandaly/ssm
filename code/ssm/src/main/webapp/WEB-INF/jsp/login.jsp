<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns=http://www.w3.org/1999/xhtml>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${sysTitle}</title>
<script type="text/javascript" src="js/jquery.js"></script>
<style type="text/css">
<!--
	html,body{
		height:100%;
		width: 100%;
		margin-left: 0px;
		margin-top: 0px;
		margin-right: 0px;
		margin-bottom: 0px;
		background-color: #FFF;/*#E1E4EB;*/
		font-size: 14px;
		font-family: Arial, Helvetica, sans-serif;
	}
	.mainContent{
		height:auto!important; /*for ie6 bug and ie7+,moz,webkit 正确*/
		height:100%; /*修复IE6,all browser*/
		min-height:99%; /*for ie6 bug and ie7+,moz,webkit 正确*/
	}
	
	.login-top {
		width: 100%;
		height: 42px;
		background-color:#024BA0;
		margin-bottom: 80px;
	}
	
	.login-content {
		width: 100%;
	}	
	.login-content-left {
		float: left;
		width: 40%;
		text-align: right;
	}
	.login-content-right {
		float: right;
		width: 50%;
		height: 100%;
		border-left: 1px;
		border-left-color: #ccc;
		border-left-style: solid;
		padding: 20px;
		text-align: left;
	}
	
	.login-bottom {
		bottom: 0px;
		position: absolute;
		text-align: center;
		background: #024BA0;
		height: 78px;
		width: 100%;
		margin: 0 auto;
	}
	.login-buttom-txt {
		font-family: Arial, Helvetica, sans-serif;
		font-size: 14px;
		color: #fff;
		text-decoration: none;
		line-height: 20px;
		font-weight: bold;
	}
	
	.login_txt_bt {
		font-family: Arial, Helvetica, sans-serif;
		font-size: 30px;
		line-height: 90px;
		color: #666666;
		font-weight: bold;
	}
	
	.login_txt {
		width: 150px;
		padding-right: 15px;
		font-family: Arial, Helvetica, sans-serif;
		font-size: 14px;
		line-height: 25px;
		color: #333333;
	}
	
	#myform .button {
		background: url(images/bg_button_login.jpg) center center no-repeat;
		color: #333;
		width: 87px;
		height: 33px;
		line-height: 33px;
		border: none;
		padding: 0;
		cursor: pointer;
	}
	
	.userName {
		background: #FFFFFF url(images/user.gif) 5px center no-repeat;
	}
	
	.password {
		background: #FFFFFF url(images/luck.gif) 5px center no-repeat;
	}
	
	.userName, .password{
		margin-bottom: 15px;
		padding: 5px 5px 5px 25px;
		height: 20px;
		width: 220px;
		border: 1px #C4D9E1 solid;
		color: #333;
	}
	
	.verifyCode{
		padding: 5px 5px 5px 25px;
		height: 20px;
		width: 150px;
		border: 1px #C4D9E1 solid;
		color: #333;
	}
	.vcode {
		margin-bottom: 15px;
	}
	-->
</style>
<script type="text/javascript">
	
	$(function(){
		$("input[name=userName]").focus();
	});
</script>
</head>
<body>
	<div id="mainContent">
		<div class="login-top">
		</div>
		
		<div class="login-content">
			<div class="login-content-left">
				<div style="margin-top:100px;">
					<img alt="" src="images/login-left-img.gif" style="height: 260px;">
				</div>
			</div>
			<div class="login-content-right">
				<span class="login_txt_bt">${sysTitle}</span>
				<form id="myform" name="myform" action="logins.do" method="post">
						<table width="360" cellspacing="0" cellpadding="0" border="0">
							<tr>
								<td>
									<span class="login_txt">&nbsp;</span>
								</td>
								<td> 
									<font color="red" style="font-size:12px;line-height:40px;">${msg} &nbsp;</font>
								</td>
							</tr>
							<tr>
								<td >
									<span class="login_txt">用户名</span>
								</td>
								<td colspan="2" >
									<input class="userName" name="userName" value="" size="20">
								</td>
							</tr>
							<tr>
								<td>
									<span class="login_txt"> 密&nbsp;&nbsp;码 </span>
								</td>
								<td colspan="2">
									<input class="password" type="password" size="20" name="password"> 
								</td>
							</tr>
							<tr>
								<td>
									<span class="login_txt">验证码</span>
								</td>
								<td colspan="2" >
									<div class="vcode">
										<input class="verifyCode" name="verifyCode" type="text" value="" maxLength=4 size=10>
										<img id="verifyCodeImg" name="verifyCodeImg" height="28" width="60" style="vertical-align:bottom;cursor:pointer;"
											title="点我换下张图" border=0 onClick="javascript:document.getElementById('verifyCodeImg').src='image.do?'+Math.random();" src="image.do" >
									</div>
									</td>
							</tr>
							<tr>
								<td>
									<span class="login_txt">&nbsp;</span>
								</td>
								<td  colspan="2" >
									<div style="margin-bottom: 15px;">
										<input type="checkbox" />记住密码
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<span class="login_txt">&nbsp;</span>
								</td>
								<td >
									<div style="width:100%;">
										<input name="Submit" type="submit" class="button" id="Submit" value="登  录">
										<input type="reset" class="button" value="重  置">
									</div>
								</td>
							</tr>
						</table>
				</form>
			</div>
		</div>
		<div class="login-bottom">
			<span class="login-buttom-txt">Copyright &copy; 2013 tandaly</span>
		</div>
	</div>	
	
</body>

</html>