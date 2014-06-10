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
package com.founder.fix.fixflow.expand.connector.RunSqlSelectOneObject;


import java.util.List;
import java.util.Map;

import com.founder.fix.fixflow.core.runtime.ExecutionContext;
import com.founder.fix.fixflow.core.action.ConnectorHandler;

public class RunSqlSelectOneObject implements ConnectorHandler {

	private java.lang.String sqlText;
	private java.util.List<java.util.Map<String, Object>> outputfield;

	public void execute(ExecutionContext executionContext) throws Exception {
		//Object sqltextTemp=ExpressionMgmt.execute(sqlText, executionContext);
		List<Map<String, Object>> mapList= executionContext.getSqlCommand().queryForList(sqlText);
	
		outputfield=mapList;
	}

	public void  setSqlText(java.lang.String sqlText){
		this.sqlText = sqlText;
	}

	public java.util.List<java.util.Map<String, Object>>  getOutputfield(){
		return outputfield ;
	}

}