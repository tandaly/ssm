package com.tandaly.core.mybatis.plugin;

import java.util.Properties;

import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.log4j.Logger;

@Intercepts({@Signature(
  type= Executor.class,
  method = "update",
  args = {MappedStatement.class, Object.class})})
public class UpdatePlugin implements Interceptor {

	Logger log = Logger.getLogger(UpdatePlugin.class);
	
	  public Object intercept(Invocation invocation) throws Throwable {
		  log.info("------------------我被mybatis拦截啦， 正在执行【更新】操作-------------------");
	    return invocation.proceed();
	  }
	  public Object plugin(Object target) {
	    return Plugin.wrap(target, this);
	  }
	  public void setProperties(Properties properties) {
	  }
}