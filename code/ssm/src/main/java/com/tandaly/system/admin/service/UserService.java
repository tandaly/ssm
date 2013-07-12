package com.tandaly.system.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tandaly.core.exception.ServiceException;
import com.tandaly.core.page.Pagination;
import com.tandaly.core.service.BaseService;
import com.tandaly.core.util.StringUtil;
import com.tandaly.system.admin.beans.User;
import com.tandaly.system.admin.dao.UserDao;

/**
 * 用户业务层
 * @author Tandaly
 * @date 2013-6-20 下午5:30:56
 */
@Service
public class UserService extends BaseService
{
	@Autowired
	private UserDao userDao;
	
	/**
	 * 登录验证
	 * @param user
	 * @return
	 * @throws ServiceException 
	 */
	public User logins(User user) throws ServiceException
	{
		if(null == user)
			throw new ServiceException("传入的参数错误");
		
		User user2 = this.userDao.logins(user.getUserName());
		if(null == user2 || 
				!user.getPassword().equals(user2.getPassword()))
		{
			throw new ServiceException("用户名或密码错误");
		}
		return user2;
	}
	
	/**
	 * 插入用户信息
	 * @param user
	 * @return
	 * @throws ServiceException 
	 */
	@Transactional
	public void addUser(User user) throws ServiceException
	{
		if(null == user || null == user.getUserName())
			throw new ServiceException("传入的参数错误");
		
		checkUserName(user.getUserName());
		
		this.userDao.insert(user);
		if(null == user.getId())
		{
			throw new ServiceException("新增用户失败");
		}
		
	}
	
	/**
	 * 删除用户
	 * @param ids
	 * @throws ServiceException
	 */
	@Transactional
	public void deleteUser(String ids) throws ServiceException
	{
		if(null == ids || "".equals(ids))
		{
			throw new ServiceException("传入的参数错误");
		}
		
		//删除用户角色关联关系
		this.userDao.deleteUserRoleByUserIds(ids);
		
		//删除用户
		Integer result = this.userDao.delete(ids);
		if(null == result || 1 > result)
		{
			throw new ServiceException("删除用户失败");
		}
	}
	
	/**
	 * 修改用户
	 * @param user
	 * @throws ServiceException
	 */
	@Transactional
	public void updateUser(User user) throws ServiceException
	{
		if(null == user || null == user.getId() || null == user.getUserName())
			throw new ServiceException("传入的参数错误");
		
		checkUpdateUserName(user.getId(), user.getUserName());
		
		Integer result = this.userDao.update(user);
		if(null == result || 1 > result)
		{
			throw new ServiceException("修改用户失败");
		}
	}
	

	/**
	 * 检查用户名称是否可用
	 * @param userName
	 * @throws ServiceException
	 */
	public void checkUserName(String userName) throws ServiceException
	{
		User user = new User();
		user.setUserName(userName);
		List<?> users = this.userDao.queryEntitys(user);
		if(null != users && 0 < users.size())
		{
			throw new ServiceException("该用户名不可用");
		}
	}
	
	/**
	 * 检查修改的用户名称是否可用
	 * @param userName
	 * @throws ServiceException
	 */
	public void checkUpdateUserName(Integer id, String userName) throws ServiceException
	{
		User user = new User();
		user.setId(id);
		user.setUserName(userName);
		Integer count = this.userDao.checkUpdateUser(user);
		if(null != count && 0 < count)
		{
			throw new ServiceException("该用户名不可用");
		}
	}
	
	
	/**
	 * 根据id查询用户
	 * @param id
	 * @return
	 */
	public User queryUserById(Integer id)
	{
		return (User) this.userDao.queryEntityById(id);
	}
	
	/**
	 * 分页查询用户列表
	 * @param pageParamMap
	 * @return
	 */
	public void pageQueryEntityList(Pagination pagination)
	{
		Integer count = this.userDao.pageQueryEntityCount(pagination.getParamMap());
		if(null != count && 0 < count)
		{
			pagination.setTotalCount(count);
			pagination.setList(this.userDao.pageQueryEntityList(pagination.getParamMap()));
		}else
		{
			pagination.setTotalCount(0);
		}
	}
	
