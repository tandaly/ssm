package com.tandaly.system.admin.actions;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.tandaly.core.exception.ServiceException;
import com.tandaly.core.metatype.ResponseMap;
import com.tandaly.core.metatype.impl.HashResponseMap;
import com.tandaly.core.page.Pagination;
import com.tandaly.core.util.WebUtil;
import com.tandaly.system.admin.beans.Dictionary;
import com.tandaly.system.admin.service.DictionaryService;

/**
 * 字典控制器
 * @author Tandaly
 * @date 2013-7-1 下午3:18:37
 */
@Controller
@RequestMapping("dictionary")
public class DictionaryController
{
	@Autowired
	DictionaryService dictionaryService;
	
	/**
	 * 删除字典
	 * @param response
	 * @param ids
	 */
	@RequestMapping(value="ajaxDeleteDictionary", method = RequestMethod.POST)
	public void ajaxDeleteDictionary(HttpServletResponse response, String ids){
		ResponseMap responseMap = new HashResponseMap();
		try
		{
			this.dictionaryService.deleteDictionary(ids);
			responseMap.setStatus(true);
			responseMap.setInfo("删除成功");
		} catch (ServiceException e) {
			responseMap.setStatus(false);
			responseMap.setInfo(e.getMessage());
		}
		
		WebUtil.writerJson(response, responseMap);
	}
	
	
	/**
	 * 跳转到字典列表
	 */
	@RequestMapping("dictionaryList")
	public void dictionaryList()
	{
		
	}
	
	/**
	 * 查询字典列表
	 * @param response
	 * @param pagination
	 * @param dictionary
	 */
	@RequestMapping(value = "ajaxDictionaryList", method = RequestMethod.POST)
	public void ajaxDictionaryList(HttpServletResponse response, Pagination pagination,
			Dictionary dictionary)
	{
		pagination.setParamEntity(dictionary);
		this.dictionaryService.pageQueryEntityList(pagination);
		WebUtil.writerPagination(response, pagination);
	}
}
