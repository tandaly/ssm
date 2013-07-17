<%@page contentType="text/html;charset=UTF-8"
	trimDirectiveWhitespaces="true"%>
<base
	href="${pageContext.request.scheme}${'://'}${pageContext.request.serverName}${':'}${pageContext.request.serverPort}${pageContext.request.contextPath}/" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="tandaly" name="description" />
<meta content="java" name="keywords" />
<script src="js/jquery.js"></script>
<link rel="shortcut icon" href="/favicon.ico" />

<link href="images/skin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/iframe.js"></script>

<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-color: #FFFFFF;
}

//
分页背景
	#pageDiv {
	//background-color: #EEF2FB;
	}



.editor_mask {
	position: absolute;
	top: 0;
	left: 0;
	z-index: 998;
	background: #fff;
	opacity: 0.3;
	filter: alpha(opacity = 30);
	width: 100%;
	height: 100%;
}
.opa50Mask {
	opacity: 0.3;
	filter: alpha(opacity = 30);
	background: #ccc;
}

.maskLayerTip {
	background: url("images/pagination_loading.gif") no-repeat scroll 5px 10px #FFFFFF;
	
	/*border: 2px solid #6593CF;
	color: #222222;
	display: none;
	height: 16px;
	left: 100px;
	padding: 12px 5px 10px 30px;
	position: absolute;
	top: 50px;
	width: auto;
	*/
	position: absolute;
	z-index: 1120;
	cursor: wait;
	left: 382px;
	top: 154px;
	width: auto;
	height: 16px;
	padding: 12px 5px 10px 30px;
	/*background: #fff no-repeat scroll 5px 10px;*/
	border: 2px solid #6593CF;
	color: #222;
	display: none;
	font-size:12px;
}
-->
</style>
<script type="text/javascript">
<!--
	var basePath = '${base}';
//-->
</script>

<!-- <div id="maskLayer"
	style="display:none; width: 100%; height: 100%; position: fixed; z-index: 2015; top: 0px; left: 0px; overflow: hidden;">
	<div
		style="height: 100%; background-color: rgb(0, 0, 0); opacity: 0.5; background-position: initial initial; background-repeat: initial initial;"></div>
</div> -->

<!-- 遮罩层 -->
<div id="_maskLayer" class="editor_mask opa50Mask "
	style="z-index: 98; display: none;" tabindex="0">
		
</div>
<div id="_maskLayerTip" class="maskLayerTip"  style="left: 382px;top: 200px;">正在执行操作，请稍候！</div>
	