package com.tandaly.system.admin.actions;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import com.tandaly.system.admin.beans.Role;
import com.tandaly.system.admin.beans.User;
import com.tandaly.system.admin.service.UserService;
import com.tandaly.system.common.util.SystemConstants;
/**
 * 用户控制器
 * @author Tandaly
 * @date 2013-6-25 上午9:13:31
 */
@Controller
@RequestMapping("user")
public class UserController
{
	@Autowired
	private UserService userService;
	
	/**
	 * 日期数据绑定(格式转换)
	 * @param binder
	 */
/*	@InitBinder
	public void initBinder(WebDataBinder binder)
	{
		binder.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd"), true));
		binder.registerCustomEditor(Timestamp.class, new CustomTimestampEditor(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"), true));
	}*/
	
	/**
	 * 跳转到用户列表
	 * @return
	 */
	@RequestMapping("userList")
	public void userList()
	{
	}
	
	/**
	 * 跳转到用户添加页面
	 * @return
	 */
	@RequestMapping("addUser")
	public void addUser(){
	}
	
	/**
	 * 添加用户
	 * @param response
	 * @param request
	 * @param user
	 */
	@RequestMapping(value = "ajaxAddUser", method = RequestMethod.POST)
	public void ajaxAddUser(HttpServletResponse response, HttpServletRequest request, User user)
	{
		ResponseMap responseMap = new HashResponseMap();
		try {
			user.setRegisterDate(new Date());
			this.userService.addUser(user);
			responseMap.setInfo("添加用户成功");
			responseMap.setStatus(true);
			responseMap.put("id", user.getId());
		} catch (ServiceException e) {
			responseMap.setInfo(e.getMessage());
			responseMap.setStatus(false);
		}
		WebUtil.writerJson(response, responseMap);
	}
	
	/**
	 * 删除用户
	 * @param response
	 * @param ids
	 */
	@RequestMapping(value="ajaxDeleteUser", method = RequestMethod.POST)
	public void ajaxDeleteUser(HttpServletResponse response, String ids){
		ResponseMap responseMap = new HashResponseMap();
		try
		{
			this.userService.deleteUser(ids);
			responseMap.setStatus(true);
			responseMap.setInfo("删除用户成功");
		} catch (ServiceException e) {
			responseMap.setStatus(false);
			responseMap.setInfo(e.getMessage());
		}
		
		WebUtil.writerJson(response, responseMap);
	}
	
	/**
	 * 跳转到用户修改页面
	 * @param role
	 * @return
	 */
	@RequestMapping("updateUser")
	public Object updateUser(User user)
	{
		return this.userService.queryUserById(user.getId());
	}
	
	/**
	 * 修改用户
	 * @param response
	 * @param user
	 */
	@RequestMapping(value = "ajaxUpdateUser", method = RequestMethod.POST)
	public void ajaxUpdateUser(HttpServletResponse response, User user)
	{
		ResponseMap responseMap = new HashResponseMap();
		try
		{
			this.userService.updateUser(user);
			responseMap.setStatus(true);
			responseMap.setInfo("修改用户成功");
		} catch (ServiceException e)
		{
			responseMap.setStatus(false);
			responseMap.setInfo(e.getMessage());
		}
		
		WebUtil.writerJson(response, responseMap);
	}
	

	/**
	 * 异步表单用户名称验证(新增和修改)
	 * @param response
	 * @param param
	 * @param name
	 */
	@RequestMapping("ajaxFormUserName")
	public void ajaxFormUserName(HttpServletResponse response, 
			String param, String name, Integer id)
	{
		ResponseMap responseMap = new HashResponseMap();
		try
		{
			if(null != id)
			{
				this.userService.checkUpdateUserName(id, param);
			}else
			{
				this.userService.checkUserName(param);
			}
			responseMap.setStatus(true);
			responseMap.setInfo("该用户名可用");
		} catch (ServiceException e)
		{
			responseMap.setStatus(false);
			responseMap.setInfo(e.getMessage());
		}
		
		WebUtil.writerJson(response, responseMap);
	}
	
	
	/**
	 * 跳转到用户角色列表
	 * @return
	 */
	@RequestMapping("userRoleList")
	public void userRoleList(@ModelAttribute("user")User user)
	{
	}
	
	/**
	 * 查询用户列表
	 * @param response
	 * @param pagination
	 * @param user
	 */
	@RequestMapping(value = "ajaxUserList", method = RequestMethod.POST)
	public void ajaxUserList(HttpServletResponse response, Pagination pagination, User user)
	{
		pagination.getParamMap().put("user", user);
		
		this.userService.pageQueryEntityList(pagination);
		WebUtil.writerPagination(response, pagination);
	}
	
	
	/**
	 * 查询用户角色列表
	 * @param response
	 * @param pagination
	 * @param role
	 * @param userId
	 */
	@RequestMapping(value = "ajaxUserRoleList", method = RequestMethod.POST)
	public void ajaxUserRoleList(HttpServletResponse response, 
			Pagination pagination, Role role, Integer userId)
	{
		pagination.setParamEntity(role);
		pagination.getParamMap().put("userId", userId);
		
		this.userService.pageQueryRolePrivilegeList(pagination);
		WebUtil.writerPagination(response, pagination);
	}
	
