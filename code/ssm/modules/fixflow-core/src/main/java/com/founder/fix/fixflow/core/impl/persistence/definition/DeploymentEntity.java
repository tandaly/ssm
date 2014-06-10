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
package com.founder.fix.fixflow.core.impl.persistence.definition;

import java.io.Serializable;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import com.founder.fix.fixflow.core.impl.db.PersistentObject;
import com.founder.fix.fixflow.core.impl.util.GuidUtil;
import com.founder.fix.fixflow.core.model.Deployment;

/**
 * @author kenshin
 */
public class DeploymentEntity implements Serializable, Deployment , PersistentObject {

	private static final long serialVersionUID = 1L;

	protected String id;
	protected String name;
	protected Map<String, ResourceEntity> resources;
	protected Date deploymentTime;
	protected boolean validatingSchema = true;
	protected boolean isNew;
	protected String updateDeploymentId;
	
	

	public DeploymentEntity()
	{
		this.id=GuidUtil.CreateGuid();
	}

	public ResourceEntity getResource(String resourceName) {
		return getResources().get(resourceName);
	}

	public void addResource(ResourceEntity resource) {
		if (resources == null) {
			resources = new HashMap<String, ResourceEntity>();
		}
		resources.put(resource.getName(), resource);
	}

	@SuppressWarnings("null")
	public Map<String, ResourceEntity> getResources() {
		if (resources == null && id != null) {
			List<ResourceEntity> resourcesList = null;/*
													 * Context
													 * .getCommandContext()
													 * .getResourceManager()
													 * .findResourcesByDeploymentId
													 * (id);
													 */
			resources = new HashMap<String, ResourceEntity>();
			for (ResourceEntity resource : resourcesList) {
				resources.put(resource.getName(), resource);
			}
		}
		return resources;
	}

	public Map<String, Object> getPersistentState() {
		Map<String, Object> persistentState = new HashMap<String, Object>();
		persistentState.put("id", this.id);
		persistentState.put("name", this.name);
		persistentState.put("deploymentTime", this.deploymentTime);
		return persistentState;
	}

	// getters and setters
	// //////////////////////////////////////////////////////

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setResources(Map<String, ResourceEntity> resources) {
		this.resources = resources;
	}

	public Date getDeploymentTime() {
		return deploymentTime;
	}

	public void setDeploymentTime(Date deploymentTime) {
		this.deploymentTime = deploymentTime;
	}

	public boolean isValidatingSchema() {
		return validatingSchema;
	}

	public void setValidatingSchema(boolean validatingSchema) {
		this.validatingSchema = validatingSchema;
	}

	public boolean isNew() {
		return isNew;
	}

	public void setNew(boolean isNew) {
		this.isNew = isNew;
	}
	public String getUpdateDeploymentId() {
		return updateDeploymentId;
	}

	public void setUpdateDeploymentId(String updateResourceId) {
		this.updateDeploymentId = updateResourceId;
	}
}
