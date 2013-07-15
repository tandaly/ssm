package com.tandaly.system.admin.dao;

import java.util.List;
import java.util.Map;

import com.tandaly.core.dao.BaseDao;

/**
 * 系统监控持久层
 * @author tandaly(tandaly001@gmail.com)
 * @date 2013-6-30 下午1:36:16
 */
public interface MonitorDao extends BaseDao{

	/*******************************事件信息操作start****************************/
	/**
	 * 保存时间
	 * @param params
	 * @return
	 */
	Integer saveEvent(Map<String, Object> params);
	
	/**
	 * 清空事件日志
	 * @return
	 */
	Integer clearEvent();
	
	/*******************************异常信息操作start****************************/
	
	/**
	 * 保存异常信息
	 * @param params
	 * @return
	 */
	Integer saveExceptions(Map<String, Object> params);
	
	/**
	 * 删除异常信息日志
	 * @param ids
	 * @return
	 */
	Integer deleteExceptions(String ids);
	
	/**
	 * 	清空异常信息日志
	 * @return
	 */
	Integer clearExceptions();
	
	/**
	 * 分页查询异常总数
	 * @param params
	 * @return
	 */
	Integer pageQueryExceptionsCount(Map<String, Object> params);
	
	/**
	 * 分页查询异常列表
	 * @param params
	 * @return
	 */
	List<?> pageQueryExceptionsList(Map<String, Object> params);
	
	/**
	 * 根据id查询异常信息
	 * @param id
	 * @return
	 */
	Map<String, Object> queryExceptionsById(Integer id);
	
}
