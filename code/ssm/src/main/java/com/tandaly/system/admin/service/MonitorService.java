package com.tandaly.system.admin.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tandaly.core.exception.ServiceException;
import com.tandaly.core.page.Pagination;
import com.tandaly.core.service.BaseService;
import com.tandaly.system.admin.dao.MonitorDao;

/**
 * 系统监控业务接口
 * @author tandaly(tandaly001@gmail.com)
 * @date 2013-6-30 下午1:34:37
 */
@Service
public class MonitorService extends BaseService{

	@Autowired
	MonitorDao monitorDao;
	
	/*******************************事件信息操作start****************************/
	/**
	 * 保存事件
	 * @param params
	 */
	public void saveEvent(Map<String, Object> params)
	{
		this.monitorDao.saveEvent(params);
	}
	
	/**
	 * 删除事件
	 * @param ids
	 * @throws ServiceException
	 */
	@Transactional
	public void deleteEvent(String ids) throws ServiceException
	{
		Integer rows = this.monitorDao.delete(ids);
		if(null == rows || 1 > rows)
		{
			throw new ServiceException("删除失败");
		}
	}
	
	/**
	 * 清空事件日志
	 */
	@Transactional
	public void clearEvent()
	{
		this.monitorDao.clearEvent();
	}
	
	/**
	 * 分页查询事件列表
	 * @param pagination
	 */
	public void pageQueryEntityList(Pagination pagination)
	{
		Integer count = this.monitorDao.pageQueryEntityCount(pagination.getParamMap());
		if(null != count && 0 < count)
		{
			pagination.setTotalCount(count);
			pagination.setList(this.monitorDao.pageQueryEntityList(pagination.getParamMap()));
		}else
		{
			pagination.setTotalCount(0);
		}
	}
	
	
	/*******************************异常信息操作start****************************/
	
	/**
	 * 保存异常
	 * @param params
	 */
	public void saveExceptions(Map<String, Object> params)
	{
		this.monitorDao.saveExceptions(params);
	}
	
	/**
	 * 删除异常
	 * @param ids
	 * @throws ServiceException
	 */
	@Transactional
	public void deleteExceptions(String ids) throws ServiceException
	{
		Integer rows = this.monitorDao.deleteExceptions(ids);
		if(null == rows || 1 > rows)
		{
			throw new ServiceException("删除失败");
		}
	}
	
	/**
	 * 清空异常
	 */
	@Transactional
	public void clearExceptions()
	{
		this.monitorDao.clearExceptions();
	}
	
	/**
	 * 分页查询异常列表
	 * @param pagination
	 */
	public void pageQueryExceptionsList(Pagination pagination)
	{
		Integer count = this.monitorDao.pageQueryExceptionsCount(pagination.getParamMap());
		if(null != count && 0 < count)
		{
			pagination.setTotalCount(count);
			pagination.setList(this.monitorDao.pageQueryExceptionsList(pagination.getParamMap()));
		}else
		{
			pagination.setTotalCount(0);
		}
	}
	
	/**
	 * 根据id查询异常信息
	 * @param id
	 * @return
	 * @throws ServiceException
	 */
	public Map<String, Object> queryExceptionsById(Integer id) throws ServiceException
	{
		if(null == id)
		{
			throw new ServiceException("传入的参数有错误");
		}
		
		return this.monitorDao.queryExceptionsById(id);
	}
}
