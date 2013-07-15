package com.tandaly.system.admin.actions;

import javax.servlet.http.HttpServletRequest;
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
import com.tandaly.core.util.SystemUtil;
import com.tandaly.core.util.WebUtil;
import com.tandaly.system.admin.beans.Params;
import com.tandaly.system.admin.service.ParamsService;

/**
 * 系统全局参数控制器
 * @author Tandaly
 * @date 2013-7-1 下午3:18:37
 */
@Controller
@RequestMapping("params")
public class ParamsController
{
	@Autowired
	ParamsService paramsService;
	
	/**
	 * 添加参数页面
	 */
	@RequestMapping("addParams")
	public void addParams()
	{
		
	}
	
	/**
	 * 添加参数
	 * @param response
	 * @param request
	 * @param params
	 */
	@RequestMapping(value = "ajaxAddParams", method = RequestMethod.POST)
	public void ajaxAddParams(HttpServletResponse response, HttpServletRequest request, 
			Params params)
	{
		ResponseMap responseMap = new HashResponseMap();
		try {
			this.paramsService.addParams(params);
			responseMap.setStatus(true);
			responseMap.setInfo("添加成功");
		} catch (ServiceException e) {
			responseMap.setStatus(false);
			responseMap.setInfo(e.getMessage());
		}
		
		WebUtil.writerJson(response, responseMap);
	}
	
	/**
	 * 删除参数
	 * @param response
	 * @param ids
	 */
	@RequestMapping(value="ajaxDeleteParams", method = RequestMethod.POST)
	public void ajaxDeleteParams(HttpServletResponse response, String ids){
		ResponseMap responseMap = new HashResponseMap();
		try
		{
			this.paramsService.deleteParams(ids);
			responseMap.setStatus(true);
			responseMap.setInfo("删除成功");
		} catch (ServiceException e) {
			responseMap.setStatus(false);
			responseMap.setInfo(e.getMessage());
		}
		
		WebUtil.writerJson(response, responseMap);
	}
	
	/**
	 * 修改参数页面
	 * @param model
	 * @param id
	 */
	@RequestMapping("updateParams")
	public void updateParams(Model model, Integer id)
	{
		Params params = this.paramsService.queryParamsById(id);
		model.addAttribute(params);
	}
	
	/**
	 * 修改参数
	 * @param response
	 * @param params
	 */
	@RequestMapping(value = "ajaxUpdateParams", method = RequestMethod.POST)
	public void ajaxUpdateParams(HttpServletResponse response, Params params)
	{
		ResponseMap responseMap = new HashResponseMap();
		try
		{
			this.paramsService.updateParams(params);
			responseMap.setStatus(true);
			responseMap.setInfo("修改成功");
		} catch (ServiceException e)
		{
			responseMap.setStatus(false);
			responseMap.setInfo(e.getMessage());
		}
		
		WebUtil.writerJson(response, responseMap);
	}
	

	/**
	 * 异步表单参数名称验证(新增和修改)
	 * @param response
	 * @param param
	 * @param name
	 */
	@RequestMapping("ajaxFormParamsName")
	public void ajaxFormParamsName(HttpServletResponse response, 
			String param, String name, Integer id)
	{
		ResponseMap responseMap = new HashResponseMap();
		try
		{
			if(null != id)
			{
				this.paramsService.checkUpdateParamsName(id, param);
			}else
			{
				this.paramsService.checkParamsName(param);
			}
			responseMap.setStatus(true);
			responseMap.setInfo("该名称可用");
		} catch (ServiceException e)
		{
			responseMap.setStatus(false);
			responseMap.setInfo(e.getMessage());
		}
		
		WebUtil.writerJson(response, responseMap);
	}
	
	
	/**
	 * 跳转到参数列表
	 */
	@RequestMapping("paramsList")
	public void paramsList()
	{
		
	}
	
	/**
	 * 查询参数列表
	 * @param response
	 * @param pagination
	 * @param params
	 */
	@RequestMapping(value = "ajaxParamsList", method = RequestMethod.POST)
	public void ajaxParamsList(HttpServletResponse response, Pagination pagination,
			Params params)
	{
		pagination.setParamEntity(params);
		this.paramsService.pageQueryEntityList(pagination);
		WebUtil.writerPagination(response, pagination);
	}
	
	/**
	 * 同步系统全局参数到内存
	 */
	@RequestMapping("synMemoryParams")
	public void synMemoryParams(HttpServletResponse response)
	{
		ResponseMap responseMap = new HashResponseMap();
		try
		{	
			SystemUtil.loadSystemParams();
			responseMap.setStatus(true);
			responseMap.setInfo("内存参数同步成功");
		}catch(Exception e)
		{
			responseMap.setStatus(false);
			responseMap.setInfo("内存参数同步失败");
		}
		
		WebUtil.writerJson(response, responseMap);
	}
}