	/**
	 * 跳转到选择角色列表
	 * @return
	 */
	@RequestMapping("selectRoleList")
	public void selectRoleList(@ModelAttribute("user")User user)
	{
	}
	
	/**
	 * 分页查询选择角色列表
	 * @param response
	 * @param pagination
	 * @param role
	 * @param userId
	 */
	@RequestMapping(value = "ajaxSelectRoleList", method = RequestMethod.POST)
	public void ajaxSelectRoleList(HttpServletResponse response, 
			Pagination pagination, Role role, Integer userId)
	{
		pagination.setParamEntity(role);
		pagination.getParamMap().put("userId", userId);
		
		this.userService.pageQuerySelectRoleList(pagination);
		WebUtil.writerPagination(response, pagination);
	}
	
	/**
	 * 分配角色给用户
	 * @param response
	 * @param roleId
	 * @param privilegeIds
	 */
	@RequestMapping(value="ajaxAllotUserRole", method = RequestMethod.POST)
	public void ajaxAllotUserRole(HttpServletResponse response, Integer userId, 
			String roleIds){
		ResponseMap responseMap = new HashResponseMap();
		try
		{
			this.userService.allotUserRole(userId, roleIds);
			responseMap.setStatus(true);
			responseMap.setInfo("分配角色成功");
		} catch (ServiceException e) {
			responseMap.setStatus(false);
			responseMap.setInfo(e.getMessage());
		}
		
		WebUtil.writerJson(response, responseMap);
	}
	
	/**
	 * 根据角色id和用户id删除关联
	 * @param response
	 * @param userId
	 * @param roleIds
	 */
	@RequestMapping(value="ajaxDeleteUserRole", method = RequestMethod.POST)
	public void ajaxDeleteUserRole(HttpServletResponse response, Integer userId, 
			String roleIds){
		ResponseMap responseMap = new HashResponseMap();
		try
		{
			this.userService.deleteUserRole(userId, roleIds);
			responseMap.setStatus(true);
			responseMap.setInfo("删除成功");
		} catch (ServiceException e) {
			responseMap.setStatus(false);
			responseMap.setInfo(e.getMessage());
		}
		
		WebUtil.writerJson(response, responseMap);
	}
	
	/**
	 * 启用或禁用帐号
	 * @param response
	 * @param status
	 * @param userIds
	 */
	@RequestMapping(value="ajaxChangeUserStatus", method = RequestMethod.POST)
	public void ajaxChangeUserStatus(HttpServletResponse response, String status, String userIds)
	{
		ResponseMap responseMap = new HashResponseMap();
		try
		{
			this.userService.updateUserStatus(status, userIds);
			responseMap.setStatus(true);
			responseMap.setInfo("操作成功");
		} catch (ServiceException e) {
			responseMap.setStatus(false);
			responseMap.setInfo(e.getMessage());
		}
		
		WebUtil.writerJson(response, responseMap);
	}
	
	/**
	 * 修改用户密码
	 */
	@RequestMapping("updateUserPassword")
	public void updateUserPassword()
	{
		
	}
	
	/**
	 * 异步验证密码
	 * @param response
	 * @param session
	 * @param param
	 * @param name
	 */
	@RequestMapping(value="ajaxValidPassword", method=RequestMethod.POST)
	public void ajaxValidPassword(HttpServletResponse response, HttpSession session, String param, String name)
	{
		User user = (User)session.getAttribute(SystemConstants.LOGIN_USER_SESSION);
		ResponseMap responseMap = new HashResponseMap();
		try
		{
			this.userService.validOldPassword(user.getId(), param);
			responseMap.setStatus(true);
			responseMap.setInfo("密码正确");
		}catch(ServiceException e)
		{
			responseMap.setStatus(false);
			responseMap.setInfo("密码错误");
		}
		WebUtil.writerJson(response, responseMap);
	}
	
	/**
	 * 修改用户密码
	 * @param response
	 */
	@RequestMapping(value="ajaxUpdateUserPassword", method=RequestMethod.POST)
	public void ajaxUpdateUserPassword(HttpServletResponse response, HttpSession session, 
			String oldPassword, String password, String password2)
	{
		User user = (User)session.getAttribute(SystemConstants.LOGIN_USER_SESSION);
		ResponseMap responseMap = new HashResponseMap();
		
		try
		{
			this.userService.updateUserPassword(user.getId(), oldPassword, password, password2);
			responseMap.setStatus(true);
			responseMap.setInfo("修改密码成功");
		}catch(ServiceException e)
		{
			responseMap.setStatus(false);
			responseMap.setInfo(e.getMessage());
		}
		
		WebUtil.writerJson(response, responseMap);
	}
	
}
