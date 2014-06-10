/**
 * Copyright 1996-2013 Founder International Co.,Ltd.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * 
 * @author kenshin
 */
package com.founder.fix.fixflow.core.internationalization;

/**
 * 流程引擎国际化处理类
 * @author ych
 *
 */
public interface FixFlowResources {
	
	/**
	 * 任务命令国际化配置文件名
	 */
	public static String TaskComandResource="FixFlow_SystemTaskComandResource";
	
	/**
	 * 组织机构国际化配置文件名
	 */
	public static String OrganizationResource="FixFlow_OrganizationResource";
	
	/**
	 * 系统国际化配置文件
	 */
	public static String SystemResource="FixFlow_SystemResource";
	
	/**
	 * 流程名称的国际化资源文件
	 */
	public static String FlowNameResource = "FixFlow_FlowNameResource";
	
	/**
	 * 获取指定文件中，指定key的国际化值
	 * @param propertiesName 资源文件名前缀，不包含后缀名 
	 * @param resourceKey 需要获取的key
	 * @return 如果存在则返回对应值，不存在返回key本身
	 */
	public String getResourceValue(String propertiesName,String resourceKey);
	
	/**
	 * 带占位符的国际化值得获取
	 * @param propertiesName资源文件名前缀，不包含后缀名 
	 * @param resourceKey需要获取的key
	 * @param args 资源文件里可以配置为  “*****{0},\''{1}\''****”格式，参数会对应替换
	 * @return
	 */
	public String getResourceValue(String propertiesName,String resourceKey,Object... args);
	
	/**
	 * 获取指定国际化资源文件中，指定key,指定语言的国际化值
	 * @param propertiesName 资源文件名前缀，不包含后缀名 
	 * @param resourceKey 需要获取的key
	 * @param languageName 语言名-资源文件夹名，如 zh-CN en-US
	 * @return 如果存在则返回对应值，不存在返回key本身
	 */
	public String getResourceValue(String propertiesName,String resourceKey,String languageName);
	
	/**
	 * 获取指定国际化资源文件中，指定key,指定语言的带占位符的国际化值
	 * @param propertiesName资源文件名前缀，不包含后缀名 
	 * @param resourceKey需要获取的key
	 * @param languageName 语言名-资源文件夹名，如 zh-CN en-US
	 * @param args 资源文件里可以配置为  “*****{0},\''{1}\''****”格式，参数会对应替换
	 * @return 如果存在则返回对应值，不存在返回key本身
	 */
	public String getResourceValue(String propertiesName,String resourceKey,String languageName,Object... args);
	
	/**
	 * 初始化国际化资源配置文件
	 */
	public void systemInit(String resourcePath);
	
	/**
	 * 重新加载国际化资源文件
	 */
	public void reload();
	
	/**
	 * 获取当前线程副本中的语言
	 * @return 不存在时则返回zh-CN
	 */
	public String getNowLanguage();
	
	/**
	 * 设置当前线程副本的语言
	 * @param languageType
	 */
	public void setNowLanguage(String languageType);
		

}
