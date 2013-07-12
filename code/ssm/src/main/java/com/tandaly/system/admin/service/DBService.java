package com.tandaly.system.admin.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.tandaly.core.db.DBManagerUtil;

/**
 * 数据库业务操作
 * @author Tandaly
 * @date 2013-7-12 上午10:48:28
 */
@Service
public class DBService
{

	/**
	 * select concat(round(sum(data_length/1024/1024),2),'MB') as data_length_MB,  
     concat(round(sum(index_length/1024/1024),2),'MB') as index_length_MB  
     from tables where table_schema='share' and table_name = 't_sys_user';
	 */
	/**
	 * 查询所有的表
	 * @return
	 */
	public List<Map<String, Object>> queryDBTables()
	{
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		Connection conn = DBManagerUtil.fetchJDBCConnection();
		try
		{
			String sql = "SELECT t.* FROM tables t";
			
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(sql);
			
			while (rs.next()) { 
				Map<String, Object> map = new HashMap<String, Object>();
				
				map.put("id", rs.getObject("TABLE_NAME"));//id
				map.put("dbName", rs.getObject("TABLE_SCHEMA"));//库名
				map.put("tableUserName", rs.getObject("TABLE_NAME"));//表所属用户名
				map.put("tableName", rs.getObject("TABLE_NAME"));//表名
				map.put("tableType", rs.getObject("TABLE_TYPE") );//类型（table）
				map.put("remark",rs.getObject("TABLE_NAME"));
				
				list.add(map);
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
		
		return list;
	}
	
	/**
	 * 根据表名查询字段
	 * @return
	 */
	public List<Map<String, Object>> queryDBTableColumnByTableName(String tableName)
	{
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		Connection conn = DBManagerUtil.fetchJDBCConnection();
		try
		{
			Statement st = conn.createStatement();
			
			String sql = "SELECT t.* FROM columns t WHERE t.TABLE_NAME = '" + tableName + "'";
			System.out.println("执行的sql=" + sql);
			ResultSet rs = st.executeQuery(sql);
			
			while (rs.next()) { 
				Map<String, Object> map = new HashMap<String, Object>();
				
				map.put("columnName", rs.getObject("COLUMN_NAME"));//列名
				map.put("tableName", rs.getObject("TABLE_NAME"));//表名
				map.put("columnType", rs.getObject("DATA_TYPE"));//字段类型
				map.put("columnLength", rs.getObject("CHARACTER_MAXIMUM_LENGTH"));//字段长度
				
				list.add(map);
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
		
		return list;
	}
	
	/**
	 * 查询所有的表
	 * @return
	 *//*
	public List<Map<String, Object>> queryDBTables()
	{
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		Connection conn = DBManagerUtil.fetchJDBCConnection();
		try
		{
			DatabaseMetaData meta = conn.getMetaData();
			ResultSet rs = meta.getTables(null, null, null, new String[]{"TABLE"});
			
			while (rs.next()) { 
				Map<String, Object> map = new HashMap<String, Object>();
				
				map.put("id", rs.getObject(3));//id
				map.put("dbName", rs.getObject(1));//库名
				map.put("tableUserName", rs.getObject(2));//表所属用户名
				map.put("tableName", rs.getObject(3));//表名
				map.put("tableType", rs.getObject(4));//类型（table）
				map.put("remark", rs.getObject(5));
				
				list.add(map);
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
		
		return list;
	}*/
	

	/**
	 * 根据表名查询字段
	 * @return
	 *//*
	public List<Map<String, Object>> queryDBTableColumnByTableName(String tableName)
	{
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		Connection conn = DBManagerUtil.fetchJDBCConnection();
		try
		{
			Statement st = conn.createStatement();
			
			String sql = "SELECT * FROM " + tableName;
			ResultSet rs = st.executeQuery(sql);
			ResultSetMetaData rsmd = rs.getMetaData();
			
			int colcount = rsmd.getColumnCount();//取得全部列
			
			for(int i = 1; i <= colcount; i++)
			{
				
				Map<String, Object> map = new HashMap<String, Object>();
				
				map.put("columnName", rsmd.getColumnName(i));//列名
				map.put("tableName", rsmd.getTableName(i));//表名
				map.put("columnType", rsmd.getColumnTypeName(i));//字段类型
				map.put("columnLength", rsmd.getColumnDisplaySize(i));//字段长度
				
				list.add(map);
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
		
		return list;
	}*/
}
