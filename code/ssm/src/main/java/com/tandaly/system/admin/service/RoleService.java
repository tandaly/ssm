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
import com.tandaly.system.admin.beans.Role;
import com.tandaly.system.admin.dao.MenuDao;
import com.tandaly.system.admin.dao.RoleDao;

@Service
public class RoleService extends BaseService
{

	@Autowired
	RoleDao roleDao;
	
	@Autowired
	MenuDao menuDao;
	
	/**
	 * 添加角色
	 * @param role
	 * @return
	 * @throws ServiceException 
	 */
	@Transactional
	public void addRole(Role role) throws ServiceException
	{
		if(null == role)
			throw new ServiceException("传入的参数错误");
		
		checkRoleName(role.getRoleName());//检测角色名称唯一性
		
		this.roleDao.insert(role);
		if(null == role.getId())
		{
			throw new ServiceException("新增角色失败");
		}
		
	}
	
	/**
	 * 删除角色
	 * @param ids
	 * @throws ServiceException
	 */
	@Transactional
	public void deleteRole(String ids) throws ServiceException
	{
		if(null == ids || "".equals(ids))
		{
			throw new ServiceException("传入的参数错误");
		}
		
		//删除用户和角色的关联关系
		this.roleDao.deleteUserRoleByRoleIds(ids);
		
		//删除角色和权限的关联关系
		this.roleDao.deleteRolePrivilegeByRoleIds(ids);
		
		Integer result = this.roleDao.delete(ids);
		if(null == result || 1 > result)
		{
			throw new ServiceException("删除失败");
		}
	}
	
	/**
	 * 修改角色
	 * @param role
	 * @throws ServiceException 
	 */
	@Transactional
	public void updateRole(Role role) throws ServiceException
	{
		if(null == role)
		{
			throw new ServiceException("传入的参数错误");
		}
		
		checkUpdateRoleName(role.getId(), role.getRoleName());//检测角色名称的唯一性
		
		Integer result = this.roleDao.update(role);
		
		if(null == result || 1 > result)
		{
			throw new ServiceException("修改失败");
		}
	}
	
	/**
	 * 根据id查询角色
	 * @param id
	 * @return
	 */
	public Role queryRoleById(Integer id)
	{
		return (Role) this.roleDao.queryEntityById(id);
	}
	
	/**
	 * 分页查询角色列表
	 * @param pageParamMap
	 * @return
	 */
	@Override
	public void pageQueryEntityList(Pagination pagination)
	{
		Integer count = this.roleDao.pageQueryEntityCount(pagination.getParamMap());
		if(null != count && 0 < count)
		{
			pagination.setTotalCount(count);
			pagination.setList(this.roleDao.pageQueryEntityList(pagination.getParamMap()));
		}else
		{
			pagination.setTotalCount(0);
		}
	}
	
	/**
	 * 检查角色名称是否可用
	 * @param roleName
	 * @throws ServiceException
	 */
	public void checkRoleName(String roleName) throws ServiceException
	{
		Role role = new Role();
		role.setRoleName(roleName);
		List<?> roles = this.roleDao.queryEntitys(role);
		if(null != roles && 0 < roles.size())
		{
			throw new ServiceException("该角色名称不可用");
		}
	}
	
	/**
	 * 检查修改的角色名称是否可用
	 * @param roleName
	 * @throws ServiceException
	 */
	public void checkUpdateRoleName(Integer id, String roleName) throws ServiceException
	{
		Role role = new Role();
		role.setId(id);
		role.setRoleName(roleName);
		Integer count = this.roleDao.checkUpdateRole(role);
		if(null != count && 0 < count)
		{
			throw new ServiceException("该角色名称不可用");
		}
	}
	
	/**
	 * 分页查询角色权限列表
	 * @param pageParamMap
	 * @return
	 */
	public void pageQueryRolePrivilegeList(Pagination pagination)
	{
		Integer count = this.roleDao.pageQueryRolePrivilegeCount(pagination.getParamMap());
		if(null != count && 0 < count)
		{
			pagination.setTotalCount(count);
			pagination.setList(this.roleDao.pageQueryRolePrivilegeList(pagination.getParamMap()));
		}else
		{
			pagination.setTotalCount(0);
		}
	}
	
	/**
	 * 分页查询选择权限列表
	 * @param pageParamMap
	 * @return
	 */
	public void pageQuerySelectPrivilegeList(Pagination pagination)
	{
		Integer count = this.roleDao.pageQuerySelectPrivilegeCount(pagination.getParamMap());
		if(null != count && 0 < count)
		{
			pagination.setTotalCount(count);
			pagination.setList(this.roleDao.pageQuerySelectPrivilegeList(pagination.getParamMap()));
		}else
		{
			pagination.setTotalCount(0);
		}
	}
	
	/**
	 * 分配角色权限
	 * @param roleId
	 * @param privilegeIds
	 * @throws ServiceException 
	 */
	@Transactional
	public void allotRolePrivilege(Integer roleId, String privilegeIds) throws ServiceException
	{
		if(null == roleId || null == privilegeIds 
				|| "".equals(privilegeIds))
		{
			throw new ServiceException("传入的参数错误");
		}
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("roleId", roleId);
		
		String[] privilegeIdArr = privilegeIds.split(",");
		for(String pId:privilegeIdArr)
		{
			paramMap.put("privilegeId", pId);
			this.roleDao.allotRolePrivilege(paramMap);
		}
	}
	
	/**
	 * 根据权限id和角色id删除关联
	 * @param roleId
	 * @param privilegeIds
	 * @throws ServiceException
	 */
	@Transactional
	public void deleteRolePrivilege(Integer roleId, String privilegeIds) throws ServiceException
	{
		if(null == roleId || null == privilegeIds 
				|| "".equals(privilegeIds))
		{
			throw new ServiceException("传入的参数错误");
		}
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("roleId", roleId);
		paramMap.put("privilegeId", privilegeIds);
		Integer result = this.roleDao.deleteRolePrivilege(paramMap);
		if(null == result || 1 > result)
		{
			throw new ServiceException("删除失败");
		}
	}
	
	
}
