<%@page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@include file="/WEB-INF/jsp/common/header.jsp"%>	
	<!-- 分页插件 -->
	<script type="text/javascript" src="plugins/page/fTable.js"></script>
	
	<!-- 日期控件 -->
	<script type="text/javascript" src="${base}plugins/date/WdatePicker.js"></script>
	
	<script type="text/javascript">
	
		$(function(){
			fTable = new FTable({
				fields: ['title', 'content', 'createTime'],
				url: 'notice/ajaxNoticeList.do'
			});
		});
		
		function deleteNotices()
		{
			var ids = fTable.getCheckedValue();
			if("" == ids)
			{
				top.art.dialog.alert("请选择记录");
				return;
			}
			
			deleteNotice(ids);
		}
		
		function deleteNotice(ids)
		{
			top.art.dialog.confirm("你确定要删除吗?", function(){
				$.ajax({
					type:"POST",
					url:"notice/ajaxDeleteNotice.do",
					data:{"ids":ids},
					success:function(data)
					{
						if("y" != data.status)
						{
							top.art.dialog.alert(data.info);
						}else
						{
							top.art.dialog.tips(data.info);
							fTable.queryForm();
						}
					},
					error:function()
					{
						top.art.dialog.alert("操作失败");
					}
				});
			});
		}
		
		//打开添加页面
		function openAddNotice()
		{
			top.art.dialog.open('notice/addNotice.do',
				    {id: 'addDialog', title: '添加系统公告', width:500, height:310, lock: true,
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
		

		//打开修改页面
		function openUpdateNotice()
		{	
			var ids = fTable.getCheckedValue();
			if("" == ids || ids.indexOf(",") > 0)
			{
				top.art.dialog.alert("请选择一条记录!");
				return;
			}
				
			top.art.dialog.open('notice/updateNotice.do?id=' + ids,
				    {id: 'updateDialog', title: '修改系统公告', width:500, height:410, lock: true,
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
	<div class="mainContent">
		<!-- 导航条 -->
		<div class="box-positon">
			<div class="rpos">当前位置: 消息管理 &gt; 系统公告 &gt; 列表</div>
			<div class="clear"></div>
		</div>
		<div class="form">
			<form id="queryForm" name="queryForm" onsubmit="return fTable.queryForm()">
				<span class="input-line">
					<span class="input-label">标题</span>
					<input name="title" class="input-text"/> 
				</span>
				<span class="input-line">
					<span class="input-label">内容</span>
					<input name="content" class="input-text"/> 
				</span>
				<span class="input-line">
					<span class="input-label">日期</span>
					<input name="createTime" class="input-text Wdate" onfocus="WdatePicker();"/> 
				</span>
				<input value="查询" type="submit" class="button_highlight"/>
			</form>
		</div>
		<div>
			<div class="toolGroup">
				<input type="button" value="新增" onclick="openAddNotice();"/>
				<input type="button" value="修改" onclick="openUpdateNotice()"/>
				<input  type="button" value="删除" onclick="deleteNotices()"/>
			</div>
			<div class="fTableContent">
				<table id="fTable" class="fTable" cellpadding="0" cellspacing="0">
					<tr>
						<th></th>
						<th>
							<input type="checkbox"/>
						</th>
						<th width="200px">
							标题
						</th>
						<th>
							发布内容
						</th>
						<th>
							发布时间
						</th>
					</tr>
				</table>
			</div>
			<div id="fPage"></div>
		</div>
	</div>
</body>
</html>