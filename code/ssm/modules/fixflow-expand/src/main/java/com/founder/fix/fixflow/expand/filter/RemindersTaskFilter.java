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
package com.founder.fix.fixflow.expand.filter;

import java.util.List;

import com.founder.fix.fixflow.core.ProcessEngine;
import com.founder.fix.fixflow.core.ProcessEngineManagement;
import com.founder.fix.fixflow.core.exception.FixFlowException;
import com.founder.fix.fixflow.core.factory.ProcessObjectFactory;
import com.founder.fix.fixflow.core.impl.Context;
import com.founder.fix.fixflow.core.impl.bpmn.behavior.ProcessDefinitionBehavior;
import com.founder.fix.fixflow.core.impl.bpmn.behavior.TaskCommandInst;
import com.founder.fix.fixflow.core.impl.expression.ExpressionMgmt;
import com.founder.fix.fixflow.core.impl.filter.AbstractCommandFilter;
import com.founder.fix.fixflow.core.impl.identity.Authentication;
import com.founder.fix.fixflow.core.impl.persistence.ProcessDefinitionManager;
import com.founder.fix.fixflow.core.impl.persistence.ProcessInstanceManager;
import com.founder.fix.fixflow.core.impl.runtime.ProcessInstanceEntity;
import com.founder.fix.fixflow.core.impl.runtime.TokenEntity;
import com.founder.fix.fixflow.core.impl.util.StringUtil;
import com.founder.fix.fixflow.core.runtime.ExecutionContext;
import com.founder.fix.fixflow.core.task.TaskInstance;
import com.founder.fix.fixflow.core.task.TaskQuery;

public class RemindersTaskFilter extends AbstractCommandFilter {

	@Override
	public boolean accept(TaskInstance taskInstance) {

		if (taskInstance == null) {
			return false;
		}

		if (taskInstance.isSuspended()) {
			return false;
		}

		if (taskInstance.hasEnded()) {
			return false;
		}

		if (taskInstance.getDelegationState() != null) {
			return false;
		}

		if (isProcessTracking()) {

			TaskCommandInst taskCommandInst = getTaskCommandInst();

			ProcessEngine processEngine = ProcessEngineManagement.getDefaultProcessEngine();
			TaskQuery taskQuery = processEngine.getTaskService().createTaskQuery();
			List<TaskInstance> taskInstancesEnd = taskQuery.processInstanceId(taskInstance.getProcessInstanceId())
					.taskAssignee(Authentication.getAuthenticatedUserId()).taskIsEnd().list();

			String tokenId = taskInstance.getTokenId();

			String processDefinitionId = taskInstance.getProcessDefinitionId();
			ProcessInstanceManager processInstanceManager = Context.getCommandContext().getProcessInstanceManager();

			String processInstanceId = taskInstance.getProcessInstanceId();

			ProcessDefinitionManager processDefinitionManager = Context.getCommandContext().getProcessDefinitionManager();

			ProcessDefinitionBehavior processDefinition = processDefinitionManager.findLatestProcessDefinitionById(processDefinitionId);

			ProcessInstanceEntity processInstanceImpl = processInstanceManager.findProcessInstanceById(processInstanceId, processDefinition);
			if(processInstanceImpl.hasEnded()){
				return false;
			}
			TokenEntity token = processInstanceImpl.getTokenMap().get(tokenId);

			ExecutionContext executionContext = ProcessObjectFactory.FACTORYINSTANCE.createExecutionContext(token);

			Object returnValueObject = null;
			if (taskCommandInst != null && taskCommandInst.getExpression() != null) {
				try {

					returnValueObject = ExpressionMgmt.execute(taskCommandInst.getExpression(), executionContext);
				} catch (Exception e) {
					throw new FixFlowException("用户命令表达式执行异常!", e);
				}
			}
			if (returnValueObject == null || returnValueObject.equals("")) {
				return true;
			} else {
				String nodeIdString = StringUtil.getString(returnValueObject);
				String[] nodeIdSZ = nodeIdString.split(",");

				for (TaskInstance taskInstanceTemp : taskInstancesEnd) {
					if (isExist(nodeIdSZ, taskInstanceTemp.getNodeId())) {
						return true;
					}
				}
				return false;
			}

		}

		return false;

	}

	private boolean isExist(String[] contentStrings, String content) {
		for (String string : contentStrings) {
			if (string.equals(content)) {
				return true;
			}
		}
		return false;
	}

}
