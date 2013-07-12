package com.tandaly.core.db;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
/**
 * DB数据库管理辅助类
 * @author Tandaly
 * @date 2013-7-12 上午10:16:25
 */
public class DBManagerUtil
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
