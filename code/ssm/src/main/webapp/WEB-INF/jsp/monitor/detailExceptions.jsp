<%@page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@include file="/WEB-INF/jsp/common/header.jsp"%>	
	<title>详情</title>
</head>

<body style="background-color: #FFF">  

	<!-- 主内容 start -->
	<div class="main">
	    <div class="wraper">
	        <form id="form" name="form" class="registerform" action="" onsubmit="return false;" method="post">
	            <table width="100%" style="table-layout:fixed;padding-left: 10px;" border="0">
	            	<tr>
	            		<td class="need" style="width:10px;"></td>
	            		<td style="width:70px;">激活时间：</td>
	                    <td style="width:205px;">
	                    	${exceptions.activeTime}
	                    <td></td>
	            	</tr>
	            	<tr>
	            		<td class="need" style="width:10px;"></td>
	            		<td style="width:70px;">类&nbsp;&nbsp;名：</td>
	                    <td style="width:205px;color:green;">
	                    	${exceptions.className}
	                    <td></td>
	            	</tr>
	            	<tr>
	            		<td class="need" style="width:10px;"></td>
	            		<td style="width:70px;">方&nbsp;&nbsp;法：</td>
	                    <td style="width:205px;">
	                    	${exceptions.methodName}
	                    <td></td>
	            	</tr>
	            	<tr>
	            		<td class="need" style="width:10px;"></td>
	            		<td style="width:70px;">描&nbsp;&nbsp;述：</td>
	                    <td style="width:205px;">
	                    	<!-- <div style="width:600px;height:300px; border: 1px solid #999; word-break: keep-all; overflow-y: scroll; margin-left: 1px;"> -->
	                    	<textarea cols="138" rows="30" style="color: red" readonly="readonly">${exceptions.description}</textarea>
	                    <td></td>
	            	</tr>
	            </table>
	        </form>
	    </div>
	</div>
							
</body>
</html>