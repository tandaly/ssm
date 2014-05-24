package com.tanf.system.admin.actions;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tanf.core.page.Pagination;
import com.tanf.core.util.WebUtil;
import com.tanf.system.admin.service.DBService;

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
	public void ajaxTableList(HttpServletResponse response, Pagination pagination, String tableSchema, String tableName)
	{
		pagination.getParamMap().put("tableSchema", tableSchema);
		pagination.getParamMap().put("tableName", tableName);
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
	
	/**
	 * 表设计页面
	 */
	@RequestMapping("tableDesign")
	public void tableDesign()
	{
		
	}
	
}
