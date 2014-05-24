package com.tanf.core.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.log4j.Logger;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;

import com.tanf.core.spring.SpringFactory;
import com.tanf.core.util.StringUtil;
import com.tanf.system.admin.beans.Menu;
import com.tanf.system.admin.beans.Privilege;
import com.tanf.system.admin.dao.MenuDao;
import com.tanf.system.admin.dao.PrivilegeDao;

/**
 * 最核心的地方，就是提供某个资源对应的权限定义，即getAttributes方法返回的结果。 此类在初始化时，应该取到所有资源及其对应角色的定义。
 * @author tanf
 * @date 2013-7-23 上午9:31:31
 */
public class MySecurityMetadataSource implements
		FilterInvocationSecurityMetadataSource
{

	private static final Logger log = Logger.getLogger(MySecurityMetadataSource.class);
	
	private static Map<String, Collection<ConfigAttribute>> resourceMap = null;//权限资源集合

	public MySecurityMetadataSource()
	{
		loadResourceDefine();
	}
	
	/**
	 * 载入所有权限资源集合
	 */
	public static void loadResourceDefine()
	{
		log.info("载入所有权限集合");
		resourceMap = new HashMap<String, Collection<ConfigAttribute>>();
		
		PrivilegeDao pDao = SpringFactory.getBean(PrivilegeDao.class);
		MenuDao mDao = SpringFactory.getBean(MenuDao.class);
		
		List<Menu> menus = mDao.queryMenusByMenu(null);//查询所有的菜单
		
		for(Menu m:menus)
		{
			String url = m.getMenuUrl();
			
			if(StringUtil.isNotEmpty(url))
			{
				int firstQuestionMarkIndex = url.indexOf("?");
				if (firstQuestionMarkIndex != -1)
				{
					url = url.substring(0, firstQuestionMarkIndex);
				}
				
				//根据菜单id查询权限集合
				List<Privilege> privileges = pDao.queryPrivilegesByMenu(m);
				Collection<ConfigAttribute> atts = new ArrayList<ConfigAttribute>();
				for(Privilege p:privileges)
				{
					ConfigAttribute ca = new SecurityConfig(p.getPrivilegeCode());//权限编码
					atts.add(ca);
				}
				
				if(!url.startsWith("/"))//避免不是以/开头会和请求url不匹配
					url = "/" + url;
				
				if(resourceMap.containsKey(url))
				{//存在该资源,需要叠加权限
					Collection<ConfigAttribute> ps = resourceMap.get(url);
					atts.addAll(ps);
				}
				
				resourceMap.put(url, atts);
			}
		}
		
		log.info("载入所有权限集合完成！");
	}

	/** 获取所有权限匹配属性 */
	@Override
	public Collection<ConfigAttribute> getAllConfigAttributes()
	{
		Set<ConfigAttribute> allAttributes = new HashSet<ConfigAttribute>();
		for (Map.Entry<String, Collection<ConfigAttribute>> entry : resourceMap
				.entrySet()) {
			allAttributes.addAll(entry.getValue());
		}
		return allAttributes;
	}

	/** 接口中规定的方法， 这核心方法 ，用户获取正在访问的资源所对应的权限集合 */
	@Override
	public Collection<ConfigAttribute> getAttributes(Object object)
			throws IllegalArgumentException
	{
		// object 是一个URL，被用户请求的url。
		String url = ((FilterInvocation) object).getRequestUrl();
		log.info("根据资源获取权限集合, 资源地址=" + url);
		
		int firstQuestionMarkIndex = url.indexOf("?");

		if (firstQuestionMarkIndex != -1)
		{
			url = url.substring(0, firstQuestionMarkIndex);
		}

		return resourceMap.get(url);
		//return null;// 如果不是库里面的路径，就让它过去
	}

	@Override
	public boolean supports(Class<?> arg0)
	{

		return true;
	}

}