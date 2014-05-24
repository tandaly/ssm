package com.tanf.system.admin.beans;

import java.io.Serializable;

/**
 * 字典表
 * @author Tandaly
 * @date 2013-7-1 下午3:11:52
 */
public class Dictionary implements Serializable
{
	private static final long serialVersionUID = 8409170323838025849L;
	
	private Integer id;
	private String dicKey;//键
	private String name;//名称
	private String value;//值
	private String status;//启用/禁用
	private String remark;//描述
	
	
	public Integer getId()
	{
		return id;
	}
	public void setId(Integer id)
	{
		this.id = id;
	}

	public String getDicKey()
	{
		return dicKey;
	}
	public void setDicKey(String dicKey)
	{
		this.dicKey = dicKey;
	}
	public String getName()
	{
		return name;
	}
	public void setName(String name)
	{
		this.name = name;
	}
	public String getValue()
	{
		return value;
	}
	public void setValue(String value)
	{
		this.value = value;
	}
	public String getRemark()
	{
		return remark;
	}
	public void setRemark(String remark)
	{
		this.remark = remark;
	}
	public String getStatus()
	{
		return status;
	}
	public void setStatus(String status)
	{
		this.status = status;
	}
	
	
	
}
