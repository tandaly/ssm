package com.tandaly.core.web.interceptor;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import com.tandaly.core.spring.SpringFactory;
import com.tandaly.core.util.Constants;
import com.tandaly.core.util.DateUtil;
import com.tandaly.system.admin.service.MonitorService;
import com.tandaly.system.common.util.ParamsConstants;
/**
 * 系统异常拦截器
 * @author Tandaly
 * @date 2013-7-1 下午5:39:01
 */
public class SystemExeptionResolver implements HandlerExceptionResolver
{

	Logger log = Logger.getLogger(SystemExeptionResolver.class);
	
	@Override
	public ModelAndView resolveException(HttpServletRequest request,
			HttpServletResponse response, Object obj, Exception e)
	{
		//这里可根据不同异常引起类做不同处理方式，本例做不同返回页面。 
//		Map<String, Object> model = new HashMap<String, Object>();
//		model.put("data", "");
//		return new ModelAndView("视图名", model);
		
		this.log.info("系统发生异常啦");
		if(Constants.ENABLED_Y.equals(ParamsConstants.SYSTEM_PARAMS.get(
				ParamsConstants.ENABLED_EXCEPTIONS)))
		{//如果系统异常为启用状态，ze需要保存异常到数据库
			saveExeptions(e);
		}
		
		return null;
	}
	
	/**
	 * 保存异常到数据库
	 * @param e
	 */
	public void saveExeptions(Exception e)
	{
		 StackTraceElement[] stackTraceElements = e.getStackTrace();
		 String exceptionMsg = e.toString() + "\n";
		 StackTraceElement se = null;
		 for (int index = 0; index <= stackTraceElements.length - 1; index++) {
			 exceptionMsg += "在 [" + stackTraceElements[index].getClassName() + ",";
			 exceptionMsg += stackTraceElements[index].getFileName() + ",";
			 exceptionMsg += stackTraceElements[index].getMethodName() + ",";
			 exceptionMsg += stackTraceElements[index].getLineNumber() + "]\n";
			 
			 System.out.println(stackTraceElements[index].getClassName());
			 if(null == se && stackTraceElements[index].getClassName()
					 .indexOf(ParamsConstants.SYSTEM_PARAMS.get("EXCEPTIONS_PACKAGE").toString()) != -1)
			 {
				 se = stackTraceElements[index];
			 }
		}
		
		if(null == se)
		{
			se = stackTraceElements[0];
		}
          
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("className", se.getClassName());
		params.put("methodName", se.getMethodName());
		params.put("description", exceptionMsg);
		params.put("activeTime", DateUtil.getCurrDateTime());
		
		MonitorService monitorService = SpringFactory.getBean(MonitorService.class);
		monitorService.saveExceptions(params);
		
	}

}
