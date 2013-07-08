<%@page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@include file="/WEB-INF/jsp/common/header.jsp"%>	
	<!-- 分页插件 -->
	<link href="plugins/page/page.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="plugins/page/page.js"></script>
	<script type="text/javascript">
	
		$(function(){
			var url = "monitor/ajaxExceptionsList.do";
			initPageTable(url, callback);
		});
		
		function callback(data)
		{
			var list = data.list;
			if(list)
			{
				for(var i = 0; i < list.length; i++)
				{
					list[i].description = "<font color=red>" + formatStr(list[i].description, 50) +"</font>";
					list[i].options = '<a href="javascript:openDetailExceptions('+list[i].id+')">详情</a>';
				}
			}
			buildTable('datatable',list,['activeTime', 'className', 'methodName', 'description', 'options'],true,'id','cbx_',true);
		}
		
		function formatStr(str, limit)
		{
			var result = "";
			if(limit < str.length)
			{
				result += str.substring(0, limit) + "...";
			}
			else
			{
				result = str;
			}
			return result;
		}
		
		//打开详情页面
		function openDetailExceptions(id)
		{	
			top.art.dialog.open('monitor/detailExceptions.do?id=' + id,
				    {id: 'detailDialog', title: '查看异常', width:700, height:400, lock: true,
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
		
		function deleteRows()
		{
			var ids = checkedValue("cbx_");
			if("" == ids)
			{
				top.art.dialog.alert("请选择记录");
				return;
			}
			
			deleteRow(ids);
		}
		
		function deleteRow(ids)
		{
			top.art.dialog.confirm("你确定要删除吗?", function(){
				$.ajax({
					type:"POST",
					url:"monitor/ajaxDeleteExceptions.do",
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
		
		//清空异常日志
		function clearExceptions()
		{
			top.art.dialog.confirm("一旦清空，所有的记录不可恢复，请谨慎操作", function(){
				if(confirm("再次确认你要清空异常日志吗?"))
				{
					$.ajax({
						type:"POST",
						url:"monitor/ajaxClearExceptions.do",
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
				}
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
						<td height="31"><div class="titlebt">异常日志</div></td>
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
									类名：<input name="userName" /> 
									&nbsp;
									<input value="查询" type="submit" class="button_highlight"/>
								</form>
							</div>
							<div>
								<div class="toolGroup">
									<input  type="button" value="删除" onclick="deleteRows()"/>
									<input  type="button" value="清空" onclick="clearExceptions()"/>
								</div>
								<table width="100%" border="1" cellpadding="0" cellspacing="0"
									class="content-right-column-tb" id="datatable">
									<tr style="background-color: #a9c4e8;" class="content-right-column-tb-topbg">
										<th></th>
										<th>
											<input type="checkbox" id="ckall" />
										</th>
										<th width="120px">
											激活时间
										</th>
										<th>
											类名
										</th>
										<th>
											方法
										</th>
										<th>
											描述
										</th>
										<th width="50px">
											操作
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