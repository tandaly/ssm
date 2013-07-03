-- --------------------------------------------------------
-- 主机                            :127.0.0.1
-- 服务器版本                         :5.0.67-community-log - MySQL Community Edition (GPL)
-- 服务器操作系统                       :Win32
-- HeidiSQL 版本                   :7.0.0.4278
-- 创建                            :2013-07-01 18:02:20
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 导出  表 share.t_sys_dictionary 结构
DROP TABLE IF EXISTS `t_sys_dictionary`;
CREATE TABLE IF NOT EXISTS `t_sys_dictionary` (
  `id` int(10) NOT NULL auto_increment,
  `key` varchar(50) NOT NULL default '' COMMENT '键',
  `name` varchar(50) NOT NULL default '' COMMENT '名称',
  `value` varchar(50) NOT NULL default '' COMMENT '值',
  `status` varchar(50) NOT NULL default '启用' COMMENT '启用/禁用  默认''启用''',
  `remark` varchar(50) NOT NULL default '' COMMENT '描述',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `key` (`key`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='字典表';

-- 正在导出表  share.t_sys_dictionary 的数据: ~2 rows ((大约))
/*!40000 ALTER TABLE `t_sys_dictionary` DISABLE KEYS */;
INSERT INTO `t_sys_dictionary` (`id`, `key`, `name`, `value`, `status`, `remark`) VALUES
	(1, 'TIME_FORMAT', '时间格式', 'yyyy-MM-dd HH:mm:ss', '启用', '一般的事件格式'),
	(2, 'DATE_FORMAT', '日期格式', 'yyyy-MM-dd', '启用', '通用的日期格式');
/*!40000 ALTER TABLE `t_sys_dictionary` ENABLE KEYS */;


-- 导出  表 share.t_sys_event 结构
DROP TABLE IF EXISTS `t_sys_event`;
CREATE TABLE IF NOT EXISTS `t_sys_event` (
  `id` bigint(20) NOT NULL auto_increment COMMENT '事件ID',
  `userId` varchar(8) default NULL COMMENT '用户ID',
  `userName` varchar(100) default NULL COMMENT '用户名',
  `description` varchar(100) default NULL COMMENT '事件描述',
  `activeTime` varchar(50) default NULL COMMENT '活动时间',
  `requestPath` varchar(200) default NULL COMMENT '请求路径',
  `methodName` varchar(50) default NULL COMMENT '请求方法名',
  `costTime` int(10) default NULL COMMENT '耗时',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6101 DEFAULT CHARSET=utf8 COMMENT='操作员事件表';

-- 正在导出表  share.t_sys_event 的数据: ~1,245 rows ((大约))
/*!40000 ALTER TABLE `t_sys_event` DISABLE KEYS */;
INSERT INTO `t_sys_event` (`id`, `userId`, `userName`, `description`, `activeTime`, `requestPath`, `methodName`, `costTime`) VALUES
	(6099, '1', 'super', '[super]调用了方法[ajaxClearEvent]', '2013-07-01 18:02:01', '/share/monitor/ajaxClearEvent.do', 'ajaxClearEvent', 78),
	(6100, '1', 'super', '[super]调用了方法[ajaxEventList]', '2013-07-01 18:02:01', '/share/monitor/ajaxEventList.do', 'ajaxEventList', 31);
/*!40000 ALTER TABLE `t_sys_event` ENABLE KEYS */;


-- 导出  表 share.t_sys_exceptions 结构
DROP TABLE IF EXISTS `t_sys_exceptions`;
CREATE TABLE IF NOT EXISTS `t_sys_exceptions` (
  `id` int(10) NOT NULL auto_increment,
  `className` varchar(50) NOT NULL default '' COMMENT '类名',
  `methodName` varchar(50) NOT NULL default '' COMMENT '方法',
  `description` varchar(50) NOT NULL default '' COMMENT '异常信息',
  `activeTime` varchar(50) NOT NULL default '' COMMENT '激活时间',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='系统异常信息表';

-- 正在导出表  share.t_sys_exceptions 的数据: ~1 rows ((大约))
/*!40000 ALTER TABLE `t_sys_exceptions` DISABLE KEYS */;
INSERT INTO `t_sys_exceptions` (`id`, `className`, `methodName`, `description`, `activeTime`) VALUES
	(1, 'com.tandaly.system.admin.userService', 'addUser', 'nullException', '2013-07-01 10:10:10'),
	(2, 'com.tandaly.system.admin.userDao', 'delete', 'fail', '2013-07-02 10:10:10'),
	(5, 'java.lang.Exception: hahahh哈哈', 'method', 'hahahh哈哈', '2013-07-01 17:59:58');
/*!40000 ALTER TABLE `t_sys_exceptions` ENABLE KEYS */;


-- 导出  表 share.t_sys_menu 结构
DROP TABLE IF EXISTS `t_sys_menu`;
CREATE TABLE IF NOT EXISTS `t_sys_menu` (
  `id` bigint(20) NOT NULL auto_increment,
  `menuNo` varchar(100) NOT NULL,
  `parentNo` varchar(100) NOT NULL default '-1',
  `menuName` varchar(100) NOT NULL,
  `menuUrl` longtext,
  `orderNo` varchar(100) default NULL,
  `click` longtext,
  `target` varchar(50) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `menuName` (`menuName`),
  UNIQUE KEY `menuNo` (`menuNo`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- 正在导出表  share.t_sys_menu 的数据: ~22 rows ((大约))
/*!40000 ALTER TABLE `t_sys_menu` DISABLE KEYS */;
INSERT INTO `t_sys_menu` (`id`, `menuNo`, `parentNo`, `menuName`, `menuUrl`, `orderNo`, `click`, `target`) VALUES
	(1, '1', '-1', '系统管理', NULL, '1', 'return false;', NULL),
	(3, '2', '-1', '基础数据维护', NULL, '3', 'return false;', NULL),
	(4, '3', '-1', '运行监控', NULL, '3', 'return false;', NULL),
	(5, '1001', '1', '用户管理', 'user/userList.do', '1001', NULL, NULL),
	(6, '1002', '1', '角色管理', 'role/roleList.do', '1002', NULL, NULL),
	(9, '2001', '2', '字典维护', 'dictionary/dictionaryList.do', '2001', NULL, NULL),
	(10, '2002', '2', '全局参数', 'params/paramsList.do', '2002', NULL, NULL),
	(11, '3001', '3', '事件日志', 'monitor/requestList.do', '3001', NULL, NULL),
	(12, '3002', '3', '会话日志', 'build.do', '3002', NULL, NULL),
	(13, '3003', '3', 'JDBC监控', 'build.do', '3003', NULL, NULL),
	(14, '3004', '3', '异常监控', 'monitor/exceptionsList.do', '3004', NULL, NULL),
	(15, '3005', '3', '服务器监控', 'server/serverFrame.do', '3005', NULL, NULL),
	(16, '4', '-1', '测试管理', NULL, '4', NULL, NULL),
	(21, '4001', '4', '测试1', 'build.do', '4001', NULL, NULL),
	(22, '5', '-1', '地图管理', '', '5', NULL, NULL),
	(23, '5001', '5', '地图', 'map/map.do', '5001', NULL, NULL),
	(24, '6', '-1', '权限中心', '', '2', NULL, NULL),
	(25, '6001', '6', '权限管理', 'privilege/privilegeFrame.do', '6001', NULL, NULL),
	(26, '6002', '6', '菜单管理', 'menu/menuFrame.do', '6002', NULL, NULL),
	(28, '6003', '6', '功能操作', 'build.do', '6003', NULL, NULL),
	(29, '6004', '6', '页面元素', 'build.do', '6004', NULL, NULL),
	(30, '6005', '6', '文件权限', 'build.do', '6005', NULL, NULL);
/*!40000 ALTER TABLE `t_sys_menu` ENABLE KEYS */;


-- 导出  表 share.t_sys_params 结构
DROP TABLE IF EXISTS `t_sys_params`;
CREATE TABLE IF NOT EXISTS `t_sys_params` (
  `id` int(10) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL default '' COMMENT '参数键名',
  `value` varchar(50) NOT NULL default '' COMMENT '参数键值',
  `remark` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='系统全局参数表';

-- 正在导出表  share.t_sys_params 的数据: ~2 rows ((大约))
/*!40000 ALTER TABLE `t_sys_params` DISABLE KEYS */;
INSERT INTO `t_sys_params` (`id`, `name`, `value`, `remark`) VALUES
	(1, 'DEFAULT_ADMIN_ACCOUNT', 'super', '默认超级管理员帐户'),
	(2, 'SYS_TITLE', '信息管理平台', '系统标题');
/*!40000 ALTER TABLE `t_sys_params` ENABLE KEYS */;


-- 导出  表 share.t_sys_privilege 结构
DROP TABLE IF EXISTS `t_sys_privilege`;
CREATE TABLE IF NOT EXISTS `t_sys_privilege` (
  `id` bigint(20) NOT NULL auto_increment,
  `privilegeName` varchar(100) default NULL,
  `remark` varchar(100) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `privilegeName` (`privilegeName`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- 正在导出表  share.t_sys_privilege 的数据: ~4 rows ((大约))
/*!40000 ALTER TABLE `t_sys_privilege` DISABLE KEYS */;
INSERT INTO `t_sys_privilege` (`id`, `privilegeName`, `remark`) VALUES
	(1, '<font color=red>超级权限</font>', '拥有系统一切权限(勿删)'),
	(2, '系统权限', '系统级权限'),
	(3, '测试权限', '测试用的'),
	(5, '地图权限', '可以管理地图哦');
/*!40000 ALTER TABLE `t_sys_privilege` ENABLE KEYS */;


-- 导出  表 share.t_sys_privilege_menu 结构
DROP TABLE IF EXISTS `t_sys_privilege_menu`;
CREATE TABLE IF NOT EXISTS `t_sys_privilege_menu` (
  `privilegeId` bigint(20) NOT NULL,
  `menuId` bigint(20) NOT NULL,
  PRIMARY KEY  (`privilegeId`,`menuId`),
  KEY `FKE83B638A1D84A168` (`privilegeId`),
  KEY `FKE83B638AE1AAEF4C` (`menuId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  share.t_sys_privilege_menu 的数据: ~25 rows ((大约))
/*!40000 ALTER TABLE `t_sys_privilege_menu` DISABLE KEYS */;
INSERT INTO `t_sys_privilege_menu` (`privilegeId`, `menuId`) VALUES
	(1, 1),
	(1, 3),
	(1, 4),
	(1, 5),
	(1, 6),
	(1, 9),
	(1, 10),
	(1, 11),
	(1, 12),
	(1, 13),
	(1, 14),
	(1, 15),
	(1, 24),
	(1, 25),
	(1, 26),
	(1, 28),
	(1, 29),
	(1, 30),
	(2, 1),
	(2, 5),
	(2, 6),
	(3, 16),
	(3, 21),
	(5, 22),
	(5, 23);
/*!40000 ALTER TABLE `t_sys_privilege_menu` ENABLE KEYS */;


-- 导出  表 share.t_sys_role 结构
DROP TABLE IF EXISTS `t_sys_role`;
CREATE TABLE IF NOT EXISTS `t_sys_role` (
  `id` bigint(20) NOT NULL auto_increment,
  `roleName` varchar(100) NOT NULL COMMENT '角色名称',
  `remark` varchar(50) NOT NULL COMMENT '备注',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `roleName` (`roleName`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- 正在导出表  share.t_sys_role 的数据: ~5 rows ((大约))
/*!40000 ALTER TABLE `t_sys_role` DISABLE KEYS */;
INSERT INTO `t_sys_role` (`id`, `roleName`, `remark`) VALUES
	(1, '<font color=red>超级管理员</font>', '最高权限管理员(勿删)'),
	(2, '系统管理员', '管理系统业务权限分配'),
	(8, '测试角色', '测试用'),
	(10, '地图角色', '管理地图的'),
	(19, 'DSFSS', '任溶溶');
/*!40000 ALTER TABLE `t_sys_role` ENABLE KEYS */;


-- 导出  表 share.t_sys_role_privilege 结构
DROP TABLE IF EXISTS `t_sys_role_privilege`;
CREATE TABLE IF NOT EXISTS `t_sys_role_privilege` (
  `roleId` bigint(20) NOT NULL,
  `privilegeId` bigint(20) NOT NULL,
  PRIMARY KEY  (`roleId`,`privilegeId`),
  KEY `FKA850DB851D84A168` (`privilegeId`),
  KEY `FKA850DB85FB1983EC` (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  share.t_sys_role_privilege 的数据: ~9 rows ((大约))
/*!40000 ALTER TABLE `t_sys_role_privilege` DISABLE KEYS */;
INSERT INTO `t_sys_role_privilege` (`roleId`, `privilegeId`) VALUES
	(1, 1),
	(2, 2),
	(2, 3),
	(8, 3),
	(19, 3),
	(1, 5),
	(2, 5),
	(10, 5),
	(19, 5);
/*!40000 ALTER TABLE `t_sys_role_privilege` ENABLE KEYS */;


-- 导出  表 share.t_sys_user 结构
DROP TABLE IF EXISTS `t_sys_user`;
CREATE TABLE IF NOT EXISTS `t_sys_user` (
  `id` bigint(20) NOT NULL auto_increment,
  `userName` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `registerDate` datetime NOT NULL,
  `status` varchar(50) NOT NULL default '启用' COMMENT '启用/禁用',
  `remark` varchar(50) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `username` (`userName`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8;

-- 正在导出表  share.t_sys_user 的数据: ~14 rows ((大约))
/*!40000 ALTER TABLE `t_sys_user` DISABLE KEYS */;
INSERT INTO `t_sys_user` (`id`, `userName`, `password`, `registerDate`, `status`, `remark`) VALUES
	(1, 'super', '123456', '2013-05-31 16:44:24', '启用', '超级管理员'),
	(2, 'admin', '123456', '2013-05-31 16:44:24', '启用', '系统管理员'),
	(118, 'admin5', '123456', '2013-06-24 15:04:06', '启用', 'gsdfs'),
	(119, 'admin2', '123456', '2013-06-24 15:07:50', '启用', NULL),
	(120, 'admin3', '123456', '2013-06-24 15:08:59', '启用', NULL),
	(121, 'admin4', '123456', '2013-06-24 15:09:11', '启用', NULL),
	(131, 'map', '123456', '2013-06-28 10:37:58', '启用', NULL),
	(133, 'sd', '123456', '2013-06-28 10:47:03', '启用', 'gdsfsdf'),
	(134, 'gew', '123456', '2013-06-28 10:47:52', '启用', NULL),
	(135, '各位', '123456', '2013-06-28 10:48:16', '启用', NULL),
	(136, 'dsfs', '123456', '2013-06-28 10:49:00', '禁用', NULL),
	(137, 'sdll', '123456', '2013-06-28 10:50:38', '禁用', NULL),
	(138, '广东省的', '123456', '2013-06-28 17:37:46', '启用', '时代复分'),
	(140, 'test', '123456', '2013-06-28 21:00:51', '启用', 'dsd');
/*!40000 ALTER TABLE `t_sys_user` ENABLE KEYS */;


-- 导出  表 share.t_sys_user_role 结构
DROP TABLE IF EXISTS `t_sys_user_role`;
CREATE TABLE IF NOT EXISTS `t_sys_user_role` (
  `userId` bigint(20) NOT NULL,
  `roleId` bigint(20) NOT NULL,
  PRIMARY KEY  (`userId`,`roleId`),
  KEY `FKEEC648EDFB1983EC` (`roleId`),
  KEY `FKEEC648EDA04447CC` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  share.t_sys_user_role 的数据: ~7 rows ((大约))
/*!40000 ALTER TABLE `t_sys_user_role` DISABLE KEYS */;
INSERT INTO `t_sys_user_role` (`userId`, `roleId`) VALUES
	(1, 1),
	(2, 2),
	(3, 8),
	(118, 8),
	(138, 8),
	(131, 10),
	(140, 10);
/*!40000 ALTER TABLE `t_sys_user_role` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
