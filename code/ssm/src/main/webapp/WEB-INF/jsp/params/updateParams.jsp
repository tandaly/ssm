<%@page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@include file="/WEB-INF/jsp/common/header.jsp"%>	
	<title>修改参数</title>
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
	            		<td class="need" style="width:10px;">*</td>
	            		<td style="width:70px;">名称：</td>
	                    <td style="width:205px;">
	                    	<input type="hidden" name="id" value="${params.id }" />
	                    	<input type="text" value="${params.name }" name="name"  ajaxurl="params/ajaxFormParamsName.do?id=${params.id}"
	                    		class="inputxt"  datatype="*1-50" nullmsg="请输入名称！" errormsg="名称范围在1~50位之间！" /></td>
	                    <td><div class="Validform_checktip">名称范围在1~50位之间！</div></td>
	            	</tr>
	            	<tr>
	            		<td class="need" style="width:10px;">*</td>
	            		<td style="width:70px;">值：</td>
	                    <td style="width:205px;">
	                    	<input type="text" value="${params.value }" name="value" 
	                    		class="inputxt"  datatype="*1-255" nullmsg="请输入值！" errormsg="值不能为空" /></td>
	                    <td><div class="Validform_checktip">值不能为空!</div></td>
	            	</tr>
	            	<tr>
	            		<td class="need" style="width:10px;">&nbsp;</td>
	            		<td style="width:70px;">描&nbsp;&nbsp;述：</td>
	                    <td style="width:205px;">
	                    	<textarea rows="3" cols="10" name="remark">${params.remark }</textarea>
	                    </td>
	                    <td><div class="Validform_checktip"></div></td>
	            	</tr>
	                <tr>
	                    <td class="need"></td>
	                    <td></td>
	                    <td colspan="2" style="padding:10px 0 18px 0;">
	                        <input type="submit" value="提 交" class="ajaxpost" id="submit" style="display:none;"/> 
	                    </td>
	                </tr>
	            </table>
	        </form>
	    </div>
	</div>
							
	
	<!-- 表单验证 -->
	<script type="text/javascript" src="plugins/validform/Validform.js"></script>
	<script type="text/javascript" src="plugins/validform/form.js"></script>
	<script type="text/javascript">
	$(function(){
		initForm(".registerform", callback);
		
		function callback(form){
			top.art.dialog.confirm('你确定要提交吗？', function () {
				$.ajax({
					type: "POST",
					url: "params/ajaxUpdateParams.do",
					data: $(".registerform").serialize(),
					success: function(data)
					{
						if("y" == data.status)
						{
							top.topFrame.main.window.fTable.queryForm();
							top.art.dialog.tips(data.info);
							top.art.dialog({id: 'updateDialog'}).close();
							
						}else
						{
							top.art.dialog.alert(data.info);
						}
					},
					error: function()
					{
						top.art.dialog.alert("操作失败");
					}
				});
			}, function () {
			    
			});
			
			return false;
		};
	});
	
	</script>
</body>
</html>