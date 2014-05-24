package com.tanf.system.admin.dao;

import java.util.Map;

import com.tanf.core.dao.BaseDao;
/**
 * 字典持久层
 * @author Tandaly
 * @date 2013-7-1 下午3:14:36
 */
public interface DictionaryDao extends BaseDao
{
	/**
	 * 启用或禁用字典
	 * @param paramMap
	 * @return
	 */
	Integer updateDicStatus(Map<String, Object> paramMap);

}
