//导入分页核心js
var jsFile = '<script type="text/javascript" src="plugins/page/jquery.myPagination.js"><\/script>';
document.write(jsFile);

var myPagination;

/*初始化分页*/
function initPageTable(url, callback)
{
	var formData = $("#queryForm").serialize(); //序列化表单
    formData = decodeURIComponent(formData, true);	//解码
	myPagination = $("#pageDiv").myPagination({
		ajax: 
		{
		  on: true,
		  url: url,
		  dataType: 'json',
		  param:formData,
		  ajaxStart:function(){
		  },onClick:function(page){
			  $.fn.debug(page);
		  },
		  callback:function(data){
			  	$("#ckall").attr("checked", false);//取消全选
				if(typeof(callback) == "function")
					callback(data);
		  }
		}
	});
}

/*表单查询*/
function queryFrom(){
	var formData = $("#queryForm").serialize(); //序列化表单
    formData = decodeURIComponent(formData, true);	//解码
	$.fn.debug("开始指定加载");
	myPagination.onLoad({param:formData});
	$.fn.debug("结束指定加载");
	return false;
};


/*tanfei add start*/
var oddBG = "#F5F5F5";//表格奇数行背景色
var evenBG = "#FFFFFF";//表格偶数行背景色
var hoverBG = "#EAEAEA";//鼠标经过表格行背景色
var selectedBG = "#DCF8A8";//表格被选中行的背景色FFE48A
/*tanfei add end*/

/**
 * tableId 表格id
 * list	表格数据
 * fields	字段名
 * checkbox	是否有多选
 * boxid	选项值字段名，一般为记录id
 * prefix	多选框id前缀
 * num	是否显示序号
 * cbxname 多选框名称
 */
function buildTable(tableId,list,fields,checkbox,boxid,prefix,num,cbxname){
	$("#" + tableId).find("tr").not(":first").each(function(){
		$(this).remove();
	});
	/*
	$("#" + tableId).find("input[type=checkbox]").each(function(){
		$(this).removeAttr("checked");
	});
	*/
	if(list != null && list.length > 0){
		/*tanfei add start*/
		var trs = new Array();
		var indexs = new Array();
		/*tanfei add end*/
		$.each(list,function(index,item){
			var values = new Array();
			if(checkbox){
				values[0] = item[boxid];
			}
			if(null != num && num ){
				 values[checkbox ? 1 : 0] = index + 1;
			}
			for(var i = 0;i < fields.length; i++){
				if(fields[i].indexOf(".") == -1){
					values[i + (checkbox + num)] = item[fields[i]];
				} else {
					var list = fields[i].split(".");
					var temp = "";
					if(list.length > 0){
						var obj = item;
						for(var k = 0; k < list.length && null != obj; k++){
							obj = obj[list[k]];
						}
						temp = obj;
					}
					values[i + (checkbox + num)] = temp;
				}
			}
			var tr = createRow(index,values,checkbox,prefix,(null != num && num));
			/*tanfei add start*/
			trs.push(tr);
			indexs.push(index);
			/*tanfei add end*/
			$("#" + tableId).children().first().append(tr);
		});
		/*tanfei add start*/
		$("#ckall").bind("click", function(){
			var iCheck = $("#ckall").attr("checked");
			iCheck = iCheck == "checked"?true:false;//这是为jquery 1.6而处理
			$("input[id^="+prefix+"]").attr("checked", iCheck);//全选/取消 （用的模糊匹配）
			for(var i = 0; i < trs.length; i++)
			{
				if($("#ckall").attr("checked"))
				{
					trs[i].css({"background":selectedBG});
					trs[i].hover(function(){
							$(this).css({"background":selectedBG});
						}, function(){
							$(this).css({"background":selectedBG});
						});
				}else
				{
					initEvent(indexs[i], trs[i]);
				}
			}
		});
		/*tanfei add end*/
	}else //tanfei增加
	{
		if(!checkbox)
		{
			fields.length -= 1;
		}
        //$(":checkbox");
        //$("input[type='checkbox']").attr("disabled","disabled");
		var tr = $("<tr height=30 >");
		tr.append("<td colspan="+(fields.length+2)+" style='text-align:center;'><font color=red>没有数据！！！</font></td>");
		$("#" + tableId).children().first().append(tr);
	}
}

