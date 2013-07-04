<%@page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@include file="/WEB-INF/jsp/common/header.jsp" %>
	
	<!-- 编辑器插件 -->
	<link style="text/css" href="plugins/kindeditor/themes/default/default.css" rel="stylesheet"/>
	<script type="text/javascript" src="plugins/kindeditor/kindeditor.js"></script>
	
	<script>
		KindEditor.ready(function(K) {
			K('#create1').click(function() {
				var dialog = K.dialog({
					width : 500,
					height: 400,
					title : '窗口',
					body : '<div style="margin:10px;"><strong>内容</strong></div>',
					closeBtn : {
						name : '关闭',
						click : function(e) {
							dialog.remove();
						}
					},
					yesBtn : {
						name : '确定',
						click : function(e) {
							alert(this.value);
						}
					},
					noBtn : {
						name : '取消',
						click : function(e) {
							dialog.remove();
						}
					}
				});
			});
		});
	</script>
<body>
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td width="17" valign="top" background="images/mail_leftbg.gif"><img
				src="images/left-top-right.gif" width="17" height="29" /></td>
			<td valign="top" background="images/content-bg.gif"><table
					width="100%" height="31" border="0" cellpadding="0" cellspacing="0"
					class="left_topbg" id="table2">
					<tr>
						<td height="31"><div class="titlebt">欢迎界面</div></td>
					</tr>
				</table></td>
			<td width="16" valign="top" background="images/mail_rightbg.gif"><img
				src="images/nav-right-bg.gif" width="16" height="29" /></td>
		</tr>
		<tr>
			<td valign="middle" background="images/mail_leftbg.gif">&nbsp;</td>
			<td valign="top" bgcolor="#F7F8F9"><table width="98%" border="0"
					align="center" cellpadding="0" cellspacing="0">
					<tr>
						<td colspan="2" valign="top">&nbsp;</td>
						<td>&nbsp;</td>
						<td valign="top">&nbsp;</td>
					</tr>
					<tr>
						<td colspan="2" valign="top"><span class="left_bt">感谢您使用
								网站管理系统程序</span><br> <br> <span class="left_txt">&nbsp;<img
								src="images/ts.gif" width="16" height="16"> 提示：<br>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;您现在使用的是tandaly开发的一套用于构建网站的专业系统！如果您有任何疑问请点左下解的
						</span><span class="left_ts">在线客服</span><span class="left_txt">进行咨询！<br>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;七大栏目完美整合，一站通使用方式，功能强大，操作简单，后台操作易如反掌，只需会打字，会上网，就会管理网站！<br>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;此程序是您首选方案！ <br>
						</span></td>
						<td width="7%">&nbsp;</td>
						<td width="40%" valign="top"><table width="100%" height="144"
								border="0" cellpadding="0" cellspacing="0" class="line_table">
								<tr>
									<td width="7%" height="27"
										background="images/news-title-bg.gif"><img
										src="images/news-title-bg.gif" width="2" height="27"></td>
									<td width="93%" background="images/news-title-bg.gif"
										class="left_bt2">最新动态</td>
								</tr>
								<tr>
									<td height="102" valign="top">&nbsp;
									</td>
									<td height="102" valign="top">
									<!-- 时钟 start -->
										<div id="J_TB_clock">
											<div id="J_TB_clock_1" class="big-num"></div>
											<div id="J_TB_clock_2" class="big-num"></div>
											<div id="J_TB_clock_3" class="big-num"></div>
											<div id="J_TB_clock_4" class="big-num"></div>
											<div id="J_TB_clock_5" class="big-num"></div>
											<div id="J_TB_clock_6" class="small-num"></div>
											<div id="J_TB_clock_7" class="small-num"></div>
											</div>
											<style> 
											    #J_TB_clock{
											        width:104px;
											        height:30px;
											    }
												#J_TB_clock_3{
												width:10px;
												}
											    .big-num{
											        float:left;
											        width:16px;
											        height:30px;
												margin-right:2px;
											        background: url(images/clock.png) no-repeat;
											    }
											    .small-num{
											        float:left;
											        width:9px;
											        height:15px;
											        background: url(images/clock.png) no-repeat;
											        margin-top:15px;
											    }
											    #J_TB_clock_6{
											        margin-left: 2px;
											    }
											</style>
											<script> 
											    var TBClock=function(){
											        var get=function(ele){
											            return document.getElementById(ele)
											        },
											        fillZero=function(num,length){
											            num=num.toString();
											            length=length||2
											            var str="";
											            for(var i=0,n=length-num.length;i<n;i++){
											                str+="0";
											            }
											            return str+num;
											        },
											        setPos=function(ele,value,y){
											            ele.style.backgroundPosition="-"+value+"px "+y+"px";
											        },
											        setBigNum=function(ele,ele2,num){
											            setPos(ele,num.charAt(0)*16.4,0)
											            setPos(ele2,num.charAt(1)*16.4,0)
											        },
											        setFlashP=function(ele){
											            ele.style.backgroundPosition=((TBClock.flash=!TBClock.flash)==true)?"-164px 0":"-180px 0";
											        },
											        setSmallNum=function(ele,ele2,num){
											            setPos(ele,num.charAt(0)*10,-31)
											            setPos(ele2,num.charAt(1)*10,-31)
											        }
											        var eles={
											            h1:get("J_TB_clock_1"),
											            h2:get("J_TB_clock_2"),
											            m1:get("J_TB_clock_4"),
											            m2:get("J_TB_clock_5"),
											            s1:get("J_TB_clock_6"),
											            s2:get("J_TB_clock_7"),
											            p:get("J_TB_clock_3")
											        }
											        return {
											            flash:true,
											            init:function(){
											                this.start();
											            },
											            start:function(){
														this.go();
											                setInterval(this.go,1000)
											            },
											            go:function(){
											                var T=new Date();
											                setBigNum(eles.h1,eles.h2,fillZero(T.getHours()))
											                setBigNum(eles.m1,eles.m2,fillZero(T.getMinutes()))
											                setFlashP(eles.p)
											                setSmallNum(eles.s1,eles.s2,fillZero(T.getSeconds()))
											            }
											        }
											    }();
											    TBClock.init();
											</script>
										<!-- 时钟 end -->
									</td>
								</tr>
								<tr>
									<td height="5" colspan="2">&nbsp;</td>
								</tr>
							</table></td>
					</tr>
					<tr>
						<td colspan="2">&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td colspan="2" valign="top">
							<!--JavaScript部分--> <SCRIPT language=javascript>
								function secBoard(n) {
									for (i = 0; i < secTable.cells.length; i++)
										secTable.cells[i].className = "sec1";
									secTable.cells[n].className = "sec2";
									for (i = 0; i < mainTable.tBodies.length; i++)
										mainTable.tBodies[i].style.display = "none";
									mainTable.tBodies[n].style.display = "block";
								}
							</SCRIPT> <!--HTML部分-->
							<TABLE width=72% border=0 cellPadding=0 cellSpacing=0 id=secTable>
								<TBODY>
									<TR align=middle height=20>
										<TD align="center" class=sec2 onclick=secBoard(0)>验证信息</TD>
										<TD align="center" class=sec1 onclick=secBoard(1)>统计信息</TD>
										<TD align="center" class=sec1 onclick=secBoard(2)>系统参数</TD>
										<TD align="center" class=sec1 onclick=secBoard(3)>版权说明</TD>
									</TR>
								</TBODY>
							</TABLE>
							<TABLE class=main_tab id=mainTable cellSpacing=0 cellPadding=0
								width=100% border=0>
								<!--关于TBODY标记-->
								<TBODY style="DISPLAY: block">
									<TR>
										<TD vAlign=top align=middle><TABLE width=98% height="133"
												border=0 align="center" cellPadding=0 cellSpacing=0>
												<TBODY>
													<TR>
														<TD height="5" colspan="3"></TD>
													</TR>
													<TR>
														<TD width="4%" height="28"
															background="images/news-title-bg.gif"></TD>
														<TD height="25" colspan="2"
															background="images/news-title-bg.gif" class="left_txt">亲爱的管理员：
															<font color="#FFFFFF" class="left_ts"><b></b>
														</TD>
													</TR>
													<TR>
														<TD bgcolor="#FAFBFC">&nbsp;</TD>
														<TD width="42%" height="25" bgcolor="#FAFBFC"><span
															class="left_txt">您有未验证分类信息： </span> <span class="left_ts">
														</span></TD>
														<TD width="54%" height="25" bgcolor="#FAFBFC"><span
															class="left_txt">您有未验证广告张贴： </span> <span class="left_ts">
														</span></TD>
													</TR>
													
													<TR>
														<TD height="5" colspan="3"></TD>
													</TR>
												</TBODY>
											</TABLE></TD>
									</TR>
								</TBODY>
								<!--关于cells集合-->
								<TBODY style="DISPLAY: none">
									<TR>
										<TD vAlign=top align=middle><TABLE width=98% height="133"
												border=0 align="center" cellPadding=0 cellSpacing=0>
												<TBODY>
													<TR>
														<TD height="5" colspan="3"></TD>
													</TR>
													<TR>
														<TD width="4%" height="28"
															background="images/news-title-bg.gif"></TD>
														<TD colspan="2" background="images/news-title-bg.gif"
															class="left_txt">现有会员：名&nbsp;&nbsp; 其中：
															名&nbsp;&nbsp;&nbsp;&nbsp;名&nbsp;&nbsp;&nbsp;&nbsp;名</TD>
													</TR>
													<TR>
														<TD bgcolor="#FAFBFC">&nbsp;</TD>
														<TD width="42%" height="25" bgcolor="#FAFBFC"><span
															class="left_txt">本站现有分类信息： </span><span class="left_txt">条</span></TD>
														<TD width="54%" bgcolor="#FAFBFC"><span
															class="left_txt">本站现有广告张贴： </span><span class="left_txt">条</span></TD>
													</TR>
													<TR>
														<TD bgcolor="#FAFBFC">&nbsp;</TD>
														<TD height="25" bgcolor="#FAFBFC"><span
															class="left_txt">本站现有商家展示： </span><span class="left_txt">个</span></TD>
														<TD height="25" bgcolor="#FAFBFC"><span
															class="left_txt">本站现有网上商城： </span><span class="left_txt">个</span></TD>
													</TR>
													<TR>
														<TD bgcolor="#FAFBFC">&nbsp;</TD>
														<TD height="25" bgcolor="#FAFBFC"><span
															class="left_txt">本站现有网上名片： </span><span class="left_txt">个</span></TD>
														<TD height="25" bgcolor="#FAFBFC"><span
															class="left_txt">本站现有市场联盟： </span><span class="left_txt">个</span></TD>
													</TR>
													<TR>
														<TD bgcolor="#FAFBFC">&nbsp;</TD>
														<TD height="25" bgcolor="#FAFBFC"><span
															class="left_txt">本站现有市场资讯： </span><span class="left_txt">条</span></TD>
														<TD height="25" bgcolor="#FAFBFC"><span
															class="left_txt">本站现有商家商品： </span><span class="left_txt">个</span></TD>
													</TR>
													<TR>
														<TD height="5" colspan="3"></TD>
													</TR>
												</TBODY>
											</TABLE></TD>
									</TR>
								</TBODY>
								<!--关于tBodies集合-->
								<TBODY style="DISPLAY: none">
									<TR>
										<TD vAlign=top align=middle><TABLE width=98% border=0
												align="center" cellPadding=0 cellSpacing=0>
												<TBODY>
													<TR>
														<TD colspan="3"></TD>
													</TR>
													<TR>
														<TD height="5" colspan="3"></TD>
													</TR>
													<TR>
														<TD width="4%" height="25"
															background="images/news-title-bg.gif"></TD>
														<TD height="25" colspan="2"
															background="images/news-title-bg.gif" class="left_txt"><span
															class="TableRow2">服务器IP:</span>系统版本：</TD>
													</TR>
													<TR>
														<TD height="25" bgcolor="#FAFBFC">&nbsp;</TD>
														<TD width="42%" height="25" bgcolor="#FAFBFC"><span
															class="left_txt">服务器类型：</span></TD>
														<TD width="54%" height="25" bgcolor="#FAFBFC"><span
															class="left_txt">脚本解释引擎：</span></TD>
													</TR>
													<TR>
														<TD height="25" bgcolor="#FAFBFC">&nbsp;</TD>
														<TD height="25" colspan="2" bgcolor="#FAFBFC"><span
															class="left_txt">站点物理路径：</span></TD>
													</TR>
													<TR>
														<TD height="25" bgcolor="#FAFBFC">&nbsp;</TD>
														<TD height="25" bgcolor="#FAFBFC"><span
															class="left_txt">FSO文本读写：</span><span class="TableRow2"><font
																color="#FF0066"><b><img src="images/X.gif"
																		width="12" height="13"></b></font><img src="images/g.gif"
																width="12" height="12"></span></TD>
														<TD height="25" bgcolor="#FAFBFC"><span
															class="left_txt">数据库使用：</span><span class="left_ts"><img
																src="images/X.gif" width="12" height="13"><b
																style="color: blue"> MYSQL </b></span></TD>
													</TR>

													<TR>
														<TD height="5" colspan="3"></TD>
													</TR>
												</TBODY>
											</TABLE></TD>
									</TR>
								</TBODY>
								<!--关于display属性-->
								<TBODY style="DISPLAY: none">
									<TR>
										<TD vAlign=top align=middle><TABLE width=98% border=0
												align="center" cellPadding=0 cellSpacing=0>
												<TBODY>
													<TR>
														<TD colspan="3"></TD>
													</TR>
													<TR>
														<TD height="5" colspan="3"></TD>
													</TR>
													<TR>
														<TD width="4%" background="images/news-title-bg.gif"></TD>
														<TD width="91%" background="images/news-title-bg.gif"
															class="left_ts">《程序说明》：</TD>
														<TD width="5%" background="images/news-title-bg.gif"
															class="left_txt">&nbsp;</TD>
													</TR>
													<TR>
														<TD bgcolor="#FAFBFC">&nbsp;</TD>
														<TD bgcolor="#FAFBFC" class="left_txt"><span
															class="left_ts">1、</span>本程序处于开发
														</TD>
														<TD bgcolor="#FAFBFC" class="left_txt">&nbsp;</TD>
													</TR>
													<TR>
														<TD bgcolor="#FAFBFC">&nbsp;</TD>
														<TD bgcolor="#FAFBFC" class="left_txt"><span
															class="left_ts">2、</span>请大家支持本系统！</TD>
														<TD bgcolor="#FAFBFC" class="left_txt">&nbsp;</TD>
													</TR>
													<TR>
														<TD bgcolor="#FAFBFC">&nbsp;</TD>
														<TD bgcolor="#FAFBFC" class="left_txt"><span
															class="left_ts">3、</span> 支持作者的劳动，请保留版权。</TD>
														<TD bgcolor="#FAFBFC" class="left_txt">&nbsp;</TD>
													</TR>
													<TR>
														<TD bgcolor="#FAFBFC">&nbsp;</TD>
														<TD bgcolor="#FAFBFC" class="left_txt"><span
															class="left_ts">4、</span>程序使用，技术支持请联系http://tandaly.42t.com。</TD>
														<TD bgcolor="#FAFBFC" class="left_txt">&nbsp;</TD>
													</TR>
													<TR>
														<TD height="5" colspan="3"></TD>
													</TR>
												</TBODY>
											</TABLE></TD>
									</TR>
								</TBODY>
							</TABLE>
						</td>
						<td>&nbsp;</td>
						<td valign="top"><table width="100%" height="144" border="0"
								cellpadding="0" cellspacing="0" class="line_table">
								<tr>
									<td width="7%" height="27"
										background="images/news-title-bg.gif"><img
										src="images/news-title-bg.gif" width="2" height="27"></td>
									<td width="93%" background="images/news-title-bg.gif"
										class="left_bt2">程序说明</td>
								</tr>
								<tr>
									<td height="102" valign="top">&nbsp;</td>
									<td height="102" valign="top"><label></label> <label>
											<textarea name="textarea" cols="48" rows="8" class="left_txt">一、专业的首选方案！
二、全站一号通，一次注册，终身使用，一个帐号，全站通用！
三、分类信息、商家展示（百业联盟）、
四、界面设计精美，后台功能强大。傻瓜式后台操作，无需专业的网站制作知识，只要会打字，就会管理维护网站。</textarea>
									</label></td>
								</tr>
								<tr>
									<td height="5" colspan="2">&nbsp;</td>
								</tr>
							</table></td>
					</tr>
					<tr>
						<td height="40" colspan="4"><table width="100%" height="1"
								border="0" cellpadding="0" cellspacing="0" bgcolor="#CCCCCC">
								<tr>
									<td></td>
								</tr>
							</table></td>
					</tr>
					<tr>
						<td width="2%">&nbsp;</td>
						<td width="51%" class="left_txt"><img
							src="images/icon-mail2.gif" width="16" height="11">
							客户服务邮箱：619606426@qq.com<br> <img
							src="images/icon-phone.gif" width="17" height="14">
							官方网站：http://tandaly.42t.com</td>
						<td><input type="button" id="create1" value="^_^"></td>
						<td>&nbsp;</td>
					</tr>
				</table></td>
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