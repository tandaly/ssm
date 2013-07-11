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
 * 表格分页插件 (该插件需要依赖jquery)
 * fTable.js
 * create author tandaly
 * create date 2013-07-10
 */

//默认的全局表格对象(如果一个页面中要使用多个这样的表格，需要用户自己定义,如果不定义在ie下面是有问题的哦)
var fTable;

//FTable相关参数配置
FTable = function(config) {
	var _obj = this;
/*********以下是表格配置参数***********/
	//表格id
	this.id = config.id || 'fTable';	
	//表格皮肤样式名称 默认default  (skin2)
	this.skin = config.skin || 'skin1';
	//是否默认加载数据 默认加载
	this.isBuild = typeof config.isBuild == 'boolean'?config.isBuild:true; 
	//是否显示序号 默认显示
	this.isNo = typeof config.isNo == 'boolean'?config.isNo:true; 
	//是否有多选 默认有
	this.isCheckbox = typeof config.isCheckbox == 'boolean'?config.isCheckbox:true; 
	//全选/反选对象
	this.checkboxAll = config.checkboxAll || $("#"+this.id+ " tr th input[type=checkbox]").first();	
	//复选框id前缀
	this.checkboxIdPrefix = config.checkboxIdPrefix || "cbx_"; 
	//复选框值字段名称(一般对应记录id)
	this.checkboxValueField = config.checkboxValueField || "id";
	//表格列字段名称
	this.fields = config.fields || []; 
/**********以下是分页配置参数*********/
	//是否分页  默认分页
	this.isPage = typeof config.isPage == 'boolean'?config.isPage:true;		
	//分页对象 ;值可以是id表达式、name表达式、css表达式...
	this.page = config.page || '#fPage';	
	//分页样式
	this.pageCssStyle = config.pageCssStyle || 'msdn'; 
	//查询表单;值可以是id表达式、name表达式、css表达式...
	this.form = config.form || '#queryForm'; 
	//每页显示数
	this.pageSize = config.pageSize || 10;	
	//ajax分页获取数据地址
	this.url = config.url || '';	
	//分页回调函数
	this.callback = config.callback || function(data){
		if(_obj.isBuild)
			_obj.build(data.list);
	};
/*************以下是公共配置参数************/
	this.myPagination;//分页标签对象
	
	//表格颜色配置
	this.oddBG = config.oddBG || "#F5F5F5";//表格奇数行背景色
	this.evenBG = config.evenBG || "#FFFFFF";//表格偶数行背景色
	this.hoverBG = config.hoverBG || "#EAEAEA";//鼠标经过表格行背景色
	this.selectedBG = config.selectedBG || "#DCF8A8";//表格被选中行的背景色FFE48A
	
	//表格行高
	this.trHeight = config.trHeight || "30px";
	
	//分页背景颜色
	this.pageBG = config.pageBG || "#FFF";
	
	//目标对象拥有了所有源对象所拥有的特性，可理解为继承
  	// true 为深度拷贝，将子对象进行合并
//	var obj = this;
//	obj = $.extend(true, obj, config);
	
	//debug(this);
	this._init();//初始化操作
};

