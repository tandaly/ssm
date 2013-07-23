package com.tandaly.system.admin.beans;

import java.io.Serializable;

/**
 * 权限实体
 * @author Tandaly
 * @date 2013-6-26 下午4:48:01
 */
public class Privilege implements Serializable
{
	private static final long serialVersionUID = -7821664544297696139L;
	
	private Integer id;
	private String privilegeCode;//权限编码
	private String privilegeName;//权限名称
	private String privilegeType;//权限类型
	private String status;//启用/禁用
	private String remark;//备注
	
	public Integer getId()
	{
		return id;
	}
	public void setId(Integer id)
	{
		this.id = id;
	}
	public String getPrivilegeName()
	{
		return privilegeName;
	}
	public void setPrivilegeName(String privilegeName)
	{
		this.privilegeName = privilegeName;
	}
	public String getRemark()
	{
		return remark;
	}
	public void setRemark(String remark)
	{
		this.remark = remark;
	}
	
	public String getPrivilegeCode()
	{
		return privilegeCode;
	}
	public void setPrivilegeCode(String privilegeCode)
	{
		this.privilegeCode = privilegeCode;
	}
	public String getStatus()
	{
		return status;
	}
	public void setStatus(String status)
	{
		this.status = status;
	}
	public String getPrivilegeType()
	{
		return privilegeType;
	}
	public void setPrivilegeType(String privilegeType)
	{
		this.privilegeType = privilegeType;
	}
	
	
}
