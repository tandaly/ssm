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
 * @author yangchenhui
 */
package com.founder.fix.fixflow.expand.database;

import com.founder.fix.bpmn2extensions.sqlmappingconfig.Column;
import com.founder.fix.bpmn2extensions.sqlmappingconfig.DataBaseTable;
import com.founder.fix.fixflow.core.ProcessEngineManagement;
import com.founder.fix.fixflow.core.exception.FixFlowException;
import com.founder.fix.fixflow.core.impl.ProcessEngineConfigurationImpl;
import com.founder.fix.fixflow.core.impl.util.StringUtil;
import com.founder.fix.fixflow.core.runtime.QueryLocation;

/**
 * 查询query中数据来源工具类，用来处理归档表 运行表之间的关系
 * @author yangchenhui
 *
 */
public class TableUtil {
	
	
	private final static String RUN_PROCESSINSTANCE_TABLE_ID="fixflow_run_processinstance";
	private final static String RUN_TOKEN_TABLE_ID="fixflow_run_token";
	private final static String RUN_TASKINSTANCE_TABLE_ID="fixflow_run_taskinstance";
	private final static String RUN_TASKIDENTITYLINK_TABLE_ID="fixflow_run_taskidentitylink";
	private final static String RUN_VARIABLE_TABLE_ID="fixflow_run_variable";

	
	/**
	 * 获取流程实例运行表名
	 * @return
	 */
	public static String getProcessInstanceRunTableName(){
		return getDefaultTableName(RUN_PROCESSINSTANCE_TABLE_ID);
	}
	
	/**
	 * 获取令牌运行表名
	 * @return
	 */
	public static String getTokenRunTableName(){
		return getDefaultTableName(RUN_TOKEN_TABLE_ID);
	}
	
	/**
	 * 获取任务实例运行表名
	 * @return
	 */
	public static String getTaskInstanceRunTableName(){
		return getDefaultTableName(RUN_TASKINSTANCE_TABLE_ID);
	}
	
	/**
	 * 获取任务候选人运行表名
	 * @return
	 */
	public static String getTaskTdentityLinkRunTableName(){
		return getDefaultTableName(RUN_TASKIDENTITYLINK_TABLE_ID);
	}
	
	/**
	 * 获取变量运行表名
	 * @return
	 */
	public static String getVariableRunTableName(){
		return getDefaultTableName(RUN_VARIABLE_TABLE_ID);
	}
	
	//   历史表 //////////////////////
	
	/**
	 * 获取流程实例历史表名
	 * @return
	 */
	public static String getProcessInstanceHisTableName(){
		return getArchiveTableName(RUN_PROCESSINSTANCE_TABLE_ID);
	}
	
	/**
	 * 获取令牌历史表名
	 * @return
	 */
	public static String getTokenHisTableName(){
		return getArchiveTableName(RUN_TOKEN_TABLE_ID);
	}
	
	/**
	 * 获取任务实例历史表名
	 * @return
	 */
	public static String getTaskInstanceHisTableName(){
		return getArchiveTableName(RUN_TASKINSTANCE_TABLE_ID);
	}
	
	/**
	 * 获取任务候选人历史表名
	 * @return
	 */
	public static String getTaskTdentityLinkHisTableName(){
		return getArchiveTableName(RUN_TASKIDENTITYLINK_TABLE_ID);
	}
	
