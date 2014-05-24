package com.tanf.core.page;

import java.util.HashMap;
/**
 * 分页参数Map
 * @author tanf
 * @date 2013-6-21 上午11:57:37
 */
public class PageParamMap extends HashMap<String, Object>{

	/**
	 * 序列号
	 */
	private static final long serialVersionUID = -4929833749921880133L;
	
	public final static String PAGENO = "pageNo";
	public final static String PAGESIZE = "pageSize";
	
	//private Map<String, Object> paramMap = new HashMap<String, Object>();
	
	private Object paramEntity;//参数实体
	private int pageNo;
	private int pageSize;
	
	public PageParamMap(Integer pageNo, Integer pageSize)
	{
		if(null == pageNo)
		{
			this.pageNo = SimplePage.PAGENO;
		}
		else 
		{
			this.pageNo = pageNo;
		}
		
		if(null == pageSize)
			this.pageSize = SimplePage.PAGESIZE;
		else
			this.pageSize = pageSize;
	}
	
	public PageParamMap(Object paramEntity, Integer pageNo, Integer pageSize)
	{
//		super.put(PAGENO, pageNo);
//		super.put(PAGESIZE, pageSize);
		
		this.paramEntity = paramEntity;
		
		if(null == pageNo)
		{
			this.pageNo = 0;
		}
		else 
		{
			this.pageNo = pageNo;
		}
		
		if(null == pageSize)
			this.pageSize = 0;
		else
			this.pageSize = pageSize;
	}
	
	
	public Object getParamEntity() {
		return paramEntity;
	}

	public int getPageNo()
	{
		return this.pageNo;
	}
	
	public int getPageSize()
	{
		return this.pageSize;
	}
	
	
}
