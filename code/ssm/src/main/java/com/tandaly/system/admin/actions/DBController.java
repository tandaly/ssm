package com.tandaly.system.admin.actions;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tandaly.core.page.Pagination;
import com.tandaly.core.util.WebUtil;
import com.tandaly.system.admin.service.DBService;

@Controller
@RequestMapping("db")
public class DBController
{

	@Autowired
	DBService dbService;
	
	/**
	 * 数据表列表页面
	 */
	@RequestMapping("tableList")
	public void tableList()
	{
		
	}
	
	/**
	 * 查询数据表列表
	 * @param response
	 */
	@RequestMapping("ajaxTableList")
	public void ajaxTableList(HttpServletResponse response, Pagination pagination, String tableSchema)
	{
		pagination.getParamMap().put("tableSchema", tableSchema);
		dbService.queryDBTables(pagination);
		
		WebUtil.writerPagination(response, pagination);
	}
	
	
	/**
	 * 数据库字段列表页面
	 * @param tableName
	 */
	@RequestMapping("tableColumnList")
	public void tableColumnList(Model model, String tableName)
	{
		model.addAttribute("tableName", tableName);
	}
	
	/**
	 * 查询数据表列表
	 * @param response
	 */
	@RequestMapping("ajaxTableColumnList")
	public void ajaxTableColumnList(HttpServletResponse response, String tableName)
	{
		List<Map<String, Object>> resultMap = dbService.queryDBTableColumnByTableName(tableName);
		
		WebUtil.writerJson(response, resultMap);
	}
	
}
