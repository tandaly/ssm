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
package com.founder.fix.fixflow.core.exception;

/**
 * 运行时异常，这是所有FixFlow异常的基类
 * 
 * @author kenshin
 */
public class FixFlowException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public FixFlowException(String exceptionCode) {
		super(ExceptionResourceCore.getResourceValue(exceptionCode));
	}

	public FixFlowException(String exceptionCode,Object... args) {
		super(ExceptionResourceCore.getResourceValue(exceptionCode,args));
	}
	public FixFlowException(String exceptionCode,Throwable cause,Object... args) {
		super(ExceptionResourceCore.getResourceValue(exceptionCode,args),cause);
	}
	
	public FixFlowException(String exceptionCode,Throwable cause){
		super(ExceptionResourceCore.getResourceValue(exceptionCode),cause);
	}
	
	public FixFlowException(String exceptionCode,Object[] args,Throwable cause){
		super(ExceptionResourceCore.getResourceValue(exceptionCode,args),cause);
	}
	
}
