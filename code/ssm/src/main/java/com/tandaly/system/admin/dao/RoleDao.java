package com.tandaly.system.admin.dao;

import java.util.List;
import java.util.Map;

import com.tandaly.core.dao.BaseDao;
import com.tandaly.system.admin.beans.Privilege;
import com.tandaly.system.admin.beans.Role;

public interface RoleDao extends BaseDao
{
	
	/**
	 * 验证修改的角色
	 * @param role
	 * @return
	 */
	Integer checkUpdateRole(Role role);
	
	/**
	 * 根据权限id删除角色
	 * @param privilegeId
	 * @return
	 */
	Integer deleteRolePrivilegeByPrivilegeId(String privilegeIds);
	
	/**
	 * 根据角色id分页查询权限总数
	 * @param paramMap
	 * @return
	 */
	Integer pageQueryRolePrivilegeCount(Map<String, Object> paramMap);
	
	/**
	 * 根据角色id分页查询权限列表
	 * @param paramMap
	 * @return
	 */
	List<Privilege> pageQueryRolePrivilegeList(Map<String, Object> paramMap);
	
	/**
	 * 分配权限给角色
	 * @param paramMap
	 * @return
	 */
	Integer allotRolePrivilege(Map<String, Object> paramMap);
	
	/**
	 * 根据权限id和角色id删除关联
	 * @param paramMap
	 * @return
	 */
	Integer deleteRolePrivilege(Map<String, Object> paramMap);
	
	/**
	 * 分页查询选择权限总数
	 * @param paramMap
	 * @return
	 */
	Integer pageQuerySelectPrivilegeCount(Map<String, Object> paramMap);
	
	/**
	 * 分页查询选择权限列表
	 * @param paramMap
	 * @return
	 */
	List<Privilege> pageQuerySelectPrivilegeList(Map<String, Object> paramMap);
	
	/**
	 * 删除角色和权限的关联关系
	 * @param roleIds
	 * @return
	 */
	Integer deleteRolePrivilegeByRoleIds(String roleIds);
	
	/**
	 * 删除用户和角色的关联关系
	 * @param roleIds
	 * @return
	 */
	Integer deleteUserRoleByRoleIds(String roleIds);
}