//FTable相关方法配置
FTable.prototype = {
		/**
		 * 初始化
		 */
		_init: function() { 
			var _obj = this;
			//设置表格样式皮肤
			$("#" + _obj.id).attr("class", "fTable_" + _obj.skin)
				.attr("cellpadding", "0").attr("cellspacing", "0");
			
			//判断是否分页
			if(this.isPage)
			{//分页操作
				
				$(_obj.page).css("background-color", _obj.pageBG);//设置分页背景颜色
				
				this.myPagination = this._initFPage(this.form, this.page, 
						this.url, this.callback, this.checkboxAll, this.pageSize);
			}
		},


		/*初始化分页*/
		_initFPage: function(form, page, url, callback, checkboxAll, pageSize)
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
		},
		
		/**
		 * 创建表格行
		 * @param index
		 * @param values
		 * @param isCheckbox
		 * @param prefix
		 * @param isNo
		 * @param checkboxAll
		 * @returns
		 */
		 _createTr: function(index, values, isCheckbox, prefix, isNo, checkboxAll){
			var _obj = this;
			var tr;//行对象
			if(index%2 == 1)
			{//奇数行
				tr = $("<tr style='background: "+_obj.oddBG+"; height:"+_obj.trHeight+";' >");
			}else
			{//偶数行
				tr = $("<tr style='background: "+_obj.evenBG+"; height:"+_obj.trHeight+";'>");
			}
			_obj._hoverEvent(index, tr); //给行对象添加鼠标hover事件
			
			if(isNo){//创建序号列
				var td = $("<td style='width:25px;'>").css("text-align","center").html("<b>" + values[isCheckbox ? 1 : 0] + "</b>");
				tr.append(td);
			}
			
			if(isCheckbox){//创建td复选框
				var tdCheckbox = $("<input>").attr("type","checkbox").attr("id",prefix + values[0]).val(values[0]);
				tdCheckbox.bind("click", function(){
					_obj._clickTrEvent(index, tr, tdCheckbox, checkboxAll);
				});
				tdCheckbox.bind("change", function(){
				});
				
//				if(null != cbxname && cbxname.length >0){
//					box.attr("name",cbxname);
//				}	
				
				var td = $("<td style='width:25px;'>").append(tdCheckbox).css("text-align","left");
				
				/*tr.bind("click", function(){ //单击行选中
					_obj._clickTrEvent(index, tr, tdCheckbox, checkboxAll);
				});*/ //2013-07-08 remove
				
				tr.append(td);
			}

			for(var i = (isCheckbox + isNo); i < values.length; i++){
				tr.append(_obj._createTd(values[i]));
			}
			
			return tr;
		},
		

		/**
		 * 创建列
		 * @param value td值
		 * @returns
		 */
		_createTd: function(value){
//			var reg = /^.*[\\/|<|>|'|"].*$/;
//			if(!reg.test(value))
//			{
//				return $("<td>").css("text-align", "center").html(getBytesCount(value)>20?value.substring(0,10)+"...":value).attr("title", value);
//			}else
//			{
				return $("<td>").css("text-align", "left").html(value);
//			}
		},
		
		/**
		 * 重置表格行样式事件(全选复选框用)
		 * @param index
		 * @param tr
		 */
		_resetTrCssEvent: function(index, tr)
		{
			var _obj = this;
			_obj._hoverEvent(index, tr);
			if(index%2 == 1)//奇数行
			{
				tr.css({"background":_obj.oddBG});
			}else//偶数行
			{
				tr.css({"background":_obj.evenBG});
			}
		},
		

		/**
		 * 表格的hover事件处理
		 * @param index
		 * @param tr
		 */
		_hoverEvent: function(index, tr)
		{
			var _obj = this;
			if(index%2 == 1)//奇数行
			{
				tr.css({"background":_obj.oddBG});
				tr.hover(
				  function () {
				    tr.css({"background":_obj.hoverBG});
				  },
				  function () {
				    tr.css({"background":_obj.oddBG});
				  }
				);
			}else//偶数行
			{
				tr.css({"background":_obj.evenBG});
				tr.hover(
				  function () {
				    tr.css({"background":_obj.hoverBG});
				  },
				  function () {
				    tr.css({"background":_obj.evenBG});
				  }
				);
			}
		},
		

		/**
		 * td复选框是否被选中样式
		 * @param index 索引号
		 * @param tr	行
		 * @param tdCheckbox td复选框
		 * @param checkboxAll 全选复选框
		 */
		_clickTrEvent: function(index, tr, tdCheckbox, checkboxAll)
		{
			var _obj = this;
			if(!tdCheckbox.attr("checked"))//复选框未被选中
			{
				_obj._hoverEvent(index, tr);
			}else
			{
				tr.css({"background":_obj.selectedBG}).hover(
					function () {
				    	tr.css({"background":_obj.selectedBG});
				 	},
				  	function () {
				    	tr.css({"background":_obj.selectedBG});
				  });
			}
			_obj._judgeCheckbox(checkboxAll);
		},
		
		/**
		 * 判断全选复选框应该被选中
		 */
		_judgeCheckbox: function(checkboxAll){
			var _obj = this;
			
			var tdCheckboxed = $("#"+_obj.id+ " tr td input[type='checkbox'][id^=" + _obj.checkboxIdPrefix + "]:checked");
			var tdCheckbox = $("#"+_obj.id+ " tr td input[type='checkbox'][id^=" + _obj.checkboxIdPrefix + "]");
			
			//如果复选框被全部选中，则全选复选框设置为选中，否则相反
			if(tdCheckboxed.size() != tdCheckbox.size())
			{
				checkboxAll.attr("checked", false);
			}else
			{
				checkboxAll.attr("checked", true);
			}
		},
		
