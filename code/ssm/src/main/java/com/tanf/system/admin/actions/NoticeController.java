package com.tanf.system.admin.actions;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.tanf.core.exception.ServiceException;
import com.tanf.core.metatype.ResponseMap;
import com.tanf.core.metatype.impl.HashResponseMap;
import com.tanf.core.page.Pagination;
import com.tanf.core.util.CustomTimestampEditor;
import com.tanf.core.util.WebUtil;
import com.tanf.system.admin.beans.Notice;
import com.tanf.system.admin.service.NoticeService;
/**
 * 系统公告控制器
 * @author Tandaly
 * @date 2013-7-15 下午2:07:52
 */
@Controller
@RequestMapping("notice")
public class NoticeController
{

	@InitBinder
	public void initBinder(WebDataBinder binder)
	{
		binder.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd"), true));
		binder.registerCustomEditor(Timestamp.class, new CustomTimestampEditor(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"), true));
	}
	
	@Autowired
	NoticeService noticeService;
	
	/**
	 * 跳转到增加系统公告页面
	 */
	@RequestMapping("addNotice")
	public void addNotice()
	{
		
	}
	
	/**
	 * 添加系统公告
	 * @param response
	 * @param request
	 * @param notice
	 */
	@RequestMapping(value = "ajaxAddNotice", method = RequestMethod.POST)
	public void ajaxAddNotice(HttpServletResponse response, HttpServletRequest request, Notice notice)
	{
		ResponseMap responseMap = new HashResponseMap();
		try {
			this.noticeService.addNotice(notice);
			responseMap.put("id", notice.getId());
			responseMap.setStatus(true);
			responseMap.setInfo("添加系统公告成功");
		} catch (ServiceException e) {
			responseMap.setStatus(false);
			responseMap.setInfo(e.getMessage());
		}
		
		WebUtil.writerJson(response, responseMap);
	}
	
	/**
	 * 删除系统公告
	 * @param response
	 * @param ids
	 */
	@RequestMapping(value="ajaxDeleteNotice", method = RequestMethod.POST)
	public void ajaxDeleteNotice(HttpServletResponse response, String ids){
		ResponseMap responseMap = new HashResponseMap();
		try
		{
			this.noticeService.deleteNotice(ids);
			responseMap.setStatus(true);
			responseMap.setInfo("删除系统公告成功");
		} catch (ServiceException e) {
			responseMap.setStatus(false);
			responseMap.setInfo(e.getMessage());
		}
		
		WebUtil.writerJson(response, responseMap);
	}
	
	/**
	 * 跳转到系统公告修改页面
	 * @param notice
	 * @return
	 */
	@RequestMapping("updateNotice")
	public Object updateNotice(Notice notice)
	{
		return this.noticeService.queryNoticeById(notice.getId());
	}
	
	/**
	 * 修改系统公告
	 * @param response
	 * @param notice
	 */
	@RequestMapping(value = "ajaxUpdateNotice", method = RequestMethod.POST)
	public void ajaxUpdateNotice(HttpServletResponse response, Notice notice)
	{
		ResponseMap responseMap = new HashResponseMap();
		try
		{
			this.noticeService.updateNotice(notice);
			responseMap.setStatus(true);
			responseMap.setInfo("修改系统公告成功");
		} catch (ServiceException e)
		{
			responseMap.setStatus(false);
			responseMap.setInfo(e.getMessage());
		}
		
		WebUtil.writerJson(response, responseMap);
	}
	
	/**
	 * 系统公告列表页面
	 */
	@RequestMapping("noticeList")
	public void noticeList()
	{
	}
	
	/**
	 * 查询系统公告列表
	 * @param response
	 * @param pagination
	 * @param notice
	 */
	@RequestMapping(value = "ajaxNoticeList", method = RequestMethod.POST)
	public void ajaxNoticeList(HttpServletResponse response, Pagination pagination, Notice notice)
	{
		pagination.setParamEntity(notice);
		this.noticeService.pageQueryEntityList(pagination);
		WebUtil.writerPagination(response, pagination);
	}
	
	/**
	 * 详情系统公告页面
	 * @param model
	 * @param id
	 */
	@RequestMapping(value="detailNotice", method = RequestMethod.GET)
	public void detailNotice(Model model, Integer id)
	{
		model.addAttribute("notice", this.noticeService.queryNoticeById(id));
	}
	
}
