package com.tandaly.system.admin.beans;

import java.io.Serializable;
/**
 * 菜单实体类
 * @author Tandaly
 * @date 2013-6-25 上午9:19:43
 */
public class Menu implements Serializable
{
	private static final long serialVersionUID = 4879112786489145501L;
	
	private Integer id;
	private String menuNo;//菜单编号
	private String parentNo;//父菜单编号
	private String menuName;//菜单名称
	private String menuUrl;//菜单地址
	private String orderNo;//排序号
	
	/************以下属性是树形菜单使用*************/
	/**
	 *  结点展开 / 折叠 状态
	 * true 表示节点为 展开 状态
	 * false 表示节点为 折叠 状态
	 */
	private boolean open = true;
	private boolean checked;//是否勾选
	
	/**
	 * 显示图标
	 */
	private String icon;
	
	public Integer getId()
	{
		return id;
	}
	public void setId(Integer id)
	{
		this.id = id;
	}
	public String getMenuNo()
	{
		return menuNo;
	}
	public void setMenuNo(String menuNo)
	{
		this.menuNo = menuNo;
	}
	public String getParentNo()
	{
		return parentNo;
	}
	public void setParentNo(String parentNo)
	{
		this.parentNo = parentNo;
	}
	public String getMenuName()
	{
		return menuName;
	}
	public void setMenuName(String menuName)
	{
		this.menuName = menuName;
	}
	public String getMenuUrl()
	{
		return menuUrl;
	}
	public void setMenuUrl(String menuUrl)
	{
		this.menuUrl = menuUrl;
	}
	public String getOrderNo()
	{
		return orderNo;
	}
	public void setOrderNo(String orderNo)
	{
		this.orderNo = orderNo;
	}
	public boolean isOpen()
	{
		return open;
	}
	public void setOpen(boolean open)
	{
		this.open = open;
	}
	public String getIcon()
	{
		return icon;
	}
	public void setIcon(String icon)
	{
		this.icon = icon;
	}
	public boolean isChecked()
	{
		return checked;
	}
	public void setChecked(boolean checked)
	{
		this.checked = checked;
	}
	
	
}
