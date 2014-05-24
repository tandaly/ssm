package com.tanf.core.db;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

/**
 * mybatis数据库辅助类
 * @author tanf
 * @date 2013-7-16 下午2:37:59
 */
public class MybatisDBUtil
{
	private static SqlSessionFactory sqlSessionFactory = init();
	
	public static SqlSessionFactory init() 
	{
		String resource = "mybatis-config-db.xml";
		InputStream inputStream = null;
		try
		{
			inputStream = Resources.getResourceAsStream(resource);
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return new SqlSessionFactoryBuilder().build(inputStream);
	}
	
	/**
	 * 获取jdbc连接
	 * @return
	 */
	public static Connection fetchJDBCConnection()
	{
		if(null == sqlSessionFactory)
		{
			sqlSessionFactory = init();
		}
		//SqlSessionFactory sqlSessionFactory = SpringFactory.getBean("sqlSessionFactory2");
		SqlSession session = sqlSessionFactory.openSession();
		Connection conn = session.getConnection();
		
		return conn;
	}
}
