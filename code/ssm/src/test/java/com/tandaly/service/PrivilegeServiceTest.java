package com.tandaly.service;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.tandaly.base.BaseTest;
import com.tandaly.core.page.Pagination;
import com.tandaly.system.admin.beans.Privilege;
import com.tandaly.system.admin.service.PrivilegeService;

public class PrivilegeServiceTest extends BaseTest
{

	@Autowired
	PrivilegeService privilegeService;
	
	@Test
	public void testPage()
	{
		Privilege p = new Privilege();
		p.setPrivilegeName("系统权限");
		Pagination pagination = new Pagination(p, 1, 10);
		this.privilegeService.pageQueryEntityList(pagination);
		
		Assert.assertNotNull(pagination);
		Assert.assertNotNull(pagination.getList());
		Assert.assertSame(1, pagination.getList().size());
	}

}
