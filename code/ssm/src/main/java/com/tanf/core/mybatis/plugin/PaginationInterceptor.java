package com.tanf.core.mybatis.plugin;

import java.sql.Connection;
import java.util.Properties;

import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.log4j.Logger;

@Intercepts({ @Signature(type = StatementHandler.class, 
	method = "prepare", args = { Connection.class }) })
public class PaginationInterceptor implements Interceptor {

	Logger log = Logger.getLogger(PaginationInterceptor.class);

	@Override
	public Object intercept(Invocation invocation) throws Throwable {
	
	       StatementHandler statementHandler = (StatementHandler)invocation.getTarget();
	
	       BoundSql boundSql = statementHandler.getBoundSql();
	       
	       log.info("我要开始执行sql语句：" + boundSql.getSql());
	
	      /* MetaObject metaStatementHandler = MetaObject.forObject(statementHandler);
	
	       RowBounds rowBounds = (RowBounds)metaStatementHandler.getValue("delegate.rowBounds");
	
	       if(rowBounds ==null|| rowBounds == RowBounds.DEFAULT){
	
	           return invocation.proceed();
	
	       }
	
	       Configuration configuration = (Configuration)metaStatementHandler.getValue("delegate.configuration");
	
	       Dialect.Type databaseType  =null;
	
	       try{
	
	           databaseType = Dialect.Type.valueOf(configuration.getVariables().getProperty("dialect").toUpperCase());
	
	       } catch(Exception e){
	
	           //ignore
	
	       }
	
	       if(databaseType ==null){
	
	           throw new RuntimeException("the value of the dialect property in configuration.xml is not defined : "+ configuration.getVariables().getProperty("dialect"));
	
	       }
	
	       Dialect dialect =null;
	
	       switch(databaseType){
	
	           case MYSQL:
	
	              dialect =new MySql5Dialect();
	       }
	
	       String originalSql = (String)metaStatementHandler.getValue("delegate.boundSql.sql");
	
	       metaStatementHandler.setValue("delegate.boundSql.sql", dialect.getLimitString(originalSql, rowBounds.getOffset(), rowBounds.getLimit()) );
	
	       metaStatementHandler.setValue("delegate.rowBounds.offset", RowBounds.NO_ROW_OFFSET );
	
	       metaStatementHandler.setValue("delegate.rowBounds.limit", RowBounds.NO_ROW_LIMIT );
	
	       if(log.isDebugEnabled()){
	
	           log.debug("生成分页SQL : "+ boundSql.getSql());
	
	       }
	*/
	       return invocation.proceed();
	
	    }

	@Override
	public Object plugin(Object target) {

		return Plugin.wrap(target, this);

	}

	@Override
	public void setProperties(Properties properties) {

	}

}
