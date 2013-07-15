package com.tandaly.system.admin.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.tandaly.core.exception.ServiceException;
import com.tandaly.core.metatype.ResponseMap;
import com.tandaly.core.metatype.impl.HashResponseMap;
import com.tandaly.core.page.Pagination;
import com.tandaly.core.util.WebUtil;
import com.tandaly.system.admin.beans.Privilege;
import com.tandaly.system.admin.beans.Role;
import com.tandaly.system.admin.service.RoleService;
/**
 * 角色控制器
 * @author Tandaly
 * @date 2013-6-25 上午9:13:25
 */
@Controller
@RequestMapping("role")
public class RoleController
{
	
	@Autowired
	RoleService roleService;
	
	/**
	 * 异步表单角色名称验证
	 * @param response
	 * @param param
	 * @param name
	 */
	/*@RequestMapping("ajaxFormRoleName")
	public void ajaxFormRoleName(HttpServletResponse response, String param, String name)
	{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try
		{
			this.roleService.checkRoleName(param);
			resultMap.put("info", "该角色名可用");
			resultMap.put("status", "y");
		} catch (ServiceException e)
		{
			resultMap.put("info", e.getMessage());
			resultMap.put("status", "n");
		}
		
		WebUtil.writerJson(response, resultMap);
	}*/
	
	/**
	 * 跳转到角色添加页面
	 * @return
	 */
	@RequestMapping("addRole")
	public void addRole(){
	}
	
	/**
	 * 添加角色
	 * @param response
	 * @param request
	 * @param role
	 */
	@RequestMapping(value = "ajaxAddRole", method = RequestMethod.POST)
	public void ajaxAddRole(HttpServletResponse response, HttpServletRequest request, Role role)
	{
		ResponseMap responseMap = new HashResponseMap();
		try {
			this.roleService.addRole(role);
			responseMap.put("id", role.getId());
			responseMap.setStatus(true);
			responseMap.setInfo("添加角色成功");
		} catch (ServiceException e) {
			responseMap.setStatus(false);
			responseMap.setInfo(e.getMessage());
		}
		
		WebUtil.writerJson(response, responseMap);
	}
	
	/**
	 * 删除角色
	 * @param response
	 * @param ids
	 */
	@RequestMapping(value="ajaxDeleteRole", method = RequestMethod.POST)
	public void ajaxDeleteRole(HttpServletResponse response, String ids)
	{
		ResponseMap responseMap = new HashResponseMap();
		try
		{
			this.roleService.deleteRole(ids);
			responseMap.setStatus(true);
			responseMap.setInfo("删除角色成功");
		} catch (ServiceException e) {
			responseMap.setStatus(false);
			responseMap.setInfo(e.getMessage());
		}
		
		WebUtil.writerJson(response, responseMap);
	}
	
	/**
	 * 跳转到角色修改页面
	 * @param role
	 * @return
	 */
	@RequestMapping("updateRole")
	public Object updateRole(Role role)
	{
		return this.roleService.queryRoleById(role.getId());
	}
	
