package com.tandaly.core.security;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import com.tandaly.core.exception.ServiceException;
import com.tandaly.core.spring.SpringFactory;
import com.tandaly.core.util.StringUtil;
import com.tandaly.system.admin.beans.User;
import com.tandaly.system.admin.service.UserService;
import com.tandaly.system.common.util.ParamsConstants;
import com.tandaly.system.common.util.SystemConstants;
/**
 * 登录用户名密码认证过滤器
 * @author Tandaly
 * @date 2013-7-23 上午9:29:58
 */
public class MyUsernamePasswordAuthenticationFilter extends UsernamePasswordAuthenticationFilter{
	
	private static final Logger log = Logger.getLogger(MyUsernamePasswordAuthenticationFilter.class);
	
	public static final String VALIDATE_CODE = "verifyCode";//验证码字符
	public static final String USERNAME = "userName";	//用户名字符
	public static final String PASSWORD = "password"; //密码字符
	
	@Override
	public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException {
		if (!request.getMethod().equals("POST")) {
			throw new AuthenticationServiceException("认证方法不支持: " + request.getMethod());
		}
		
		log.info("登录用户名密码认证...");
		checkValidateCode(request);
		
		String userName = obtainUsername(request);
		String password = obtainPassword(request);
		
		//验证用户账号与密码是否对应
		userName = userName.trim();
		
		//Users users = this.usersDao.findByName(username);
		
		//if(users == null || !users.getPassword().equals(password)) {
	/*
	 
		if (forwardToDestination) {
            request.setAttribute(WebAttributes.AUTHENTICATION_EXCEPTION, exception);
        } else {
            HttpSession session = request.getSession(false);

            if (session != null || allowSessionCreation) {
                request.getSession().setAttribute(WebAttributes.AUTHENTICATION_EXCEPTION, exception);
            }
        }
	 */
		//	throw new AuthenticationServiceException("password or username is notEquals"); 
		//}
		
//			HttpSession session = request.getSession(false);
//            if (session != null) {
//                request.getSession().setAttribute(WebAttributes.AUTHENTICATION_EXCEPTION, exception);
//            }
            
        //登录验证操作
		try
		{
			User user1 = new User();
			user1.setUserName(userName);
			user1.setPassword(password);
			
			UserService userService = SpringFactory.getBean(UserService.class);
			User user = userService.logins(user1);
			
			HttpSession session = request.getSession();
			session.setAttribute(SystemConstants.LOGIN_USER_SESSION, user);
			session.setAttribute(SystemConstants.SYS_PARAMS, ParamsConstants.SYSTEM_PARAMS);
			log.info("登录认证成功！");
		} catch (ServiceException e)
		{
			log.info("登录认证失败！");
			throw new AuthenticationServiceException(e.getMessage()); 
		}
		
		//UsernamePasswordAuthenticationToken实现 Authentication
		UsernamePasswordAuthenticationToken authRequest = new UsernamePasswordAuthenticationToken(userName, password);
		// Place the last username attempted into HttpSession for views
		
		// 允许子类设置详细属性
        setDetails(request, authRequest);
		
        // 运行UserDetailsService的loadUserByUsername 再次封装Authentication
		return this.getAuthenticationManager().authenticate(authRequest);
	}
	
	/**
	 * 检验验证码
	 * @param request
	 */
	protected void checkValidateCode(HttpServletRequest request) { 
		HttpSession session = request.getSession();
		
	    String sessionValidateCode = obtainSessionValidateCode(session); 
	    //让上一次的验证码失效
	    session.setAttribute(VALIDATE_CODE, null);
	    String validateCodeParameter = obtainValidateCodeParameter(request);  
	    if (StringUtil.isEmpty(validateCodeParameter) || !sessionValidateCode.equalsIgnoreCase(validateCodeParameter)) {  
	        throw new AuthenticationServiceException("验证码错误");  
	    }  
	}
	
	private String obtainValidateCodeParameter(HttpServletRequest request) {
		Object obj = request.getParameter(VALIDATE_CODE);
		return null == obj ? "" : obj.toString();
	}

	protected String obtainSessionValidateCode(HttpSession session) {
		Object obj = session.getAttribute(VALIDATE_CODE);
		return null == obj ? "" : obj.toString();
	}

	@Override
	protected String obtainUsername(HttpServletRequest request) {
		Object obj = request.getParameter(USERNAME);
		return null == obj ? "" : obj.toString();
	}

	@Override
	protected String obtainPassword(HttpServletRequest request) {
		Object obj = request.getParameter(PASSWORD);
		return null == obj ? "" : obj.toString();
	}
	
	
}
