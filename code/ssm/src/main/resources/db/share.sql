-- MySQL dump 10.11
--
-- Host: localhost    Database: share
-- ------------------------------------------------------
-- Server version	5.0.67-community-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `t_sys_dictionary`
--

DROP TABLE IF EXISTS `t_sys_dictionary`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `t_sys_dictionary` (
  `id` int(10) NOT NULL auto_increment,
  `dicKey` varchar(50) NOT NULL default '' COMMENT '键',
  `name` varchar(50) NOT NULL default '' COMMENT '名称',
  `value` varchar(50) NOT NULL default '' COMMENT '值',
  `status` varchar(50) NOT NULL default '启用' COMMENT '启用/禁用  默认''启用''',
  `remark` varchar(50) NOT NULL default '' COMMENT '描述',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `key` (`dicKey`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='字典表';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `t_sys_dictionary`
--

LOCK TABLES `t_sys_dictionary` WRITE;
/*!40000 ALTER TABLE `t_sys_dictionary` DISABLE KEYS */;
INSERT INTO `t_sys_dictionary` VALUES (1,'TIME_FORMAT','时间格式','yyyy-MM-dd HH:mm:ss','启用','一般的事件格式'),(2,'DATE_FORMAT','日期格式','yyyy-MM-dd','启用','通用的日期格式');
/*!40000 ALTER TABLE `t_sys_dictionary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_sys_event`
--

DROP TABLE IF EXISTS `t_sys_event`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `t_sys_event` (
  `id` bigint(20) NOT NULL auto_increment COMMENT '事件ID',
  `userId` varchar(8) default NULL COMMENT '用户ID',
  `userName` varchar(100) default NULL COMMENT '用户名',
  `description` varchar(100) default NULL COMMENT '事件描述',
  `activeTime` varchar(50) default NULL COMMENT '活动时间',
  `requestPath` varchar(200) default NULL COMMENT '请求路径',
  `methodName` varchar(50) default NULL COMMENT '请求方法名',
  `costTime` int(10) default NULL COMMENT '耗时',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='操作员事件表';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `t_sys_event`
--

LOCK TABLES `t_sys_event` WRITE;
/*!40000 ALTER TABLE `t_sys_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_sys_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_sys_exceptions`
--

DROP TABLE IF EXISTS `t_sys_exceptions`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `t_sys_exceptions` (
  `id` int(10) NOT NULL auto_increment,
  `className` text NOT NULL COMMENT '类名',
  `methodName` text NOT NULL COMMENT '方法',
  `description` longtext NOT NULL COMMENT '异常信息',
  `activeTime` varchar(50) NOT NULL default '' COMMENT '激活时间',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='系统异常信息表';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `t_sys_exceptions`
--

LOCK TABLES `t_sys_exceptions` WRITE;
/*!40000 ALTER TABLE `t_sys_exceptions` DISABLE KEYS */;
INSERT INTO `t_sys_exceptions` VALUES (1,'com.tandaly.system.admin.userService','addUser','nullException','2013-07-01 10:10:10'),(6,'java.lang.NullPointerException','method','java.lang.NullPointerException\nat [java.lang.Thread,Thread.java,run,619]\nat [org.apache.tomcat.util.net.JIoEndpoint$Worker,JIoEndpoint.java,run,447]\nat [org.apache.coyote.http11.Http11Protocol$Http11ConnectionHandler,Http11Protocol.java,process,583]\nat [org.apache.coyote.http11.Http11Processor,Http11Processor.java,process,844]\nat [org.apache.catalina.connector.CoyoteAdapter,CoyoteAdapter.java,service,286]\nat [org.apache.catalina.core.StandardEngineValve,StandardEngineValve.java,invoke,109]\nat [org.apache.catalina.valves.ErrorReportValve,ErrorReportValve.java,invoke,102]\nat [org.apache.catalina.core.StandardHostValve,StandardHostValve.java,invoke,128]\nat [org.apache.catalina.core.StandardContextValve,StandardContextValve.java,invoke,175]\nat [org.apache.catalina.core.StandardWrapperValve,StandardWrapperValve.java,invoke,233]\nat [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,doFilter,206]\nat [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,internalDoFilter,235]\nat [org.springframework.web.filter.OncePerRequestFilter,OncePerRequestFilter.java,doFilter,107]\nat [org.springframework.web.filter.CharacterEncodingFilter,CharacterEncodingFilter.java,doFilterInternal,88]\nat [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,doFilter,206]\nat [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,internalDoFilter,235]\nat [com.tandaly.core.web.filter.RequestFilter,RequestFilter.java,doFilter,71]\nat [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,doFilter,206]\nat [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,internalDoFilter,290]\nat [javax.servlet.http.HttpServlet,HttpServlet.java,service,803]\nat [org.springframework.web.servlet.FrameworkServlet,FrameworkServlet.java,service,801]\nat [javax.servlet.http.HttpServlet,HttpServlet.java,service,690]\nat [org.springframework.web.servlet.FrameworkServlet,FrameworkServlet.java,doGet,816]\nat [org.springframework.web.servlet.FrameworkServlet,FrameworkServlet.java,processRequest,920]\nat [org.springframework.web.servlet.DispatcherServlet,DispatcherServlet.java,doService,856]\nat [org.springframework.web.servlet.DispatcherServlet,DispatcherServlet.java,doDispatch,925]\nat [org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter,AbstractHandlerMethodAdapter.java,handle,80]\nat [org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter,RequestMappingHandlerAdapter.java,handleInternal,686]\nat [org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter,RequestMappingHandlerAdapter.java,invokeHandleMethod,745]\nat [org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod,ServletInvocableHandlerMethod.java,invokeAndHandle,104]\nat [org.springframework.web.method.support.InvocableHandlerMethod,InvocableHandlerMethod.java,invokeForRequest,132]\nat [org.springframework.web.method.support.InvocableHandlerMethod,InvocableHandlerMethod.java,invoke,219]\nat [java.lang.reflect.Method,Method.java,invoke,597]\nat [sun.reflect.DelegatingMethodAccessorImpl,DelegatingMethodAccessorImpl.java,invoke,25]\nat [sun.reflect.NativeMethodAccessorImpl,NativeMethodAccessorImpl.java,invoke,39]\nat [sun.reflect.NativeMethodAccessorImpl,NativeMethodAccessorImpl.java,invoke0,-2]\nat [com.tandaly.system.admin.actions.ServerInfoController,ServerInfoController.java,serverChart,53]\n','2013-07-02 08:50:42'),(7,'java.lang.Thread','run','java.lang.NullPointerException\nat [java.lang.Thread,Thread.java,run,619]\nat [org.apache.tomcat.util.net.JIoEndpoint$Worker,JIoEndpoint.java,run,447]\nat [org.apache.coyote.http11.Http11Protocol$Http11ConnectionHandler,Http11Protocol.java,process,583]\nat [org.apache.coyote.http11.Http11Processor,Http11Processor.java,process,844]\nat [org.apache.catalina.connector.CoyoteAdapter,CoyoteAdapter.java,service,286]\nat [org.apache.catalina.core.StandardEngineValve,StandardEngineValve.java,invoke,109]\nat [org.apache.catalina.valves.ErrorReportValve,ErrorReportValve.java,invoke,102]\nat [org.apache.catalina.core.StandardHostValve,StandardHostValve.java,invoke,128]\nat [org.apache.catalina.core.StandardContextValve,StandardContextValve.java,invoke,175]\nat [org.apache.catalina.core.StandardWrapperValve,StandardWrapperValve.java,invoke,233]\nat [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,doFilter,206]\nat [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,internalDoFilter,235]\nat [org.springframework.web.filter.OncePerRequestFilter,OncePerRequestFilter.java,doFilter,107]\nat [org.springframework.web.filter.CharacterEncodingFilter,CharacterEncodingFilter.java,doFilterInternal,88]\nat [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,doFilter,206]\nat [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,internalDoFilter,235]\nat [com.tandaly.core.web.filter.RequestFilter,RequestFilter.java,doFilter,71]\nat [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,doFilter,206]\nat [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,internalDoFilter,290]\nat [javax.servlet.http.HttpServlet,HttpServlet.java,service,803]\nat [org.springframework.web.servlet.FrameworkServlet,FrameworkServlet.java,service,801]\nat [javax.servlet.http.HttpServlet,HttpServlet.java,service,690]\nat [org.springframework.web.servlet.FrameworkServlet,FrameworkServlet.java,doGet,816]\nat [org.springframework.web.servlet.FrameworkServlet,FrameworkServlet.java,processRequest,920]\nat [org.springframework.web.servlet.DispatcherServlet,DispatcherServlet.java,doService,856]\nat [org.springframework.web.servlet.DispatcherServlet,DispatcherServlet.java,doDispatch,925]\nat [org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter,AbstractHandlerMethodAdapter.java,handle,80]\nat [org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter,RequestMappingHandlerAdapter.java,handleInternal,686]\nat [org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter,RequestMappingHandlerAdapter.java,invokeHandleMethod,745]\nat [org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod,ServletInvocableHandlerMethod.java,invokeAndHandle,104]\nat [org.springframework.web.method.support.InvocableHandlerMethod,InvocableHandlerMethod.java,invokeForRequest,132]\nat [org.springframework.web.method.support.InvocableHandlerMethod,InvocableHandlerMethod.java,invoke,219]\nat [java.lang.reflect.Method,Method.java,invoke,597]\nat [sun.reflect.DelegatingMethodAccessorImpl,DelegatingMethodAccessorImpl.java,invoke,25]\nat [sun.reflect.NativeMethodAccessorImpl,NativeMethodAccessorImpl.java,invoke,39]\nat [sun.reflect.NativeMethodAccessorImpl,NativeMethodAccessorImpl.java,invoke0,-2]\nat [com.tandaly.system.admin.actions.ServerInfoController,ServerInfoController.java,serverChart,53]\n','2013-07-02 08:57:56'),(8,'com.tandaly.system.admin.actions.ServerInfoController','serverChart','java.lang.NullPointerException\nat [java.lang.Thread,Thread.java,run,619]\nat [org.apache.tomcat.util.net.JIoEndpoint$Worker,JIoEndpoint.java,run,447]\nat [org.apache.coyote.http11.Http11Protocol$Http11ConnectionHandler,Http11Protocol.java,process,583]\nat [org.apache.coyote.http11.Http11Processor,Http11Processor.java,process,844]\nat [org.apache.catalina.connector.CoyoteAdapter,CoyoteAdapter.java,service,286]\nat [org.apache.catalina.core.StandardEngineValve,StandardEngineValve.java,invoke,109]\nat [org.apache.catalina.valves.ErrorReportValve,ErrorReportValve.java,invoke,102]\nat [org.apache.catalina.core.StandardHostValve,StandardHostValve.java,invoke,128]\nat [org.apache.catalina.core.StandardContextValve,StandardContextValve.java,invoke,175]\nat [org.apache.catalina.core.StandardWrapperValve,StandardWrapperValve.java,invoke,233]\nat [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,doFilter,206]\nat [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,internalDoFilter,235]\nat [org.springframework.web.filter.OncePerRequestFilter,OncePerRequestFilter.java,doFilter,107]\nat [org.springframework.web.filter.CharacterEncodingFilter,CharacterEncodingFilter.java,doFilterInternal,88]\nat [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,doFilter,206]\nat [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,internalDoFilter,235]\nat [com.tandaly.core.web.filter.RequestFilter,RequestFilter.java,doFilter,71]\nat [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,doFilter,206]\nat [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,internalDoFilter,290]\nat [javax.servlet.http.HttpServlet,HttpServlet.java,service,803]\nat [org.springframework.web.servlet.FrameworkServlet,FrameworkServlet.java,service,801]\nat [javax.servlet.http.HttpServlet,HttpServlet.java,service,690]\nat [org.springframework.web.servlet.FrameworkServlet,FrameworkServlet.java,doGet,816]\nat [org.springframework.web.servlet.FrameworkServlet,FrameworkServlet.java,processRequest,920]\nat [org.springframework.web.servlet.DispatcherServlet,DispatcherServlet.java,doService,856]\nat [org.springframework.web.servlet.DispatcherServlet,DispatcherServlet.java,doDispatch,925]\nat [org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter,AbstractHandlerMethodAdapter.java,handle,80]\nat [org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter,RequestMappingHandlerAdapter.java,handleInternal,686]\nat [org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter,RequestMappingHandlerAdapter.java,invokeHandleMethod,745]\nat [org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod,ServletInvocableHandlerMethod.java,invokeAndHandle,104]\nat [org.springframework.web.method.support.InvocableHandlerMethod,InvocableHandlerMethod.java,invokeForRequest,132]\nat [org.springframework.web.method.support.InvocableHandlerMethod,InvocableHandlerMethod.java,invoke,219]\nat [java.lang.reflect.Method,Method.java,invoke,597]\nat [sun.reflect.DelegatingMethodAccessorImpl,DelegatingMethodAccessorImpl.java,invoke,25]\nat [sun.reflect.NativeMethodAccessorImpl,NativeMethodAccessorImpl.java,invoke,39]\nat [sun.reflect.NativeMethodAccessorImpl,NativeMethodAccessorImpl.java,invoke0,-2]\nat [com.tandaly.system.admin.actions.ServerInfoController,ServerInfoController.java,serverChart,53]\n','2013-07-02 09:00:35'),(9,'org.springframework.jdbc.support.SQLErrorCodeSQLExceptionTranslator','doTranslate','org.springframework.jdbc.BadSqlGrammarException: \r\n### Error updating database.  Cause: com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'key,\n			value,\n			remark ) \n		VALUES\n		 ( null,\n			\'sdf\',\n			\'sd\',\n			\'gd\',\n			\'\' at line 4\r\n### The error may involve com.tandaly.system.admin.dao.DictionaryDao.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO t_sys_dictionary    ( id,    name,    key,    value,    remark )    VALUES    ( ?,    ?,    ?,    ?,    ? )\r\n### Cause: com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'key,\n			value,\n			remark ) \n		VALUES\n		 ( null,\n			\'sdf\',\n			\'sd\',\n			\'gd\',\n			\'\' at line 4\n; bad SQL grammar []; nested exception is com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'key,\n			value,\n			remark ) \n		VALUES\n		 ( null,\n			\'sdf\',\n			\'sd\',\n			\'gd\',\n			\'\' at line 4\n在 [java.lang.Thread,Thread.java,run,619]\n在 [org.apache.tomcat.util.net.JIoEndpoint$Worker,JIoEndpoint.java,run,447]\n在 [org.apache.coyote.http11.Http11Protocol$Http11ConnectionHandler,Http11Protocol.java,process,583]\n在 [org.apache.coyote.http11.Http11Processor,Http11Processor.java,process,844]\n在 [org.apache.catalina.connector.CoyoteAdapter,CoyoteAdapter.java,service,286]\n在 [org.apache.catalina.core.StandardEngineValve,StandardEngineValve.java,invoke,109]\n在 [org.apache.catalina.valves.ErrorReportValve,ErrorReportValve.java,invoke,102]\n在 [org.apache.catalina.core.StandardHostValve,StandardHostValve.java,invoke,128]\n在 [org.apache.catalina.core.StandardContextValve,StandardContextValve.java,invoke,175]\n在 [org.apache.catalina.core.StandardWrapperValve,StandardWrapperValve.java,invoke,233]\n在 [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,doFilter,206]\n在 [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,internalDoFilter,235]\n在 [org.springframework.web.filter.OncePerRequestFilter,OncePerRequestFilter.java,doFilter,107]\n在 [org.springframework.web.filter.CharacterEncodingFilter,CharacterEncodingFilter.java,doFilterInternal,88]\n在 [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,doFilter,206]\n在 [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,internalDoFilter,235]\n在 [com.tandaly.core.web.filter.RequestFilter,RequestFilter.java,doFilter,71]\n在 [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,doFilter,206]\n在 [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,internalDoFilter,290]\n在 [javax.servlet.http.HttpServlet,HttpServlet.java,service,803]\n在 [org.springframework.web.servlet.FrameworkServlet,FrameworkServlet.java,service,812]\n在 [javax.servlet.http.HttpServlet,HttpServlet.java,service,710]\n在 [org.springframework.web.servlet.FrameworkServlet,FrameworkServlet.java,doPost,838]\n在 [org.springframework.web.servlet.FrameworkServlet,FrameworkServlet.java,processRequest,936]\n在 [org.springframework.web.servlet.DispatcherServlet,DispatcherServlet.java,doService,856]\n在 [org.springframework.web.servlet.DispatcherServlet,DispatcherServlet.java,doDispatch,925]\n在 [org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter,AbstractHandlerMethodAdapter.java,handle,80]\n在 [org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter,RequestMappingHandlerAdapter.java,handleInternal,686]\n在 [org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter,RequestMappingHandlerAdapter.java,invokeHandleMethod,745]\n在 [org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod,ServletInvocableHandlerMethod.java,invokeAndHandle,104]\n在 [org.springframework.web.method.support.InvocableHandlerMethod,InvocableHandlerMethod.java,invokeForRequest,132]\n在 [org.springframework.web.method.support.InvocableHandlerMethod,InvocableHandlerMethod.java,invoke,219]\n在 [java.lang.reflect.Method,Method.java,invoke,597]\n在 [sun.reflect.DelegatingMethodAccessorImpl,DelegatingMethodAccessorImpl.java,invoke,25]\n在 [sun.reflect.NativeMethodAccessorImpl,NativeMethodAccessorImpl.java,invoke,39]\n在 [sun.reflect.NativeMethodAccessorImpl,NativeMethodAccessorImpl.java,invoke0,-2]\n在 [com.tandaly.system.admin.actions.DictionaryController,DictionaryController.java,ajaxAddDictionary,51]\n在 [com.tandaly.system.admin.service.DictionaryService$$EnhancerByCGLIB$$4bb2b93b,<generated>,addDictionary,-1]\n在 [org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor,CglibAopProxy.java,intercept,631]\n在 [org.springframework.aop.framework.ReflectiveMethodInvocation,ReflectiveMethodInvocation.java,proceed,172]\n在 [org.springframework.transaction.interceptor.TransactionInterceptor,TransactionInterceptor.java,invoke,94]\n在 [org.springframework.transaction.interceptor.TransactionAspectSupport,TransactionAspectSupport.java,invokeWithinTransaction,260]\n在 [org.springframework.transaction.interceptor.TransactionInterceptor$1,TransactionInterceptor.java,proceedWithInvocation,96]\n在 [org.springframework.aop.framework.ReflectiveMethodInvocation,ReflectiveMethodInvocation.java,proceed,150]\n在 [org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation,CglibAopProxy.java,invokeJoinpoint,698]\n在 [org.springframework.cglib.proxy.MethodProxy,MethodProxy.java,invoke,204]\n在 [com.tandaly.system.admin.service.DictionaryService$$FastClassByCGLIB$$9db611f8,<generated>,invoke,-1]\n在 [com.tandaly.system.admin.service.DictionaryService,DictionaryService.java,addDictionary,36]\n在 [$Proxy14,null,insert,-1]\n在 [org.apache.ibatis.binding.MapperProxy,MapperProxy.java,invoke,43]\n在 [org.apache.ibatis.binding.MapperMethod,MapperMethod.java,execute,46]\n在 [org.mybatis.spring.SqlSessionTemplate,SqlSessionTemplate.java,insert,236]\n在 [$Proxy12,null,insert,-1]\n在 [org.mybatis.spring.SqlSessionTemplate$SqlSessionInterceptor,SqlSessionTemplate.java,invoke,364]\n在 [org.mybatis.spring.MyBatisExceptionTranslator,MyBatisExceptionTranslator.java,translateExceptionIfPossible,71]\n在 [org.springframework.jdbc.support.AbstractFallbackSQLExceptionTranslator,AbstractFallbackSQLExceptionTranslator.java,translate,72]\n在 [org.springframework.jdbc.support.SQLErrorCodeSQLExceptionTranslator,SQLErrorCodeSQLExceptionTranslator.java,doTranslate,237]\n','2013-07-03 17:18:31'),(10,'org.springframework.jdbc.support.SQLErrorCodeSQLExceptionTranslator','doTranslate','org.springframework.jdbc.BadSqlGrammarException: \r\n### Error updating database.  Cause: com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'key,\n			value,\n			remark ) \n		VALUES\n		 ( null,\n			\'sdf\',\n			\'sd\',\n			\'gd\',\n			\'\' at line 4\r\n### The error may involve com.tandaly.system.admin.dao.DictionaryDao.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO t_sys_dictionary    ( id,    name,    key,    value,    remark )    VALUES    ( ?,    ?,    ?,    ?,    ? )\r\n### Cause: com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'key,\n			value,\n			remark ) \n		VALUES\n		 ( null,\n			\'sdf\',\n			\'sd\',\n			\'gd\',\n			\'\' at line 4\n; bad SQL grammar []; nested exception is com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'key,\n			value,\n			remark ) \n		VALUES\n		 ( null,\n			\'sdf\',\n			\'sd\',\n			\'gd\',\n			\'\' at line 4\n在 [java.lang.Thread,Thread.java,run,619]\n在 [org.apache.tomcat.util.net.JIoEndpoint$Worker,JIoEndpoint.java,run,447]\n在 [org.apache.coyote.http11.Http11Protocol$Http11ConnectionHandler,Http11Protocol.java,process,583]\n在 [org.apache.coyote.http11.Http11Processor,Http11Processor.java,process,844]\n在 [org.apache.catalina.connector.CoyoteAdapter,CoyoteAdapter.java,service,286]\n在 [org.apache.catalina.core.StandardEngineValve,StandardEngineValve.java,invoke,109]\n在 [org.apache.catalina.valves.ErrorReportValve,ErrorReportValve.java,invoke,102]\n在 [org.apache.catalina.core.StandardHostValve,StandardHostValve.java,invoke,128]\n在 [org.apache.catalina.core.StandardContextValve,StandardContextValve.java,invoke,175]\n在 [org.apache.catalina.core.StandardWrapperValve,StandardWrapperValve.java,invoke,233]\n在 [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,doFilter,206]\n在 [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,internalDoFilter,235]\n在 [org.springframework.web.filter.OncePerRequestFilter,OncePerRequestFilter.java,doFilter,107]\n在 [org.springframework.web.filter.CharacterEncodingFilter,CharacterEncodingFilter.java,doFilterInternal,88]\n在 [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,doFilter,206]\n在 [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,internalDoFilter,235]\n在 [com.tandaly.core.web.filter.RequestFilter,RequestFilter.java,doFilter,71]\n在 [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,doFilter,206]\n在 [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,internalDoFilter,290]\n在 [javax.servlet.http.HttpServlet,HttpServlet.java,service,803]\n在 [org.springframework.web.servlet.FrameworkServlet,FrameworkServlet.java,service,812]\n在 [javax.servlet.http.HttpServlet,HttpServlet.java,service,710]\n在 [org.springframework.web.servlet.FrameworkServlet,FrameworkServlet.java,doPost,838]\n在 [org.springframework.web.servlet.FrameworkServlet,FrameworkServlet.java,processRequest,936]\n在 [org.springframework.web.servlet.DispatcherServlet,DispatcherServlet.java,doService,856]\n在 [org.springframework.web.servlet.DispatcherServlet,DispatcherServlet.java,doDispatch,925]\n在 [org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter,AbstractHandlerMethodAdapter.java,handle,80]\n在 [org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter,RequestMappingHandlerAdapter.java,handleInternal,686]\n在 [org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter,RequestMappingHandlerAdapter.java,invokeHandleMethod,745]\n在 [org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod,ServletInvocableHandlerMethod.java,invokeAndHandle,104]\n在 [org.springframework.web.method.support.InvocableHandlerMethod,InvocableHandlerMethod.java,invokeForRequest,132]\n在 [org.springframework.web.method.support.InvocableHandlerMethod,InvocableHandlerMethod.java,invoke,219]\n在 [java.lang.reflect.Method,Method.java,invoke,597]\n在 [sun.reflect.DelegatingMethodAccessorImpl,DelegatingMethodAccessorImpl.java,invoke,25]\n在 [sun.reflect.NativeMethodAccessorImpl,NativeMethodAccessorImpl.java,invoke,39]\n在 [sun.reflect.NativeMethodAccessorImpl,NativeMethodAccessorImpl.java,invoke0,-2]\n在 [com.tandaly.system.admin.actions.DictionaryController,DictionaryController.java,ajaxAddDictionary,51]\n在 [com.tandaly.system.admin.service.DictionaryService$$EnhancerByCGLIB$$4bb2b93b,<generated>,addDictionary,-1]\n在 [org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor,CglibAopProxy.java,intercept,631]\n在 [org.springframework.aop.framework.ReflectiveMethodInvocation,ReflectiveMethodInvocation.java,proceed,172]\n在 [org.springframework.transaction.interceptor.TransactionInterceptor,TransactionInterceptor.java,invoke,94]\n在 [org.springframework.transaction.interceptor.TransactionAspectSupport,TransactionAspectSupport.java,invokeWithinTransaction,260]\n在 [org.springframework.transaction.interceptor.TransactionInterceptor$1,TransactionInterceptor.java,proceedWithInvocation,96]\n在 [org.springframework.aop.framework.ReflectiveMethodInvocation,ReflectiveMethodInvocation.java,proceed,150]\n在 [org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation,CglibAopProxy.java,invokeJoinpoint,698]\n在 [org.springframework.cglib.proxy.MethodProxy,MethodProxy.java,invoke,204]\n在 [com.tandaly.system.admin.service.DictionaryService$$FastClassByCGLIB$$9db611f8,<generated>,invoke,-1]\n在 [com.tandaly.system.admin.service.DictionaryService,DictionaryService.java,addDictionary,36]\n在 [$Proxy14,null,insert,-1]\n在 [org.apache.ibatis.binding.MapperProxy,MapperProxy.java,invoke,43]\n在 [org.apache.ibatis.binding.MapperMethod,MapperMethod.java,execute,46]\n在 [org.mybatis.spring.SqlSessionTemplate,SqlSessionTemplate.java,insert,236]\n在 [$Proxy12,null,insert,-1]\n在 [org.mybatis.spring.SqlSessionTemplate$SqlSessionInterceptor,SqlSessionTemplate.java,invoke,364]\n在 [org.mybatis.spring.MyBatisExceptionTranslator,MyBatisExceptionTranslator.java,translateExceptionIfPossible,71]\n在 [org.springframework.jdbc.support.AbstractFallbackSQLExceptionTranslator,AbstractFallbackSQLExceptionTranslator.java,translate,72]\n在 [org.springframework.jdbc.support.SQLErrorCodeSQLExceptionTranslator,SQLErrorCodeSQLExceptionTranslator.java,doTranslate,237]\n','2013-07-03 17:23:47'),(11,'org.springframework.jdbc.support.SQLErrorCodeSQLExceptionTranslator','doTranslate','org.springframework.jdbc.BadSqlGrammarException: \r\n### Error updating database.  Cause: com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')\' at line 5\r\n### The error may involve com.tandaly.system.admin.dao.DictionaryDao.delete-Inline\r\n### The error occurred while setting parameters\r\n### SQL: DELETE FROM    t_sys_dictionary   WHERE id IN (        )\r\n### Cause: com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')\' at line 5\n; bad SQL grammar []; nested exception is com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')\' at line 5\n在 [java.lang.Thread,Thread.java,run,619]\n在 [org.apache.tomcat.util.net.JIoEndpoint$Worker,JIoEndpoint.java,run,447]\n在 [org.apache.coyote.http11.Http11Protocol$Http11ConnectionHandler,Http11Protocol.java,process,583]\n在 [org.apache.coyote.http11.Http11Processor,Http11Processor.java,process,844]\n在 [org.apache.catalina.connector.CoyoteAdapter,CoyoteAdapter.java,service,286]\n在 [org.apache.catalina.core.StandardEngineValve,StandardEngineValve.java,invoke,109]\n在 [org.apache.catalina.valves.ErrorReportValve,ErrorReportValve.java,invoke,102]\n在 [org.apache.catalina.core.StandardHostValve,StandardHostValve.java,invoke,128]\n在 [org.apache.catalina.core.StandardContextValve,StandardContextValve.java,invoke,175]\n在 [org.apache.catalina.core.StandardWrapperValve,StandardWrapperValve.java,invoke,233]\n在 [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,doFilter,206]\n在 [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,internalDoFilter,235]\n在 [org.springframework.web.filter.OncePerRequestFilter,OncePerRequestFilter.java,doFilter,107]\n在 [org.springframework.web.filter.CharacterEncodingFilter,CharacterEncodingFilter.java,doFilterInternal,88]\n在 [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,doFilter,206]\n在 [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,internalDoFilter,235]\n在 [com.tandaly.core.web.filter.RequestFilter,RequestFilter.java,doFilter,71]\n在 [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,doFilter,206]\n在 [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,internalDoFilter,290]\n在 [javax.servlet.http.HttpServlet,HttpServlet.java,service,803]\n在 [org.springframework.web.servlet.FrameworkServlet,FrameworkServlet.java,service,812]\n在 [javax.servlet.http.HttpServlet,HttpServlet.java,service,710]\n在 [org.springframework.web.servlet.FrameworkServlet,FrameworkServlet.java,doPost,838]\n在 [org.springframework.web.servlet.FrameworkServlet,FrameworkServlet.java,processRequest,936]\n在 [org.springframework.web.servlet.DispatcherServlet,DispatcherServlet.java,doService,856]\n在 [org.springframework.web.servlet.DispatcherServlet,DispatcherServlet.java,doDispatch,925]\n在 [org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter,AbstractHandlerMethodAdapter.java,handle,80]\n在 [org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter,RequestMappingHandlerAdapter.java,handleInternal,686]\n在 [org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter,RequestMappingHandlerAdapter.java,invokeHandleMethod,745]\n在 [org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod,ServletInvocableHandlerMethod.java,invokeAndHandle,104]\n在 [org.springframework.web.method.support.InvocableHandlerMethod,InvocableHandlerMethod.java,invokeForRequest,132]\n在 [org.springframework.web.method.support.InvocableHandlerMethod,InvocableHandlerMethod.java,invoke,219]\n在 [java.lang.reflect.Method,Method.java,invoke,597]\n在 [sun.reflect.DelegatingMethodAccessorImpl,DelegatingMethodAccessorImpl.java,invoke,25]\n在 [sun.reflect.NativeMethodAccessorImpl,NativeMethodAccessorImpl.java,invoke,39]\n在 [sun.reflect.NativeMethodAccessorImpl,NativeMethodAccessorImpl.java,invoke0,-2]\n在 [com.tandaly.system.admin.actions.DictionaryController,DictionaryController.java,ajaxDeleteDictionary,73]\n在 [com.tandaly.system.admin.service.DictionaryService$$EnhancerByCGLIB$$18be46e5,<generated>,deleteDictionary,-1]\n在 [org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor,CglibAopProxy.java,intercept,631]\n在 [org.springframework.aop.framework.ReflectiveMethodInvocation,ReflectiveMethodInvocation.java,proceed,172]\n在 [org.springframework.transaction.interceptor.TransactionInterceptor,TransactionInterceptor.java,invoke,94]\n在 [org.springframework.transaction.interceptor.TransactionAspectSupport,TransactionAspectSupport.java,invokeWithinTransaction,260]\n在 [org.springframework.transaction.interceptor.TransactionInterceptor$1,TransactionInterceptor.java,proceedWithInvocation,96]\n在 [org.springframework.aop.framework.ReflectiveMethodInvocation,ReflectiveMethodInvocation.java,proceed,150]\n在 [org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation,CglibAopProxy.java,invokeJoinpoint,698]\n在 [org.springframework.cglib.proxy.MethodProxy,MethodProxy.java,invoke,204]\n在 [com.tandaly.system.admin.service.DictionaryService$$FastClassByCGLIB$$9db611f8,<generated>,invoke,-1]\n在 [com.tandaly.system.admin.service.DictionaryService,DictionaryService.java,deleteDictionary,51]\n在 [$Proxy14,null,delete,-1]\n在 [org.apache.ibatis.binding.MapperProxy,MapperProxy.java,invoke,43]\n在 [org.apache.ibatis.binding.MapperMethod,MapperMethod.java,execute,52]\n在 [org.mybatis.spring.SqlSessionTemplate,SqlSessionTemplate.java,delete,264]\n在 [$Proxy12,null,delete,-1]\n在 [org.mybatis.spring.SqlSessionTemplate$SqlSessionInterceptor,SqlSessionTemplate.java,invoke,364]\n在 [org.mybatis.spring.MyBatisExceptionTranslator,MyBatisExceptionTranslator.java,translateExceptionIfPossible,71]\n在 [org.springframework.jdbc.support.AbstractFallbackSQLExceptionTranslator,AbstractFallbackSQLExceptionTranslator.java,translate,72]\n在 [org.springframework.jdbc.support.SQLErrorCodeSQLExceptionTranslator,SQLErrorCodeSQLExceptionTranslator.java,doTranslate,237]\n','2013-07-03 17:31:17'),(12,'org.springframework.jdbc.support.SQLErrorCodeSQLExceptionTranslator','doTranslate','org.springframework.jdbc.BadSqlGrammarException: \r\n### Error updating database.  Cause: com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')\' at line 5\r\n### The error may involve com.tandaly.system.admin.dao.DictionaryDao.delete-Inline\r\n### The error occurred while setting parameters\r\n### SQL: DELETE FROM    t_sys_dictionary   WHERE id IN (        )\r\n### Cause: com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')\' at line 5\n; bad SQL grammar []; nested exception is com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \')\' at line 5\n在 [java.lang.Thread,Thread.java,run,619]\n在 [org.apache.tomcat.util.net.JIoEndpoint$Worker,JIoEndpoint.java,run,447]\n在 [org.apache.coyote.http11.Http11Protocol$Http11ConnectionHandler,Http11Protocol.java,process,583]\n在 [org.apache.coyote.http11.Http11Processor,Http11Processor.java,process,844]\n在 [org.apache.catalina.connector.CoyoteAdapter,CoyoteAdapter.java,service,286]\n在 [org.apache.catalina.core.StandardEngineValve,StandardEngineValve.java,invoke,109]\n在 [org.apache.catalina.valves.ErrorReportValve,ErrorReportValve.java,invoke,102]\n在 [org.apache.catalina.core.StandardHostValve,StandardHostValve.java,invoke,128]\n在 [org.apache.catalina.core.StandardContextValve,StandardContextValve.java,invoke,175]\n在 [org.apache.catalina.core.StandardWrapperValve,StandardWrapperValve.java,invoke,233]\n在 [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,doFilter,206]\n在 [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,internalDoFilter,235]\n在 [org.springframework.web.filter.OncePerRequestFilter,OncePerRequestFilter.java,doFilter,107]\n在 [org.springframework.web.filter.CharacterEncodingFilter,CharacterEncodingFilter.java,doFilterInternal,88]\n在 [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,doFilter,206]\n在 [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,internalDoFilter,235]\n在 [com.tandaly.core.web.filter.RequestFilter,RequestFilter.java,doFilter,71]\n在 [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,doFilter,206]\n在 [org.apache.catalina.core.ApplicationFilterChain,ApplicationFilterChain.java,internalDoFilter,290]\n在 [javax.servlet.http.HttpServlet,HttpServlet.java,service,803]\n在 [org.springframework.web.servlet.FrameworkServlet,FrameworkServlet.java,service,812]\n在 [javax.servlet.http.HttpServlet,HttpServlet.java,service,710]\n在 [org.springframework.web.servlet.FrameworkServlet,FrameworkServlet.java,doPost,838]\n在 [org.springframework.web.servlet.FrameworkServlet,FrameworkServlet.java,processRequest,936]\n在 [org.springframework.web.servlet.DispatcherServlet,DispatcherServlet.java,doService,856]\n在 [org.springframework.web.servlet.DispatcherServlet,DispatcherServlet.java,doDispatch,925]\n在 [org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter,AbstractHandlerMethodAdapter.java,handle,80]\n在 [org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter,RequestMappingHandlerAdapter.java,handleInternal,686]\n在 [org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter,RequestMappingHandlerAdapter.java,invokeHandleMethod,745]\n在 [org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod,ServletInvocableHandlerMethod.java,invokeAndHandle,104]\n在 [org.springframework.web.method.support.InvocableHandlerMethod,InvocableHandlerMethod.java,invokeForRequest,132]\n在 [org.springframework.web.method.support.InvocableHandlerMethod,InvocableHandlerMethod.java,invoke,219]\n在 [java.lang.reflect.Method,Method.java,invoke,597]\n在 [sun.reflect.DelegatingMethodAccessorImpl,DelegatingMethodAccessorImpl.java,invoke,25]\n在 [sun.reflect.NativeMethodAccessorImpl,NativeMethodAccessorImpl.java,invoke,39]\n在 [sun.reflect.NativeMethodAccessorImpl,NativeMethodAccessorImpl.java,invoke0,-2]\n在 [com.tandaly.system.admin.actions.DictionaryController,DictionaryController.java,ajaxDeleteDictionary,73]\n在 [com.tandaly.system.admin.service.DictionaryService$$EnhancerByCGLIB$$18be46e5,<generated>,deleteDictionary,-1]\n在 [org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor,CglibAopProxy.java,intercept,631]\n在 [org.springframework.aop.framework.ReflectiveMethodInvocation,ReflectiveMethodInvocation.java,proceed,172]\n在 [org.springframework.transaction.interceptor.TransactionInterceptor,TransactionInterceptor.java,invoke,94]\n在 [org.springframework.transaction.interceptor.TransactionAspectSupport,TransactionAspectSupport.java,invokeWithinTransaction,260]\n在 [org.springframework.transaction.interceptor.TransactionInterceptor$1,TransactionInterceptor.java,proceedWithInvocation,96]\n在 [org.springframework.aop.framework.ReflectiveMethodInvocation,ReflectiveMethodInvocation.java,proceed,150]\n在 [org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation,CglibAopProxy.java,invokeJoinpoint,698]\n在 [org.springframework.cglib.proxy.MethodProxy,MethodProxy.java,invoke,204]\n在 [com.tandaly.system.admin.service.DictionaryService$$FastClassByCGLIB$$9db611f8,<generated>,invoke,-1]\n在 [com.tandaly.system.admin.service.DictionaryService,DictionaryService.java,deleteDictionary,51]\n在 [$Proxy14,null,delete,-1]\n在 [org.apache.ibatis.binding.MapperProxy,MapperProxy.java,invoke,43]\n在 [org.apache.ibatis.binding.MapperMethod,MapperMethod.java,execute,52]\n在 [org.mybatis.spring.SqlSessionTemplate,SqlSessionTemplate.java,delete,264]\n在 [$Proxy12,null,delete,-1]\n在 [org.mybatis.spring.SqlSessionTemplate$SqlSessionInterceptor,SqlSessionTemplate.java,invoke,364]\n在 [org.mybatis.spring.MyBatisExceptionTranslator,MyBatisExceptionTranslator.java,translateExceptionIfPossible,71]\n在 [org.springframework.jdbc.support.AbstractFallbackSQLExceptionTranslator,AbstractFallbackSQLExceptionTranslator.java,translate,72]\n在 [org.springframework.jdbc.support.SQLErrorCodeSQLExceptionTranslator,SQLErrorCodeSQLExceptionTranslator.java,doTranslate,237]\n','2013-07-03 17:32:23');
/*!40000 ALTER TABLE `t_sys_exceptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_sys_menu`
--

DROP TABLE IF EXISTS `t_sys_menu`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `t_sys_menu` (
  `id` bigint(20) NOT NULL auto_increment,
  `menuNo` varchar(100) NOT NULL,
  `parentNo` varchar(100) NOT NULL default '-1',
  `menuName` varchar(100) NOT NULL,
  `menuUrl` longtext,
  `orderNo` varchar(100) default NULL,
  `click` longtext,
  `target` varchar(50) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `menuName` (`menuName`),
  UNIQUE KEY `menuNo` (`menuNo`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `t_sys_menu`
--

LOCK TABLES `t_sys_menu` WRITE;
/*!40000 ALTER TABLE `t_sys_menu` DISABLE KEYS */;
INSERT INTO `t_sys_menu` VALUES (1,'1','-1','系统管理',NULL,'1','return false;',NULL),(3,'2','-1','基础数据维护',NULL,'3','return false;',NULL),(4,'3','-1','运行监控',NULL,'3','return false;',NULL),(5,'1001','1','用户管理','user/userList.do','1001',NULL,NULL),(6,'1002','1','角色管理','role/roleList.do','1002',NULL,NULL),(9,'2001','2','字典维护','dictionary/dictionaryList.do','2001',NULL,NULL),(10,'2002','2','全局参数','params/paramsList.do','2002',NULL,NULL),(11,'3001','3','事件日志','monitor/requestList.do','3001',NULL,NULL),(12,'3002','3','会话日志','build.do','3002',NULL,NULL),(13,'3003','3','JDBC监控','build.do','3003',NULL,NULL),(14,'3004','3','异常监控','monitor/exceptionsList.do','3004',NULL,NULL),(15,'3005','3','服务器监控','server/serverFrame.do','3005',NULL,NULL),(16,'4','-1','测试管理',NULL,'6',NULL,NULL),(21,'4001','4','测试1','build.do','4001',NULL,NULL),(22,'5','-1','地图管理','','7',NULL,NULL),(23,'5001','5','地图','map/map.do','5001',NULL,NULL),(24,'6','-1','权限中心','','2',NULL,NULL),(25,'6001','6','权限管理','privilege/privilegeFrame.do','6001',NULL,NULL),(26,'6002','6','菜单管理','menu/menuFrame.do','6002',NULL,NULL),(28,'6003','6','功能操作','build.do','6003',NULL,NULL),(29,'6004','6','页面元素','build.do','6004',NULL,NULL),(30,'6005','6','文件权限','build.do','6005',NULL,NULL),(31,'7','-1','数据库管理','build.do','5',NULL,NULL),(32,'7001','7','数据表','build.do','7001',NULL,NULL);
/*!40000 ALTER TABLE `t_sys_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_sys_params`
--

DROP TABLE IF EXISTS `t_sys_params`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `t_sys_params` (
  `id` int(10) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL default '' COMMENT '参数键名',
  `value` varchar(50) NOT NULL default '' COMMENT '参数键值',
  `remark` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='系统全局参数表';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `t_sys_params`
--

LOCK TABLES `t_sys_params` WRITE;
/*!40000 ALTER TABLE `t_sys_params` DISABLE KEYS */;
INSERT INTO `t_sys_params` VALUES (1,'DEFAULT_ADMIN_ACCOUNT','super','默认超级管理员帐户'),(2,'SYS_TITLE','信息管理平台-tandaly','系统标题'),(3,'ENABLED_EXCEPTIONS','启用','启用/禁用 捕获系统异常');
/*!40000 ALTER TABLE `t_sys_params` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_sys_privilege`
--

DROP TABLE IF EXISTS `t_sys_privilege`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `t_sys_privilege` (
  `id` bigint(20) NOT NULL auto_increment,
  `privilegeName` varchar(100) default NULL,
  `remark` varchar(100) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `privilegeName` (`privilegeName`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `t_sys_privilege`
--

LOCK TABLES `t_sys_privilege` WRITE;
/*!40000 ALTER TABLE `t_sys_privilege` DISABLE KEYS */;
INSERT INTO `t_sys_privilege` VALUES (1,'<font color=red>超级权限</font>','拥有系统一切权限(勿删)'),(2,'系统权限','系统级权限'),(3,'测试权限','测试用的'),(5,'地图权限','可以管理地图哦');
/*!40000 ALTER TABLE `t_sys_privilege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_sys_privilege_menu`
--

DROP TABLE IF EXISTS `t_sys_privilege_menu`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `t_sys_privilege_menu` (
  `privilegeId` bigint(20) NOT NULL,
  `menuId` bigint(20) NOT NULL,
  PRIMARY KEY  (`privilegeId`,`menuId`),
  KEY `FKE83B638A1D84A168` (`privilegeId`),
  KEY `FKE83B638AE1AAEF4C` (`menuId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `t_sys_privilege_menu`
--

LOCK TABLES `t_sys_privilege_menu` WRITE;
/*!40000 ALTER TABLE `t_sys_privilege_menu` DISABLE KEYS */;
INSERT INTO `t_sys_privilege_menu` VALUES (1,1),(1,3),(1,4),(1,5),(1,6),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),(1,24),(1,25),(1,26),(1,28),(1,29),(1,30),(1,31),(1,32),(2,1),(2,5),(2,6),(3,16),(3,21),(5,22),(5,23);
/*!40000 ALTER TABLE `t_sys_privilege_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_sys_role`
--

DROP TABLE IF EXISTS `t_sys_role`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `t_sys_role` (
  `id` bigint(20) NOT NULL auto_increment,
  `roleName` varchar(100) NOT NULL COMMENT '角色名称',
  `remark` varchar(50) NOT NULL COMMENT '备注',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `roleName` (`roleName`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `t_sys_role`
--

LOCK TABLES `t_sys_role` WRITE;
/*!40000 ALTER TABLE `t_sys_role` DISABLE KEYS */;
INSERT INTO `t_sys_role` VALUES (1,'<font color=red>超级管理员</font>','最高权限管理员(勿删)'),(2,'系统管理员','管理系统业务权限分配'),(8,'测试角色','测试用'),(10,'地图角色','管理地图的'),(19,'DSFSS','任溶溶');
/*!40000 ALTER TABLE `t_sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_sys_role_privilege`
--

DROP TABLE IF EXISTS `t_sys_role_privilege`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `t_sys_role_privilege` (
  `roleId` bigint(20) NOT NULL,
  `privilegeId` bigint(20) NOT NULL,
  PRIMARY KEY  (`roleId`,`privilegeId`),
  KEY `FKA850DB851D84A168` (`privilegeId`),
  KEY `FKA850DB85FB1983EC` (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `t_sys_role_privilege`
--

LOCK TABLES `t_sys_role_privilege` WRITE;
/*!40000 ALTER TABLE `t_sys_role_privilege` DISABLE KEYS */;
INSERT INTO `t_sys_role_privilege` VALUES (1,1),(2,2),(2,3),(8,3),(19,3),(1,5),(2,5),(10,5),(19,5);
/*!40000 ALTER TABLE `t_sys_role_privilege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_sys_user`
--

DROP TABLE IF EXISTS `t_sys_user`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `t_sys_user` (
  `id` bigint(20) NOT NULL auto_increment,
  `userName` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `registerDate` datetime NOT NULL,
  `status` varchar(50) NOT NULL default '启用' COMMENT '启用/禁用',
  `remark` varchar(50) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `username` (`userName`)
) ENGINE=InnoDB AUTO_INCREMENT=241 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `t_sys_user`
--

LOCK TABLES `t_sys_user` WRITE;
/*!40000 ALTER TABLE `t_sys_user` DISABLE KEYS */;
INSERT INTO `t_sys_user` VALUES (1,'super','123456','2013-05-31 16:44:24','启用','超级管理员'),(2,'admin','123456','2013-05-31 16:44:24','启用','系统管理员'),(118,'admin5','123456','2013-06-24 15:04:06','启用','gsdfs'),(119,'admin2','123456','2013-06-24 15:07:50','启用',NULL),(120,'admin3','123456','2013-06-24 15:08:59','启用',NULL),(121,'admin4','123456','2013-06-24 15:09:11','启用',NULL),(131,'map','123456','2013-06-28 10:37:58','启用',NULL),(133,'sd','123456','2013-06-28 10:47:03','启用','gdsfsdf'),(134,'gew','123456','2013-06-28 10:47:52','启用',NULL),(135,'各位','123456','2013-06-28 10:48:16','启用',NULL),(136,'dsfs','123456','2013-06-28 10:49:00','禁用',NULL),(137,'sdll','123456','2013-06-28 10:50:38','禁用',NULL),(138,'广东省的','123456','2013-06-28 17:37:46','启用','时代复分'),(140,'test','123456','2013-06-28 21:00:51','启用','dsd'),(141,'tandaly0','0123','2013-07-03 12:10:40','启用',NULL),(142,'tandaly1','1123','2013-07-03 12:10:40','启用',NULL),(143,'tandaly2','2123','2013-07-03 12:10:40','启用',NULL),(144,'tandaly3','3123','2013-07-03 12:10:40','启用',NULL),(145,'tandaly4','4123','2013-07-03 12:10:40','启用',NULL),(146,'tandaly5','5123','2013-07-03 12:10:40','启用',NULL),(147,'tandaly6','6123','2013-07-03 12:10:40','启用',NULL),(148,'tandaly7','7123','2013-07-03 12:10:40','启用',NULL),(149,'tandaly8','8123','2013-07-03 12:10:40','启用',NULL),(150,'tandaly9','9123','2013-07-03 12:10:40','启用',NULL),(151,'tandaly10','10123','2013-07-03 12:10:40','启用',NULL),(152,'tandaly11','11123','2013-07-03 12:10:40','启用',NULL),(153,'tandaly12','12123','2013-07-03 12:10:40','启用',NULL),(154,'tandaly13','13123','2013-07-03 12:10:40','启用',NULL),(155,'tandaly14','14123','2013-07-03 12:10:40','启用',NULL),(156,'tandaly15','15123','2013-07-03 12:10:40','启用',NULL),(157,'tandaly16','16123','2013-07-03 12:10:40','启用',NULL),(158,'tandaly17','17123','2013-07-03 12:10:41','启用',NULL),(159,'tandaly18','18123','2013-07-03 12:10:41','启用',NULL),(160,'tandaly19','19123','2013-07-03 12:10:41','启用',NULL),(161,'tandaly20','20123','2013-07-03 12:10:41','启用',NULL),(162,'tandaly21','21123','2013-07-03 12:10:41','启用',NULL),(163,'tandaly22','22123','2013-07-03 12:10:41','启用',NULL),(164,'tandaly23','23123','2013-07-03 12:10:41','启用',NULL),(165,'tandaly24','24123','2013-07-03 12:10:41','启用',NULL),(166,'tandaly25','25123','2013-07-03 12:10:41','启用',NULL),(167,'tandaly26','26123','2013-07-03 12:10:41','启用',NULL),(168,'tandaly27','27123','2013-07-03 12:10:41','启用',NULL),(169,'tandaly28','28123','2013-07-03 12:10:41','启用',NULL),(170,'tandaly29','29123','2013-07-03 12:10:41','启用',NULL),(171,'tandaly30','30123','2013-07-03 12:10:41','启用',NULL),(172,'tandaly31','31123','2013-07-03 12:10:41','启用',NULL),(173,'tandaly32','32123','2013-07-03 12:10:41','启用',NULL),(174,'tandaly33','33123','2013-07-03 12:10:41','启用',NULL),(175,'tandaly34','34123','2013-07-03 12:10:41','启用',NULL),(176,'tandaly35','35123','2013-07-03 12:10:41','启用',NULL),(177,'tandaly36','36123','2013-07-03 12:10:41','启用',NULL),(178,'tandaly37','37123','2013-07-03 12:10:41','启用',NULL),(179,'tandaly38','38123','2013-07-03 12:10:41','启用',NULL),(180,'tandaly39','39123','2013-07-03 12:10:41','启用',NULL),(181,'tandaly40','40123','2013-07-03 12:10:41','启用',NULL),(182,'tandaly41','41123','2013-07-03 12:10:41','启用',NULL),(183,'tandaly42','42123','2013-07-03 12:10:41','启用',NULL),(184,'tandaly43','43123','2013-07-03 12:10:41','启用',NULL),(185,'tandaly44','44123','2013-07-03 12:10:42','启用',NULL),(186,'tandaly45','45123','2013-07-03 12:10:42','启用',NULL),(187,'tandaly46','46123','2013-07-03 12:10:42','启用',NULL),(188,'tandaly47','47123','2013-07-03 12:10:42','启用',NULL),(189,'tandaly48','48123','2013-07-03 12:10:42','启用',NULL),(190,'tandaly49','49123','2013-07-03 12:10:42','启用',NULL),(191,'tandaly50','50123','2013-07-03 12:10:42','启用',NULL),(192,'tandaly51','51123','2013-07-03 12:10:42','启用',NULL),(193,'tandaly52','52123','2013-07-03 12:10:42','启用',NULL),(194,'tandaly53','53123','2013-07-03 12:10:42','启用',NULL),(195,'tandaly54','54123','2013-07-03 12:10:42','启用',NULL),(196,'tandaly55','55123','2013-07-03 12:10:42','启用',NULL),(197,'tandaly56','56123','2013-07-03 12:10:42','启用',NULL),(198,'tandaly57','57123','2013-07-03 12:10:42','启用',NULL),(199,'tandaly58','58123','2013-07-03 12:10:42','启用',NULL),(200,'tandaly59','59123','2013-07-03 12:10:42','启用',NULL),(201,'tandaly60','60123','2013-07-03 12:10:42','启用',NULL),(202,'tandaly61','61123','2013-07-03 12:10:42','启用',NULL),(203,'tandaly62','62123','2013-07-03 12:10:42','启用',NULL),(204,'tandaly63','63123','2013-07-03 12:10:42','启用',NULL),(205,'tandaly64','64123','2013-07-03 12:10:42','启用',NULL),(206,'tandaly65','65123','2013-07-03 12:10:42','启用',NULL),(207,'tandaly66','66123','2013-07-03 12:10:42','启用',NULL),(208,'tandaly67','67123','2013-07-03 12:10:42','启用',NULL),(209,'tandaly68','68123','2013-07-03 12:10:42','启用',NULL),(210,'tandaly69','69123','2013-07-03 12:10:42','启用',NULL),(211,'tandaly70','70123','2013-07-03 12:10:42','启用',NULL),(212,'tandaly71','71123','2013-07-03 12:10:42','启用',NULL),(213,'tandaly72','72123','2013-07-03 12:10:43','启用',NULL),(214,'tandaly73','73123','2013-07-03 12:10:43','启用',NULL),(215,'tandaly74','74123','2013-07-03 12:10:43','启用',NULL),(216,'tandaly75','75123','2013-07-03 12:10:43','启用',NULL),(217,'tandaly76','76123','2013-07-03 12:10:43','启用',NULL),(218,'tandaly77','77123','2013-07-03 12:10:43','启用',NULL),(219,'tandaly78','78123','2013-07-03 12:10:43','启用',NULL),(220,'tandaly79','79123','2013-07-03 12:10:43','启用',NULL),(221,'tandaly80','80123','2013-07-03 12:10:43','启用',NULL),(222,'tandaly81','81123','2013-07-03 12:10:43','启用',NULL),(223,'tandaly82','82123','2013-07-03 12:10:43','启用',NULL),(224,'tandaly83','83123','2013-07-03 12:10:43','启用',NULL),(225,'tandaly84','84123','2013-07-03 12:10:43','启用',NULL),(226,'tandaly85','85123','2013-07-03 12:10:43','启用',NULL),(227,'tandaly86','86123','2013-07-03 12:10:43','启用',NULL),(228,'tandaly87','87123','2013-07-03 12:10:43','启用',NULL),(229,'tandaly88','88123','2013-07-03 12:10:43','启用',NULL),(230,'tandaly89','89123','2013-07-03 12:10:43','启用',NULL),(231,'tandaly90','90123','2013-07-03 12:10:43','启用',NULL),(232,'tandaly91','91123','2013-07-03 12:10:43','启用',NULL),(233,'tandaly92','92123','2013-07-03 12:10:43','启用',NULL),(234,'tandaly93','93123','2013-07-03 12:10:43','启用',NULL),(235,'tandaly94','94123','2013-07-03 12:10:43','启用',NULL),(236,'tandaly95','95123','2013-07-03 12:10:44','启用',NULL),(237,'tandaly96','96123','2013-07-03 12:10:44','启用',NULL),(238,'tandaly97','97123','2013-07-03 12:10:44','启用',NULL),(239,'tandaly98','98123','2013-07-03 12:10:44','启用',NULL),(240,'tandaly99','99123','2013-07-03 12:10:44','启用',NULL);
/*!40000 ALTER TABLE `t_sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_sys_user_role`
--

DROP TABLE IF EXISTS `t_sys_user_role`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `t_sys_user_role` (
  `userId` bigint(20) NOT NULL,
  `roleId` bigint(20) NOT NULL,
  PRIMARY KEY  (`userId`,`roleId`),
  KEY `FKEEC648EDFB1983EC` (`roleId`),
  KEY `FKEEC648EDA04447CC` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `t_sys_user_role`
--

LOCK TABLES `t_sys_user_role` WRITE;
/*!40000 ALTER TABLE `t_sys_user_role` DISABLE KEYS */;
INSERT INTO `t_sys_user_role` VALUES (1,1),(2,2),(3,8),(118,8),(138,8),(131,10),(140,10),(138,19);
/*!40000 ALTER TABLE `t_sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-07-03  9:58:03
