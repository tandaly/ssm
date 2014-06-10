/**
 * Copyright 1996-2013 Founder International Co.,Ltd.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * 
 * @author kenshin
 */
package com.founder.fix.fixflow.core.impl.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.founder.fix.fixflow.core.exception.FixFlowException;
import com.founder.fix.fixflow.core.impl.log.LogFactory;

public class SqlCommand {
	
	 private static com.founder.fix.fixflow.core.impl.log.DebugLog debugLog = LogFactory.getDebugLog(SqlCommand.class);

	Connection conn;

	public SqlCommand(Connection conn) {
		this.conn = conn;
	}

	/**
	 * 取得原始连接
	 * 
	 * @return
	 */
	public Connection getConnect() {
		return conn;
	}

	/**
	 * 取得查询的单值
	 * 
	 * @param sql
	 * @param data
	 * @return
	 * @throws DAOException
	 */
	public Object queryForValue(String sql, List<Object> data) throws FixFlowException {
		String resultStr = new String();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			pstmt = conn.prepareStatement(sql);
			debugLog.debug("FixFlow引擎数据持久化语句: " +sql); 
			debugLog.debug("参数: " +data); 
			if (null != data && data.size() > 0) {
				for (int i = 0; i < data.size(); i++) {
					data.set(i, transformSqlType(data.get(i)));
					pstmt.setObject(i + 1, data.get(i));
				}
			}
			rs = pstmt.executeQuery();
			if (rs.next()) {

				resultStr = rs.getString(1);

			}
		} catch (SQLException e) {
			throw new FixFlowException("查询错误：" + e.getMessage(), e);
		}
		finally
		{
			try {
				pstmt.close();
				if(rs != null){
				rs.close();}
			} catch (SQLException e) {
				throw new FixFlowException("关闭游标失败",e);
			}
		}
		return resultStr;
	}

	/**
	 * 取得查询的单值
	 * 
	 * @param sql
	 * @return
	 * @throws DAOException
	 */
	public Object queryForValue(String sql) throws FixFlowException {
		return queryForValue(sql, null);
	}

	/**
	 * 以Map对象形式获取返回一个查询结果
	 * 
	 * @param sql
	 * @param data
	 * @return Map<String, Object> 结果集
	 * @throws DAOException
	 */
	public Map<String, Object> queryForMap(String sql, Object[] data) throws FixFlowException {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		ResultSet rs = null;
		PreparedStatement pstmt=null;
		try {
			pstmt = conn.prepareStatement(sql);
			debugLog.debug("FixFlow引擎数据持久化语句: " +sql); 
			debugLog.debug("参数: " +sql); 
			if (null != data && data.length > 0) {
				for (int i = 0; i < data.length; i++) {
					data[i] = transformSqlType(data[i]);

					if (data[i] == null) {
						pstmt.setNull(i + 1, Types.VARCHAR);
					} else {
						pstmt.setObject(i + 1, data[i]);
					}

					pstmt.setObject(i + 1, data[i]);
				}
			}
			rs = pstmt.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData();
			
			if (rs.next()) {

				for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					if (rsmd.getColumnType(i) == 93) {
						if (rs.getTimestamp(i) != null) {
							resultMap.put(rsmd.getColumnLabel(i), new Date(rs.getTimestamp(i).getTime()));
						}

					} else {
						if (rsmd.getColumnType(i) == 2004) {
							resultMap.put(rsmd.getColumnLabel(i), rs.getBytes(i));

						} else {
							resultMap.put(rsmd.getColumnLabel(i), rs.getObject(i));
						}
				
					}
				}
			}
		} catch (SQLException e) {
			throw new FixFlowException("查询错误：" + e.getMessage(), e);
		}
		
		finally
		{
			try {
				pstmt.close();
				if(rs != null){
				rs.close();}
			} catch (SQLException e) {
				throw new FixFlowException("关闭游标失败",e);
			}
		}
		return resultMap;
	}

	/**
	 * 以Map对象形式获取返回一个查询结果
	 * 
	 * @param sql
	 * @return Map<String, Object> 结果集
	 * @throws DAOException
	 */
	public Map<String, Object> queryForMap(String sql) throws FixFlowException {
		return queryForMap(sql, null);
	}

	/*
	 * public List<Map<String, Object>> queryForList(String sql, Object[] data)
	 * throws FixFlowException { List<Map<String, Object>> resultList = new
	 * ArrayList<Map<String, Object>>(); try { PreparedStatement pstmt =
	 * conn.prepareStatement(sql); if(null != data && data.length > 0) { for(int
	 * i = 0; i < data.length; i++) { data[i]=transformSqlType(data[i]);
	 * pstmt.setObject(i+1, data[i]); } } ResultSet rs = pstmt.executeQuery();
	 * ResultSetMetaData rsmd = rs.getMetaData(); while(rs.next()) { Map<String,
	 * Object> row = new HashMap<String, Object>(); for(int i = 1; i <=
	 * rsmd.getColumnCount(); i++) { row.put(rsmd.getColumnLabel(i),
	 * rs.getObject(i)); } resultList.add(row); } } catch (SQLException e) {
	 * throw new FixFlowException("查询错误："+e.getMessage(),e); } return
	 * resultList; }
	 */

	/**
	 * 以List对象形式返回查询一组结果
	 * 
	 * @param sql
	 * @param data
	 * @return List<Map<String, Object>> 结果集
	 * @throws DAOException
	 */
	public List<Map<String, Object>> queryForList(String sql, List<Object> data) throws FixFlowException {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
		ResultSet rs = null;
		PreparedStatement pstmt=null;
		try {
			pstmt = conn.prepareStatement(sql);
			debugLog.debug("FixFlow引擎数据持久化语句: " +sql);
			debugLog.debug("参数："+data);
			if (null != data && data.size() > 0) {
				for (int i = 0; i < data.size(); i++) {

					Object returnObj = transformSqlType(data.get(i));
					if (returnObj == null) {
						pstmt.setNull(i + 1, Types.VARCHAR);
					} else {
						data.set(i, returnObj);
						pstmt.setObject(i + 1, data.get(i));
					}

				}
			}
			rs = pstmt.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData();
			while (rs.next()) {
				Map<String, Object> row = new HashMap<String, Object>();
				for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					if (rsmd.getColumnType(i) == 93) {
						if (rs.getTimestamp(i) != null) {
							row.put(rsmd.getColumnLabel(i), new Date(rs.getTimestamp(i).getTime()));
						}

					} else {
						if (rsmd.getColumnType(i) == 2004) {
							row.put(rsmd.getColumnLabel(i), rs.getBytes(i));

						} else {
							row.put(rsmd.getColumnLabel(i), rs.getObject(i));
						}
					}

				}
				resultList.add(row);
			}
		} catch (SQLException e) {
			throw new FixFlowException("查询错误：" + e.getMessage(), e);
		}
		finally
		{
			try {
				pstmt.close();
				if(rs != null){
					rs.close();
				}
			} catch (SQLException e) {
				throw new FixFlowException("关闭游标失败",e);
			}
		}
		return resultList;
	}

	/**
	 * 以List对象形式返回查询一组结果
	 * 
	 * @param sql
	 * @return List<Map<String, Object>> 结果集
	 * @throws DAOException
	 */
	public List<Map<String, Object>> queryForList(String sql) throws FixFlowException {
		return queryForList(sql, null);
	}

	/**
	 * 执行查询
	 * 
	 * @param sql
	 * @throws DAOException
	 */
	public void execute(String sql) throws FixFlowException {
		Statement stmt=null;
		try {
			stmt = conn.createStatement();
			debugLog.debug("FixFlow引擎数据持久化语句: " +sql);
			stmt.execute(sql);
			 
			
		} catch (SQLException e) {
			throw new FixFlowException("查询错误：" + e.getMessage(), e);
		}
		finally
		{
			try {
				stmt.close();
			} catch (SQLException e) {
				throw new FixFlowException("关闭游标失败",e);
			}
		}
	}

	/**
	 * 执行查询
	 * 
	 * @param sql
	 * @param data
	 * @throws DAOException
	 */
	public void execute(String sql, Object[] data) throws FixFlowException {
		PreparedStatement pstmt=null;
		try {
			pstmt = conn.prepareStatement(sql);
			debugLog.debug("FixFlow引擎数据持久化语句: " +sql); 
			debugLog.debug("参数: "+ Arrays.asList(data));
			if (null != data && data.length > 0) {
				for (int i = 0; i < data.length; i++) {
					data[i] = transformSqlType(data[i]);

					Object returnObj = data[i];
					if (returnObj == null) {
						pstmt.setNull(i + 1, Types.VARCHAR);
					} else {
						pstmt.setObject(i + 1, returnObj);
					}

				}
			}
			pstmt.execute();
		} catch (SQLException e) {
			throw new FixFlowException("查询错误：" + e.getMessage(), e);
		}
		finally
		{
			try {
				pstmt.close();
			} catch (SQLException e) {
				throw new FixFlowException("关闭游标失败",e);
			}
		}
		
	}

	/**
	 * 执行查询
	 * 
	 * @param sql
	 * @throws DAOException
	 */
	public ResultSet query(String sql) throws FixFlowException {
		ResultSet result = null;
		Statement stmt=null;
		try {
			stmt = conn.createStatement();
			debugLog.debug("FixFlow引擎数据持久化语句: " +sql); 
			result = stmt.executeQuery(sql);
			
		} catch (SQLException e) {
			throw new FixFlowException("查询错误：" + e.getMessage(), e);
		}
		finally
		{
			try {
				stmt.close();
				if(result != null){
				result.close();}
			} catch (SQLException e) {
				throw new FixFlowException("关闭游标失败",e);
			}
		}
		return result;
	}

	/**
	 * 执行查询
	 * 
	 * @param sql
	 * @param data
	 * @throws DAOException
	 */
	public ResultSet query(String sql, Object[] data) throws FixFlowException {
		ResultSet result = null;
		PreparedStatement pstmt=null;
		try {
			pstmt = conn.prepareStatement(sql);
			debugLog.debug("FixFlow引擎数据持久化语句: " +sql); 
			debugLog.debug("参数: "+ Arrays.asList(data));
			if (null != data && data.length > 0) {
				for (int i = 0; i < data.length; i++) {

					data[i] = transformSqlType(data[i]);
					Object returnObj = data[i];
					if (returnObj == null) {
						pstmt.setNull(i + 1, Types.VARCHAR);
					} else {
						pstmt.setObject(i + 1, returnObj);
					}

				}
			}
			result = pstmt.executeQuery(sql);
		} catch (SQLException e) {
			throw new FixFlowException("查询错误：" + e.getMessage(), e);
		}
		finally
		{
			try {
				pstmt.close();
				if(result!=null){
				result.close();}
			} catch (SQLException e) {
				throw new FixFlowException("关闭游标失败",e);
			}
		}
		return result;
	}

	/**
	 * 将Map对象插入到数据表中
	 * 
	 * @param tableName 要插入的数据表的名称
	 * @param data 数据对象
	 * @return 影响行数
	 * @throws DAOException
	 */
	public Integer insert(String tableName, Map<String, Object> data) throws FixFlowException {
		
		
		if (data.size() < 1) {
			throw new FixFlowException("插入错误: 无效的数据输入");
		}
		/* 构造插入查询语句 */
		StringBuffer querySql = new StringBuffer("INSERT INTO ");
		querySql.append(tableName);
		querySql.append(" ( ");

		Set<String> keys = data.keySet();
		for (Object key : keys.toArray()) {
			querySql.append((String) key);
			querySql.append(" , ");
		}

		querySql = new StringBuffer(querySql.substring(0, querySql.lastIndexOf(",")));
		querySql.append(" ) VALUES ( ");
		for (int i = 0; i < data.size(); i++) {
			querySql.append(" ? ,");
		}

		querySql = new StringBuffer(querySql.substring(0, querySql.lastIndexOf(",")));
		querySql.append(" )");
		/* 构造插入查询语句 完成 */

		Integer affectRow = 0;
		PreparedStatement pstmt=null;
		try {
			debugLog.debug("FixFlow引擎数据持久化语句: " +querySql.toString());
			debugLog.debug("参数: "+ data);
			pstmt = conn.prepareStatement(querySql.toString());
			
			Object[] keyArray = keys.toArray();
			for (int i = 0; i < keyArray.length; i++) {

				Object returnObj = transformSqlType(data.get((String) keyArray[i]));
				if (returnObj == null) {
					pstmt.setNull(i + 1, Types.VARCHAR);
				} else {
					pstmt.setObject(i + 1, returnObj);
				}

			}
			 
			affectRow = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new FixFlowException("查询错误：" + e.getMessage(), e);
		}
		finally
		{
			try {
				pstmt.close();
			} catch (SQLException e) {
				throw new FixFlowException("关闭游标失败",e);
			}
		}
		
		return affectRow;
	}

	/**
	 * 将Map对象更新到数据库中
	 * 
	 * @param tableName 要更新的数据表
	 * @param data 要更新的数据对象
	 * @param sql Where查询条件子句
	 * @return 影响行数
	 * @throws DAOException
	 */
	public Integer update(String tableName, Map<String, Object> data, String sql, Object[] sdata) throws FixFlowException {
		if (data.size() < 1) {
			throw new FixFlowException("插入错误: 无效的数据输入");
		}

		/* 构造插入查询语句 */
		StringBuffer querySql = new StringBuffer("UPDATE ");
		querySql.append(tableName);
		querySql.append(" SET ");
		Set<String> keys = data.keySet();
		for (Object key : keys.toArray()) {
			querySql.append((String) key);
			querySql.append(" = ? , ");
		}
		querySql = new StringBuffer(querySql.substring(0, querySql.lastIndexOf(",")));
		if (null != sql) {
			querySql.append(" WHERE ");
			querySql.append(sql);
		}
		/* 构造插入查询语句 */
		PreparedStatement pstmt=null;
		Integer affectRow = 0;
		try {
			debugLog.debug("FixFlow引擎数据持久化语句: " +querySql.toString());
			debugLog.debug("参数data: "+ data);
			debugLog.debug("参数sdata: "+ Arrays.asList(sdata));
			pstmt = conn.prepareStatement(querySql.toString());
			Object[] keyArray = keys.toArray();
			int j = 1;
			for (int i = 0; i < keyArray.length; i++) {

				Object returnObj = transformSqlType(data.get((String) keyArray[i]));
				if (returnObj == null) {
					pstmt.setNull(j++, Types.VARCHAR);
				} else {
					pstmt.setObject(j++, returnObj);
				}

			}
			if (null != sdata && sdata.length > 0) {
				for (int i = 0; i < sdata.length; i++) {

					Object returnObj = transformSqlType(sdata[i]);
					if (returnObj == null) {
						pstmt.setNull(j++, Types.VARCHAR);
					} else {
						pstmt.setObject(j++, returnObj);
					}

				}
			}
			affectRow = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new FixFlowException("查询错误：" + e.getMessage(), e);
		}
		finally
		{
			try {
				pstmt.close();
			} catch (SQLException e) {
				throw new FixFlowException("关闭游标失败",e);
			}
		}
		return affectRow;
	}

	/**
	 * 将Map对象更新到数据库中
	 * 
	 * @param tableName 要更新的数据表
	 * @param data 要更新的数据对象
	 * @return 影响行数
	 * @throws DAOException
	 */
	public Integer update(String tableName, Map<String, Object> data, String sql) throws FixFlowException {
		return update(tableName, data, sql, null);
	}

	/**
	 * 将Map对象更新到数据库中
	 * 
	 * @param tableName 要更新的数据表
	 * @param data 要更新的数据对象
	 * @return 影响行数
	 * @throws DAOException
	 */
	public Integer update(String tableName, Map<String, Object> data) throws FixFlowException {
		return update(tableName, data, null, null);
	}

	/**
	 * 删除记录
	 * 
	 * @param tableName 表名
	 * @param sql WHERE查询子句
	 * @param data 数据对象
	 * @return
	 * @throws DAOException
	 */
	public Integer delete(String tableName, String sql, Object[] data) throws FixFlowException {
		StringBuffer querySql = new StringBuffer("DELETE FROM ");
		querySql.append(tableName);
		if (null != sql) {
			querySql.append(" WHERE ");
			querySql.append(sql);
		}
		Integer affectRow = 0;
		PreparedStatement pstmt=null;
		try {
			debugLog.debug("FixFlow引擎数据持久化语句: " +querySql.toString());
			debugLog.debug("参数: "+ Arrays.asList(data));
			pstmt = conn.prepareStatement(querySql.toString());
			if (data != null) {
				for (int i = 0; i < data.length; i++) {

					Object returnObj = transformSqlType(data[i]);
					if (returnObj == null) {
						pstmt.setNull(i + 1, Types.VARCHAR);
					} else {
						pstmt.setObject(i + 1, returnObj);
					}

				}
			}
			affectRow = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new FixFlowException("查询错误：" + e.getMessage(), e);
		}
		finally
		{
			try {
				pstmt.close();
			} catch (SQLException e) {
				throw new FixFlowException("关闭游标失败",e);
			}
		}
		return affectRow;
	}

	/**
	 * 删除记录
	 * 
	 * @param tableName 表名
	 * @param sql WHERE查询子句
	 * @return
	 * @throws DAOException
	 */
	public Integer delete(String tableName, String sql) throws FixFlowException {
		return delete(tableName, sql, null);
	}

	/**
	 * 清空表
	 * 
	 * @param tableName 表名
	 * @return
	 * @throws DAOException
	 */
	public Integer delete(String tableName) throws FixFlowException {
		return delete(tableName, null, null);
	}

	/**
	 * 设置事务级别
	 * 
	 * @param level
	 * @throws DAOException
	 */
	public void startTransaction(Integer level) throws FixFlowException {
		try {
			conn.setTransactionIsolation(level);
		} catch (SQLException e) {
			throw new FixFlowException("事务错误：" + e.getMessage(), e);
		}
	}

	/**
	 * 提交事务
	 * 
	 * @throws DAOException
	 */
	public void commit() throws FixFlowException {
		try {
			conn.commit();
		} catch (SQLException e) {
			throw new FixFlowException("事务错误：" + e.getMessage(), e);
		}
	}

	/**
	 * 回滚事务
	 * 
	 * @throws DAOException
	 */
	public void rollback() throws FixFlowException {
		try {
			conn.rollback();
		} catch (SQLException e) {
			throw new FixFlowException("事务错误：" + e.getMessage(), e);
		}
	}

	/**
	 * 将Java类型转换为数据库能接受的Sql类型
	 * 
	 * @param object 数据对象
	 * @return
	 */
	private Object transformSqlType(Object object) {

		if (object == null) {
			return null;
		}

		if (object instanceof java.util.Date) {

			object = new java.sql.Timestamp(((java.util.Date) object).getTime());

		}

		return object;
	}

}
