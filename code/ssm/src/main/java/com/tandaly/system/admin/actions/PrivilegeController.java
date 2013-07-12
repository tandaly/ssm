package com.tandaly.system.admin.actions;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.tandaly.core.exception.ServiceException;
import com.tandaly.core.metatype.ResponseMap;
import com.tandaly.core.metatype.impl.HashResponseMap;
import com.tandaly.core.page.Pagination;
import com.tandaly.core.util.WebUtil;
import com.tandaly.system.admin.beans.Menu;
import com.tandaly.system.admin.beans.Privilege;
import com.tandaly.system.admin.service.MenuService;
import com.tandaly.system.admin.service.PrivilegeService;
/**
 * 权限控制器
 * @author Tandaly
 * @date 2013-6-27 上午8:50:22
 */
@Controller
@RequestMapping("privilege")
public class PrivilegeController
{

	@Autowired
	PrivilegeService privilegeService;
	
	@Autowired
	MenuService menuService;
	
	@RequestMapping("privilegeFrame")
	public void privilegeFrame()
	{
		
	}
	
	@RequestMapping("frame")
	public void frame()
	{
		
	}
	
	@RequestMapping("privilegeList")
	public void privilegeList()
	{
		
	}
	
	@RequestMapping("privilegeDetailList")
	public void privilegeDetailList()
	{
		
	}
	
	/**
	 * 跳转到增加权限页面
	 */
	@RequestMapping("addPrivilege")
	public void addPrivilege()
	{
		
	}
	
	/**
	 * 添加权限
	 * @param response
	 * @param request
	 * @param privilege
	 */
	@RequestMapping(value = "ajaxAddPrivilege", method = RequestMethod.POST)
	public void ajaxAddPrivilege(HttpServletResponse response, HttpServletRequest request, Privilege privilege)
	{
		ResponseMap responseMap = new HashResponseMap();
		try {
			this.privilegeService.addPrivilege(privilege);
			responseMap.put("id", privilege.getId());
			responseMap.setStatus(true);
			responseMap.setInfo("添加权限成功");
		} catch (ServiceException e) {
			responseMap.setStatus(false);
			responseMap.setInfo(e.getMessage());
		}
		
		WebUtil.writerJson(response, responseMap);
	}
	
	/**
	 * 删除权限
	 * @param response
	 * @param ids
	 */
	@RequestMapping(value="ajaxDeletePrivilege", method = RequestMethod.POST)
	public void ajaxDeletePrivilege(HttpServletResponse response, String ids){
		ResponseMap responseMap = new HashResponseMap();
		try
		{
			this.privilegeService.deletePrivilege(ids);
			responseMap.setStatus(true);
			responseMap.setInfo("删除权限成功");
		} catch (ServiceException e) {
			responseMap.setStatus(false);
			responseMap.setInfo(e.getMessage());
		}
		
		WebUtil.writerJson(response, responseMap);
	}
	
	/**
	 * 跳转到权限修改页面
	 * @param privilege
	 * @return
	 */
	@RequestMapping("updatePrivilege")
	public Object updatePrivilege(Privilege privilege)
	{
		return this.privilegeService.queryPrivilegeById(privilege.getId());
	}
	
	/**
	 * 修改权限
	 * @param response
	 * @param privilege
	 */
	@RequestMapping(value = "ajaxUpdatePrivilege", method = RequestMethod.POST)
	public void ajaxUpdatePrivilege(HttpServletResponse response, Privilege privilege)
	{
		ResponseMap responseMap = new HashResponseMap();
		try
		{
			this.privilegeService.updatePrivilete(privilege);
			responseMap.setStatus(true);
			responseMap.setInfo("修改权限成功");
		} catch (ServiceException e)
		{
			responseMap.setStatus(false);
			responseMap.setInfo(e.getMessage());
		}
		
		WebUtil.writerJson(response, responseMap);
	}
	
	/**
	 * 异步表单权限名称验证(新增和修改)
	 * @param response
	 * @param param
	 * @param name
	 */
	@RequestMapping("ajaxFormPrivilegeName")
	public void ajaxFormPrivilegeName(HttpServletResponse response, 
			String param, String name, Integer id)
	{
		ResponseMap responseMap = new HashResponseMap();
		try
		{
			if(null != id)
			{
				this.privilegeService.checkUpdatePrivilegeName(id, param);
			}else
			{
				this.privilegeService.checkPrivilegeName(param);
			}
			responseMap.setStatus(true);
			responseMap.setInfo("该权限名称可用");
		} catch (ServiceException e)
		{
			responseMap.setStatus(false);
			responseMap.setInfo(e.getMessage());
		}
		
		WebUtil.writerJson(response, responseMap);
	}
	
	/**
	 * 查询权限列表
	 * @param response
	 * @param pagination
	 * @param user
	 */
	@RequestMapping(value = "ajaxPrivilegeList", method = RequestMethod.POST)
	public void ajaxPrivilegeList(HttpServletResponse response, Pagination pagination, Privilege privilege)
	{
		pagination.setParamEntity(privilege);
		this.privilegeService.pageQueryEntityList(pagination);
		WebUtil.writerPagination(response, pagination);
	}
	
	/**
	 * 跳转到菜单树界面
	 */
	@RequestMapping("menuTree")
	public Object menuTree(Privilege privilege)
	{
		return privilege;
	}
	
	/**
	 * 异步查询所有菜单
	 * @param response
	 */
	@RequestMapping("ajaxQueryMenuTree")
	public void ajaxQueryMenuTree(HttpServletResponse response, Integer privilegeId)
	{
		List<Menu> menus = this.menuService.queryMenuTree(privilegeId);
		
		WebUtil.writerJson(response, menus);
	}
	
	
	/**
	 * 异步分配菜单
	 * @param response
	 * @param menuIds
	 */
	@RequestMapping("ajaxAllotMenu")
	public void ajaxAllotMenu(HttpServletResponse response, Integer privilegeId, String menuIds)
	{
		ResponseMap responseMap = new HashResponseMap();
		try
		{
			this.privilegeService.allotMenu(privilegeId, menuIds);
			responseMap.setStatus(true);
			responseMap.setInfo("分配菜单成功");
		} catch (ServiceException e) {
			responseMap.setStatus(false);
			responseMap.setInfo(e.getMessage());
		}
		
		WebUtil.writerJson(response, responseMap);
	}
}
