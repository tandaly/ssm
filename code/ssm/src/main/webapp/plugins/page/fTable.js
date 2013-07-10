//导入分页核心js
var jsFile = '<script type="text/javascript" src="plugins/page/jquery.myPagination.js"><\/script>';
document.write(jsFile);

//引入表格样式
var cssFile = '<link href="plugins/page/page.css" rel="stylesheet" type="text/css" />';
document.write(cssFile);

/**
 * 分页表格 
 * 			$().fTable({
				url: 'user/ajaxUserList.do',
				callback:callback
			});
 */
/*(function($){
	$.fn.fTable = function(params) 
	{
		return init(params, $(this));
	};
	
	// opts 代表所有参数
	// obj 代表当前对象
	// init 方法 采用闭包概念
	function init(params, obj)
	{
		var defaults = {
				id: 'fTable',	//表格id
				cssStyle: 'fTable',//表格样式
				isPage: true,		//是否分页  默认分页
				page: '#pageDiv',	//分页对象 ,值可以是id表达式、name表达式、css表达式...
				pageCssStyle: 'msdn', //分页样式
				form: '#queryForm', //查询表单,值可以是id表达式、name表达式、css表达式...
				url: '',	//ajax分页获取数据地址
				callback: function(data){
					return false;
				},	//分页回调函数
		};
		
		//目标对象拥有了所有源对象所拥有的特性，可理解为继承
	  	// true 为深度拷贝，将子对象进行合并
		var opts = $.extend(true,defaults, params);
		
		debug(opts);//合并之后的设置项
		
		//判断是否分页
		if(opts.isPage)
		{//分页操作
			initfPageTable(opts.form, opts.page, opts.url, opts.callback);
		}
	};
	
})(jQuery);*/


/**
 * 表格分页插件 
 * fTable.js
 * create author tandaly
 * create date 2013-07-10
 */

var fTable;
//FTable相关参数配置
FTable = function(config) {
	var _obj = this;
	/*********以下是表格配置参数***********/
	this.id = config.id || 'fTable';	//表格
	this.cssStyle = config.cssStyle || 'fTable';//表格样式
	this.isBuild = config.isBuild || true; //是否默认加载数据 默认加载
	this.isNo = config.isNo || true; //是否显示序号 默认显示
	this.isCheckbox = config.isCheckbox || true; //是否有多选 默认有
	this.checkboxAll = config.checkboxAll || $("#"+this.id+ " tr th input[type=checkbox]").first();	//全选/反选对象
	this.checkboxIdPrefix = config.checkboxIdPrefix || "cbx_"; //复选框id前缀
	this.checkboxValueField = config.checkboxValueField || "id"; //复选框值字段名称(一般对应记录id)
	this.fields = config.fields || []; //表格列字段名称
	/**********一下是分页配置参数*********/
	this.isPage = config.isPage || true;		//是否分页  默认分页
	this.page = config.page || '#fPage';	//分页对象 ;值可以是id表达式、name表达式、css表达式...
	this.pageCssStyle = config.pageCssStyle || 'msdn'; //分页样式
	this.form = config.form || '#queryForm'; //查询表单;值可以是id表达式、name表达式、css表达式...
	this.pageSize = config.pageSize || 10;	//每页显示数
	this.url = config.url || '';	//ajax分页获取数据地址
	this.callback = config.callback || function(data){//分页回调函数
		if(_obj.isBuild)
			_obj.build(data.list);
	};
	/*************以下是公共配置参数************/
	this.myPagination;//分页标签对象
	//目标对象拥有了所有源对象所拥有的特性，可理解为继承
  	// true 为深度拷贝，将子对象进行合并
//	var obj = this;
//	obj = $.extend(true, obj, config);
	
	this.init();//初始化操作
};

