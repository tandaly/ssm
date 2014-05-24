package com.tanf.core.metatype.impl;

import java.io.Serializable;
import java.util.HashMap;

import com.tanf.core.metatype.ResponseMap;
/**
 * 响应数据集实现
 * @author tanf(tandaly001@gmail.com)
 * @date 2013-6-29 下午11:37:00
 */
public class HashResponseMap extends HashMap<String, Object> implements ResponseMap,
		Serializable {
	
	private static final long serialVersionUID = -4181926242140734681L;

	public HashResponseMap()
	{
		
	}
	
	public HashResponseMap(String key, Object value)
	{
		put(key, value);
	}

	@Override
	public void setInfo(Object info) {
		put(INFO, info);
	}

	@Override
	public Object getInfo() {
		return get(INFO);
	}

	@Override
	public void setStatus(boolean b) {
		put(STATUS, b?"y":"n");
	}

	@Override
	public boolean getStatus() {
		return get(STATUS) == "y"?true:false;
	}

}
