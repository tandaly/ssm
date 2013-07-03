<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${sysTitle}</title>

<script src="plugins/dialog/artDialog.source.js?skin=black" type="text/javascript"></script>
<script type="text/javascript" src="plugins/dialog/plugins/iframeTools.js"></script>
<script type="text/javascript" src="plugins/dialog/artDialog.notice.js"></script>
<script type="text/javascript">
//配置artDialog全局默认参数
(function (config) {
    config['lock'] = true;
    config['fixed'] = true;
    config['okVal'] = '确定';
    config['cancelVal'] = '取消';
    // [more..]
})(art.dialog.defaults);

//窗口抖动
artDialog.fn.shake = function (){
    var style = this.DOM.wrap[0].style,
        p = [4, 8, 4, 0, -4, -8, -4, 0],
        fx = function () {
            style.marginLeft = p.shift() + 'px';
            if (p.length <= 0) {
                style.marginLeft = 0;
                clearInterval(timerId);
            };
        };
    p = p.concat(p.concat(p));
    timerId = setInterval(fx, 13);
    return this;
};

$(function(){
	art.dialog.notice({
	    title: '系统提示',
	    width: 200,// 必须指定一个像素宽度值或者百分比，否则浏览器窗口改变可能导致artDialog收缩
	    height: 100,
	    content: '<p style="font-size:12px;">你好[<font color=red>${user.userName}</font>]</p>',
	    icon: 'face-smile',
	    time: 5,
	    init: function () {
	    	var that = this, i = 5;
	        var fn = function () {
	            that.title(i + '秒后关闭');
	            !i && that.close();
	            i --;
	        };
	        timer = setInterval(fn, 1000);
	        fn();
	    },
	    close: function () {
	    	clearInterval(timer);
	    }
	});
});


function test()
{
	//art.dialog.alert('警察叔叔会请你喝茶！', function () {alert(0)});
}
	
</script>
</head>
<body style="margin:0px;">
	<div style="width:100%;height:800px;">
		<iframe name="topFrame" src="frame.do" style="margin:0px;" frameborder="0" width="100%" height="100%"></iframe>
	</div>
</body>
</html>