package com.tandaly.system.admin.dao;

import java.util.Map;

import com.tandaly.core.dao.BaseDao;
import com.tandaly.system.admin.beans.Privilege;

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
}
