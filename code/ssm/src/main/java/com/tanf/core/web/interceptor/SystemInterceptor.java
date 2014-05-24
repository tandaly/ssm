package com.tanf.core.web.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.core.NamedThreadLocal;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

/**
 * 系统拦截器
 * @author tanfei(619606426@qq.com)
 * @date 2013-2-3 下午9:55:23
 */
public class SystemInterceptor implements HandlerInterceptor {

	private Logger log = Logger.getLogger(SystemInterceptor.class);
	
	private NamedThreadLocal<Long> startTimeThreadLocal = 
			new NamedThreadLocal<Long>("StopWatch-StartTime");
	

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object nextInterceptor) throws Exception {
		log.info("1、请求到达控制器前执行，请求路径=" + request.getServletPath());
		long startTime = System.currentTimeMillis();
		startTimeThreadLocal.set(startTime);//线程绑定变量（该数据只有当前请求的线程可见）
		return true;
	}
	

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response,
			Object obj, ModelAndView model) throws Exception {
		log.info("2、执行完控制器后并未生成视图前执行，响应视图=" + (null != model?model.getViewName():"无视图"));
		long endTime = System.currentTimeMillis();
		
		long responseTime = endTime - startTimeThreadLocal.get();
		if(null != model)
		{
			model.getModel().put("responseTime", responseTime);
		}
		else
		{
			model = new ModelAndView();
		}
		
		if(null != model.getViewName() 
				&& !model.getViewName().equals("redirect:/index.do"))
		{
			//项目根路径
			String base = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
			model.addObject("base", base);
		}
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object nextInterceptor, Exception arg3)
			throws Exception {
		log.info("3、执行完成后执行，一般用于在1当中创建的对象，在这里可以进行释放，例如数据库连接之类的\n");
	}
	


}
