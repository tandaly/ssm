package com.tanf.system.admin.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;

import com.tanf.core.dao.BaseDao;
import com.tanf.system.admin.beans.Role;
import com.tanf.system.admin.beans.User;

public interface UserDao extends BaseDao
{

	/**
	 * 登录查询
	 * @param userName
	 * @return
	 */
	User logins(String userName);
	
	/**
	 * 验证修改的用户
	 * @param role
	 * @return
	 */
	Integer checkUpdateUser(User user);
	
	/**
	 * 根据用户id分页查询角色总数
	 * @param paramMap
	 * @return
	 */
	Integer pageQueryUserRoleCount(Map<String, Object> paramMap);
	
	/**
	 * 根据用户id分页查询角色列表
	 * @param paramMap
	 * @return
	 */
	List<Role> pageQueryUserRoleList(Map<String, Object> paramMap);
	
	/**
	 * 分页查询选择角色总数
	 * @param paramMap
	 * @return
	 */
	Integer pageQuerySelectRoleCount(Map<String, Object> paramMap);
	
	/**
	 * 分页查询选择角色列表
	 * @param paramMap
	 * @return
	 */
	List<Role> pageQuerySelectRoleList(Map<String, Object> paramMap);
	
	/**
	 * 分配角色给用户
	 * @param paramMap
	 * @return
	 */
	Integer allotUserRole(Map<String, Object> paramMap);
	
	/**
	 * 根据角色id和用户id删除关联
	 * @param paramMap
	 * @return
	 */
	Integer deleteUserRole(Map<String, Object> paramMap);
	
	/**
	 * 删除用户和角色的关联关系
	 * @param userIds
	 * @return
	 */
	Integer deleteUserRoleByUserIds(String userIds);
	
	/**
	 * 启用或禁用帐号
	 * @param paramMap
	 * @return
	 */
	Integer updateUserStatus(Map<String, Object> paramMap);
	
	
	
	
	
	
	
	
	@Select("SELECT * FROM USER")
	List<User> queryUser2();
}
