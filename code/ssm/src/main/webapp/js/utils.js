
/**
 * utils.js
 * 收集的相关工具类方法 
 * author tandaly
 */


/**
 * 获取当前页面地址参数
 * @param name {String}
 * @returns {String}
 */
function getCurrentLocationParam(name) 
{
	return getLocationParam(location.href, name);
}

/**
 * 获取指定连接地址参数信息
 * @param href {String}
 * @param name {String}
 * @returns {strings}
 */
function getLocationParam(href, name)
{
	return href.match(new RegExp('[?&]' + name + '=([^?&]+)', 'i')) ? decodeURIComponent(RegExp.$1) : '';
}

/**
 * 获得字符串字节数(中文英文都可以)
 * @param str {String}
 * @returns {Number}
 */
function getBytesCount(str) 
{ 
	var bytesCount = 0; 
	if (str != null) 
	{ 
		for (var i = 0; i < str.length; i++) 
		{ 
			var c = str.charAt(i); 
			if (/^[\u0000-\u00ff]$/.test(c)) 
			{ 
				bytesCount += 1; 
			} 
			else 
			{ 
				bytesCount += 2; 
			} 
		} 
	} 
	return bytesCount; 
}

/**
 * 截取中英字符串
 * @param str {String}
 * @param cutLen {Number}
 * @returns {String}
 */
function cutStr(str,cutLen){
    var returnStr = '',    //返回的字符串
    reCN = /[^\x00-\xff]/,    //中文字符
    strCNLen = str.replace(/[^\x00-\xff]/g,'**').length;//一个中文字符算2个字节

    if(cutLen>=strCNLen){
        return str;
    }

    for(var i=0,len=0;len<cutLen;i++){
        returnStr += str.charAt(i);
        if(reCN.test(str.charAt(i))){
            len+=2;
        }else{
            len++;
        }
    }

    return returnStr;
}

/**
 * 获取反色方法1
 * @param color #FFCC00
 * @returns {String}
 */
function getReverseColor(color)
{
	var ar = new Array();
	//分三组转换为10进制整数，然后减去255，取绝对值，再转换为16进制字符
	ar.push(Math.abs(parseInt('0x' + color.substr(1,2))-255).toString(16));
	ar.push(Math.abs(parseInt('0x' + color.substr(3,2))-255).toString(16));
	ar.push(Math.abs(parseInt('0x' + color.substr(5,2))-255).toString(16));
	//不足2位的补零  转换为大写
	for(i in ar) {
	    if (ar[i].length < 2) ar[i] = '0' + ar[i];
	    ar[i] = ar[i].toUpperCase();
	}
	var newColor = '#' + ar.join('');
	
	return newColor;
}

/**
 * 获取反色方法2
 * @param color #FFCC00
 * @returns {String}
 */
function getReverseColor2(color)
{
	var r = (0xFFFFFF - parseInt(color.slice(-6), 16)).toString(16);
	r = "#" + ("000000" + r).slice(-6).toUpperCase();
	
	return r;
}