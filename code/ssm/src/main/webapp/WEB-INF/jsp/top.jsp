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
	
	
	/*换肤功能
	------------------------------------*/
	#ul_skins{
		float:right;
	    padding:5px;
		width:120px;
	    padding-right:0px;
		list-style:none;
		overflow:hidden;
	    }
	#ul_skins li{
		float:left;
	    margin-right:5px;
	    width:15px;
	    height:15px;
		text-indent:-999px;
		overflow:hidden;
		display:block;
		cursor:pointer;
		background-image:url(images/theme.gif);
	}
	#green{
		background-position:0px 0px;
	}
	#blue{
		background-position:15px 0px;
	}
	#red{
		background-position:35px 0px;
	}
	#pink{
		background-position:55px 0px;
	}
	#gray{
		background-position:75px 0px;
	}
	#brown{
		background-position:95px 0px;
	}
	#green.selected{
		background-position:0px 15px !important;
	}
	#blue.selected{
		background-position:15px 15px !important;
	}
	#red.selected{
		background-position:35px 15px !important;
	}
	#pink.selected{
		background-position:55px 15px !important;
	}
	#gray.selected{
		background-position:75px 15px !important;
	}
	#brown.selected{
		background-position:95px 15px !important;
	}
	
	#topMenu {
		background-color: #024BA0;
	}
	
	#topMenu.green{
		background-color: #4D9016;
	}
	
	#topMenu.blue{
		background-color: #1B74A2;
	}
	
	#topMenu.pink{
		background-color: #D13270;
	}
	
	#topMenu.gray{
		background-color: #5E6369;
	}
	
	#topMenu.red{
		background-color: #AC1838;
	}
	
	#topMenu.brown{
		background-color: #75574C;
	}
</style>

<script type="text/javascript">
	
	$(function(){
		addChangeSkinEvent();
	});

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
	
	//添加皮肤选择监听
	function addChangeSkinEvent() {
		var $li = $("#ul_skins li");
		$li.click(function () {
			switchSkin(this.id);
		});
	}
	
	//切换皮肤操作
	function switchSkin(_skinName) {
		$("#" + _skinName).addClass("selected").siblings().removeClass("selected");  //去掉其他同辈<li>元素的选中
		
		$("#topMenu").attr("class", "").addClass(_skinName);//.css("background-color", "#74C862");
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
	<div id="topArea" style="width:100%;height:34px;background-color:#D6EDFF; background-repeat: repeat-x;">
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
				<td>
					<div id="minimize_container">
						<ul id="ul_skins" style="margin-left:10px;margin-top:7px;">
					        <li id="green" title="绿色" ></li>
							<li id="blue" title="蓝色" ></li>
							<li id="pink" title="桃红色" ></li>
							<li id="gray" title="灰色"></li>
							 
							<li id="red" title="红色" onclick=""></li>
							<li id="brown" title="褐色"></li>
							
				      	</ul>
					</div>
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
			024BA0
		绿色：
			74C862
		红色：
			B10606
			E50039
		黄色：
			ECAD81
	-->
	<!-- 系统顶部菜单条 -->
	<!-- <div style="width:100%;height:36px;background-image: url('images/top-menu.jpg'); padding-bottom:5px; margin:0px; font-size:12px; background-repeat: repeat-x;"> -->
	<div id="topMenu" style="width:100%;height:36px; padding-bottom:5px; margin:0px; font-size:12px; background-repeat: repeat-x;">
		<div style="margin:0 auto;width:500px;">
			<span style="cursor:pointer;" onclick="javascript:alert('${notice.id}');" >
				<marquee scrollamount="2" onmouseover="this.stop();"
						onmouseout="this.start();" style="color:#E3C387;">
					<pre><b style="color:red">系统公告</b>: ${notice.title} -${notice.createTime}发布</pre>
				</marquee>
			</span>
		</div>
	</div> 
	
	<!-- 底部样式 -->
	<div style="width:100%;height:11px;margin:0px;background-image: url('images/top-bottom.jpg'); background-repeat: repeat-x;">
	</div>
</body>
</html>

</body>
</html>