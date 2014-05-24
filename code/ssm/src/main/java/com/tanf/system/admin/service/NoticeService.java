package com.tanf.system.admin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tanf.core.exception.ServiceException;
import com.tanf.core.page.Pagination;
import com.tanf.core.service.BaseService;
import com.tanf.system.admin.beans.Notice;
import com.tanf.system.admin.dao.NoticeDao;
/**
 * 系统公告业务层操作
 * @author Tandaly
 * @date 2013-7-15 下午2:18:03
 */
@Service
public class NoticeService extends BaseService
{

	@Autowired
	NoticeDao noticeDao;
	
	/**
	 * 添加系统公告
	 * @param notice
	 * @return
	 * @throws ServiceException 
	 */
	@Transactional
	public void addNotice(Notice notice) throws ServiceException
	{
		if(null == notice)
			throw new ServiceException("传入的参数错误");
		
		this.noticeDao.insert(notice);
		
		if(null == notice.getId())
		{
			throw new ServiceException("添加系统公告失败");
		}
	}
	
	/**
	 * 修改系统公告
	 * @param notice
	 * @throws ServiceException 
	 */
	@Transactional
	public void updateNotice(Notice notice) throws ServiceException
	{
		if(null == notice)
		{
			throw new ServiceException("传入的参数错误");
		}
		Integer result = this.noticeDao.update(notice);
		
		if(null == result || 1 > result)
		{
			throw new ServiceException("修改系统公告失败");
		}
	}
	
	/**
	 * 删除系统公告
	 * @param ids
	 * @throws ServiceException
	 */
	@Transactional
	public void deleteNotice(String ids) throws ServiceException
	{
		Integer rows = this.noticeDao.delete(ids);
		if(null == rows || 1 > rows)
		{
			throw new ServiceException("删除系统公告失败");
		}
	}
	
	/**
	 * 分页查询系统公告列表
	 * @param pageParamMap
	 * @return
	 */
	@Override
	public void pageQueryEntityList(Pagination pagination)
	{
		Integer count = this.noticeDao.pageQueryEntityCount(pagination.getParamMap());
		if(null != count && 0 < count)
		{
			pagination.setTotalCount(count);
			pagination.setList(this.noticeDao.pageQueryEntityList(pagination.getParamMap()));
		}else
		{
			pagination.setTotalCount(0);
		}
	}
	
	/**
	 * 根据id查询系统公告
	 * @param id
	 * @return
	 */
	public Notice queryNoticeById(Integer id)
	{
		return (Notice) this.noticeDao.queryEntityById(id);
	}
	
	/**
	 * 查询最新系统公告(首页)
	 * @return
	 */
	public Notice queryNewNotice()
	{
		return this.noticeDao.queryNewNotice();
	}
	
}
