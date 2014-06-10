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
package com.founder.fix.fixflow.expand.cmd;

import com.founder.fix.fixflow.core.exception.FixFlowBizException;
import com.founder.fix.fixflow.core.exception.FixFlowException;
import com.founder.fix.fixflow.core.impl.Context;
import com.founder.fix.fixflow.core.impl.cmd.AbstractExpandTaskCmd;
import com.founder.fix.fixflow.core.impl.identity.Authentication;
import com.founder.fix.fixflow.core.impl.interceptor.CommandContext;
import com.founder.fix.fixflow.core.impl.task.TaskInstanceEntity;
import com.founder.fix.fixflow.core.impl.util.ClockUtil;
import com.founder.fix.fixflow.expand.command.ClaimTaskCommand;


/**
 * @author kenshin
 */
public class ClaimTaskCmd extends AbstractExpandTaskCmd<ClaimTaskCommand, Void> {



	public ClaimTaskCmd(ClaimTaskCommand claimTaskCommand) {
		super(claimTaskCommand);
	
	}

	public Void execute(CommandContext commandContext) {
		if (taskId == null||taskId.equals("")) {
			throw new FixFlowException("任务编号为空！");
		}


		TaskInstanceEntity task = Context.getCommandContext().getTaskManager()
				.findTaskById(taskId);
		
		if (task == null) {
			throw new FixFlowException("无法找到编号为: " + taskId + " 的任务!");
		}
		if(task.hasEnded()){
			throw new FixFlowBizException("当前的任务已经结束,无法继续处理!");
		}
		
		if (Authentication.getAuthenticatedUserId() != null) {
			
			
			if(this.agent!=null&&!this.agent.equals("")){
				
				if (task.getAssignee() != null) {
					if (!task.getAssignee().equals(this.agent)) {
						// 当任务已经被另一个不是自己的用户占有，则抛出异常。
						throw new FixFlowException("任务 " + taskId + " 已经被另一个用户领取!");
					}
				} else {
					
					task.setAssignee(this.agent);
					task.setClaimTime(ClockUtil.getCurrentTime());
					Context.getCommandContext().getTaskManager()
							.saveTaskInstanceEntity(task);
					
				}
		
				
			}
			else{

					if (task.getAssignee() != null) {
						if (!task.getAssignee().equals(Authentication.getAuthenticatedUserId())) {
							// 当任务已经被另一个不是自己的用户占有，则抛出异常。
							throw new FixFlowException("任务 " + taskId + " 已经被另一个用户领取!");
						}
					} else {
						
						task.setAssignee(Authentication.getAuthenticatedUserId() );
						task.setClaimTime(ClockUtil.getCurrentTime());
						Context.getCommandContext().getTaskManager()
								.saveTaskInstanceEntity(task);
						
					}
			
			}
			
			
			
		}
		else{
			// 当用户编号为空的时候则将该任务设置为任何人都可以获取
			task.setAssignee(null);
			Context.getCommandContext().getTaskManager()
					.saveTaskInstanceEntity(task);
		}
		
		
		

		return null;
	}

}