function createRow(index,values,checkbox,prefix,num,cbxname){
	var tr;
	/*tanfei add start*/
	if(index%2 == 1)//tanfei增加
	{
		tr = $("<tr style='background: "+oddBG+"; height:30px;' >");
	}else
	{
		tr = $("<tr style='background: "+evenBG+"; height:30px;'>");
	}
	hoverEvent(index, tr);
	
	//创建序号列
	if(num){
		var td = $("<td style='width:25px;'>").css("text-align","center").html("<b>" + values[checkbox ? 1 : 0] + "</b>");
		tr.append(td);
	}
	
	/*tanfei add end*/
	if(checkbox){
		var box = $("<input>").attr("type","checkbox").attr("id",prefix + values[0]).val(values[0]);
		/*tanfei add start*/
		box.bind("click", function(){
				changeEvent(index, tr, box);
		});
		box.bind("change", function(){
		});
		
		/*tanfei add end*/	
		
		if(null != cbxname && cbxname.length >0){
			box.attr("name",cbxname);
		}	
		var td = $("<td style='width:25px;'>").append(box).css("text-align","left");
		
		/*tanfei add start*/
		tr.bind("click", function(){
			changeEvent(index, tr, box);
		});
		/*tanfei add end*/
		tr.append(td);
	}
	
	
	for(var i = (checkbox + num); i < values.length; i++){
		tr.append(createCell(values[i]));
	}
	return tr;
}
function createCell(value){
//	var reg = /^.*[\\/|<|>|'|"].*$/;
//	if(!reg.test(value))
//	{
//		return $("<td>").css("text-align", "center").html(getBytesCount(value)>20?value.substring(0,10)+"...":value).attr("title", value);
//	}else
//	{
		return $("<td>").css("text-align", "left").html(value);
//	}
}

/*tanfei add : 表格的hover事件处理*/
function hoverEvent(index, tr)
{
	if(index%2 == 1)//奇数行
	{
		tr.css({"background":oddBG});
		tr.hover(
		  function () {
		    tr.css({"background":hoverBG});
		  },
		  function () {
		    tr.css({"background":oddBG});
		  }
		);
	}else//偶数行
	{
		tr.css({"background":evenBG});
		tr.hover(
		  function () {
		    tr.css({"background":hoverBG});
		  },
		  function () {
		    tr.css({"background":evenBG});
		  }
		);
	}
}

/*tanfei add: 复选框是否被选中样式*/
function changeEvent(index, tr, box)
{
	if(box.attr("checked"))//复选框被选中
	{
		hoverEvent(index, tr);
		box.attr("checked", false);
	}else
	{
		box.attr("checked", true);
		tr.css({"background":selectedBG}).hover(
			function () {
		    	tr.css({"background":selectedBG});
		 	},
		  	function () {
		    	tr.css({"background":selectedBG});
		  });
	}
	judeCheckbox();
}

function initEvent(index, tr)
{
	hoverEvent(index, tr);
	if(index%2 == 1)//奇数行
	{
		tr.css({"background":oddBG});
	}else//偶数行
	{
		tr.css({"background":evenBG});
	}
}

/*tanfei增加*/
function judeCheckbox(){
	var arr1 = $("input[type='checkbox']:checked");
	var arr2 = $("input[type='checkbox']");
	var len1 = arr1.size();
	var len2 = arr2.size()-1;
	for(var i = 0; i < arr1.size(); i++)
	{
		if(arr1[i].value == "on")len1 -= 1;
	}
	if(len1 != len2)
	{
		$("#ckall").attr("checked", false);
	}else
	{
		$("#ckall").attr("checked", true);
	}
}

/**
*获得字符串字节数
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