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
package com.founder.fix.fixflow.core.impl.persistence;

import java.util.Map;

import com.founder.fix.fixflow.core.impl.db.DbSqlSession;
import com.founder.fix.fixflow.core.impl.db.MappingSqlSession;
import com.founder.fix.fixflow.core.impl.db.PersistentObject;
import com.founder.fix.fixflow.core.impl.interceptor.CommandContext;

/**
 * @author kenshin
 */
public abstract class AbstractManager {

	public void insert(String insertStatement, PersistentObject persistentObject) {
		getMappingSqlSession().insert(insertStatement, persistentObject);
	}

	public void delete(String deleteStatement, PersistentObject persistentObject) {
		delete(deleteStatement, persistentObject.getId());
	}
	
	public void delete(String deleteStatement, String parameter) {
		getMappingSqlSession().delete(deleteStatement, parameter);
	}
	
	public void update(String updateStatement, PersistentObject persistentObject){
		getMappingSqlSession().update(updateStatement, persistentObject);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> getPersistentDbMap(String statement, PersistentObject persistentObject){

		return (Map<String, Object>)getMappingSqlSession().selectOne(statement, persistentObject);
	}

	protected DbSqlSession getDbSqlSession() {

		return commandContext.getDbSqlSession();
	}
	
	protected MappingSqlSession getMappingSqlSession() {

		return commandContext.getMappingSqlSession();
	}

	protected CommandContext commandContext;

	public CommandContext getCommandContext() {
		return commandContext;
	}

	public void setCommandContext(CommandContext commandContext) {
		this.commandContext = commandContext;
	}

}
