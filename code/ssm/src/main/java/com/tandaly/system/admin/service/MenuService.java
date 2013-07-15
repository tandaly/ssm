package com.tandaly.system.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tandaly.core.exception.ServiceException;
import com.tandaly.core.page.Pagination;
import com.tandaly.core.service.BaseService;
import com.tandaly.core.util.StringUtil;
import com.tandaly.system.admin.beans.Menu;
import com.tandaly.system.admin.dao.MenuDao;
import com.tandaly.system.admin.dao.PrivilegeDao;

@Service
public class MenuService extends BaseService
{

	@Autowired
	MenuDao menuDao;
	
	@Autowired
	PrivilegeDao privilegeDao;
	/**
	 * 添加菜单信息
	 * @param menu
	 * @return
	 * @throws ServiceException 
	 */
	@Transactional
	public void addMenu(Menu menu) throws ServiceException
	{
		if(null == menu)
			throw new ServiceException("传入的参数错误");
		
		Menu menu2 = this.menuDao.queryMenuByMenuName(menu.getMenuName());
		if(null != menu2)
		{
			throw new ServiceException("该菜单名已存在");
		}
		
		//判断修改的菜单父级菜单是否为禁用，如果为禁用是不能启用该菜单的
		if("启用".equals(menu.getStatus().trim()))
		{
			Menu qmenu = new Menu();
			qmenu.setMenuNo(menu.getParentNo());
			qmenu.setStatus("禁用");
			
			List<Menu> menus = this.menuDao.queryMenusByMenu(qmenu);
			if(StringUtil.isNotEmpty(menus))
			{
				throw new ServiceException("父级菜单处于禁用状态,不能启用该菜单");
			}
		}
		
		this.menuDao.insertMenu(menu);
		if(null == menu.getId())
		{
			throw new ServiceException("新增菜单失败");
		}
		
	}
	
	/**
	 * 删除菜单
	 * @param ids
	 * @throws ServiceException
	 */
	@Transactional
	public void deleteMenu(String ids) throws ServiceException
	{
		//级联删除菜单及其关联权限
		/*****处理递归查询start*****/
		if(ids.endsWith(","))
		{
			ids.substring(0, ids.length() - 1);
		}
		
		String[] idArr = ids.split(",");
		StringBuffer dIds = new StringBuffer();
		for(String id:idArr)
		{
			dmenu(Integer.valueOf(id), dIds);
		}
		dIds.append(ids);
		ids = dIds.toString();
		/*****处理递归查询end*****/
		
		//删除菜单和权限关联关系
		this.menuDao.deletePrivilegeMenuByMenuIds(ids);
		
		Integer result = this.menuDao.deleteMenu(ids);
		if(null == result || 1 > result)
		{
			throw new ServiceException("删除菜单失败");
		}
	}
	
	/**
	 * 递归查询该菜单下的所有菜单
	 * @param id
	 * @param ids
	 */
	private void dmenu(Integer id, StringBuffer ids)
	{
		Menu menu1 = this.menuDao.queryMenuById(id);
		if(null == menu1) return;
		Menu menu = new Menu();
		menu.setParentNo(menu1.getMenuNo());
		menu1 = null;
		List<Menu> menus = this.menuDao.queryMenusByMenu(menu);
		for(Menu m:menus)
		{
			ids.append(m.getId() + ",");
			dmenu(m.getId(), ids);
		}
		menu = null;
		menus = null;
	}
	
	/**
	 * 切换该菜单以下的子菜单状态
	 * @param menuId
	* @throws ServiceException
	 */
	private void switchChildMenuStatus(Integer menuId, String status)  throws ServiceException
	{
		StringBuffer dIds = new StringBuffer();
		dmenu(menuId, dIds);
		if(!"".equals(dIds.toString().trim()))
		{
			String[] idArr = dIds.toString().split(",");
			for(String id: idArr)
			{
				Integer uid = Integer.valueOf(id);
				
				Menu m = new Menu();
				m.setId(uid);
				m.setStatus(status);
				
				Integer rows = this.menuDao.updateMenu(m);
				if(null == rows || rows < 1)
				{
					throw new ServiceException("启用子菜单失败");
				}
			}
		}
	}
	

	/**
	 * 启用子菜单状态
	 * @param menuId
	 * @param status
	 * @throws ServiceException
	 */
	@Transactional
	public void updateChildMenuStatus(Integer menuId, String status)  throws ServiceException
	{
		this.switchChildMenuStatus(menuId, status);
	}
	
