package com.tandaly.service;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.tandaly.base.BaseTest;
import com.tandaly.system.admin.service.MenuService;

public class MenuServiceTest extends BaseTest{
	
	Logger log = Logger.getLogger(MenuServiceTest.class);
	
	@Autowired
	MenuService menuService;
	
	@Test
	public void testDmenu() {
//		Integer id = 35;
//		StringBuffer ids = new StringBuffer();
//		this.menuService.dmenu(id, ids);
//		
//		log.info(ids);
	}

}
