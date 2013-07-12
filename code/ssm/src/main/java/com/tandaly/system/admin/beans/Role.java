package com.tandaly.system.admin.beans;

import java.io.Serializable;

/**
 * 角色
 * @author Tandaly
 * @date 2013-6-24 上午10:44:25
 */
public class Role implements Serializable
{
	private static final long serialVersionUID = -155282004408583630L;
	
	private Integer id;
	private String roleName;//角色名称
	private String remark;//备注
	
	public Integer getId()
	{
		return id;
	}
	public void setId(Integer id)
	{
		this.id = id;
	}
	public String getRoleName()
	{
		return roleName;
	}
	public void setRoleName(String roleName)
	{
		this.roleName = roleName;
	}
	public String getRemark()
	{
		return remark;
	}
	public void setRemark(String remark)
	{
		this.remark = remark;
	}
	
	
}
