<%@page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@include file="/WEB-INF/jsp/common/header.jsp"%>	
	<!-- 分页必须 -->
	<link href="plugins/page/page.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="plugins/page/page.js"></script>
	
	<script type="text/javascript">
	
		$(function(){
			var url = "dictionary/ajaxDictionaryList.do";
			initPageTable(url, callback);
		});
		
		function callback(data)
		{
			var list = data.list;
			buildTable('datatable',list,['name','dicKey', 'value', 'remark', 'status'],true,'id','cbx_',true);
		}
		
		function deleteDictionarys()
		{
			var ids = checkedValue("cbx_");
			if("" == ids)
			{
				top.art.dialog.alert("请选择记录");
				return;
			}
			
			deleteDictionary(ids);
		}
		
		function deleteDictionary(ids)
		{
			top.art.dialog.confirm("你确定要删除吗?", function(){
				$.ajax({
					type:"POST",
					url:"dictionary/ajaxDeleteDictionary.do",
					data:{"ids":ids},
					success:function(data)
					{
						if("y" != data.status)
						{
							top.art.dialog.alert(data.info);
						}else
						{
							top.art.dialog.alert(data.info);
							queryFrom();
						}
					},
					error:function()
					{
						top.art.dialog.alert("操作失败");
					}
				});
			});
		}
		

		//打开修改页面
		function openUpdateDictionary()
		{	
			var ids = checkedValue("cbx_");
			if("" == ids || ids.indexOf(",") > 0)
			{
				top.art.dialog.alert("请选择一条记录!");
				return;
			}
				
			top.art.dialog.open('dictionary/updateDictionary.do?id=' + ids,
				    {id: 'updateDictionary', title: '修改字典', width:500, height:410, lock: true,
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
		
		//打开添加页面
		function openAddDictionary()
		{
			top.art.dialog.open('dictionary/addDictionary.do',
				    {id: 'addDictionary', title: '添加字典', width:500, height:400, lock: true,
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
<body>

	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td width="17" valign="top" background="images/mail_leftbg.gif"><img
				src="images/left-top-right.gif" width="17" height="29" /></td>
			<td valign="top" background="images/content-bg.gif"><table
					width="100%" height="31" border="0" cellpadding="0" cellspacing="0"
					class="left_topbg" id="table2">
					<tr>
						<td height="31"><div class="titlebt">字典维护</div></td>
					</tr>
				</table></td>
			<td width="16" valign="top" background="images/mail_rightbg.gif"><img
				src="images/nav-right-bg.gif" width="16" height="29" /></td>
		</tr>
		<tr>
			<td valign="middle" background="images/mail_leftbg.gif">&nbsp;</td>
			<td valign="top" bgcolor="#F7F8F9">
				<table width="98%" border="0" align="center"
					cellpadding="0" cellspacing="0">
					<tr>
						<td colspan="2" valign="top">&nbsp;</td>
						<td>&nbsp;</td>
						<td valign="top">&nbsp;</td>
					</tr>
					<tr>
						<td colspan="4" valign="top" style="">
							
							<div style="text-align: center;">
								<form id="queryForm" name="queryForm" onsubmit="return queryFrom()">
									名称：<input name="name" /> 
									&nbsp;
									<input value="查询" type="submit" class="button_highlight"/>
								</form>
							</div>
							<div>
								<div class="toolGroup">
									<input type="button" value="新增" onclick="openAddDictionary();"/>
									<input type="button" value="修改" onclick="openUpdateDictionary()"/>
									<input  type="button" value="删除" onclick="deleteDictionarys()"/>
									<input type="button" value="内存同步" onclick=""/>
									<font color=red size=2>提示:维护字典后必须执行内存同步</font>
								</div>
								<table width="100%" border="1" cellpadding="0" cellspacing="0"
									class="content-right-column-tb" id="datatable">
									<tr style="background-color: #a9c4e8;" class="content-right-column-tb-topbg">
										<th></th>
										<th>
											<input type="checkbox" id="ckall" />
										</th>
										<th>
											名称
										</th>
										<th>
											键
										</th>
										<th>
											值
										</th>
										<th>
											描述
										</th>
										<th>
											状态
										</th>
				
									</tr>
								</table>
							</div>
							<br/>
							<div style="height: 80px;">
								<div id="pageDiv"></div>
							</div>
						</td>
					</tr>
				</table>
			</td>
			<td background="images/mail_rightbg.gif">&nbsp;</td>
		</tr>
		<tr>
			<td valign="bottom" background="images/mail_leftbg.gif"><img
				src="images/buttom_left2.gif" width="17" height="17" /></td>
			<td background="images/buttom_bgs.gif"><img
				src="images/buttom_bgs.gif" width="17" height="17"></td>
			<td valign="bottom" background="images/mail_rightbg.gif"><img
				src="images/buttom_right2.gif" width="16" height="17" /></td>
		</tr>
	</table>

</body>
</html>