/********************以下的方法是面向用户的方法*********************/
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
			var _obj = this;
			var tableId = this.id;
			var isNo = this.isNo;
			var isCheckbox = this.isCheckbox;
			var checkboxAll = this.checkboxAll;
			var checkboxIdPrefix = this.checkboxIdPrefix;
			var checkboxValueField = this.checkboxValueField;
			var fields = this.fields;
			
			//移除表格数据
			$("#" + tableId).find("tr").not(":first").each(function(){
				$(this).remove();
			});
			
			if(list != null && list.length > 0)
			{//有数据时的处理
				var trs = new Array();
				var indexs = new Array();
				
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
					var tr = _obj._createTr(index,values,isCheckbox,checkboxIdPrefix, isNo, checkboxAll);
					trs.push(tr);
					indexs.push(index);
					$("#" + tableId).children().first().append(tr);
				});
				
				checkboxAll.bind("click", function(){
					var iCheck = checkboxAll.attr("checked");
					iCheck = iCheck == "checked"?true:false;//这是为jquery 1.6而处理
					$("#"+tableId+ " tr td input[id^="+checkboxIdPrefix+"]").attr("checked", iCheck);//全选/取消 （用的模糊匹配）
					for(var i = 0; i < trs.length; i++)
					{
						if(checkboxAll.attr("checked"))
						{
							trs[i].css({"background":_obj.selectedBG});
							trs[i].hover(function(){
									$(this).css({"background":_obj.selectedBG});
								}, function(){
									$(this).css({"background":_obj.selectedBG});
								});
						}else
						{
							_obj._resetTrCssEvent(indexs[i], trs[i]);
						}
					}
				});
				
			}else
			{//表格无数据处理
				if(!isCheckbox)
				{
					fields.length -= 1;
				}
				var tr = $("<tr style='height:"+_obj.trHeight+";' >");
				tr.append("<td colspan="+(fields.length+2)+" style='text-align:center;'><font color=red>没有数据！！！</font></td>");
				$("#" + tableId).children().first().append(tr);
			}
		},
		
		/**
		 * 获取所有复选框的值
		 * @returns strings
		 */
		getCheckAllValue: function(){
			var _obj = this;
			var values = "";
			$("#"+_obj.id+ " tr td input[type='checkbox'][id^=" + _obj.checkboxIdPrefix + "]").each(function(){
				values += $(this).val() + ",";
			});
			return values.length > 0 ? values.substring(0,values.length - 1) : values;
		},
		
		/**
		 * 获取选中复选框的值
		 * @returns strings
		 */
		getCheckedValue: function(){
			var _obj = this;
			var values = "";
			$("#"+_obj.id+ " tr td input[type='checkbox'][id^=" + _obj.checkboxIdPrefix + "]:checked").each(function(){
				values += $(this).val() + ",";
			});
			return values.length > 0 ? values.substring(0,values.length - 1) : values;
		},
		
};













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