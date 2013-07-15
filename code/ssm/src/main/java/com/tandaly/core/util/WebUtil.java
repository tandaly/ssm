package com.tandaly.core.util;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.tandaly.core.page.Pagination;

public class WebUtil
{
	/**
	 * 输出html
	 * @param response
	 * @param htmlStr
	 */
	public static void writerHtml(HttpServletResponse response, Object obj)
	{
		HtmlUtil.writerHtml(response, obj.toString());
	}
	/**
	 * 输出json
	 * @param response
	 * @param object
	 */
	public static void writerJson(HttpServletResponse response, Object object)
	{
		HtmlUtil.writerJson(response, object);
	}
	/**
	 * 输出分页数据
	 * 
	 * @param response	响应对象
	 * @param pagination	分页对象
	 */
	public static void writerPagination(HttpServletResponse response,
			Pagination pagination)
	{
		writerPagination(response, pagination, new HashMap<String, Object>());
	}
	
	/**
	 * 输出分页数据
	 * 
	 * @param response	响应对象
	 * @param pagination	分页对象
	 * @param result	返回对象实体，由调用者自行创建并设置参数
	 */
	public static void writerPagination(HttpServletResponse response,
			Pagination pagination, Map<String, Object> result)
	{
		// 分页返回参数
		result.put("pageCount", pagination.getPageCount());
		result.put("list", pagination.getList());
		result.put("countRecord", pagination.getTotalCount());

		HtmlUtil.writerJson(response, result);
	}
}
