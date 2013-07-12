package com.tandaly.dao;

import static org.junit.Assert.assertNotNull;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;

import org.junit.Test;

import com.tandaly.base.BaseTest;
import com.tandaly.core.db.JDBCUtil;

public class JDBCTest extends BaseTest
{

	@Test
	public void testFecthDBTables()
	{
		Connection conn = JDBCUtil.fetchJDBCConnection();
		
		assertNotNull(conn);
		
		try
		{
			DatabaseMetaData meta = conn.getMetaData();
			ResultSet rs = meta.getTables(null, null, null, new String[]{"TABLE"});
			
			while (rs.next()) {  
				System.out.println(rs.getObject(1));//库名
				System.out.println(rs.getObject(4));//类型 (table)
				System.out.println(rs.getObject(5));
			     System.out.println("表名：" + rs.getString(3));  
			     System.out.println("表所属用户名：" + rs.getString(2));  
			     System.out.println("------------------------------");  
			} 
			
		} catch (SQLException e)
		{
			e.printStackTrace();
		} finally 
		{
			try
			{
				conn.close();
			} catch (SQLException e)
			{
				e.printStackTrace();
			}  
		}
	}
	
	@Test
	public void testFecthTableColumns()
	{
		Connection conn = JDBCUtil.fetchJDBCConnection();
		assertNotNull(conn);
		
		try
		{
			Statement st = conn.createStatement();
			
			String sql = "SELECT * FROM t_sys_menu";
			ResultSet rs = st.executeQuery(sql);
			ResultSetMetaData rsmd = rs.getMetaData();
			
			int colcount = rsmd.getColumnCount();//取得全部列
			
			for(int i = 1; i <= colcount; i++)
			{
				String colname = rsmd.getColumnName(i);//取得全部列名
				
				System.out.println(colname + " " + rsmd.getTableName(i)
						+ " " +  rsmd.getColumnTypeName(i)
						+ " " + rsmd.getColumnDisplaySize(i) + " " + rsmd.getColumnClassName(i));
			}
			
		} catch (SQLException e)
		{
			e.printStackTrace();
		} finally 
		{
			try
			{
				conn.close();
			} catch (SQLException e)
			{
				e.printStackTrace();
			}  
		}
	}

}
