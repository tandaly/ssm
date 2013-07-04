<%@page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%@include file="/WEB-INF/jsp/common/header.jsp"%>	
	<title></title>
	<!-- 图形报表插件 -->
	<script src="plugins/highcharts/highcharts.js"></script>
	<script src="plugins/highcharts/modules/exporting.js"></script>
	
	<script type="text/javascript">
	$(function () {
	    $(document).ready(function() {
	        Highcharts.setOptions({
	            global: {
	                useUTC: false
	            }
	        });
	    
	        var chart;
	        $('#container').highcharts({
	            chart: {
	                type: 'spline',//'area',
	                animation: Highcharts.svg, // don't animate in old IE
	                marginRight: 10,
	                events: {
	                    load: function() {
	                        var series = this.series[0];
	                        
	                    	//设置每隔5秒钟更新一次
	                        setInterval(function() {
	                            var x = (new Date()).getTime(), // 当前时间
	                                y = parseInt(ajaxServerChartData());//Math.random() * 100;
	                            series.addPoint([x, y], true, true);
	                            
	                            
	                        }, 5000);
	                    }
	                }
	            },
	            title: {
	                text: '<b>${caption}<b>'
	            },
	            xAxis: {
	                type: 'datetime',
	                tickPixelInterval: 100
	            },
	            yAxis: {
	                title: {
	                    text: '总内存(M)'
	                },
	                plotLines: [{
	                    value: parseInt('${useMemory}'),
	                    width: 1,
	                    color: '#808080'
	                }]
	            },
	            tooltip: {
	            	crosshairs: true,//坐标线
	            	//shared: true, //冒泡并暂停
	                formatter: function() {
	                        return '<b>'+ this.series.name +'</b>：'+Highcharts.numberFormat(this.y, 2)+'M<br/>'+
	                        "<b>当前时间</b>：" + Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) +'<br/>';
	                }
	            },
	            legend: {
	                enabled: false
	            },
	            exporting: {
	                enabled: false
	            },
	            series: [{
	                name: '已用内存',
	                data: (function() {
	                    // generate an array of random data
	                    var data = [],
	                        time = (new Date()).getTime(), 
	                        i;
	    
	                    for (i = -19; i <= 0; i++) {
	                        data.push({
	                            x: time + i * 1000,
	                            y: parseInt('${jvmMaxMemory}') 
	                        });
	                    }
	                    return data;
	                })()
	            }]
	        });
	    });
    
	});

	var useMemory = '${useMemory}';
	function ajaxServerChartData()
	{
		$.ajax({
			type:"POST",
			url: "server/ajaxServerChartData.do",
			success: function(data)
			{
				useMemory = data;
			}
		});
		return useMemory;
	}
		</script>
</head>
<body>
<div id="container" style="min-width: 400px; height: 400px; margin: 0 auto"></div>
</body>
</html>