package com.tandaly.core.db;

import java.sql.Connection;

import com.tandaly.core.druid.DataSourceUtil;
/**
 * DB数据库管理辅助类
 * @author Tandaly
 * @date 2013-7-12 上午10:16:25
 */
public class DBManagerUtil
{
	
	/**
	 * 获取jdbc连接
	 * @return
	 */
	public static Connection fetchDruidConnection()
	{
		Connection conn = null;
		try
		{
			conn = DataSourceUtil.getDataSource(0).getConnection();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		
		return conn;
	}
}