	/**
	 * 修改菜单
	 * @param menu
	 * @throws ServiceException
	 */
	@Transactional
	public void updateMenu(Menu menu) throws ServiceException
	{
		if(null == menu)
		{
			throw new ServiceException("传入的参数错误");
		}
		
		//判断修改的菜单父级菜单是否为禁用，如果为禁用是不能启用该菜单的
		if("启用".equals(menu.getStatus().trim()))
		{
			Menu qmenu = new Menu();
			qmenu.setMenuNo(menu.getParentNo());
			qmenu.setStatus("禁用");
			
			List<Menu> menus = this.menuDao.queryMenusByMenu(qmenu);
			if(StringUtil.isNotEmpty(menus))
			{
				throw new ServiceException("父级菜单处于禁用状态,不能启用该菜单");
			}
		}
		
		//如果修改的菜单为禁用，则需要将该菜单下的所有菜单都设置为禁用
		if("禁用".equals(menu.getStatus().trim()))
		{
			this.switchChildMenuStatus(menu.getId(), "禁用");//禁用该菜单下的所有菜单
		}
		
		Integer result = this.menuDao.updateMenu(menu);
		if(null == result || 1 > result)
		{
			throw new ServiceException("修改菜单失败");
		}
	}
	
	/**
	 * 查询所有菜单
	 * @return
	 */
	public List<Menu> queryMenusByMenu(Menu menu)
	{
		return this.menuDao.queryMenusByMenu(menu);
	}
	
	/**
	 * 分页查询菜单列表
	 * @param pageParamMap
	 * @return
	 */
	@Override
	public void pageQueryEntityList(Pagination pagination)
	{
		Integer count = this.menuDao.pageQueryEntityCount(pagination.getParamMap());
		if(null != count && 0 < count)
		{
			pagination.setTotalCount(count);
			pagination.setList(this.menuDao.pageQueryEntityList(pagination.getParamMap()));
		}else
		{
			pagination.setTotalCount(0);
		}
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
		
		List<Menu> pMenus = this.menuDao.queryMenusByPrivilegeId(privilegeId);//根据角色查询菜单
		
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
	 * 根据用户id查询权限菜单
	 * @param userId
	 * @return
	 */
	public List<Menu> queryMenusByUserId(Integer userId)
	{
		return this.menuDao.queryMenusByUserId(userId);
	}
	
	/**
	 * 根据菜单id查询菜单
	 * @param id
	 * @return
	 */
	public Menu queryMenuById(Integer id)
	{
		return this.menuDao.queryMenuById(id);
	}
	
	/**
	 * 检查菜单编号是否可用
	 * @param menuNo
	 * @throws ServiceException
	 */
	public void checkMenuNo(String menuNo) throws ServiceException
	{
		Menu menu = new Menu();
		menu.setMenuNo(menuNo);
		List<Menu> menus = this.menuDao.queryMenusByMenu(menu);
		if(null != menus && 0 < menus.size())
		{
			throw new ServiceException("该菜单编号不可用");
		}
	}
	
	/**
	 * 检查菜单名是否可用
	 * @param menuName
	 * @throws ServiceException
	 */
	public void checkMenuName(String menuName) throws ServiceException
	{
		Menu menu = new Menu();
		menu.setMenuName(menuName);
		List<Menu> menus = this.menuDao.queryMenusByMenu(menu);
		if(null != menus && 0 < menus.size())
		{
			throw new ServiceException("该菜单名称不可用");
		}
	}
	
	/**
	 * 检查修改的菜单编号是否可用
	 * @param menuNo
	 * @throws ServiceException
	 */
	public void checkUpdateMenuNo(Integer id, String menuNo) throws ServiceException
	{
		Menu menu = new Menu();
		menu.setId(id);
		menu.setMenuNo(menuNo);
		Integer count = this.menuDao.checkUpdateMenu(menu);
		if(null != count && 0 < count)
		{
			throw new ServiceException("该菜单编号不可用");
		}
	}
	
	/**
	 * 检查修改的菜单名是否可用
	 * @param menuName
	 * @throws ServiceException
	 */
	public void checkUpdateMenuName(Integer id, String menuName) throws ServiceException
	{
		Menu menu = new Menu();
		menu.setId(id);
		menu.setMenuName(menuName);
		Integer count = this.menuDao.checkUpdateMenu(menu);
		if(null != count && 0 < count)
		{
			throw new ServiceException("该菜单名称不可用");
		}
	}
	
}
