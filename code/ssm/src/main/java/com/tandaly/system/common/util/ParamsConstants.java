package com.tandaly.system.common.util;

import java.util.HashMap;
import java.util.Map;

public interface ParamsConstants
{
	/**
	 * 系统参数集合(系统启动时加载)
	 */
	public static final Map<String, Object> SYSTEM_PARAMS = new HashMap<String, Object>();

	/**
	 * 系统标题
	 */
	public static final String SYS_TITLE = "SYS_TITLE";
	
	/**
	 * 默认超级管理员账户
	 */
	public static final String DEFAULT_ADMIN_ACCOUNT = "DEFAULT_ADMIN_ACCOUNT";
	
	/**
	 * 启用/禁用 系统异常捕获
	 */
	public static final String ENABLED_EXCEPTIONS = "ENABLED_EXCEPTIONS";
}
