function checkAll(boxid,prefix){
	var box = $("#" + boxid);
	box.unbind("click");
	box.click(function(){
		$("input[id^=" + prefix + "]").each(function(){
			box.attr("checked") ? $(this).attr("checked",true) : $(this).removeAttr("checked");
		});
	});
}
function checkedValue(prefix){
	var values = "";
	$("input[type='checkbox'][id^=" + prefix + "]:checked").each(function(){
		values += $(this).val() + ",";
	});
	return values.length > 0 ? values.substring(0,values.length - 1) : values;
}
function cascade(options){
	//给左边的下拉菜单添加事件
	$("#" + options.left).bind("change",function(){
		//清空右侧下拉菜单
		if(options.header){
			$("#" + options.right).find("option").not(":first").each(function(){
				$(this).remove();
			});
		} else {
			$("#" + options.right).find("option").each(function(){
				$(this).remove();
			});
		}
		//判断是否选择的第一个,如果是,不提交
		if($(this).val() == "0" || $(this).val() == ""){
			return;
		}
		//创建参数JSON对象
		var paramStr = "{\"" + options.receive + "\":\"" + $(this).val() + "\"}";
		var param = $.parseJSON(paramStr);
		//JSON请求
		$.getJSON(options.url,param,function(data){
			try{
				if(null != data){
					//遍历,并放入右边的下拉菜单中
					if(data[options.list] != null && data[options.list].length > 0){
						for (var i = 0 ; i < data[options.list].length; i++){
							var option = $("<option>").val(data[options.list][i][options.value]).html(data[options.list][i][options.display]);
							$("#" + options.right).append(option);
						}
					}
				}
			} catch (e) {}
		});
	});
}