package com.tandaly.core.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;

/**
 * 最核心的地方，就是提供某个资源对应的权限定义，即getAttributes方法返回的结果。 此类在初始化时，应该取到所有资源及其对应角色的定义。
 * 
 */
public class MySecurityMetadataSource implements
		FilterInvocationSecurityMetadataSource
{

	private static Map<String, Collection<ConfigAttribute>> resourceMap = null;

	public MySecurityMetadataSource()
	{
		loadResourceDefine();
	}

	private void loadResourceDefine()
	{
		/*
		 * ApplicationContext context = new ClassPathXmlApplicationContext(
		 * "classpath:applicationContext.xml");
		 * 
		 * SessionFactory sessionFactory = (SessionFactory) context
		 * .getBean("sessionFactory");
		 * 
		 * Session session = sessionFactory.openSession();
		 * 
		 * String username = ""; String sql = "";
		 * 
		 * // 在Web服务器启动时，提取系统中的所有权限。 sql =
		 * "select authority_name from pub_authorities";
		 * 
		 * List<String> query = session.createSQLQuery(sql).list();
		 * 
		 * 
		 * 应当是资源为key， 权限为value。 资源通常为url， 权限就是那些以ROLE_为前缀的角色。 一个资源可以由多个权限来访问。
		 * sparta
		 * 
		 * resourceMap = new HashMap<String, Collection<ConfigAttribute>>();
		 * 
		 * for (String auth : query) { ConfigAttribute ca = new
		 * SecurityConfig(auth);
		 * 
		 * List<String> query1 = session .createSQLQuery(
		 * "select b.resource_string " +
		 * "from Pub_Authorities_Resources a, Pub_Resources b, " +
		 * "Pub_authorities c where a.resource_id = b.resource_id " +
		 * "and a.authority_id=c.authority_id and c.Authority_name='" + auth +
		 * "'").list();
		 * 
		 * for (String res : query1) { String url = res;
		 * 
		 * 
		 * 判断资源文件和权限的对应关系，如果已经存在相关的资源url，则要通过该url为key提取出权限集合，将权限增加到权限集合中。 sparta
		 * 
		 * if (resourceMap.containsKey(url)) {
		 * 
		 * Collection<ConfigAttribute> value = resourceMap.get(url);
		 * value.add(ca); resourceMap.put(url, value); } else {
		 * Collection<ConfigAttribute> atts = new ArrayList<ConfigAttribute>();
		 * atts.add(ca); resourceMap.put(url, atts); }
		 * 
		 * }
		 * 
		 * }
		 */
		System.out.println("加载权限列表");
		resourceMap = new HashMap<String, Collection<ConfigAttribute>>();
		
		ConfigAttribute ca = new SecurityConfig("PRIVILEGE_TEST");
		Collection<ConfigAttribute> atts = new ArrayList<ConfigAttribute>();
		atts.add(ca);
		resourceMap.put("/build.do", atts);
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
		System.out.println("根据url找到权限...");
		// object 是一个URL，被用户请求的url。
		String url = ((FilterInvocation) object).getRequestUrl();

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