package com.tanf.base;


import org.junit.After;
import org.junit.Before;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.AfterTransaction;
import org.springframework.test.context.transaction.BeforeTransaction;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "/applicationContext.xml"})
@TransactionConfiguration(defaultRollback = false)
@Transactional(readOnly = true, propagation = Propagation.SUPPORTS)
public class BaseTest {


	//@Resource
	//private InitDB initDB;
	
	@Before
    public void setUp() throws Exception {
		System.out.println("【测试开始】");
    }

    @After
    public void tearDown() throws Exception {
    	System.out.println("【测试结束】");
    }
    
    @BeforeTransaction
    public void beforeTransaction() {
    	System.out.println("【事务开始】");
    }

    @AfterTransaction
    public void afterTransaction() {
    	System.out.println("【事务结束】");
    }
	
}
