package com.tandaly.system.admin.actions;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.tandaly.core.exception.ServiceException;
import com.tandaly.core.metatype.ResponseMap;
import com.tandaly.core.metatype.impl.HashResponseMap;
import com.tandaly.core.page.Pagination;
import com.tandaly.core.util.WebUtil;
import com.tandaly.system.admin.beans.Menu;
import com.tandaly.system.admin.service.MenuService;
/**
 * 菜单控制器
 * @author Tandaly
 * @date 2013-6-25 上午9:13:18
 */
@Controller
@RequestMapping("menu")
public class MenuController
{

	@Autowired
	MenuService menuService;
	
	/**
	 * 跳转到菜单管理框架页面
	 */
	@RequestMapping("menuFrame")
	public void menuFrame()
	{
	}
	
	/**
	 * 跳转到菜单框架页面
	 */
	@RequestMapping("frame")
	public void frame()
	{
		
	}
	
	/**
	 * 跳转到左菜单页面
	 */
	@RequestMapping("left")
	public void left()
	{
		
	}
	
	/**
	 * 跳转到添加菜单页面
	 * @param menu
	 * @return
	 */
	@RequestMapping("addMenu")
	public Object addMenu(Menu menu)
	{
		return menu;
	}
	
	/**
	 * 添加菜单
	 * @param response
	 * @param request
	 * @param menu
	 */
	@RequestMapping(value = "ajaxAddMenu", method = RequestMethod.POST)
	public void ajaxAddMenu(HttpServletResponse response, 
			HttpServletRequest request, Menu menu)
	{
		String msg = "";
		try {
			this.menuService.addMenu(menu);
		} catch (ServiceException e) {
			msg = e.getMessage();
		}
		
		WebUtil.writerJson(response, msg);
	}
	
	/**
	 * 删除菜单
	 * @param response
	 * @param ids
	 */
	@RequestMapping(value="ajaxDeleteMenu", method = RequestMethod.POST)
	public void ajaxDeleteMenu(HttpServletResponse response, String ids){
		ResponseMap responseMap = new HashResponseMap();
		try
		{
			this.menuService.deleteMenu(ids);
			responseMap.setStatus(true);
			responseMap.setInfo("删除菜单成功");
		} catch (ServiceException e) {
			responseMap.setStatus(false);
			responseMap.setInfo(e.getMessage());
		}
		
		WebUtil.writerJson(response, responseMap);
	}
	
	/**
	 * 跳转到修改菜单页面
	 * @param menu
	 * @return
	 */
	@RequestMapping("updateMenu")
	public Object updateMenu(Menu menu)
	{
		return this.menuService.queryMenuById(menu.getId());
	}
	
	/**
	 * 修改菜单
	 * @param response
	 * @param menu
	 */
	@RequestMapping(value = "ajaxUpdateMenu", method = RequestMethod.POST)
	public void ajaxUpdateMenu(HttpServletResponse response, Menu menu)
	{
		ResponseMap responseMap = new HashResponseMap();
		try
		{
			this.menuService.updateMenu(menu);
			responseMap.setStatus(true);
			responseMap.setInfo("修改菜单成功");
		} catch (ServiceException e)
		{
			responseMap.setStatus(false);
			responseMap.setInfo(e.getMessage());
		}
		
		WebUtil.writerJson(response, responseMap);
	}
	
	/**
	 * 异步查询所有菜单
	 * @param response
	 */
	@RequestMapping("ajaxQueryMenus")
	public void ajaxQueryMenus(HttpServletResponse response)
	{
		List<Menu> menus = this.menuService.queryMenusByMenu(null);
		
		WebUtil.writerJson(response, menus);
	}
	
	/**
	 * 跳转到菜单列表页面
	 */
	@RequestMapping("menuList")
	public Object menuList(ModelMap model, String parentNo)
	{
		model.addAttribute("parentNo", parentNo);
		return model;
	}
	
	/**
	 * 异步查询菜单列表
	 * @param response
	 * @param pagination
	 * @param menu
	 */
	@RequestMapping(value = "ajaxMenuList", method = RequestMethod.POST)
	public void ajaxMenuList(HttpServletResponse response, 
			Pagination pagination, Menu menu)
	{
		pagination.getParamMap().put("menu", menu);
		
		this.menuService.pageQueryEntityList(pagination);
		WebUtil.writerPagination(response, pagination);
	}
	

	/**
	 * 异步表单菜单编号验证(新增和修改)
	 * @param response
	 * @param param
	 * @param name
	 */
	@RequestMapping("ajaxFormMenuNo")
	public void ajaxFormMenuNo(HttpServletResponse response, 
			String param, String name, Integer id)
	{
		ResponseMap responseMap = new HashResponseMap();
		try
		{
			if(null != id)
			{
				this.menuService.checkUpdateMenuNo(id, param);
			}else
			{	
				this.menuService.checkMenuNo(param);
			}
			responseMap.setStatus(true);
			responseMap.setInfo("该菜单编号可用");
		} catch (ServiceException e)
		{
			responseMap.setStatus(false);
			responseMap.setInfo(e.getMessage());
		}
		
		WebUtil.writerJson(response, responseMap);
	}
	
	/**
	 * 异步表单菜单名称验证(新增和修改)
	 * @param response
	 * @param param
	 * @param name
	 */
	@RequestMapping("ajaxFormMenuName")
	public void ajaxFormMenuName(HttpServletResponse response, 
			String param, String name, Integer id)
	{
		ResponseMap responseMap = new HashResponseMap();
		try
		{
			if(null != id)
			{
				this.menuService.checkUpdateMenuName(id, param);
			}else
			{
				this.menuService.checkMenuName(param);
			}
			responseMap.setStatus(true);
			responseMap.setInfo("该菜单名称可用");
		} catch (ServiceException e)
		{
			responseMap.setStatus(false);
			responseMap.setInfo(e.getMessage());
		}
		
		WebUtil.writerJson(response, responseMap);
	}
	
}
