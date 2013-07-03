package com.tandaly.core.page;

import java.util.List;

/**
 * 列表分页。包含list属性。
 * 
 * @author 
 * 
 */
public class Pagination extends SimplePage implements java.io.Serializable,
		Paginable {

	private static final long serialVersionUID = -4098654823888996038L;

	public Pagination() {
	}

	public Pagination(Integer pageNo, Integer pageSize)
	{
		super(pageNo, pageSize);
	}
	
	public Pagination(Object paramEntity, Integer pageNo, Integer pageSize)
	{
		super(paramEntity, pageNo, pageSize);
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
	public Pagination(Integer pageNo, Integer pageSize, int totalCount) {
		super(pageNo, pageSize, totalCount);
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
	 * @param list
	 *            分页内容
	 */
	public Pagination(Integer pageNo, Integer pageSize, int totalCount, List<?> list) {
		super(pageNo, pageSize, totalCount);
		this.list = list;
	}

	/**
	 * 第一条数据位置
	 * 
	 * @return
	 */
	public int getFirstResult() {
		return (pageNo - 1) * pageSize;
	}

	/**
	 * 当前页的数据
	 */
	private List<?> list;

	/**
	 * 获得分页内容
	 * 
	 * @return
	 */
	public List<?> getList() {
		return list;
	}

	/**
	 * 设置分页内容
	 * 
	 * @param list
	 */
	@SuppressWarnings("rawtypes")
	public void setList(List list) {
		this.list = list;
	}
}
