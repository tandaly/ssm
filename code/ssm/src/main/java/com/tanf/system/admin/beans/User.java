package com.tanf.system.admin.beans;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

public class User implements Serializable
{
	private static final long serialVersionUID = -5717336685008710275L;
	
	private Integer id;
	private String userName;//用户名
	private String password;//密码
	private String status;//状态 启用/禁用
	@DateTimeFormat(iso=ISO.DATE)
	private Date registerDate;//注册日期
	
	private String remark;//备注
	
	private Timestamp testTime;
	
	public Integer getId()
	{
		return id;
	}
	public void setId(Integer id)
	{
		this.id = id;
	}
	public String getUserName()
	{
		return userName;
	}
	public void setUserName(String userName)
	{
		this.userName = userName;
	}
	public String getPassword()
	{
		return password;
	}
	public void setPassword(String password)
	{
		this.password = password;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getRegisterDate() {
		return registerDate;
	}
	public void setRegisterDate(Date registerDate) {
		this.registerDate = registerDate;
	}
	public Timestamp getTestTime() {
		return testTime;
	}
	public void setTestTime(Timestamp testTime) {
		this.testTime = testTime;
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
