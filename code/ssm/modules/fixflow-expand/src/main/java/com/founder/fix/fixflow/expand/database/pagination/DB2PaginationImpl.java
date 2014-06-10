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
package com.founder.fix.fixflow.expand.database.pagination;

import com.founder.fix.fixflow.core.db.pagination.Pagination;
import com.founder.fix.fixflow.core.impl.util.StringUtil;

public class DB2PaginationImpl implements Pagination{
	protected static final String SQL_END_DELIMITER = ";";

	public String getPaginationSql(String sql, int firstResult, int maxResults, String fields, String orderBy) {
		sql = trim(sql);
    	String inFiled = fields;
    	if(StringUtil.isNotEmpty(fields)){
    		fields="*";
    		inFiled="A.*";
    	}
        StringBuffer sb = new StringBuffer(sql.length() + 20);
        sb.append("(");
        sb.append("SELECT "+fields+" FROM (SELECT "+inFiled+", rownumber() over() as RN_ FROM (");
        sb.append(sql);
        sb.append(" )A");
        sb.append(" )b WHERE b.RN_ <=");
        sb.append(maxResults);
        sb.append(" and b.RN_ >=");
        if (firstResult >= 0) {
            sb.append(firstResult);
         } 
        sb.append(")");
        
        return sb.toString();
	}

	public String getIsNullLocalismSql(String sql) {
		return "COALESCE("+sql+")";
	}

	public String getDateSql() {
		return "current date";
	}

	public String getCurrentDateSql() {
		return "current timestamp";
	}

	public String getCastConvertSql(String sql, String type) {
		return "cast("+sql+" as "+ type +")";
	}

	public String getLocalismSql(String localismKey, String localismValue) {

		if(localismKey.equals("processperformance")){
			return "COALESCE(TIMESTAMPDIFF(8,end_time-start_time),0)";
		}
		
		if(localismKey.equals("datediffconvert")) {
			return "avg(TIMESTAMPDIFF(8,end_time-create_time))";
		}
		
		if(localismKey.equals("datediffconvertorg")) {
			return "avg(TIMESTAMPDIFF(8,x.end_time-x.create_time))";
		}
		
		return null;
	}

	private String trim(String sql) {
        sql = sql.trim();
        if (sql.endsWith(SQL_END_DELIMITER)) {
            sql = sql.substring(0, sql.length() - 1
                    - SQL_END_DELIMITER.length());
        }
        return sql;
    }
}
