package com.tanf.system.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tanf.core.exception.ServiceException;
import com.tanf.core.page.Pagination;
import com.tanf.core.security.MySecurityMetadataSource;
import com.tanf.core.service.BaseService;
import com.tanf.system.admin.beans.Menu;
import com.tanf.system.admin.beans.Privilege;
import com.tanf.system.admin.dao.MenuDao;
import com.tanf.system.admin.dao.PrivilegeDao;
import com.tanf.system.admin.dao.RoleDao;

@Service
public class PrivilegeService extends BaseService
{

	@Autowired
	PrivilegeDao privilegeDao;
	
	@Autowired
	RoleDao roleDao;
	
	@Autowired
	MenuDao menuDao;
	
	/**
	 * 添加权限信息
	 * @param privilege
	 * @return
	 * @throws ServiceException 
	 */
	@Transactional
	public void addPrivilege(Privilege privilege) throws ServiceException
	{
		if(null == privilege)
			throw new ServiceException("传入的参数错误");
		
		checkPrivilegeName(privilege.getPrivilegeName());//验证权限名称是否可用
		
		this.privilegeDao.insert(privilege);
		
		if(null == privilege.getId())
		{
			throw new ServiceException("添加权限失败");
		}
	}
	
	/**
	 * 修改权限
	 * @param privilege
	 * @throws ServiceException 
	 */
	@Transactional
	public void updatePrivilete(Privilege privilege) throws ServiceException
	{
		if(null == privilege)
		{
			throw new ServiceException("传入的参数错误");
		}
		checkUpdatePrivilegeName(privilege.getId(), privilege.getPrivilegeName());//检测权限名称唯一性
		
		Integer result = this.privilegeDao.update(privilege);
		
		if(null == result || 1 > result)
		{
			throw new ServiceException("修改权限失败");
		}
	}
	
	/**
	 * 删除角色权限
	 * @param ids
	 * @throws ServiceException
	 */
	@Transactional
	public void deletePrivilege(String ids) throws ServiceException
	{
		//删除角色权限
		this.roleDao.deleteRolePrivilegeByPrivilegeId(ids);
		
		//删除权限菜单
		this.privilegeDao.deletePrivilegeMenuByPrivilegeId(ids);
		
		//删除权限信息
		Integer rows = this.privilegeDao.delete(ids);
		if(null == rows || 1 > rows)
		{
			throw new ServiceException("删除权限失败");
		}
	}
	
	/**
	 * 检查权限名称是否可用
	 * @param privilegeName
	 * @throws ServiceException
	 */
	public void checkPrivilegeName(String privilegeName) throws ServiceException
	{
		Privilege privilege = new Privilege();
		privilege.setPrivilegeName(privilegeName);
		List<?> privileges = this.privilegeDao.queryEntitys(privilege);
		if(null != privileges && 0 < privileges.size())
		{
			throw new ServiceException("该权限名称不可用");
		}
	}
	
	/**
	 * 检查修改的权限是否可用
	 * @param privilegeName
	 * @throws ServiceException
	 */
	public void checkUpdatePrivilegeName(Integer id, String privilegeName) throws ServiceException
	{
		Privilege privilege = new Privilege();
		privilege.setId(id);
		privilege.setPrivilegeName(privilegeName);
		Integer count = this.privilegeDao.checkUpdatePrivilege(privilege);
		if(null != count && 0 < count)
		{
			throw new ServiceException("该权限名称不可用");
		}
	}
	
	/**
	 * 分页查询菜单列表
	 * @param pageParamMap
	 * @return
	 */
	@Override
	public void pageQueryEntityList(Pagination pagination)
	{
		Integer count = this.privilegeDao.pageQueryEntityCount(pagination.getParamMap());
		if(null != count && 0 < count)
		{
			pagination.setTotalCount(count);
			pagination.setList(this.privilegeDao.pageQueryEntityList(pagination.getParamMap()));
		}else
		{
			pagination.setTotalCount(0);
		}
	}
	
	/**
	 * 根据id查询权限
	 * @param id
	 * @return
	 */
	public Privilege queryPrivilegeById(Integer id)
	{
		return (Privilege) this.privilegeDao.queryEntityById(id);
	}
	
	/**
	 * 查询权限菜单树
	 * @param roleId
	 * @return
	 */
	public List<Menu> queryMenuTree(Integer privilegeId)
	{
		Menu pmenu = new Menu();
		pmenu.setStatus("启用");
		List<Menu> menus = this.menuDao.queryMenusByMenu(pmenu);//查询所有的菜单
		
		List<Menu> pMenus = this.menuDao.queryMenusByPrivilegeId(privilegeId);//根据权限id查询菜单
		
		if(null != pMenus && 0 < pMenus.size())
		{
			for(Menu menu:menus)
			{
				for(Menu rmenu:pMenus)
				{
					if(menu.getId() == rmenu.getId())
						menu.setChecked(true);
				}
			}
		}
		
		return menus;
	}
	
	/**
	 * 分配菜单
	 * @param privilegeId
	 * @param menuIds
	 * @throws ServiceException
	 */
	@Transactional
	public void allotMenu(Integer privilegeId, String menuIds) throws ServiceException
	{
		if(null == privilegeId)
		{
			throw new ServiceException("传入的参数错误");
		}
		
		//根据权限id删除拥有的菜单
		this.privilegeDao.deletePrivilegeMenuByPrivilegeId(privilegeId.toString());
		
		//根据权限id增加菜单
		if(null != menuIds && !"".equals(menuIds.trim()))
		{
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("privilegeId", privilegeId);
			
			String[] menuIdArr = menuIds.split(",");
			for(String menuId:menuIdArr)
			{
				paramMap.put("menuId", menuId);
				this.privilegeDao.insertPrivilegeMenu(paramMap);
			}
		}
		
		MySecurityMetadataSource.loadResourceDefine();//重新载入权限菜单
	}
}
