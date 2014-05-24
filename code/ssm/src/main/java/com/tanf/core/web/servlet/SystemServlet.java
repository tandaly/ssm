package com.tanf.core.web.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.apache.log4j.Logger;

import com.tanf.core.util.SystemUtil;

/**
 * 服务器启动时初始化操作
 * @author Tandaly
 * @date 2013-3-6 上午11:05:42
 */
public class SystemServlet extends HttpServlet
{
	
	private Logger log = Logger.getLogger(SystemServlet.class);
    /**
	 * 序列号
	 */
	private static final long serialVersionUID = -53411255141980767L;

	//销毁
    public void destroy()
    {
        super.destroy();
    }
    
    //初始化主方法
    public void init() throws ServletException
    {
    	log.info("----------------初始化操作开始------------");
    	log.info("--开始获得操作bean");
    	//MenuService mService = SpringFactory.getBean("menuService");
    	/*MenuService mService = SpringFactory.getBean(MenuService.class);
    	List<Menu> menus = mService.queryMenusByMenu(null);
    	for(Menu m:menus)
    	{
    		log.info(m.getMenuName());
    	}*/
    	log.info("--开始进行数据库初始化操作");
    	//initDB.excute();
    	
    	log.info("开始加载系统全局参数信息");
    	SystemUtil.loadSystemParams();
    	log.info("完成加载系统全局参数信息");
    	
    	log.info("--初始化完成");
    	
    }
    
    
   
}
