package com.tanf.system.admin.dao;

import com.tanf.core.dao.BaseDao;
import com.tanf.system.admin.beans.Params;
/**
 * 系统全局参数持久层
 * @author Tandaly
 * @date 2013-7-1 下午3:14:36
 */
public interface ParamsDao extends BaseDao
{

	/**
	 * 检测修改的参数对象
	 * @param params
	 * @return
	 */
	Integer checkUpdateParams(Params params);
}
