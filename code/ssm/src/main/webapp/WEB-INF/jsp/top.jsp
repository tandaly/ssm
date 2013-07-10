<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<base target="main">
<meta http-equiv=Content-Type content=text/html;charset=UTF-8>
<!-- <meta http-equiv="refresh" content="60"> -->
<script type="text/javascript" src="js/jquery.js"></script>
<link href="images/skin.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
	function locks() {
		suopin = top.art
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
						
						$.ajax({
							type: 'POST',
							url: 'user/ajaxValidPassword.do',
							data: {"param": input.value},
							success: function(data)
							{
								if (data.status != 'y') {
									suopin.shake && suopin.shake();// 调用抖动接口
									input.select();
									input.focus();
								} else {
									suopin.close();
									top.art.dialog({
										content : '密码正确！',
										icon : 'succeed',
										fixed : true,
										lock : true,
										time : 1.5
									});
								}
							}
						});
						return false;
					},
					cancel : false
				});
	}

	function logout() {
		top.art.dialog.confirm('你确定要退出系统吗？', function() {
			top.location = "logout.do";
		}, function() {
			top.art.dialog.alert("你还挺明智的嘛");
		});
	}
	
	function setsitebar()
	{
		
		top.topFrame.document.getElementsByTagName("frameset")[0].rows = "0,*";
		
		top.topFrame.document.getElementsByTagName("frameset")[1].cols = "0,10,*";
	}
</script>
<style type="text/css">
	.a {
		color: #333;
		text-decoration: none;
	}
	.a:hover {
		color: #CA0000;
		text-decoration: none;
	}
	
	.logo {
		color: #5F7B00;
		font-size: 25px;
		line-height: 38px;
		text-shadow: 2px 2px 5px #092334;
		font-weight: bold;
	}
</style>

<script type="text/javascript">
	//密码修改弹出框
	function openUpdatePassword()
	{
		top.art.dialog.open('user/updateUserPassword.do',
		    {id: 'updateUserPassword', title: '修改密码', width:500, height:400, lock: true,
			 ok: function () {
		    	var iframe = this.iframe.contentWindow;
		    	if (!iframe.document.body) {
		        	return false;
		        };
		        iframe.$("#submit").click();
		       	return false;
			 },
			 button:[{
				    name: '关闭',
				    callback: function() {
				    	return true;
				    }
				}]
			 
		    });
	}
</script>

</head>
<body leftmargin="0" topmargin="0">
	<!-- bg color BDDEE3 -->
	<!-- 
		D8E7ED
		D6EDFF
		306DA4
	 -->
	<!-- 顶部区域 -->
	<div style="width:100%;height:34px;background-color:#D6EDFF; background-repeat: repeat-x;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="38%">
					<div class="logo" style="padding-left:50px;">
						${sys_params.SYS_TITLE}
					</div>
				</td>
				<td width="30%" height="38" class="admin_txt" align="right">
					欢迎你[<b style="color:red">${user.userName}</b>]
				</td>
				<td style="padding-left:20px;text-align:right;font-size: 12px;" width="30%">
					<a href="main.do" target="main" class="a">首页</a>|
					<a href="#" target="_self" onClick="openUpdatePassword();" class="a">修改密码</a>|
					<a href="#" target="_self" onClick="locks();" class="a">锁屏</a>|
					<a href="#" target="_self" onClick="setsitebar();" class="a">切屏</a>|
					<a href="#" target="_self" onClick="logout();" class="a">退出</a>
				</td>
				<td width="2%">&nbsp;</td>
			</tr>
		</table>
	</div>
	
	<!-- 
		好看的蓝色背景色：
			1977B0
			3777BC
			3398CC
			285B85
			2A689D
			1C3C78
		绿色：
			74C862
		红色：
			B10606
			E50039
		黄色：
			ECAD81
	-->
	<!-- 顶级菜单条 -->
	<!-- <div style="width:100%;height:36px;background-image: url('images/top-menu.jpg'); padding-bottom:5px; margin:0px; font-size:12px; background-repeat: repeat-x;"> -->
	<div style="width:100%;height:36px;background-color:#1C3C78; padding-bottom:5px; margin:0px; font-size:12px; background-repeat: repeat-x;">
		<marquee scrollamount="2" onmouseover="this.stop();"
				onmouseout="this.start();">
			<pre><b style="color:red">公告</b>: 系统升级啦!         -2013年07月05日</pre>
		</marquee>
	</div> 
	
	<!-- 底部样式 -->
	<div style="width:100%;height:11px;margin:0px;background-image: url('images/top-bottom.jpg'); background-repeat: repeat-x;">
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