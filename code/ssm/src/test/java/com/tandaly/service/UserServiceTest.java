package com.tandaly.service;

import java.util.Date;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.tandaly.base.BaseTest;
import com.tandaly.core.exception.ServiceException;
import com.tandaly.core.page.Pagination;
import com.tandaly.system.admin.beans.User;
import com.tandaly.system.admin.service.UserService;

public class UserServiceTest extends BaseTest
{

	@Autowired
	private UserService userService;
	
	@Test
	public void testInsertUser()
	{
		/*User user = new User();
		user.setUserName("admin");
		user.setPassword("admin");
		user.setStatus("启用");
		user.setRegisterDate(new Date());
		
		try {
			this.userService.addUser(user);
			
			Assert.assertNotNull(user.getId());
			Assert.assertTrue(0 < user.getId());
		} catch (ServiceException e) {
			Assert.fail(e.getMessage());
		}*/
	}
	
	@Test
	public void testInsertUsers()
	{
		for(int i = 0; i < 100; i++)
		{
			User user = new User();
			user.setUserName("tandaly" + i);
			user.setPassword("" + i + 123);
			user.setStatus("启用");
			user.setRegisterDate(new Date());
			
			try
			{
				this.userService.addUser(user);
				
				Assert.assertNotNull(user.getId());
			} catch (ServiceException e)
			{
				Assert.fail(e.getMessage());
			}
		}
		
	}
	
	@Test
	public void testDeleteUser()
	{
		String ids = "95, 96";
		try
		{
			this.userService.deleteUser(ids);
		} catch (ServiceException e)
		{
			e.printStackTrace();
			Assert.fail("测试删除用户失败");
		}
	}
	
	@Test 
	public void testPageQueryUserList()
	{
		User user = new User();
		user.setUserName("admin");
		Pagination pagination = new Pagination(1, 10);
		
		pagination.getParamMap().put("user", user);
		
		this.userService.pageQueryEntityList(pagination);
		
		Assert.assertNotNull(pagination);
		Assert.assertNotNull(pagination.getList());
		Assert.assertSame(1, pagination.getList().size());
	}
	
	@Test
	public void testP()
	{
	}
	

}
