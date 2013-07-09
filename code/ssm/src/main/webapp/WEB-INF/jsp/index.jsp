<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${sysTitle}</title>
<script type="text/javascript" src="js/jquery.js"></script>
<script src="plugins/dialog/jquery.artDialog.source.js?skin=blue"
	type="text/javascript"></script>
<script type="text/javascript"
	src="plugins/dialog/plugins/iframeTools.js"></script>
<script type="text/javascript" src="plugins/dialog/artDialog.notice.js"></script>
<script type="text/javascript">
	//配置artDialog全局默认参数
	(function(config) {
		config['lock'] = true;
		config['fixed'] = true;
		config['okVal'] = '确定';
		config['cancelVal'] = '取消';
		config['background'] = '#FFFFFF';//设置遮罩层背景颜色
		// [more..]
	})(art.dialog.defaults);

	//窗口抖动
	artDialog.fn.shake = function() {
		var style = this.DOM.wrap[0].style, p = [ 4, 8, 4, 0, -4, -8, -4, 0 ], fx = function() {
			style.marginLeft = p.shift() + 'px';
			if (p.length <= 0) {
				style.marginLeft = 0;
				clearInterval(timerId);
			}
			;
		};
		p = p.concat(p.concat(p));
		timerId = setInterval(fx, 13);
		return this;
	};

	$(function() {
		art.dialog
				.notice({
					title : '系统提示',
					width : 200,// 必须指定一个像素宽度值或者百分比，否则浏览器窗口改变可能导致artDialog收缩
					height : 100,
					content : '<p style="font-size:12px;">你好[<font color=red>${user.userName}</font>]</p>',
					icon : 'face-smile',
					time : 5,
					init : function() {
						var that = this, i = 5;
						var fn = function() {
							that.title(i + '秒后关闭');
							!i && that.close();
							i--;
						};
						timer = setInterval(fn, 1000);
						fn();
					},
					close : function() {
						clearInterval(timer);
					}
				});
	});
	
	/* window.onbeforeunload = function exitWindow()
	{
		event.returnValue="确定离开当前页面吗？";
		return "确定离开当前页面吗？";//
	} */
	
	/* window.onbeforeunload   =   function(e){
			e = e || window.event;
			
	      var   n   =   window.event.screenX   -   window.screenLeft;   
	      var   b   =   n   >   document.documentElement.scrollWidth-20;   
	      if(b   &&   window.event.clientY   <   0   ||   window.event.altKey)   
	      {   
	         // alert("是关闭而非刷新");   
	        e.returnValue   =   "是否关闭？"; // For IE and Firefox prior to version 4 
		    	 
	      }else
	      {
	        //alert("是刷新而非关闭");   
	      }   
	     
	    var bw = checkbrowse();
        if(bw.is == 'chrome')
        {
        	 return "你确认要退出吗？";// For Safari  and Chrome 
        }
	     
	} */
	
</script>
<script type="text/javascript">
<!--
	/* var winWidth = 0;
	var winHeight = 0;
	function findDimensions() // 函数：获取尺寸
	{
		// 获取窗口宽度
		if (window.innerWidth)
			winWidth = window.innerWidth;
		else if ((document.body) && (document.body.clientWidth))
			winWidth = document.body.clientWidth;
		// 获取窗口高度
		if (window.innerHeight)
			winHeight = window.innerHeight;
		else if ((document.body) && (document.body.clientHeight))
			winHeight = document.body.clientHeight;
		// 通过深入 Document 内部对 body 进行检测，获取窗口大小
		if (document.documentElement && document.documentElement.clientHeight
				&& document.documentElement.clientWidth) {
			winHeight = document.documentElement.clientHeight;
			winWidth = document.documentElement.clientWidth;
		}
		// 结果输出至两个文本框
		document.getElementById("topFrame").height = winHeight - 2;
		//document.getElementById("topFrame").width= winWidth;
	} */
	// 调用函数，获取数值
	//window.onresize = findDimensions;
//-->
</script>

	<style type="text/css">
		html,body{height:100%;}
		#topFrame{
			height:auto!important; /*for ie6 bug and ie7+,moz,webkit 正确*/
			height:100%; /*修复IE6,all browser*/
			min-height:99%; /*for ie6 bug and ie7+,moz,webkit 正确*/
		}
		
		.BScreen_omBtn {
			height: 15px;
			width: 15px;
			position: absolute;
			cursor: pointer;
			overflow: hidden;
			background: url(images/iconctrls.gif) no-repeat;
			z-index: 1210;
			
			background-position: 0 -26px;
			background-position-x: 0px;
			background-position-y: -26px;
		}
		
		.BScreen_omBtnClosed {
			background-position: 0 -41px;
			background-position-x: 0px;
			background-position-y: -41px;
		}
	</style>
	<script type="text/javascript">
		function setsitebar(obj)
		{
			var topObject = top.topFrame.document.getElementsByTagName("frameset")[0].rows;
			var obj = top.topFrame.document.getElementsByTagName("frameset")[1].cols;
			
			if(topObject == "0,*" && obj == "0,0,*")
			{
				top.topFrame.document.getElementsByTagName("frameset")[0].rows = "90,*";
			}else
			{
				top.topFrame.document.getElementsByTagName("frameset")[0].rows = "0,*";
			}
			
			if(obj == "0,0,*")
			{//打开
				$(obj).removeClass("BScreen_omBtnClosed");
				top.topFrame.document.getElementsByTagName("frameset")[1].cols = "190,10,*";
				$("#sitebarimg").attr("src", "images/sbhide.gif");
			}
			else
			{//关闭
				$(obj).addClass("BScreen_omBtnClosed"); 
				top.topFrame.document.getElementsByTagName("frameset")[1].cols = "0,0,*";
				$("#sitebarimg").attr("src", "images/sbshow.gif");
			}
		}
	</script>	
</head>
<body style="margin: 0px;">
	<div style="width: 100%; height: 100%;">
		<iframe id="topFrame" name="topFrame" src="frame.do"
			style="margin: 0px;" frameborder="0" width="100%" height="100%"></iframe>
	</div>
	
	<div class="BScreen_omBtn" style="bottom: 0px; right: 0px; top: auto; left: auto;" onclick="setsitebar(this)"></div>
</body>

</html>