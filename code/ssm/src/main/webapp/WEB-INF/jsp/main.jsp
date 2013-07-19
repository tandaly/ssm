<%@page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@include file="/WEB-INF/jsp/common/header.jsp" %>
	
	<!-- 编辑器插件 -->
	<link style="text/css" href="plugins/kindeditor/themes/default/default.css" rel="stylesheet"/>
	<script type="text/javascript" src="plugins/kindeditor/kindeditor.js"></script>
	<style type="text/css">
		.pageContent{
			margin: 8px;
		}
		
		h2 {
			display: block;
			font-size: 1.5em;
			-webkit-margin-before: 0.83em;
			-webkit-margin-after: 0.83em;
			-webkit-margin-start: 0px;
			-webkit-margin-end: 0px;
			font-weight: bold;
			
			margin: 7px;
			padding: 0;
			font-size: 17px;
			font-weight: bold;
		}
		
		h3 {
			display: block;
			font-size: 1.17em;
			-webkit-margin-before: 1em;
			-webkit-margin-after: 1em;
			-webkit-margin-start: 0px;
			-webkit-margin-end: 0px;
			font-weight: bold;
			
			margin: 4px;
			padding: 0;
			font-size: 15px;
			font-weight: bold;
		}
		
		p {
			display: block;
			-webkit-margin-before: 1em;
			-webkit-margin-after: 1em;
			-webkit-margin-start: 0px;
			-webkit-margin-end: 0px;
		}
		
		p.content {
			margin: 0;
			padding: 0;
			padding-left: 20px;
			line-height: 22px;
			font-size: 12px;
		}
		
		span.content-tag {
			color: #008000;
			margin-right: 2px;
			font-weight: bold;
		}
	</style>
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
	<div id="mainContent">
		<!-- 导航条 -->
		<div class="box-positon">
			<div class="rpos">当前位置: 首页</div>
			<div class="clear"></div>
		</div>
		
		
		<!-- <div class="line_table" style="height:500px;">
			<div class="left_bt2" style="background-image: images/news-title-bg.gif">
				最新动态
			</div>
			<div>斯蒂芬森的</div>
		</div>
		 -->
		<!-- <table width="100%" height="100%"
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
				<td height="500" valign="top">
				时钟 start
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
										时钟 end
									</td>
								</tr>
								<tr>
									<td height="5" colspan="2">&nbsp;</td>
								</tr>
							</table> -->
			
			<div class="pageContent">			
				<div class="divider"></div>
				<div>
					<h2>一、版本记录</h2>
					<h3>系统管理</h3>
					<p class="content">
						<span class="content-tag">[需求]</span>
						用户组管理
					</p>
					<p class="content">
						<span class="content-tag">[需求]</span>
						按用户组授权
					</p>
					<p class="content">
						<span class="content-tag">[BUG]</span>
						修复菜单图标
					</p>
				</div>
				<div class="divider"></div>
				
				<div style="width:230px;position: absolute;top:53px;right:0">
					<iframe width="100%" height="650" class="share_self"  frameborder="0" scrolling="no" src="http://widget.weibo.com/weiboshow/index.php?language=&width=0&height=650&fansRow=2&ptype=1&speed=300&skin=2&isTitle=0&noborder=1&isWeibo=1&isFans=0&uid=2067473503&verifier=013bec28&dpc=1"></iframe>
				</div>
			</div>
							
	</div>
</body>