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
package com.founder.fix.fixflow.core.impl.flowgraphics.svg.component;

import java.io.InputStream;

import org.dom4j.Document;
import org.dom4j.DocumentException;

import com.founder.fix.fixflow.core.exception.FixFlowException;
import com.founder.fix.fixflow.core.impl.flowgraphics.svg.FlowSvgUtil;
import com.founder.fix.fixflow.core.impl.flowgraphics.svg.SvgBench;
import com.founder.fix.fixflow.core.impl.flowgraphics.svg.to.SvgBaseTo;
import com.founder.fix.fixflow.core.impl.flowgraphics.svg.to.SvgDataObjectTo;
import com.founder.fix.fixflow.core.impl.util.StringUtil;
import com.founder.fix.fixflow.core.impl.util.XmlUtil;

public class SvgDataObjectComponent implements ISvgComponent {

	private static String comPath = "/svgcomponent/DataInput.xml";
	
	private static String input = "{input}";
	
	private static String output = "{output}";
	
	private static String none ="none";
	
	public String createComponent(SvgBaseTo svgTo) {
		String result = null;
		try {
			SvgDataObjectTo stevent = (SvgDataObjectTo)svgTo;
			InputStream in = SvgBench.class.getResourceAsStream(comPath);
			Document doc = XmlUtil.read(in);
			String str = doc.getRootElement().asXML();
			str = FlowSvgUtil.replaceAll(str, local_x, StringUtil.getString(stevent.getX()));
			str = FlowSvgUtil.replaceAll(str, local_y, StringUtil.getString(stevent.getY()));
			str = FlowSvgUtil.replaceAll(str, id, stevent.getId());
			str = FlowSvgUtil.replaceAll(str, text, stevent.getLabel());
			str = FlowSvgUtil.replaceAll(str, input, none);
			str = FlowSvgUtil.replaceAll(str, output, none);
			result = str;
		} catch (DocumentException e) {
			throw new FixFlowException("",e);
		}
		return result;
	}

}
