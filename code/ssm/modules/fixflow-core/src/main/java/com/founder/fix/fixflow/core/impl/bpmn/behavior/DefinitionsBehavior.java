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
package com.founder.fix.fixflow.core.impl.bpmn.behavior;

import org.eclipse.bpmn2.BaseElement;

import org.eclipse.bpmn2.FlowElement;

import org.eclipse.bpmn2.SubProcess;
import org.eclipse.bpmn2.impl.DefinitionsImpl;

import com.founder.fix.fixflow.core.impl.util.EMFUtil;



public class DefinitionsBehavior extends DefinitionsImpl {

	// fixflow
	
	protected String processId;

	public String getProcessId() {
		return processId;
	}

	public void setProcessId(String processId) {
		this.processId = processId;
	}

	public BaseElement getSubProcessElement(SubProcess subProcess, String elementId) {

		for (FlowElement flowElementSub : subProcess.getFlowElements()) {

			if (flowElementSub.getId().equals(elementId)) {
				return (BaseElement) flowElementSub;
			}

			if (flowElementSub instanceof SubProcess) {
				return getSubProcessElement((SubProcess) flowElementSub, elementId);
			}

		}
		return null;

	}

	public BaseElement getElement(String elementId) {
		// TODO Auto-generated method stub
		
		 return EMFUtil.findElement(elementId, this);
	/*

		for (RootElement rootElement : this.getRootElements()) {
			
			if(rootElement instanceof Collaboration){
				
				Collaboration collaboration=(Collaboration)rootElement;
				List<Participant>  participants=collaboration.getParticipants();
				List<MessageFlow> messageFlows=collaboration.getMessageFlows();
				for (Participant participant : participants) {
					if (participant.getId().equals(elementId)) {
						return  participant;
					}
				}
				for (MessageFlow messageFlow : messageFlows) {
					if (messageFlow.getId().equals(elementId)) {
						return messageFlow;
					}
				}
				
		
			}
			
			if(rootElement instanceof org.eclipse.bpmn2.Message){
				if (rootElement.getId().equals(elementId)) {
					return (BaseElement) rootElement;
				}
			}
			
			if (rootElement instanceof org.eclipse.bpmn2.Process) {
				for (FlowElement flowElement : ((org.eclipse.bpmn2.Process) rootElement).getFlowElements()) {

					if (flowElement.getId().equals(elementId)) {
						return (BaseElement) flowElement;
					}

					if (flowElement instanceof SubProcess) {
						BaseElement baseElement = getSubProcessElement((SubProcess) flowElement, elementId);
						if (baseElement != null) {
							return baseElement;
						}

					}

				}
				for (Artifact artifact : ((org.eclipse.bpmn2.Process) rootElement).getArtifacts()) {
					if (artifact.getId().equals(elementId)) {
						return (BaseElement) artifact;
					}
				}

				for (LaneSet laneSet : ((org.eclipse.bpmn2.Process) rootElement).getLaneSets()) {

					List<Lane> lanes = laneSet.getLanes();
					for (Lane lane : lanes) {
						if (lane.getId().equals(elementId)) {
							return (BaseElement) lane;
						}
					}

				}

				InputOutputSpecification inputOutputSpecification = ((org.eclipse.bpmn2.Process) rootElement)
						.getIoSpecification();
				if(inputOutputSpecification!=null){
					for (DataInput dataInput : inputOutputSpecification.getDataInputs()) {
						if (dataInput.getId().equals(elementId)) {
							return (BaseElement) dataInput;
						}
					}
					
					for (DataOutput dataOutput : inputOutputSpecification.getDataOutputs()) {
						if (dataOutput.getId().equals(elementId)) {
							return (BaseElement) dataOutput;
						}
					}
				}
				
				
				
				
			

			}
		}
		
		return null;
	*/
	}
	
	

}
