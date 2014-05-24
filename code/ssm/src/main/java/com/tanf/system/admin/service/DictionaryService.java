package com.tanf.system.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tanf.core.exception.ServiceException;
import com.tanf.core.page.Pagination;
import com.tanf.core.service.BaseService;
import com.tanf.core.util.StringUtil;
import com.tanf.system.admin.beans.Dictionary;
import com.tanf.system.admin.dao.DictionaryDao;
/**
 * 字典业务层
 * @author Tandaly
 * @date 2013-7-1 下午3:15:44
 */
@Service
public class DictionaryService extends BaseService
{
	@Autowired
	DictionaryDao dictionaryDao;

	/**
	 * 新增字典
	 * @param dictionary
	 */
	@Transactional
	public void addDictionary(Dictionary dictionary)
	{
		if(null == dictionary)
		{
			throw new ServiceException("传入的参数错误");
		}
		
		this.dictionaryDao.insert(dictionary);
		if(null == dictionary.getId())
		{
			throw new ServiceException("添加失败");
		}
	}
	
	/**
	 * 删除字典
	 * @param ids
	 * @throws ServiceException
	 */
	@Transactional
	public void deleteDictionary(String ids) throws ServiceException
	{
		Integer rows = this.dictionaryDao.delete(ids);
		if(null == rows || 1 > rows)
		{
			throw new ServiceException("删除失败");
		}
	}
	
	/**
	 * 修改字典
	 * @param dictionary
	 * @throws ServiceException 
	 */
	@Transactional
	public void updateDictionary(Dictionary dictionary) throws ServiceException
	{
		if(null == dictionary)
		{
			throw new ServiceException("传入的参数错误");
		}
		
		Integer result = this.dictionaryDao.update(dictionary);
		
		if(null == result || 1 > result)
		{
			throw new ServiceException("修改失败");
		}
	}
	
	/**
	 * 根据id查询字典
	 * @param id
	 * @return
	 */
	public Dictionary queryDictionaryById(Integer id)
	{
		return (Dictionary) this.dictionaryDao.queryEntityById(id);
	}
	
	/**
	 * 根据条件查询字典列表
	 * @param dictionary
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Dictionary> queryDictionarys(Dictionary dictionary)
	{
		return (List<Dictionary>) this.dictionaryDao.queryEntitys(dictionary);
	}
	
	
	/**
	 * 分页查询字典列表
	 */
	@Override
	public void pageQueryEntityList(Pagination pagination)
	{
		Integer count = this.dictionaryDao.pageQueryEntityCount(pagination.getParamMap());
		if(null != count && 0 < count)
		{
			pagination.setTotalCount(count);
			pagination.setList(this.dictionaryDao.pageQueryEntityList(pagination.getParamMap()));
		}else
		{
			pagination.setTotalCount(0);
		}
	}
	
	/**
	 * 根据字典键查询字典列表
	 * @param dicKey
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Dictionary> queryDictionarysByDicKey(String dicKey)
	{
		if(StringUtil.isEmpty(dicKey))
		{
			throw new ServiceException("传入的参数错误");
		}
		Dictionary dictionary = new Dictionary();
		dictionary.setDicKey(dicKey);
		dictionary.setStatus("启用");
		
		return (List<Dictionary>) this.dictionaryDao.queryEntitys(dictionary);
	}
	
	/**
	 * 启用或禁用字典
	 * @param status
	 * @param dicIds
	 * @throws ServiceException 
	 */
	@Transactional
	public void updateDicStatus(String status, String dicIds) throws ServiceException
	{
		if(null == status || null == dicIds 
				|| "".equals(dicIds))
		{
			throw new ServiceException("传入的参数错误");
		}
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("status", status);
		paramMap.put("dicIds", dicIds);
		Integer result = this.dictionaryDao.updateDicStatus(paramMap);
		
		if(null == result || 1 > result)
		{
			throw new ServiceException("操作失败");
		}
	}

}