	/**
	 * 分页查询用户角色列表
	 * @param pageParamMap
	 * @return
	 */
	public void pageQueryRolePrivilegeList(Pagination pagination)
	{
		Integer count = this.userDao.pageQueryUserRoleCount(pagination.getParamMap());
		if(null != count && 0 < count)
		{
			pagination.setTotalCount(count);
			pagination.setList(this.userDao.pageQueryUserRoleList(pagination.getParamMap()));
		}else
		{
			pagination.setTotalCount(0);
		}
	}
	
	/**
	 * 分页查询选择角色列表
	 * @param pageParamMap
	 * @return
	 */
	public void pageQuerySelectRoleList(Pagination pagination)
	{
		Integer count = this.userDao.pageQuerySelectRoleCount(pagination.getParamMap());
		if(null != count && 0 < count)
		{
			pagination.setTotalCount(count);
			pagination.setList(this.userDao.pageQuerySelectRoleList(pagination.getParamMap()));
		}else
		{
			pagination.setTotalCount(0);
		}
	}
	
	/**
	 * 分配角色给用户
	 * @param roleId
	 * @param privilegeIds
	 * @throws ServiceException 
	 */
	@Transactional
	public void allotUserRole(Integer userId, String roleIds) throws ServiceException
	{
		if(null == userId || null == roleIds 
				|| "".equals(roleIds))
		{
			throw new ServiceException("传入的参数错误");
		}
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userId", userId);
		
		String[] roleIdArr = roleIds.split(",");
		for(String rId:roleIdArr)
		{
			paramMap.put("roleId", rId);
			this.userDao.allotUserRole(paramMap);
		}
	}
	
	/**
	 * 根据角色id和用户id删除关联
	 * @param userId
	 * @param roleIds
	 * @throws ServiceException
	 */
	@Transactional
	public void deleteUserRole(Integer userId, String roleIds) throws ServiceException
	{
		if(null == userId || null == roleIds 
				|| "".equals(roleIds))
		{
			throw new ServiceException("传入的参数错误");
		}
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userId", userId);
		paramMap.put("roleIds", roleIds);
		Integer result = this.userDao.deleteUserRole(paramMap);
		if(null == result || 1 > result)
		{
			throw new ServiceException("删除失败");
		}
	}
	
	/**
	 * 启用或禁用帐号
	 * @param status
	 * @param userIds
	 * @throws ServiceException 
	 */
	@Transactional
	public void updateUserStatus(String status, String userIds) throws ServiceException
	{
		if(null == status || null == userIds 
				|| "".equals(userIds))
		{
			throw new ServiceException("传入的参数错误");
		}
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("status", status);
		paramMap.put("userIds", userIds);
		Integer result = this.userDao.updateUserStatus(paramMap);
		
		if(null == result || 1 > result)
		{
			throw new ServiceException("操作失败");
		}
	}
	
	/**
	 * 验证旧密码
	 * @param id
	 * @param oldPassword
	 */
	public void validOldPassword(Integer id, String oldPassword)
	{
		//验证旧密码
		User u = (User) this.userDao.queryEntityById(id);
		if(!oldPassword.equals(u.getPassword()))
		{
			throw new ServiceException("旧密码错误");
		}
	}
	
	/**
	 * 修改用户密码
	 * @param id
	 * @param password
	 * @param password2
	 */
	@Transactional
	public void updateUserPassword(Integer id, String oldPassword,
			String password, String password2) throws ServiceException
	{
		if(StringUtil.isEmpty(id)
				||StringUtil.isEmpty(oldPassword)||
				StringUtil.isEmpty(password) 
				|| StringUtil.isEmpty(password2))
		{
			throw new ServiceException("传入的参数错误");
		}
		
		validOldPassword(id, oldPassword);
		
		if(password.equals(password2))
		{
			User user = new User();
			user.setId(id);
			user.setPassword(password);
			Integer result = this.userDao.update(user);
			if(null == result || 1 > result)
			{
				throw new ServiceException("修改密码失败");
			}
		}
	}
}
