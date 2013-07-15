package com.tandaly.system.admin.beans;

import java.io.Serializable;

/**
 * 系统公告实体
 * @author Tandaly
 * @date 2013-7-15 下午2:09:33
 */
public class Notice implements Serializable
{
	private static final long serialVersionUID = 5997121802790593784L;

	private Integer id;
	private String title;//标题
	private String content;//发布内容
	private String createTime;//发布时间;
	
	
	public Integer getId()
	{
		return id;
	}
	public void setId(Integer id)
	{
		this.id = id;
	}
	public String getTitle()
	{
		return title;
	}
	public void setTitle(String title)
	{
		this.title = title;
	}
	public String getContent()
	{
		return content;
	}
	public void setContent(String content)
	{
		this.content = content;
	}
	public String getCreateTime()
	{
		return createTime;
	}
	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}
	
	
	
}
