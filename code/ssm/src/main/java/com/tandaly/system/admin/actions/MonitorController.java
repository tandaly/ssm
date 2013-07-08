package com.tandaly.system.admin.actions;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.tandaly.core.exception.ServiceException;
import com.tandaly.core.metatype.ResponseMap;
import com.tandaly.core.metatype.impl.HashResponseMap;
import com.tandaly.core.page.Pagination;
import com.tandaly.core.util.WebUtil;
import com.tandaly.system.admin.service.MonitorService;
/**
 * 系统监听控制器
 * @author Tandaly
 * @date 2013-7-1 下午2:00:41
 */
@Controller
@RequestMapping("monitor")
public class MonitorController
{

	@Autowired
	MonitorService monitorService;
	
	/*******************************事件信息操作start****************************/
	/**
	 * 删除事件日志
	 * @param response
	 * @param ids
	 */
	@RequestMapping(value="ajaxDeleteEvent", method = RequestMethod.POST)
	public void ajaxDeleteEvent(HttpServletResponse response, String ids){
		ResponseMap responseMap = new HashResponseMap();
		try
		{
			this.monitorService.deleteEvent(ids);
			responseMap.setStatus(true);
			responseMap.setInfo("删除成功");
		} catch (ServiceException e) {
			responseMap.setStatus(false);
			responseMap.setInfo(e.getMessage());
		}
		
		WebUtil.writerJson(response, responseMap);
	}
	
	/**
	 * 清空事件日志
	 * @param response
	 * @param ids
	 */
	@RequestMapping(value="ajaxClearEvent", method = RequestMethod.POST)
	public void ajaxClearEvent(HttpServletResponse response){
		ResponseMap responseMap = new HashResponseMap();
		try
		{
			this.monitorService.clearEvent();
			responseMap.setStatus(true);
			responseMap.setInfo("操作成功");
		} catch (ServiceException e) {
			responseMap.setStatus(false);
			responseMap.setInfo(e.getMessage());
		}
		
		WebUtil.writerJson(response, responseMap);
	}
	
	
	/**
	 * 跳转到request列表
	 */
	@RequestMapping("requestList")
	public void requestList()
	{
		
	}
	
	/**
	 * 查询事件列表
	 * @param response
	 * @param pagination
	 * @param userName
	 */
	@RequestMapping(value = "ajaxEventList", method = RequestMethod.POST)
	public void ajaxEventList(HttpServletResponse response, Pagination pagination,String userName)
	{
		pagination.getParamMap().put("userName", userName);
		this.monitorService.pageQueryEntityList(pagination);
		WebUtil.writerPagination(response, pagination);
	}
	
	/*******************************异常信息操作start****************************/
	/**
	 * 删除异常
	 * @param response
	 * @param ids
	 */
	@RequestMapping(value="ajaxDeleteExceptions", method = RequestMethod.POST)
	public void ajaxDeleteExceptions(HttpServletResponse response, String ids){
		ResponseMap responseMap = new HashResponseMap();
		try
		{
			this.monitorService.deleteExceptions(ids);
			responseMap.setStatus(true);
			responseMap.setInfo("删除成功");
		} catch (ServiceException e) {
			responseMap.setStatus(false);
			responseMap.setInfo(e.getMessage());
		}
		
		WebUtil.writerJson(response, responseMap);
	}
	
	/**
	 * 清空异常日志
	 * @param response
	 * @param ids
	 */
	@RequestMapping(value="ajaxClearExceptions", method = RequestMethod.POST)
	public void ajaxClearExceptions(HttpServletResponse response){
		ResponseMap responseMap = new HashResponseMap();
		try
		{
			this.monitorService.clearExceptions();
			responseMap.setStatus(true);
			responseMap.setInfo("操作成功");
		} catch (ServiceException e) {
			responseMap.setStatus(false);
			responseMap.setInfo(e.getMessage());
		}
		
		WebUtil.writerJson(response, responseMap);
	}
	
	
	/**
	 * 详情异常页面
	 * @param model
	 * @param id
	 */
	@RequestMapping(value="detailExceptions", method = RequestMethod.GET)
	public void detailExceptions(Model model, Integer id)
	{
		model.addAttribute("exceptions", this.monitorService.queryExceptionsById(id));
	}
	
	/**
	 * 跳转到异常列表
	 * @throws Exception 
	 */
	@RequestMapping("exceptionsList")
	public void exceptionsList()
	{
	}
	
	/**
	 * 查询异常列表
	 * @param response
	 * @param pagination
	 * @param className
	 */
	@RequestMapping(value = "ajaxExceptionsList", method = RequestMethod.POST)
	public void ajaxExceptionsList(HttpServletResponse response, Pagination pagination,String className)
	{
		pagination.getParamMap().put("className", className);
		this.monitorService.pageQueryExceptionsList(pagination);
		WebUtil.writerPagination(response, pagination);
	}
	
}
