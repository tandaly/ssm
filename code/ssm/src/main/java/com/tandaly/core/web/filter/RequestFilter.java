package com.tandaly.core.web.filter;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.tandaly.core.spring.SpringFactory;
import com.tandaly.core.util.Constants;
import com.tandaly.core.util.DateUtil;
import com.tandaly.core.util.StringUtil;
import com.tandaly.core.util.WebUtil;
import com.tandaly.system.admin.beans.User;
import com.tandaly.system.admin.service.MonitorService;
/**
 * request请求过滤器
 * @author tandaly(tandaly001@gmail.com)
 * @date 2013-6-30 上午10:49:31
 */
public class RequestFilter implements Filter {

	private Log log = LogFactory.getLog(RequestFilter.class);
	private FilterConfig filterConfig;
	private boolean enabled;//是否开启请求日志记录
	
	public RequestFilter()
	{
		filterConfig = null;
		enabled = true;
	}
	

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
		String value = this.filterConfig.getInitParameter("enabled");
		if(StringUtil.isEmpty(value))
		{
			this.enabled = true;
		}else if(value.equalsIgnoreCase("true"))
		{
			this.enabled = true;
		}else
		{
			this.enabled = false;
		}
	}
	
	@Override
	public void doFilter(ServletRequest sRequest, ServletResponse sResponse,
			FilterChain filterChain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest)sRequest;
		HttpServletResponse response = (HttpServletResponse)sResponse;
		
		long startTime = System.currentTimeMillis();
		if(isLogin(request, response))
		{
			filterChain.doFilter(request, response);//执行下一拦截器
		}
		
		if(this.enabled)
		{
			saveEvent(request, new BigDecimal(System.currentTimeMillis() - startTime));
		}
		
		//response.setHeader("P3P","CP=CAO PSA OUR");//解决iframe 下 session 失效解决办法记录(google)
	}
	
	/**
	 * 是否登陆权限验证
	 * @param request
	 * @param response
	 * @return
	 */
	public boolean isLogin(HttpServletRequest request, HttpServletResponse response)
	{
		//验证请求是否登录，如果没有登录，则跳转到登录页面
		if(null == request.getSession().getAttribute(Constants.LOGIN_USER_SESSION))
		{
			if(!"/login.do".equals(request.getServletPath()) 
					&& !"/logins.do".equals(request.getServletPath())
					&& !"/image.do".equals(request.getServletPath())
				)
			{
				//ajax session超时响应处理
				if(request.getHeader("x-requested-with")!=null 
					&&request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")){ 
					PrintWriter printWriter = null;
					try {
						printWriter = response.getWriter();
					} catch (IOException e) {
						e.printStackTrace();
					} 
					printWriter.print("{sessionState:0, root:'"+request.getContextPath()+"'}"); 
					printWriter.flush(); 
					printWriter.close(); 
				} 
				else
				{
					//request.getRequestDispatcher("login.do").forward(request, response);
					//response.sendRedirect(request.getContextPath() + "login.do");
					String htmlStr = "<script>if(top.art != undefined){top.art.dialog.alert('操作超时,请重新登录！', function(){top.document.location.href='"+request.getContextPath()+"/login.do';});}else{top.document.location.href='"+request.getContextPath()+"/login.do';}</script>";
					WebUtil.writerHtml(response, htmlStr);
				}
				return false;
			}
		}
		return true;
	}
	
	/**
	 * 保存事件日志
	 * @param request
	 * @param costTime
	 */
	public void saveEvent(HttpServletRequest request, BigDecimal costTime)
	{
		User user = (User)request.getSession().getAttribute(Constants.LOGIN_USER_SESSION);
		if(null == user)return;
		
		this.log.info("[system]保存事件日志");
		Map<String, Object> params = new HashMap<String ,Object>();
		params.put("userId", user.getId());
		params.put("userName", user.getUserName());
		String msg = "[" + user.getUserName() + "]调用了方法[" + getRequestMethod(request.getRequestURI()) 
				+ "]";
		params.put("description", msg);
		params.put("activeTime", DateUtil.getCurrDateTime());
		params.put("requestPath", request.getRequestURI());
		params.put("methodName", getRequestMethod(request.getRequestURI()));
		params.put("costTime", costTime);
		
		MonitorService monitorService = SpringFactory.getBean(MonitorService.class);
		monitorService.saveEvent(params);
	}
	
	/**
	 * 根据请求地址获得请求方法
	 * @param url
	 * @return
	 */
	public String getRequestMethod(String url)
	{
		String result = "";
		if(StringUtil.isNotEmpty(url) && url.endsWith(Constants.REQUEST_SUFFIX))
		{
			result = url.substring(url.lastIndexOf(Constants.PATH_SEPARATOR, url.length()) 
					+ Constants.PATH_SEPARATOR.length(),
						url.indexOf(Constants.REQUEST_SUFFIX));
		}
		return result;
	}

	@Override
	public void destroy() {
		filterConfig = null;
	}

}
