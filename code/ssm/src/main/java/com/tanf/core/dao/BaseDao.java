package com.tanf.core.dao;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * 公共dao
 * @author tanf
 * @date 2013-6-26 下午5:51:09
 */
public interface BaseDao
{

	/**
	 * 新增实体
	 * @param entity
	 * @return
	 */
	Integer insert(Object entity);
	
	/**
	 * 删除实体
	 * @param ids
	 * @return
	 */
	Integer delete(String ids);
	
	/**
	 * 修改实体
	 * @param entity
	 * @return
	 */
	Integer update(Object entity);
	
	/**
	 * 分页查询总数
	 * @param paramMap
	 * @return
	 */
	Integer pageQueryEntityCount(Map<String, Object> paramMap);
	
	/**
	 * 分页查询实体列表
	 * @param paramMap
	 * @return
	 */
	List<?> pageQueryEntityList(Map<String, Object> paramMap);
	
	/**
	 * 根据id查询实体
	 * @param id
	 * @return
	 */
	Object queryEntityById(Serializable id);
	
	/**
	 * 根据条件查询实体列表
	 * @param entity
	 * @return
	 */
	List<?> queryEntitys(Object entity);
}
