package com.tandaly.system.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tandaly.core.exception.ServiceException;
import com.tandaly.core.page.Pagination;
import com.tandaly.core.service.BaseService;
import com.tandaly.system.admin.beans.Params;
import com.tandaly.system.admin.dao.ParamsDao;
/**
 * 系统全局参数业务层
 * @author Tandaly
 * @date 2013-7-1 下午3:15:44
 */
@Service
public class ParamsService extends BaseService
{
	@Autowired
	ParamsDao paramsDao;


	/**
	 * 新增参数
	 * @param params
	 */
	@Transactional
	public void addParams(Params params)
	{
		if(null == params)
		{
			throw new ServiceException("传入的参数错误");
		}
		
		//TODO 检查参数名称唯一性
		this.paramsDao.insert(params);
		if(null == params.getId())
		{
			throw new ServiceException("添加失败");
		}
	}
	
	/**
	 * 删除参数
	 * @param ids
	 * @throws ServiceException
	 */
	@Transactional
	public void deleteParams(String ids) throws ServiceException
	{
		Integer rows = this.paramsDao.delete(ids);
		if(null == rows || 1 > rows)
		{
			throw new ServiceException("删除失败");
		}
	}
	
	/**
	 * 修改参数
	 * @param params
	 * @throws ServiceException 
	 */
	@Transactional
	public void updateParams(Params params) throws ServiceException
	{
		if(null == params)
		{
			throw new ServiceException("传入的参数错误");
		}
		Integer result = this.paramsDao.update(params);
		
		if(null == result || 1 > result)
		{
			throw new ServiceException("修改失败");
		}
	}
	
	/**
	 * 检查参数名称是否可用
	 * @param paramsName
	 * @throws ServiceException
	 */
	public void checkParamsName(String paramsName) throws ServiceException
	{
		Params params = new Params();
		params.setName(paramsName);
		List<?> paramses = this.paramsDao.queryEntitys(params);
		if(null != paramses && 0 < paramses.size())
		{
			throw new ServiceException("该名称不可用");
		}
	}
	
	/**
	 * 检查修改的参数名称是否可用
	 * @param paramsName
	 * @throws ServiceException
	 */
	public void checkUpdateParamsName(Integer id, String paramsName) throws ServiceException
	{
		Params params = new Params();
		params.setId(id);
		params.setName(paramsName);
		Integer count = this.paramsDao.checkUpdateParams(params);
		if(null != count && 0 < count)
		{
			throw new ServiceException("该名称不可用");
		}
	}
	
	/**
	 * 根据id查询参数
	 * @param id
	 * @return
	 */
	public Params queryParamsById(Integer id)
	{
		return (Params) this.paramsDao.queryEntityById(id);
	}
	
	/**
	 * 查询所有参数
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Params> queryParamses(Params params)
	{
		return (List<Params>) this.paramsDao.queryEntitys(params);
	}
	
	/**
	 * 分页查询参数列表
	 */
	@Override
	public void pageQueryEntityList(Pagination pagination)
	{
		Integer count = this.paramsDao.pageQueryEntityCount(pagination.getParamMap());
		if(null != count && 0 < count)
		{
			pagination.setTotalCount(count);
			pagination.setList(this.paramsDao.pageQueryEntityList(pagination.getParamMap()));
		}else
		{
			pagination.setTotalCount(0);
		}
	}

}