//FTable相关方法配置
FTable.prototype = {
		/**
		 * 初始化
		 */
		init: function() {
			//判断是否分页
			if(this.isPage)
			{//分页操作
				this.myPagination = initFPageTable(this.form, this.page, this.url, this.callback, this.checkboxAll, this.pageSize);
			}
		},

		/**
		 * 分页表格数据查询(表单查询按钮使用)
		 * @returns {Boolean}
		 */
		queryForm: function() {
			var formData = $(this.form).serialize(); //序列化表单
			if(formData)
			{
				formData += "&pageSize=" + this.pageSize;
			}
		    formData = decodeURIComponent(formData, true);	//解码
			this.myPagination.onLoad({param:formData});
			return false;
		},
		
		/**
		 * 表格数据建造
		 * @param list
		 */
		build: function(list){
			var tableId = this.id;
			var isNo = this.isNo;
			var isCheckbox = this.isCheckbox;
			var checkboxAll = this.checkboxAll;
			var checkboxIdPrefix = this.checkboxIdPrefix;
			var checkboxValueField = this.checkboxValueField;
			var fields = this.fields;
			
			$("#" + tableId).find("tr").not(":first").each(function(){
				$(this).remove();
			});
			/*
			$("#" + tableId).find("input[type=checkbox]").each(function(){
				$(this).removeAttr("checked");
			});
			*/
			if(list != null && list.length > 0)
			{
				/*tanfei add start*/
				var trs = new Array();
				var indexs = new Array();
				/*tanfei add end*/
				$.each(list,function(index,item){
					var values = new Array();
					if(isCheckbox){
						values[0] = item[checkboxValueField];
					}
					if(isNo){
						 values[isCheckbox ? 1 : 0] = index + 1;
					}
					for(var i = 0;i < fields.length; i++){
						if(fields[i].indexOf(".") == -1){
							values[i + (isCheckbox + isNo)] = item[fields[i]];
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
							values[i + (isCheckbox + isNo)] = temp;
						}
					}
					var tr = f_createRow(index,values,isCheckbox,checkboxIdPrefix, isNo, checkboxAll);
					/*tanfei add start*/
					trs.push(tr);
					indexs.push(index);
					/*tanfei add end*/
					$("#" + tableId).children().first().append(tr);
				});
				/*tanfei add start*/
				checkboxAll.bind("click", function(){
					var iCheck = checkboxAll.attr("checked");
					iCheck = iCheck == "checked"?true:false;//这是为jquery 1.6而处理
					$("#"+tableId+ " tr td input[id^="+checkboxIdPrefix+"]").attr("checked", iCheck);//全选/取消 （用的模糊匹配）
					for(var i = 0; i < trs.length; i++)
					{
						if(checkboxAll.attr("checked"))
						{
							trs[i].css({"background":selectedBG});
							trs[i].hover(function(){
									$(this).css({"background":selectedBG});
								}, function(){
									$(this).css({"background":selectedBG});
								});
						}else
						{
							f_initEvent(indexs[i], trs[i]);
						}
					}
				});
				/*tanfei add end*/
			}else //tanfei增加
			{
				if(!isCheckbox)
				{
					fields.length -= 1;
				}
		        //$(":checkbox");
		        //$("input[type='checkbox']").attr("disabled","disabled");
				var tr = $("<tr height=30 >");
				tr.append("<td colspan="+(fields.length+2)+" style='text-align:center;'><font color=red>没有数据！！！</font></td>");
				$("#" + tableId).children().first().append(tr);
			}
		},
		
		/**
		 * 获取所有复选框的值
		 * @returns strings
		 */
		getCheckAllValue: function(){
			var values = "";
			$("#"+this.id+ " tr td input[type='checkbox'][id^=" + this.checkboxIdPrefix + "]").each(function(){
				values += $(this).val() + ",";
			});
			return values.length > 0 ? values.substring(0,values.length - 1) : values;
		},
		
		/**
		 * 获取选中复选框的值
		 * @returns strings
		 */
		getCheckedValue: function(){
			var values = "";
			$("#"+this.id+ " tr td input[type='checkbox'][id^=" + this.checkboxIdPrefix + "]:checked").each(function(){
				values += $(this).val() + ",";
			});
			return values.length > 0 ? values.substring(0,values.length - 1) : values;
		}
};