	/**
	 * 获取变量历史表名
	 * @return
	 */
	public static String getVariableHisTableName(){
		return getArchiveTableName(RUN_VARIABLE_TABLE_ID);
	}
	
	
	/**
	 * 获取查询查询表名，run his run_his
	 * @param tableId
	 * @param queryLocation
	 * @return
	 */
	public static String getTableSelect(String tableId,QueryLocation queryLocation){
		ProcessEngineConfigurationImpl processEngineConfigurationImpl = ProcessEngineManagement.getDefaultProcessEngine().getProcessEngineConfiguration();
		DataBaseTable dataBaseTable = processEngineConfigurationImpl.getDataBaseTable(tableId);
		if(dataBaseTable == null){
			throw new FixFlowException("未找到id为"+tableId+"的table配置");
		}
		if(!StringUtil.getBoolean(processEngineConfigurationImpl.getPigeonholeConfig().getIsEnable())){
			return dataBaseTable.getTableValue();
		}
		String tableName = "";
		if(QueryLocation.HIS.equals(queryLocation)){
			tableName =  dataBaseTable.getArchiveTable();
		}else if(QueryLocation.RUN_HIS.equals(queryLocation)){
			StringBuilder sbColumn = new StringBuilder();
			for(Column column :dataBaseTable.getColumn()){
				sbColumn.append(column.getColumn());
				sbColumn.append(",");
			}
			String columnString = sbColumn.toString().substring(0,sbColumn.toString().length()-1);
			tableName = dataBaseTable.getTableValue();
			String hisTableName = dataBaseTable.getArchiveTable();
			
			tableName = "(select "+columnString+" from "+tableName+" union all select "+columnString+" from "+hisTableName+")";
		}else{
			tableName = dataBaseTable.getTableValue();
		}
		return tableName;
	}
	
	/**
	 * 获取默认run表名
	 * @param tableId
	 * @return
	 */
	public static String getDefaultTableName(String tableId){
		ProcessEngineConfigurationImpl processEngineConfigurationImpl = ProcessEngineManagement.getDefaultProcessEngine().getProcessEngineConfiguration();
		DataBaseTable dataBaseTable = processEngineConfigurationImpl.getDataBaseTable(tableId);
		if(dataBaseTable == null){
			throw new FixFlowException("未找到id为"+tableId+"的table配置");
		}
		return dataBaseTable.getTableValue();
	}
	
	/**
	 * 获取默认his表名
	 * @param tableId
	 * @return
	 */
	public static String getArchiveTableName(String tableId){
		ProcessEngineConfigurationImpl processEngineConfigurationImpl = ProcessEngineManagement.getDefaultProcessEngine().getProcessEngineConfiguration();
		DataBaseTable dataBaseTable = processEngineConfigurationImpl.getDataBaseTable(tableId);
		if(dataBaseTable == null){
			throw new FixFlowException("未找到id为"+tableId+"的table配置");
		}
		return dataBaseTable.getArchiveTable();
	}
	
	
	/**
	 * 获取配置的列信息，有序，且逗号分开，用户select或insert的字段字符串
	 * @param tableId
	 * @return
	 */
	public static String getColumnString(String tableId){
		ProcessEngineConfigurationImpl processEngineConfigurationImpl = ProcessEngineManagement.getDefaultProcessEngine().getProcessEngineConfiguration();
		DataBaseTable dataBaseTable = processEngineConfigurationImpl.getDataBaseTable(tableId);
		if(dataBaseTable == null){
			throw new FixFlowException("未找到id为"+tableId+"的table配置");
		}
		return getColumnString(dataBaseTable);
	}
	
	/**
	 * 获取配置的列信息，有序，且逗号分开，用户select或insert的字段字符串
	 * @param dataBaseTable
	 * @return
	 */
	public static String getColumnString(DataBaseTable dataBaseTable){
		StringBuilder sbColumn = new StringBuilder();
		for(Column column :dataBaseTable.getColumn()){
			sbColumn.append(column.getColumn());
			sbColumn.append(",");
		}
		String columnString = sbColumn.toString().substring(0,sbColumn.toString().length()-1);
		return columnString;
	}
	
	public static String getColumnStringWithOutArchiveTime(String tableId){
		ProcessEngineConfigurationImpl processEngineConfigurationImpl = ProcessEngineManagement.getDefaultProcessEngine().getProcessEngineConfiguration();
		DataBaseTable dataBaseTable = processEngineConfigurationImpl.getDataBaseTable(tableId);
		if(dataBaseTable == null){
			throw new FixFlowException("未找到id为"+tableId+"的table配置");
		}
		StringBuilder sbColumn = new StringBuilder();
		for(Column column :dataBaseTable.getColumn()){
			if(!column.getColumn().equals("ARCHIVE_TIME")){
				sbColumn.append(column.getColumn());
				sbColumn.append(",");
			}
		}
		String columnString = sbColumn.toString().substring(0,sbColumn.toString().length()-1);
		return columnString;
	}
}
