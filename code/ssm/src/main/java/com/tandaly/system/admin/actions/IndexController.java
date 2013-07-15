package com.tandaly.system.admin.actions;

import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tandaly.core.exception.ServiceException;
import com.tandaly.core.util.DateUtil;
import com.tandaly.core.util.WebUtil;
import com.tandaly.system.admin.beans.Menu;
import com.tandaly.system.admin.beans.Notice;
import com.tandaly.system.admin.beans.User;
import com.tandaly.system.admin.service.MenuService;
import com.tandaly.system.admin.service.NoticeService;
import com.tandaly.system.admin.service.UserService;
import com.tandaly.system.common.util.ParamsConstants;
import com.tandaly.system.common.util.SystemConstants;

/**
 * 登录及其首页控制器
 * @author Tandaly
 * @date 2013-6-25 上午9:13:02
 */
@Controller
@EnableWebMvc 
public class IndexController
{
	@Autowired
	private UserService userService;
	
	@Autowired
	private MenuService menuService;
	
	@Autowired
	private NoticeService noticeService;
	
	@RequestMapping("login") 
	public String login(Model model)
	{
		//系统标题
		model.addAttribute("sysTitle", 
			ParamsConstants.SYSTEM_PARAMS.get(ParamsConstants.SYS_TITLE));
		
		return "login";
	}
	
	@RequestMapping("image")
	public String image()
	{
		return "common/image";
	}
	
	@RequestMapping("build")
	public String build()
	{
		return "common/build";
	}
	
	@RequestMapping("frame")
	public void frame()
	{
	}
	
	/**
	 * 顶部页面
	 * @param model
	 */
	@RequestMapping("top")
	public void top(Model model)
	{
		Notice notice = this.noticeService.queryNewNotice();
		if(null != notice)
		{
			notice.setCreateTime(DateUtil.getDateShortLongTimeCn(
					DateUtil.parseFromFormats(notice.getCreateTime())));
			model.addAttribute("notice", notice);
		}
	}
	
	@RequestMapping("changeScreen")
	public void changeScreen()
	{
		
	}
	
	/**
	 * 左菜单页面
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping("left")
	public String left(Model model, HttpSession session)
	{
		String menuStyle = "" + ParamsConstants.SYSTEM_PARAMS.get("MENU_STYLE");
		if("list".equals(menuStyle))
		{
			User user = (User)session.getAttribute(SystemConstants.LOGIN_USER_SESSION);
			List<Menu> menus = this.menuService.queryMenusByUserId(user.getId());
			model.addAttribute("menus", menus);
			return "left2";
		} else 
		{
			return "left";
		}
		
	}
	
	/**
	 * 异步查询系统左菜单树
	 * @param response
	 * @param session
	 */
	@RequestMapping("ajaxLeftMenus")
	public void ajaxLeftMenus(HttpServletResponse response, HttpSession session)
	{
		User user = (User)session.getAttribute(SystemConstants.LOGIN_USER_SESSION);
		List<Menu> menus = this.menuService.queryMenusByUserId(user.getId());
		
		WebUtil.writerJson(response, menus);
	}
	
	@RequestMapping("main")
	public void main()
	{
	}
	
	
	/**
	 * 登录
	 * @param user
	 * @return
	 */
	@RequestMapping(value="logins", method=RequestMethod.POST)
	public Object logins(String verifyCode, User user, HttpSession session,
			RedirectAttributes redirectAttrs)
	{
		String viewName = "";
		try
		{
			/*
			if(null == verifyCode || "".equals(verifyCode.trim()) 
					|| !verifyCode.equals(session.getAttribute("verifyCode")))
			{
				throw new ServiceException("验证码有误");
			}
			*/
			user = this.userService.logins(user);
			
			session.setAttribute(SystemConstants.LOGIN_USER_SESSION, user);
			session.setAttribute(SystemConstants.SYS_PARAMS, ParamsConstants.SYSTEM_PARAMS);
			viewName = "redirect:/index.do";
			
		} catch (ServiceException e)
		{//登录失败
			redirectAttrs.addFlashAttribute("msg", e.getMessage());
			viewName = "redirect:/login.do";
		}
		
		return viewName;
	}
	
	/**
	 * 转到主页
	 * @return
	 */
	@RequestMapping("index")
	public String index(Model model)
	{
		//系统标题
		model.addAttribute("sysTitle", 
				ParamsConstants.SYSTEM_PARAMS.get(ParamsConstants.SYS_TITLE));
		String systemStyle = "" + ParamsConstants.SYSTEM_PARAMS.get("SYSTEM_STYLE");
		if("webos".equals(systemStyle))
		{
			return "index2";
		} else
		{
			return "index";
		}
		
	}
	
	/**
	 * 退出登录
	 * @param session
	 */
	@RequestMapping(value="logout", method = RequestMethod.GET)
	public String logout(HttpSession session)
	{
		session.invalidate();
		
		return "forward:/login.do";
	}
}
