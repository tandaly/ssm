package com.tanf.core.security;

import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserCache;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.tanf.core.spring.SpringFactory;
import com.tanf.system.admin.beans.Privilege;
import com.tanf.system.admin.dao.PrivilegeDao;
import com.tanf.system.admin.dao.UserDao;

/**
 * 该类的主要作用是为Spring Security提供一个经过用户认证后的UserDetails。
 * 该UserDetails包括用户名、密码、是否可用、是否过期等信息。
 * 
 * @author tanf
 * @date 2013-7-23 下午1:48:04
 */
public class MyAuthenticationManager implements UserDetailsService
{
//	@Autowired
//	private UserCache userCache;

	@Override
	public UserDetails loadUserByUsername(String userName)
			throws UsernameNotFoundException, DataAccessException
	{

		/*
		// 得到用户的权限
		auths = pubUsersHome.loadUserAuthoritiesByName(username);

		String password = null;

		// 取得用户的密码
		password = pubUsersHome.getPasswordByUsername(username);

		return new User(username, password, true, "", true, true, true, auths);*/
 		System.out.println("用户认证信息...");
//		return new User("admin", "123456", true, true, true, true, auths);
		
		Collection<GrantedAuthority> grantedAuths = obtionGrantedAuthorities(userName);
		
		boolean enables = true;
		boolean accountNonExpired = true;
		boolean credentialsNonExpired = true;
		boolean accountNonLocked = true;
		UserDao uDao = SpringFactory.getBean(UserDao.class);
		//封装成spring security的user
		User userdetail = new User(userName, uDao.logins(userName).getPassword(),
				enables, accountNonExpired, credentialsNonExpired, accountNonLocked, grantedAuths);
		return userdetail;
	}
	
	//取得用户的权限
	private Set<GrantedAuthority> obtionGrantedAuthorities(String userName) {
		Set<GrantedAuthority> authSet = new HashSet<GrantedAuthority>();
//		List<Resources> resources = new ArrayList<Resources>();
//		Set<Roles> roles = user.getRoles();
//		
//		for(Roles role : roles) {
//			Set<Resources> tempRes = role.getResources();
//			for(Resources res : tempRes) {
//				resources.add(res);
//			}
//		}
//		for(Resources res : resources) {
//			authSet.add(new GrantedAuthorityImpl(res.getName()));
//		}
		//根据用户名查询权限集合
		PrivilegeDao pDao = SpringFactory.getBean(PrivilegeDao.class);
		com.tanf.system.admin.beans.User user = new com.tanf.system.admin.beans.User();
		user.setUserName(userName);
		List<Privilege> privileges = pDao.queryPrivilegesByUser(user);
		for(Privilege p: privileges)
		{
			authSet.add(new SimpleGrantedAuthority(p.getPrivilegeCode()));
		}
		
		return authSet;
	}


	/*// 设置用户缓存功能。
	public void setUserCache(UserCache userCache)
	{
		this.userCache = userCache;
	}

	public UserCache getUserCache()
	{
		return this.userCache;
	}
*/
}