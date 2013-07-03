package com.tandaly.core.page;

import java.util.HashMap;
import java.util.Map;

/**
 * 简单分页类
 * 
 * @author
 * 
 */
public class SimplePage implements Paginable
{

	public static final int DEF_COUNT = 20;
	
	private Integer page;//页码
	
	private Object paramEntity;//参数实体
	
	private Map<String, Object> paramMap;//参数集合
	

	/**
	 * 检查页码 checkPageNo
	 * 
	 * @param pageNo
	 * @return if pageNo==null or pageNo<1 then return 1 else return pageNo
	 */
	public static int cpn(Integer pageNo)
	{
		return (pageNo == null || pageNo < 1) ? 1 : pageNo;
	}

	public SimplePage()
	{
	}
	
	/**
	 * 构造分页
	 * @param pageNo
	 * @param pageSize
	 */
	public SimplePage(Integer pageNo, Integer pageSize)
	{
		//loadParamMap(currentRow, pageRows);
		this.pageNo = pageNo;
		this.pageSize = pageSize;
	}
	
	/**
	 * 构造分页和实体参数
	 * @param paramEntity
	 * @param pageNo
	 * @param pageSize
	 */
	public SimplePage(Object paramEntity, Integer pageNo, Integer pageSize)
	{
		//loadParamMap(currentRow, pageRows);
		this.paramEntity = paramEntity;
		this.pageNo = pageNo;
		this.pageSize = pageSize;
	}
	

	/**
	 * 构造器
	 * 
	 * @param pageNo
	 *            页码
	 * @param pageSize
	 *            每页几条数据
	 * @param totalCount
	 *            总共几条数据
	 */
	public SimplePage(Integer pageNo, Integer pageSize, int totalCount)
	{
		if(null == pageNo)
			pageNo = 0;
		if(null == pageSize)
			pageSize = 0;
		setTotalCount(totalCount);
		setPageSize(pageSize);
		setPageNo(pageNo);
		adjustPageNo();

		setPageCount();// 设置总页码
	}

	/**
	 * 调整页码，使不超过最大页数
	 */
	public void adjustPageNo()
	{
		if (pageNo == 1)
		{
			return;
		}
		int tp = getTotalPage();
		if (pageNo > tp)
		{
			pageNo = tp;
		}
	}

	/**
	 * 获得页码
	 */
	public int getPageNo()
	{
		return pageNo;
	}

	/**
	 * 每页几条数据
	 */
	public int getPageSize()
	{
		return pageSize;
	}

	/**
	 * 总共几条数据
	 */
	public int getTotalCount()
	{
		return totalCount;
	}

	/**
	 * 总共几页
	 */
	public int getTotalPage()
	{
		int totalPage = totalCount / pageSize;
		if (totalPage == 0 || totalCount % pageSize != 0)
		{
			totalPage++;
		}
		return totalPage;
	}

	/**
	 * 是否第一页
	 */
	public boolean isFirstPage()
	{
		return pageNo <= 1;
	}

	/**
	 * 是否最后一页
	 */
	public boolean isLastPage()
	{
		return pageNo >= getTotalPage();
	}

	/**
	 * 下一页页码
	 */
	public int getNextPage()
	{
		if (isLastPage())
		{
			return pageNo;
		} else
		{
			return pageNo + 1;
		}
	}

	/**
	 * 上一页页码
	 */
	public int getPrePage()
	{
		if (isFirstPage())
		{
			return pageNo;
		} else
		{
			return pageNo - 1;
		}
	}

	public final static int PAGENO = 1;
	public final static int PAGESIZE = 10;

	protected int totalCount = 0;
	protected int pageSize = PAGESIZE;
	protected int pageNo = PAGENO;
	protected int pageCount = 1;

	public int getPageCount()
	{
		return pageCount;
	}

	public void setPageCount()
	{
		int pageCount = (this.totalCount / this.pageSize)
				+ (this.totalCount % this.pageSize > 0 ? 1 : 0);

		this.pageCount = pageCount;
	}

	/**
	 * if totalCount<0 then totalCount=0
	 * 
	 * @param totalCount
	 */
	public void setTotalCount(int totalCount)
	{
		if (totalCount < 0)
		{
			this.totalCount = 0;
		} else
		{
			this.totalCount = totalCount;
		}
		setPageCount();
	}

	/**
	 * if pageSize< 1 then pageSize=DEF_COUNT
	 * 
	 * @param pageSize
	 */
	public void setPageSize(int pageSize)
	{
		if (pageSize < 1)
		{
			this.pageSize = DEF_COUNT;
		} else
		{
			this.pageSize = pageSize;
		}
	}

	/**
	 * if pageNo < 1 then pageNo=1
	 * 
	 * @param pageNo
	 */
	public void setPageNo(int pageNo)
	{
		if (pageNo < 1)
		{
			this.pageNo = 1;
		} else
		{
			this.pageNo = pageNo;
		}
	}

	
	/**
	 * 加载分页参数集合
	 * @param pageNo
	 * @param pageSize
	 */
	public void loadParamMap(Integer pageNo, Integer pageSize)
	{
		if(null == pageNo || 0 >= pageNo)
			pageNo = PAGENO;
		if(null == pageSize || 0 >= pageSize)
			pageSize = PAGESIZE;
		
		if(null == this.paramMap)
		{
			this.paramMap = new HashMap<String, Object>();
		}
		
		if(null != this.paramEntity)
		{
			this.paramMap.put(this.paramEntity.getClass().getSimpleName().toString().toLowerCase(),
					this.paramEntity);
		}
		this.paramMap.put("startRow", (pageNo - 1) * pageSize);
		this.paramMap.put("pageSize", pageSize);
	}
	
	public Map<String, Object> getParamMap()
	{
		loadParamMap(this.page, this.pageSize);
		return paramMap;
	}

	public void setParamMap(Map<String, Object> paramMap)
	{
		this.paramMap = paramMap;
	}

	public Integer getPage()
	{
		return page;
	}

	public void setPage(Integer page)
	{
		this.page = page;
	}

	public Object getParamEntity()
	{
		return paramEntity;
	}

	public void setParamEntity(Object paramEntity)
	{
		this.paramEntity = paramEntity;
	}
	
	
	
}