/*初始化分页*/
function initFPageTable(form, page, url, callback, checkboxAll, pageSize)
{
	var formData = $(form).serialize(); //序列化表单
	if(formData)
	{
		formData += "&pageSize=" + pageSize;
	}
    formData = decodeURIComponent(formData, true);	//解码
	var myPagination = $(page).myPagination({
		ajax: 
		{
		  on: true,
		  url: url,
		  dataType: 'json',
		  param:formData,
		  ajaxStart:function(){
		  },onClick:function(page){
			  debug(page);
		  },
		  callback:function(data){
			  checkboxAll.attr("checked", false);//取消全选
				if(typeof(callback) == "function")
					callback(data);
		  }
		}
	});
	
	return myPagination;
}




/*tanfei add start*/
var oddBG = "#F5F5F5";//表格奇数行背景色
var evenBG = "#FFFFFF";//表格偶数行背景色
var hoverBG = "#EAEAEA";//鼠标经过表格行背景色
var selectedBG = "#DCF8A8";//表格被选中行的背景色FFE48A
/*tanfei add end*/

/**
 * 创建行
 * @param index
 * @param values
 * @param checkbox
 * @param prefix
 * @param num
 * @param cbxname
 * @returns
 */
function f_createRow(index,values,checkbox,prefix,num, checkboxAll){
	var tr;
	/*tanfei add start*/
	if(index%2 == 1)//tanfei增加
	{
		tr = $("<tr style='background: "+oddBG+"; height:30px;' >");
	}else
	{
		tr = $("<tr style='background: "+evenBG+"; height:30px;'>");
	}
	f_hoverEvent(index, tr);
	
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
				f_changeEvent(index, tr, box, checkboxAll);
		});
		box.bind("change", function(){
		});
		
		/*tanfei add end*/	
		
//		if(null != cbxname && cbxname.length >0){
//			box.attr("name",cbxname);
//		}	
		var td = $("<td style='width:25px;'>").append(box).css("text-align","left");
		
		/*tanfei add start*/
		/*tr.bind("click", function(){
			changeEvent(index, tr, box);
		});*/ //2013-07-08 remove
		/*tanfei add end*/
		tr.append(td);
	}
	
	
	for(var i = (checkbox + num); i < values.length; i++){
		tr.append(f_createCell(values[i]));
	}
	return tr;
}

/**
 * 创建列
 * @param value
 * @returns
 */
function f_createCell(value){
//	var reg = /^.*[\\/|<|>|'|"].*$/;
//	if(!reg.test(value))
//	{
//		return $("<td>").css("text-align", "center").html(getBytesCount(value)>20?value.substring(0,10)+"...":value).attr("title", value);
//	}else
//	{
		return $("<td>").css("text-align", "left").html(value);
//	}
}

/**
 * 表格的hover事件处理
 * @param index
 * @param tr
 */
function f_hoverEvent(index, tr)
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

/**
 * 复选框是否被选中样式
 * @param index
 * @param tr
 * @param box
 */
function f_changeEvent(index, tr, box, checkboxAll)
{
	if(!box.attr("checked"))//复选框被选中
	{
		f_hoverEvent(index, tr);
		//box.attr("checked", false);
	}else
	{
		//box.attr("checked", true);
		tr.css({"background":selectedBG}).hover(
			function () {
		    	tr.css({"background":selectedBG});
		 	},
		  	function () {
		    	tr.css({"background":selectedBG});
		  });
	}
	f_judeCheckbox(checkboxAll);
}

/**
 * 初始化事件
 * @param index
 * @param tr
 */
function f_initEvent(index, tr)
{
	f_hoverEvent(index, tr);
	if(index%2 == 1)//奇数行
	{
		tr.css({"background":oddBG});
	}else//偶数行
	{
		tr.css({"background":evenBG});
	}
}

/**
 * 判断复选框是否选中
 */
function f_judeCheckbox(checkboxAll){
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
		checkboxAll.attr("checked", false);
	}else
	{
		checkboxAll.attr("checked", true);
	}
}

/**
 * 获得字符串字节数
 * @param str
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