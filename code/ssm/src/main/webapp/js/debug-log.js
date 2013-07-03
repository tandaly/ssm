
//调式日志
function debug(str)
{
	$.fn.debug(str);
}

$.fn.debug = function(str){
	if(window.console && window.console.log){
		console.log(str);
	}
};