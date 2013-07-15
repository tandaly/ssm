package com.tandaly.core.mybatis.plugin;

import java.util.Properties;

import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;
import org.apache.log4j.Logger;

/**
 * http://guohf.iteye.com/blog/1450611
 * plugins主要用来实现拦截器的功能，使用到了动态代理，可以指定在某些操作时执行一些拦截操作，比如在一条记录插入数据库之前写入一条日志，或查询一下

权限等等

  Executor 
(update, query, flushStatements, commit, rollback, getTransaction, close, isClosed) 
  ParameterHandler  
(getParameterObject, setParameters) 
  ResultSetHandler  
(handleResultSets, handleOutputParameters) 
  StatementHandler  
(prepare, parameterize, batch, update, query) 

 * @author tandaly(tandaly001@gmail.com)
 * @date 2013-7-12 下午11:20:15
 */
@Intercepts({@Signature(
  type= Executor.class,
  method = "query",
  args = {MappedStatement.class, Object.class, RowBounds.class, ResultHandler.class})})
public class QueryPlugin implements Interceptor {

	Logger log = Logger.getLogger(QueryPlugin.class);
	
	  public Object intercept(Invocation invocation) throws Throwable {
		  log.info("------------------我被mybatis拦截啦， 正在执行【查询】操作-------------------");
	    return invocation.proceed();
	  }
	  public Object plugin(Object target) {
	    return Plugin.wrap(target, this);
	  }
	  public void setProperties(Properties properties) {
	  }
}