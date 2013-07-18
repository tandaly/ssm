<%@page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@include file="/WEB-INF/jsp/common/header.jsp"%>	
	<title>查看</title>
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
	            		<td class="need" style="width:10px;">&nbsp;</td>
	            		<td style="width:70px;">父菜单编号：</td>
	                    <td style="width:205px;">
                    		<input type="text" value="${menu.parentNo}" disabled="disabled"class="inputxt" />
	                    </td>
	            	</tr>
	            	<tr>
	            		<td class="need" style="width:10px;"></td>
	            		<td style="width:70px;">菜单编号：</td>
	                    <td style="width:205px;">
	                    	<input type="text" value="${menu.menuNo}" disabled="disabled"class="inputxt" />
	                    </td>
	            	</tr>
	            	<tr>
	            		<td class="need" style="width:10px;"></td>
	            		<td style="width:70px;">菜单名称：</td>
	                    <td style="width:205px;">
	                    	<input type="text" disabled="disabled" value="${menu.menuName }" class="inputxt" />
	                    </td>
	            	</tr>
	            	<tr>
	            		<td class="need" style="width:10px;"></td>
	            		<td style="width:70px;">菜单地址：</td>
	                    <td style="width:205px;">
	                    	<input type="text" disabled="disabled" value="${menu.menuUrl }" class="inputxt" />
	                    </td>
	            	</tr>
	            	<tr>
	            		<td class="need" style="width:10px;"></td>
	            		<td style="width:70px;">菜单图标：</td>
	                    <td style="width:205px;">
	                    	<input type="text" disabled="disabled" value="${menu.icon }" class="inputxt" />
	                    </td>
	            	</tr>
	                <tr>
	            		<td class="need" style="width:10px;">&nbsp;</td>
	            		<td style="width:70px;">排序编号：</td>
	                    <td style="width:205px;">
	                    	<input type="text" disabled="disabled" value="${menu.orderNo }" class="inputxt"/>
	                    </td>
	            	</tr>
	            	 <tr>
	                	<td class="need"></td>
	                	<td style="width:205px;">状&nbsp;&nbsp;态：</td>
	                	<td>
	                		<input type="text" disabled="disabled" value="${menu.status }" class="inputxt"/>
	                	</td>
	                </tr>
	            </table>
	        </form>
	    </div>
	</div>
</body>
</html>