package com.tandaly.dao;

import java.util.List;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.tandaly.base.BaseTest;
import com.tandaly.system.admin.beans.User;
import com.tandaly.system.admin.dao.UserDao;

public class UserDaoTest extends BaseTest
{

	@Autowired
	private UserDao userDao;
	
	@Test
	public void testQueryUser2()
	{
		List<User> users = this.userDao.queryUser2();
		
		Assert.assertNotNull(users);
		Assert.assertSame(1, users.size());
	}

}
