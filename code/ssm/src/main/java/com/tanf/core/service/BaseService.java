package com.tanf.core.service;

import org.springframework.stereotype.Service;

import com.tanf.core.page.Pagination;

@Service
public abstract class BaseService
{

	/**
	 * 分页查询实体列表
	 * @param pageParamMap
	 * @return
	 */
	public abstract void pageQueryEntityList(Pagination pagination);
	
}
