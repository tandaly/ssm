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
package com.founder.fix.fixflow.core.impl.bpmn.behavior;

import java.util.Map;

import org.eclipse.bpmn2.FlowElement;
import org.eclipse.bpmn2.StartEvent;
import org.eclipse.bpmn2.impl.SubProcessImpl;

import com.founder.fix.fixflow.core.factory.ProcessObjectFactory;
import com.founder.fix.fixflow.core.impl.runtime.TokenEntity;
import com.founder.fix.fixflow.core.runtime.ExecutionContext;


public class SubProcessBehavior extends SubProcessImpl {
	
	
	/**
	 * <!-- 开始-用户-文档 -->
	 * 流程定义的启动节点,
	 * 默认为 {@link #com.founder.fix.fixflow.bpmn.StartEvent <em>StartEvent</em>} 类型
	 * <!-- 结束-用户-文档 -->
	 */
	protected FlowElement startElement;

	
	/**
	 * <!-- 开始-用户-文档 -->
	 * 返回流程定义的启动节点
	 * <!-- 结束-用户-文档 -->
	 * @return 开始节点
	 */
	public FlowElement getStartElement() {
		
		if(this.startElement!=null)
		{
			return startElement;
		}
		
		for (FlowElement flowElement : this.getFlowElements()) {
			
			if(flowElement instanceof StartEvent){
				this.startElement=flowElement;
				return flowElement;
			}
		}
		
		
		
		return startElement;
	}

	/**
	 * <!-- 开始-用户-文档 -->
	 * 设置流程开始节点
	 * <!-- 结束-用户-文档 -->
	 * @param startElement 开始节点
	 */
	public void setStartElement(FlowElement startElement) {
		this.startElement = startElement;
	}
	
	
	/**
	 * 离开节点的时候需要清理的数据.
	 * 每个子类需要自己实现.
	 */
	public void leaveClearData(ExecutionContext executionContext) {

		Map<String, TokenEntity> children=executionContext.getToken().getChildren();;
		 
		for (String tokenKey : children.keySet()) {
			TokenEntity child = children.get(tokenKey);
			if (!child.hasEnded()) {
				child.end(false);
			}
		}
		
	}
	
	
	public void execute(ExecutionContext executionContext) {

		
		/*
		ProcessInstanceImpl subProcessInstance = new ProcessInstanceImpl(executionContext.getProcessDefinition(), executionContext.getBizKey(), (ProcessInstanceImpl)executionContext.getProcessInstance(),executionContext.getToken());

		subProcessInstance.setInitiator(Authentication.getAuthenticatedUserId());
		//subProcessInstance.getContextInstance().setTransientVariableMap(executionContext.getContextInstance().getTransientVariableMap());
		//subProcessInstance.getContextInstance().setVariableMap(executionContext.getContextInstance().getVariableMap());


		try {
			subProcessInstance.start((FlowNode)getStartElement());
			
			ProcessInstanceManager processInstanceManager=Context.getCommandContext().getProcessInstanceManager();
			processInstanceManager.saveProcessInstance(subProcessInstance);
		} catch (Exception e) {
			
			throw new FixFlowException("子流程 "+ this.getName()+" 启动异常!", e);

			
		}
		*/
		TokenEntity token=new TokenEntity(executionContext.getToken(), this.name);
		token.setSubProcessRootToken(true);
		StartEvent startEvent=(StartEvent)getStartElement();
		ExecutionContext executionContextSub=ProcessObjectFactory.FACTORYINSTANCE.createExecutionContext(token);
		startEvent.enter(executionContextSub);
		
		
	}
	
	
	

}
