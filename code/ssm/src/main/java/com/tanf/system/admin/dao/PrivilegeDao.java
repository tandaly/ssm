package com.tanf.system.admin.dao;

import java.util.List;
import java.util.Map;

import com.tanf.core.dao.BaseDao;
import com.tanf.system.admin.beans.Menu;
import com.tanf.system.admin.beans.Privilege;
import com.tanf.system.admin.beans.User;

public interface PrivilegeDao extends BaseDao
{

	/**
	 * 验证修改的权限
	 * @param privilege
	 * @return
	 */
	Integer checkUpdatePrivilege(Privilege privilege);
	
	/**
	 * 根据权限id删除权限菜单
	 * @param privilegeId
	 * @return
	 */
	Integer deletePrivilegeMenuByPrivilegeId(String privilegeIds);
	
	/**
	 * 增加权限菜单
	 * @param privilegeId
	 * @return
	 */
	Integer insertPrivilegeMenu(Map<String, Object> paramMap);
	
	/**
	 * 根据用户查询权限列表
	 * @param user
	 * @return
	 */
	List<Privilege> queryPrivilegesByUser(User user);
	
	/**
	 * 根据菜单查询权限集合
	 * @param menu
	 * @return
	 */
	List<Privilege> queryPrivilegesByMenu(Menu menu);
}
