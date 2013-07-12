<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="reset.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<!--单选下拉框(分离版)start-->
<link href="skins/style.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="js/select_split.js"></script>
<!--单选下拉框(分离版)end-->
<body>
		<div class="box2" panelTitle="基本用法" roller="true">
单选下拉框的写法与传统的一样。支持TAB键打开和上下箭头选择option。支持onchange事件，见下面<br />
<select  onchange='selFunc()' id="sel">
	<option value="">请选择功能</option>
    <option value="1">新增图片</option>
    <option value="2">维护图片</option>
    <option value="3">新增新闻</option>
 </select>
 选中项：<label id="selText">未选择</label>				
<script>
	function selFunc(){
		$("#selText").text($("#sel").val())
	}
</script>
	
</body>

</html>