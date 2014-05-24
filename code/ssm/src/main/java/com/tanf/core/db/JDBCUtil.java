package com.tanf.core.db;

import java.sql.Connection;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.tanf.core.spring.SpringFactory;
/**
 * JDBC辅助类
 * @author tanf
 * @date 2013-7-12 上午10:16:25
 */
public class JDBCUtil
{

	/**
	 * 获取jdbc连接
	 * @return
	 */
	public static Connection fetchSystemConnection()
	{
		SqlSessionFactory sqlSessionFactory = SpringFactory.getBean("sqlSessionFactory");
		SqlSession session = sqlSessionFactory.openSession();
		Connection conn = session.getConnection();
		
		return conn;
	}
}
