<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>
<link href="images/skin.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-color: #E1E4EB;
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
	padding: 5px 5px 5px 25px;
	height: 30px;
	width: 220px;
	border: 1px #C4D9E1 solid;
	color: #333;
}

.verifyCode{
	padding: 5px 5px 5px 25px;
	height: 30px;
	width: 150px;
	border: 1px #C4D9E1 solid;
	color: #333;
}
-->
</style>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
	
	$(function(){
		$("input[name=userName]").focus();
	});
	
	function correctPNG() {
		var arVersion = navigator.appVersion.split("MSIE");
		var version = parseFloat(arVersion[1]);
		if ((version >= 5.5) && (document.body.filters)) {
			for ( var j = 0; j < document.images.length; j++) {
				var img = document.images[j];
				var imgName = img.src.toUpperCase();
				if (imgName.substring(imgName.length - 3, imgName.length) == "PNG") {
					var imgID = (img.id) ? "id='" + img.id + "' " : "";
					var imgClass = (img.className) ? "class='" + img.className
							+ "' " : "";
					var imgTitle = (img.title) ? "title='" + img.title + "' "
							: "title='" + img.alt + "' ";
					var imgStyle = "display:inline-block;" + img.style.cssText;
					if (img.align == "left")
						imgStyle = "float:left;" + imgStyle;
					if (img.align == "right")
						imgStyle = "float:right;" + imgStyle;
					if (img.parentElement.href)
						imgStyle = "cursor:hand;" + imgStyle;
					var strNewHTML = "<span "
							+ imgID
							+ imgClass
							+ imgTitle
							+ " style=\""
							+ "width:"
							+ img.width
							+ "px; height:"
							+ img.height
							+ "px;"
							+ imgStyle
							+ ";"
							+ "filter:progid:DXImageTransform.Microsoft.AlphaImageLoader"
							+ "(src=\'" + img.src
							+ "\', sizingMethod='scale');\"></span>";
					img.outerHTML = strNewHTML;
					j = j - 1;
				}
			}
		}
	}
</script>
<style type="text/css">
	html,body{height:100%;}
	#content{
		height:auto!important; /*for ie6 bug and ie7+,moz,webkit 正确*/
		height:100%; /*修复IE6,all browser*/
		min-height:99%; /*for ie6 bug and ie7+,moz,webkit 正确*/
	}
</style>
</head>
<body onload="correctPNG();">
	<div id="content">
	<table id="loginTable" width="100%" height="99%" border="0" cellpadding="0"
		cellspacing="0">
		<tr>
			<td height="42" valign="top"><table width="100%" height="42"
					border="0" cellpadding="0" cellspacing="0" class="login_top_bg">
					<tr>
						<td width="1%" height="21">&nbsp;</td>
						<td height="42">&nbsp;</td>
						<td width="17%">&nbsp;</td>
					</tr>
				</table></td>
		</tr>
		<tr>
			<td valign="top"><table width="100%" height="532" border="0"
					cellpadding="0" cellspacing="0" class="login_bg">
					<tr>
						<td width="49%" align="right"><table width="91%" height="532"
								border="0" cellpadding="0" cellspacing="0" class="login_bg2">
								<tr>
									<td height="138" valign="top"><table width="89%"
											height="427" border="0" cellpadding="0" cellspacing="0">
											<tr>
												<td height="149">&nbsp;</td>
											</tr>
											<tr>
												<td height="80" align="right" valign="top">
													<!-- <img src="images/logo.png" width="279" height="68"> -->
												</td>
											</tr>
											<tr>
												<td height="198" align="right" valign="top"><table
														width="100%" border="0" cellpadding="0" cellspacing="0">
														<tr>
															<td width="35%">&nbsp;</td>
															<td height="25" colspan="2" class="left_txt"><p>1-
																	网站系统...</p></td>
														</tr>
														<tr>
															<td>&nbsp;</td>
															<td height="25" colspan="2" class="left_txt"><p>2-
																	强大的后台系统...</p></td>
														</tr>
														<tr>
															<td>&nbsp;</td>
															<td width="30%" height="40"><img
																src="images/icon-demo.gif" width="16" height="16"><a
																href="#" target="_blank"
																class="left_txt3"> 使用说明</a></td>
															<td width="35%"><img
																src="images/icon-login-seaver.gif" width="16"
																height="16"><a href="#"
																class="left_txt3"> 在线客服</a></td>
														</tr>
													</table></td>
											</tr>
										</table></td>
								</tr>

							</table></td>
						<td width="1%">&nbsp;</td>
						<td width="50%" valign="bottom"><table width="100%"
								height="59" border="0" align="center" cellpadding="0"
								cellspacing="0" style="border-left: 1px;border-left-color: #ccc;border-left-style: solid;">
								<tr>
									<td width="4%">&nbsp;</td>
									<td width="96%"><span class="login_txt_bt">信息网系统管理</span></td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td height="21"><table cellSpacing="0" cellPadding="0"
											width="100%" border="0" id="table211" height="328">
											<tr>
												<td height="164" colspan="2" align="center"><form id="myform"
														name="myform" action="logins.do" method="post">
														<table cellSpacing="0" cellPadding="0" width="100%"
															border="0" height="143" id="table212">
															<tr>
																<td width="100%" colspan="2"> 
																	<font color="red" style="font-size:12px;padding-left:100px;line-height:40px;">${msg}&nbsp;</font>
																</td>
															</tr>
															<tr>
																<td width="13%" height="38" class="top_hui_text"><span
																	class="login_txt">用户名</span></td>
																<td height="38" colspan="2" >
																<input class="userName" name="userName" value="" size="20">
																</td>
															</tr>
															<tr>
																<td width="13%" height="35" class="top_hui_text"><span
																	class="login_txt"> 密&nbsp;&nbsp;码 </span></td>
																<td height="35" colspan="2" class="top_hui_text">
																	<input class="password" type="password" size="20" name="password"> 
																</td>
															</tr>
															<tr>
																<td width="13%" height="35"><span class="login_txt">验证码</span></td>
																<td height="35" colspan="2" >
																	<input class="verifyCode" name="verifyCode" type="text" value="" maxLength=4 size=10>
																	<img id="verifyCodeImg" name="verifyCodeImg" height="28" width="60" style="vertical-align:bottom;cursor:pointer;"
											title="点我换下张图" border=0 onClick="javascript:document.getElementById('verifyCodeImg').src='image.do?'+Math.random();"
											src="image.do" >
																	</td>
															</tr>
															<tr>
																<td width="13%" height="35"><span class="login_txt"></span></td>
																<td height="35" colspan="2" >
																	<input type="checkbox" />记住密码
																</td>
															</tr>
															<tr>
																<td width="100%" height="35" colspan="2" style="padding-left:76px;">
																	<input name="Submit" type="submit" class="button" id="Submit" value="登  录">
																	<input type="reset" class="button" value="重  置">
																</td>
															</tr>
														</table>
														<br>
													</form></td>
											</tr>
											<tr>
												<td width="433" height="164" align="right" valign="bottom">
													
													<!-- <img src="images/login-wel.gif" width="242" height="138"> -->
													
												</td>
												<td width="57" align="right" valign="bottom">&nbsp;</td>
											</tr>
										</table></td>
								</tr>
							</table></td>
					</tr>
				</table></td>
		</tr>
		<tr>
			<td height="20"><table width="100%" border="0" cellspacing="0"
					cellpadding="0" class="">
					<tr>
						<td align="center"><span class="login-buttom-txt">Copyright
								&copy; 2013 tandaly</span></td>
					</tr>
				</table></td>
		</tr>
	</table>
	</div>
</body>


</html>