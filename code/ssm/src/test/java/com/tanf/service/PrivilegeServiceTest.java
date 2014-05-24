package com.tanf.service;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.tanf.base.BaseTest;
import com.tanf.core.page.Pagination;
import com.tanf.system.admin.beans.Privilege;
import com.tanf.system.admin.service.PrivilegeService;

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
