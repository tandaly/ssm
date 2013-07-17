<%@page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@include file="/WEB-INF/jsp/common/header.jsp"%>	
	<title>添加系统公告</title>
	<!-- 表单验证插件 -->
	<link rel="stylesheet" href="plugins/validform/css/style.css" type="text/css" media="all" />
	<link href="plugins/validform/css/form.css" type="text/css" rel="stylesheet" />
	<!-- 编辑器控件 -->
	<link rel="stylesheet" href="plugins/kindeditor/themes/default/default.css" />
	<script charset="utf-8" src="plugins/kindeditor/kindeditor-min.js"></script>
	<script charset="utf-8" src="plugins/kindeditor/lang/zh_CN.js"></script>
	<script>
			var editor;
			KindEditor.ready(function(K) {
				editor = K.create('textarea[name="content"]', {
					allowFileManager : true
				});
			});
	</script>
</head>

<body style="background-color: #FFF">  

	<!-- 主内容 start -->
	<div class="main">
	    <div class="wraper">
	        <form id="form" name="form" class="registerform" action="" onsubmit="return false;" method="post">
	            <table width="100%" style="table-layout:fixed;padding-left: 10px;" border="0">
	            	<tr>
	            		<td class="need" style="width:10px;">*</td>
	            		<td style="width:70px;">标题：</td>
	                    <td style="width:520px;">
	                    	<input type="text" value="" name="title" style="width:520px"
	                    		class="inputxt" datatype="*1-255" nullmsg="请输入标题！" errormsg="标题范围在1~255位之间！" />
	                    </td>
	                    <td><div class="Validform_checktip">标题范围在1~255位之间！</div></td>
	            	</tr>
	            	<tr>
	            		<td class="need" style="width:10px;">*</td>
	            		<td style="width:70px;">内容：</td>
	                    <td style="width:520px;">
	                    	<textarea rows="3" cols="10" name="content" style="width:520px;height:400px;visibility:hidden;"></textarea>
	                    </td>
	                    <td></td>
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
			editor.sync();//提交前同步一下，防止重复两次才能提交 

			top.art.dialog.confirm('你确定要提交吗？', function () {
				$.ajax({
					type: "POST",
					url: "notice/ajaxAddNotice.do",
					data: {"title":$("input[name=title]").val(), "content":editor.html()},
					success: function(data)
					{
						if("y" == data.status)
						{
							top.topFrame.main.window.fTable.queryForm();
							top.art.dialog.tips(data.info);
							top.art.dialog({id: 'addDialog'}).close();
							
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