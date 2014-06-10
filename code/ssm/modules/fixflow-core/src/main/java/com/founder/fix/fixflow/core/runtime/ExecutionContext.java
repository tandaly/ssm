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
package com.founder.fix.fixflow.core.runtime;



import java.util.List;

import org.eclipse.bpmn2.BaseElement;
import org.eclipse.bpmn2.FlowNode;
import org.eclipse.bpmn2.SequenceFlow;


import com.founder.fix.bpmn2extensions.fixflow.SkipStrategy;
import com.founder.fix.fixflow.core.context.ContextInstance;
import com.founder.fix.fixflow.core.event.BaseElementEvent;
import com.founder.fix.fixflow.core.impl.bpmn.behavior.ProcessDefinitionBehavior;
import com.founder.fix.fixflow.core.impl.connector.ConnectorInstanceBehavior;
import com.founder.fix.fixflow.core.impl.db.SqlCommand;
import com.founder.fix.fixflow.core.impl.identity.UserTo;
import com.founder.fix.fixflow.core.impl.runtime.ProcessInstanceEntity;
import com.founder.fix.fixflow.core.impl.runtime.TokenEntity;
import com.founder.fix.fixflow.core.task.TaskDefinition;
import com.founder.fix.fixflow.core.task.TaskInstance;
import com.founder.fix.fixflow.core.task.TaskMgmtInstance;

public interface ExecutionContext {
	
	
	TokenEntity getToken();
	
	SequenceFlow getSequenceFlow();
	
	void setSequenceFlow(SequenceFlow sequenceFlow);
	
	FlowNode getSequenceFlowSource();
	
	void setSequenceFlowSource(FlowNode flowNode);
	
	TaskDefinition getTaskDefinition();
	
	void setTaskDefinition(TaskDefinition taskDefinition);
	
	TaskInstance getTaskInstance();
	
	void setTaskInstance(TaskInstance taskInstance);
	
	FlowNode getTimeOutNode();

	void setTimeOutNode(FlowNode timeOutNode);

	/**
	 * 清理内容执行器临时数据
	 */
	void clearExecutionContextData();
	
	TaskMgmtInstance getTaskMgmtInstance();
	
	ProcessDefinitionBehavior getProcessDefinition();
	
	ProcessInstanceEntity getProcessInstance();
	
	ContextInstance getContextInstance();
	
	String getRollBackAssignee();
	
	void setRollBackAssignee(String rollBackAssignee);
	//表达式专用
	
	String getInitiator();
	
	String getBizKey();
	
	
	String getUserCommand();

	void setSubProcessInstance(ProcessInstance subProcessInstance);
	
	ProcessInstance getSubProcessInstance();

	void setEventSource(BaseElement eventSource);

	BaseElement getEventSource();

	BaseElementEvent getBaseElementEvent();

	void setBaseElementEvent(BaseElementEvent baseElementEvent);
	
	ConnectorInstanceBehavior getConnector();

	void setConnector(ConnectorInstanceBehavior connector);
	
	
	SqlCommand getSqlCommand();

	
	 Object selectOneObject(String sqlText);
	 
	String getStartAuthor();
	
	UserTo findUserInfoByUserId(String userId);
	
	String getGroupID();

	void setGroupID(String groupID);
	
	
	List<String> findUserDeptAndRole(String deptId,String roleId);
	
	String getProcessDefinitionKey();
	
	
	String getCallActivityInstanceId();
	
	void setCallActivityInstanceId(String callActivityInstanceId);
	
	/**
	 * 获取强制指定令牌将要去的节点
	 * @return
	 */
	FlowNode getToFlowNode();

	/**
	 * 强制指定令牌将要去的节点
	 * @param toFlowNode 节点对象
	 */
	void setToFlowNode(FlowNode toFlowNode);
	
	
	SkipStrategy getSkipStrategy();
	
	void setSkipStrategy(SkipStrategy skipStrategy);
	
	/**
	 * 获取上一步任务
	 * @return 如果上一步是会签则返回多个任务,否则则是一个。
	 */
	List<TaskInstance> getPreviousAssignee();
	
}
