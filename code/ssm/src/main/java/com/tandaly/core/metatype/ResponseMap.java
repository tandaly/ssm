package com.tandaly.core.metatype;

import java.util.Map;
/**
 * 响应数据集接口
 * @author tandaly(tandaly001@gmail.com)
 * @date 2013-6-29 下午11:37:20
 */
public interface ResponseMap extends Map<String, Object> {

	public static final String INFO = "info";//信息
	public static final String STATUS = "status";//状态
	
	/**
	 * 设置返回信息
	 * @param info
	 */
	public void setInfo(Object info);
	
	/**
	 * 获得返回信息
	 * @return
	 */
	public Object getInfo();
	
	/**
	 * 设置操作状态
	 * @param b
	 */
	public void setStatus(boolean b);
	
	/**
	 * 获得操作状态
	 * @return
	 */
	public boolean getStatus();
}
