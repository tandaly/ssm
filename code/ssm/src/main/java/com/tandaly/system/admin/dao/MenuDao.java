package com.tandaly.system.admin.dao;

import java.util.List;

import com.tandaly.core.dao.BaseDao;
import com.tandaly.system.admin.beans.Menu;

public interface MenuDao extends BaseDao
{
	/**
	 * 新增菜单
	 * @param menu
	 * @return
	 */
	Integer insertMenu(Menu menu);
	
	/**
	 * 删除菜单
	 * @param ids
	 * @return
	 */
	Integer deleteMenu(String ids);
	
	/**
	 * 修改菜单
	 * @param menu
	 * @return
	 */
	Integer updateMenu(Menu menu);
	
	/**
	 * 根据菜单编号查询菜单
	 * @param menuNo
	 * @return
	 */
	Menu queryMenuByMenuNo(String menuNo);
	
	/**
	 * 根据菜单名称查询菜单
	 * @param menuName
	 * @return
	 */
	Menu queryMenuByMenuName(String menuName);
	
	/**
	 * 根据条件查询所有菜单
	 * @return
	 */
	List<Menu> queryMenusByMenu(Menu menu);
	
	/**
	 * 根据权限id查询菜单列表
	 * @param roleId
	 * @return
	 */
	List<Menu> queryMenusByPrivilegeId(Integer privilegeId);
	
	/**
	 * 根据用户id查询菜单列表
	 * @param userId
	 * @return
	 */
	List<Menu> queryMenusByUserId(Integer userId);
	
	/**
	 * 根据菜单id查询菜单
	 * @param id
	 * @return
	 */
	Menu queryMenuById(Integer id);
	
	/**
	 * 检查修改菜单有效性
	 * @param menu
	 * @return
	 */
	Integer checkUpdateMenu(Menu menu);
	
	/**
	 * 根据菜单id删除菜单权限
	 * @param menuIds
	 * @return
	 */
	Integer deletePrivilegeMenuByMenuIds(String menuIds);
	
}
