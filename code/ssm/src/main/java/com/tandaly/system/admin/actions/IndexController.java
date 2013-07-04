package com.tandaly.system.admin.actions;

import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tandaly.core.exception.ServiceException;
import com.tandaly.system.admin.beans.Menu;
import com.tandaly.system.admin.beans.User;
import com.tandaly.system.admin.service.MenuService;
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
	
	@RequestMapping("login") 
	public void login()
	{
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
	
	@RequestMapping("top")
	public void top()
	{
	}
	
	@RequestMapping("changeScreen")
	public void changeScreen()
	{
		
	}
	
	@RequestMapping("left")
	public Object left(HttpServletResponse response, ModelMap model, HttpSession session)
	{
		User user = (User)session.getAttribute(SystemConstants.LOGIN_USER_SESSION);
		List<Menu> menus = this.menuService.queryMenusByUserId(user.getId());
		model.addAttribute("menus", menus);
		
		return model;
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
			viewName = "redirect:index.do";
			
		} catch (ServiceException e)
		{//登录失败
			redirectAttrs.addFlashAttribute("msg", e.getMessage());
			viewName = "redirect:login.do";
		}
		
		return viewName;
	}
	
	/**
	 * 转到主页
	 * @return
	 */
	@RequestMapping("index")
	public void index(Model model)
	{
		//系统标题
		model.addAttribute("sysTitle", 
				ParamsConstants.SYSTEM_PARAMS.get(ParamsConstants.SYS_TITLE));
	}
	
	/**
	 * 退出登录
	 * @param session
	 */
	@RequestMapping(value="logout")
	public String logout(HttpSession session)
	{
		session.invalidate();
		return "login";
	}
}
