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
	            		<td style="width:70px;">标&nbsp;&nbsp;题：</td>
	                    <td style="width:520px;">
	                    	${notice.title}
	                    <td></td>
	            	</tr>
	            	<tr>
	            		<td class="need" style="width:10px;"></td>
	            		<td style="width:70px;">内&nbsp;&nbsp;容：</td>
	                    <td style="width:205px;">
	                    	${notice.content}
	                    <td></td>
	            	</tr>
	            	<tr>
	            		<td class="need" style="width:10px;"></td>
	            		<td style="width:70px;">发布时间：</td>
	                    <td style="width:520px;">
	                    	${fn:substring(notice.createTime, 0, 19)}
	                    <td></td>
	            	</tr>
	            </table>
	        </form>
	    </div>
	</div>
							
</body>
</html>