package com.tanf.core.util;
/**
 * 系统常量类
 * @author tanf(tandaly001@gmail.com)
 * @date 2013-6-29 下午3:08:13
 */
public interface Constants {
	
	/**
	 * 登录用户session
	 */
	public static final String LOGIN_USER_SESSION = "user";
	
	/**
	 * 请求后缀
	 */
	public static final String REQUEST_SUFFIX = ".do";
	
	/**
	 * 参数分隔符
	 */
	public static final String PARAM_SEPARATOR = ",";
	
	/**
	 * 路径分隔符
	 */
	public static final String PATH_SEPARATOR = "/";

	/**
	 * 启用状态<br>
	 */
	public static final String ENABLED_Y = "启用"; 
	
	/**
	 * 禁用状态<br>
	 */
	public static final String ENABLED_N = "禁用";
	
	/**
	 * 格式化(24小时制)<br>
	 * FORMAT_DateTime: 日期时间
	 */
	public static final String FORMAT_DateTime = "yyyy-MM-dd HH:mm:ss";
	
	/**
	 * 格式化(12小时制)<br>
	 * FORMAT_DateTime: 日期时间
	 */
	public static final String FORMAT_DateTime_12 = "yyyy-MM-dd hh:mm:ss";

	/**
	 * 格式化<br>
	 * FORMAT_DateTime: 日期
	 */
	public static final String FORMAT_Date = "yyyy-MM-dd";

	/**
	 * 格式化(24小时制)<br>
	 * FORMAT_DateTime: 时间
	 */
	public static final String FORMAT_Time = "HH:mm:ss";
	
	/**
	 * 格式化(12小时制)<br>
	 * FORMAT_DateTime: 时间
	 */
	public static final String FORMAT_Time_12 = "hh:mm:ss";

	/**
	 * 换行符<br>
	 * \n:换行
	 */
	public static final String ENTER = "\n";
}
