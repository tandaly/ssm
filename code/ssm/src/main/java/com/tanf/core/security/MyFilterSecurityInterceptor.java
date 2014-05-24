package com.tanf.core.security;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.log4j.Logger;
import org.springframework.security.access.SecurityMetadataSource;
import org.springframework.security.access.intercept.AbstractSecurityInterceptor;
import org.springframework.security.access.intercept.InterceptorStatusToken;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;

/**
 *  该过滤器的主要作用就是通过spring著名的IoC生成securityMetadataSource。
 * securityMetadataSource相当于本包中自定义的MyInvocationSecurityMetadataSourceService。
 * 该MyInvocationSecurityMetadataSourceService的作用提从数据库提取权限和资源，装配到HashMap中，
 * 供Spring Security使用，用于权限校验。
 * 
 * @author tanf
 * @date 2013-7-23 下午1:47:46
 */
public class MyFilterSecurityInterceptor extends AbstractSecurityInterceptor
		implements Filter
{
	private static final Logger log = Logger.getLogger(MyFilterSecurityInterceptor.class);

	private FilterInvocationSecurityMetadataSource securityMetadataSource;

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException
	{

		FilterInvocation fi = new FilterInvocation(request, response, chain);
		invoke(fi);

	}

	public FilterInvocationSecurityMetadataSource getSecurityMetadataSource()
	{
		return this.securityMetadataSource;
	}

	public Class<? extends Object> getSecureObjectClass()
	{
		return FilterInvocation.class;
	}

	public void invoke(FilterInvocation fi) throws IOException,
			ServletException
	{
		// object为FilterInvocation对象
		//1.获取请求资源的权限
		//执行Collection<ConfigAttribute> attributes = SecurityMetadataSource.getAttributes(object);
		//2.是否拥有权限
		//获取安全主体，可以强制转换为UserDetails的实例
		//1) UserDetails
		// Authentication authenticated = authenticateIfRequired();
		//this.accessDecisionManager.decide(authenticated, object, attributes);
		//用户拥有的权限
		//2) GrantedAuthority
		//Collection<GrantedAuthority> authenticated.getAuthorities()
		if(log.isDebugEnabled())
		{
			log.debug("用户发送请求！ ");
		}

		InterceptorStatusToken token = super.beforeInvocation(fi);

		try
		{
			fi.getChain().doFilter(fi.getRequest(), fi.getResponse());
		} catch(Exception e)
		{
			if(log.isDebugEnabled())
			{
				log.debug("异常信息：" + e.getMessage());
			}
		}finally
		{
			super.afterInvocation(token, null);
		}

	}

	@Override
	public SecurityMetadataSource obtainSecurityMetadataSource()
	{
		return this.securityMetadataSource;
	}

	public void setSecurityMetadataSource(
			FilterInvocationSecurityMetadataSource securityMetadataSource)
	{
		this.securityMetadataSource = securityMetadataSource;
	}

	public void destroy()
	{

	}

	public void init(FilterConfig filterconfig) throws ServletException
	{

	}

}
