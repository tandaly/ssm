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
