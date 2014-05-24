package com.tanf.core.web.listener;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.apache.log4j.Logger;
/**
 * 系统session监听器
 * @author Tandaly
 * @date 2013-7-8 下午3:17:11
 */
public class SystemSessionListener implements HttpSessionListener
{
	private Logger log = Logger.getLogger(SystemSessionListener.class);

	/**
	 * session创建
	 */
	@Override
	public void sessionCreated(HttpSessionEvent event)
	{
		this.log.info("一个session被创建~" + event.getSession().getId());
	}

	/**
	 * session销毁
	 */
	@Override
	public void sessionDestroyed(HttpSessionEvent event)
	{
		this.log.info("一个session被销毁~" + event.getSession().getId());
	}

}