	/**
	 * 修改角色
	 * @param response
	 * @param role
	 */
	@RequestMapping(value = "ajaxUpdateRole", method = RequestMethod.POST)
	public void ajaxUpdateRole(HttpServletResponse response, Role role)
	{
		ResponseMap responseMap = new HashResponseMap();
		try
		{
			this.roleService.updateRole(role);
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
	 * 异步表单角色名称验证(新增和修改)
	 * @param response
	 * @param param
	 * @param name
	 */
	@RequestMapping("ajaxFormRoleName")
	public void ajaxFormRoleName(HttpServletResponse response, 
			String param, String name, Integer id)
	{
		ResponseMap responseMap = new HashResponseMap();
		try
		{
			if(null != id)
			{
				this.roleService.checkUpdateRoleName(id, param);
			}else
			{
				this.roleService.checkRoleName(param);
			}
			responseMap.setStatus(true);
			responseMap.setInfo("该角色名称可用");
		} catch (ServiceException e)
		{
			responseMap.setStatus(false);
			responseMap.setInfo(e.getMessage());
		}
		
		WebUtil.writerJson(response, responseMap);
	}
	
	
	/**
	 * 跳转到角色列表
	 * @return
	 */
	@RequestMapping("roleList")
	public void roleList()
	{
	}
	
	/**
	 * 查询角色列表
	 * @param response
	 * @param pagination
	 * @param role
	 */
	@RequestMapping(value = "ajaxRoleList", method = RequestMethod.POST)
	public void ajaxRoleList(HttpServletResponse response, Pagination pagination, Role role)
	{
		pagination.getParamMap().put("role", role);
		
		this.roleService.pageQueryEntityList(pagination);
		WebUtil.writerPagination(response, pagination);
	}
	
	/**
	 * 跳转到角色权限列表
	 * @return
	 */
	@RequestMapping("rolePrivilegeList")
	public void rolePrivilegeList(@ModelAttribute("role")Role role)
	{
	}
	
	/**
	 * 跳转到权限列表
	 * @return
	 */
	@RequestMapping("selectPrivilegeList")
	public void selectPrivilegeList(@ModelAttribute("role")Role role)
	{
	}
	
	/**
	 * 查询角色权限列表
	 * @param response
	 * @param pagination
	 * @param privilege
	 */
	@RequestMapping(value = "ajaxRolePrivilegeList", method = RequestMethod.POST)
	public void ajaxRolePrivilegeList(HttpServletResponse response, 
			Pagination pagination, Privilege privilege, Integer roleId)
	{
		pagination.setParamEntity(privilege);
		pagination.getParamMap().put("roleId", roleId);
		
		this.roleService.pageQueryRolePrivilegeList(pagination);
		WebUtil.writerPagination(response, pagination);
	}
	
	/**
	 * 分页查询选择权限列表
	 * @param response
	 * @param pagination
	 * @param privilege
	 */
	@RequestMapping(value = "ajaxSelectPrivilegeList", method = RequestMethod.POST)
	public void ajaxSelectPrivilegeList(HttpServletResponse response, 
			Pagination pagination, Privilege privilege, Integer roleId)
	{
		pagination.setParamEntity(privilege);
		pagination.getParamMap().put("roleId", roleId);
		
		this.roleService.pageQuerySelectPrivilegeList(pagination);
		WebUtil.writerPagination(response, pagination);
	}
	
	/**
	 * 分配角色权限
	 * @param response
	 * @param roleId
	 * @param privilegeIds
	 */
	@RequestMapping(value="ajaxAllotRolePrivilege", method = RequestMethod.POST)
	public void ajaxAllotRolePrivilege(HttpServletResponse response, Integer roleId, 
			String privilegeIds){
		ResponseMap responseMap = new HashResponseMap();
		try
		{
			this.roleService.allotRolePrivilege(roleId, privilegeIds);
			responseMap.setStatus(true);
			responseMap.setInfo("分配权限成功");
		} catch (ServiceException e) {
			responseMap.setStatus(false);
			responseMap.setInfo(e.getMessage());
		}
		
		WebUtil.writerJson(response, responseMap);
	}
	
	/**
	 * 根据权限id和角色id删除关联
	 * @param response
	 * @param roleId
	 * @param privilegeIds
	 */
	@RequestMapping(value="ajaxDeleteRolePrivilege", method = RequestMethod.POST)
	public void ajaxDeleteRolePrivilege(HttpServletResponse response, Integer roleId, 
			String privilegeIds){
		ResponseMap responseMap = new HashResponseMap();
		try
		{
			this.roleService.deleteRolePrivilege(roleId, privilegeIds);
			responseMap.setStatus(true);
			responseMap.setInfo("删除成功");
		} catch (ServiceException e) {
			responseMap.setStatus(false);
			responseMap.setInfo(e.getMessage());
		}
		
		WebUtil.writerJson(response, responseMap);
	}
	
}
