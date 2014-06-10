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
package com.founder.fix.fixflow.core.impl.job;

import java.util.Date;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.founder.fix.fixflow.core.ProcessEngine;
import com.founder.fix.fixflow.core.ProcessEngineManagement;
import com.founder.fix.fixflow.core.impl.ExternalContent;
import com.founder.fix.fixflow.core.impl.identity.Authentication;

public abstract class AbstactTimeJob implements Job {
	
	
	ProcessEngine processEngine = ProcessEngineManagement.getDefaultProcessEngine();

	
	
	

	public void execute(JobExecutionContext jobExecutionContext) throws JobExecutionException {
		
		ExternalContent externalContent=new ExternalContent();
		externalContent.setAuthenticatedUserId(Authentication.getSystemId());
		externalContent.setConnectionManagement("General");
		processEngine.setExternalContent(externalContent);
		//processEngine.getProcessEngineConfiguration().setConnectionManagement("General");

		
		
		try {
			System.out.println("=====定时任务启动 " + new Date() + " =====");
			System.out.println("=====任务参数为：" + new Date() + " =====");
			
			if(jobExecutionContext.getJobDetail().getJobDataMap()!=null)
			for (String mapKey : jobExecutionContext.getJobDetail().getJobDataMap().keySet()) {
				System.out.println("=====参数 "+mapKey+" ：   "+jobExecutionContext.getJobDetail().getJobDataMap().get(mapKey) + " =====");
			}
			
			
			executeJob(jobExecutionContext);
			processEngine.commitConnection();
			System.out.println("=====定时任务启动成功! "+new Date()+ " =====");
		} catch (Exception e) {
			
			processEngine.rollBackConnection();
			e.printStackTrace();
			System.out.println("=====定时任务启动失败! "+new Date()+ " =====");
		}
		finally{
			processEngine.contextClose(true, true);
		}
		
		
		
	}
	

	public abstract void executeJob(JobExecutionContext jobExecutionContext)  throws JobExecutionException;
	


}
