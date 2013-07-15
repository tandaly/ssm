package com.tandaly.system.admin.dao;

import com.tandaly.core.dao.BaseDao;
import com.tandaly.system.admin.beans.Notice;
/**
 * 系统公告数据持久层操作
 * @author Tandaly
 * @date 2013-7-15 下午2:11:10
 */
public interface NoticeDao extends BaseDao
{

	/**
	 * 查询最新系统公告(首页)
	 * @return
	 */
	Notice queryNewNotice();
}
