<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<base target="main">
<meta http-equiv=Content-Type content=text/html;charset=UTF-8>
<!-- <meta http-equiv="refresh" content="60"> -->
<script type="text/javascript" src="js/jquery.js"></script>
<link href="images/skin.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
	function locks() {
		top.art
				.dialog({
					lock : true,
					fixed : true,
					background : '#600', // 背景色
					opacity : 0.87, // 透明度
					content : '<p style="font-size:12px;">密码:'
							+ '<input type="password" id="demo-labs-input" style="width:15em; padding:4px" /></p>',
					icon : 'question',
					ok : function() {
						var input = top.document
								.getElementById('demo-labs-input');

						if (input.value !== '${user.password}') {
							this.shake && this.shake();// 调用抖动接口
							input.select();
							input.focus();
							return false;
						} else {
							top.art.dialog({
								content : '密码正确！',
								icon : 'succeed',
								fixed : true,
								lock : true,
								time : 1.5
							});
						}
						;
					},
					cancel : false
				});
	}

	function logout() {
		top.art.dialog.confirm('你确定要退出系统吗？', function() {
			top.location = "logout.do";
		}, function() {

		});
	}
	
	function setsitebar()
	{
		
		top.topFrame.document.getElementsByTagName("frameset")[0].rows = "0,*";
		
		var obj = top.topFrame.document.getElementsByTagName("frameset")[1].cols;
		if(obj == "0,10,*")
		{
			top.topFrame.document.getElementsByTagName("frameset")[1].cols = "200,10,*";
		}
		else
		{
			top.topFrame.document.getElementsByTagName("frameset")[1].cols = "0,10,*";
		}
	}
</script>
</head>
<body leftmargin="0" topmargin="0">
	<div style="width:100%;height:96px;background-image: url('images/bg.jpg');">
		
		<table width="100%" height="64" border="0" cellpadding="0"
			cellspacing="0" >
			<tr>
				<td height="64">
					<!-- <img src="images/logo.gif"
					width="262" height="64"> -->
				</td>
				<td  valign="top"><table width="100%" border="0"
						cellspacing="0" cellpadding="0">
						<tr>
							<td width="70%">
								&nbsp;
							</td>
							<td height="38" class="admin_txt">
								用户：<b>${user.userName}</b>
									您好,感谢登陆使用！
									【<font onclick="locks();" style="cursor: pointer;">锁屏</font>】
									【<font onclick="setsitebar();" style="cursor: pointer;">切屏</font>】
							</td>
							<td><a href="#" target="_self"
								onClick="logout();"><img src="images/out.gif" alt="安全退出"
									width="46" height="20" border="0"></a></td>
							<td width="4%">&nbsp;</td>
						</tr>
					</table></td>
			</tr>
		</table> 
		
	</div>
 	<%-- <table width="100%" height="64" border="0" cellpadding="0"
		cellspacing="0" >
		<tr class="admin_topbg">
			<td height="64">
				<!-- <img src="images/logo.gif"
				width="262" height="64"> -->
			</td>
			<td  valign="top"><table width="100%" border="0"
					cellspacing="0" cellpadding="0">
					<tr>
						<td width="70%">
							&nbsp;
						</td>
						<td height="38" class="admin_txt">
							用户：<b>${user.userName}</b>
								您好,感谢登陆使用！
								【<font onclick="locks();" style="cursor: pointer;">锁屏</font>】
								【<font onclick="setsitebar();" style="cursor: pointer;">切屏</font>】
						</td>
						<td><a href="#" target="_self"
							onClick="logout();"><img src="images/out.gif" alt="安全退出"
								width="46" height="20" border="0"></a></td>
						<td width="4%">&nbsp;</td>
					</tr>
					<tr class="top_bottom">
						<td  colspan="4">&nbsp;</td>
					</tr>
				</table></td>
		</tr>
	</table>  --%>
	
</body>
</html>

</body>
</html>