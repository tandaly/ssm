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

package com.founder.fix.fixflow.core.model;
import com.founder.fix.fixflow.core.query.Query;

/**
 * 定义部署查询器
 * @author kenshin
 *
 */
public interface DeploymentQuery extends Query<DeploymentQuery, Deployment>{

	/**
	 * 根据部署号
	 * @param deploymentId
	 * @return
	 */
	DeploymentQuery deploymentId(String deploymentId);

	/**
	 * 部署名称
	 * @param name
	 * @return
	 */
	DeploymentQuery deploymentName(String name);

	/**
	 * 部署名称like匹配
	 * @param nameLike
	 * @return
	 */
	DeploymentQuery deploymentNameLike(String nameLike);

	/**
	 * 根据发布号排序
	 * @return
	 */
	DeploymentQuery orderByDeploymentId();

	/**
	 * 根据发布名称排序
	 * @return
	 */
	DeploymentQuery orderByDeploymentName();

	/**
	 * 根据发布时间排序
	 * @return
	 */
	DeploymentQuery orderByDeploymenTime();
}
