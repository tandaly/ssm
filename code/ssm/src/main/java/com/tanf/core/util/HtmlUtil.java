package com.tanf.core.util;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;


/**
 * <br>
 * <b>功能：</b>详细的功能描述<br>
 * <b>日期：</b> Dec 14, 2011 <br>
 * <b>更新者：</b><br>
 * <b>日期：</b> <br>
 * <b>更新内容：</b><br>
 */
public class HtmlUtil {
	
	/**
	 * 
	 * <br>
	 * <b>功能：</b>输出json格式<br>
	 * <b>作者：</b><br>
	 * <b>日期：</b> Dec 14, 2011 <br>
	 * @param response
	 * @param jsonStr
	 * @throws Exception
	 */
	public static void writerJson(HttpServletResponse response,String jsonStr) {
			writer(response,jsonStr);
	}
	
	public static void writerJson(HttpServletResponse response,Object object){
		response.setContentType("application/json;charset=UTF-8");
//		try
//		{
//			System.out.println("jsonutil=" + JSONUtil.toJSONString(object));
//			writer(response, JSONUtil.toJSONString(object));
//		} catch (JSONException e)
//		{
//			e.printStackTrace();
//		}
		
		SerializerFeature[] features = {
								SerializerFeature.WriteMapNullValue //保留null};
								};
		writer(response,JSON.toJSONStringWithDateFormat(object, "yyyy-MM-dd HH:mm:ss", features));
	}
	
	/**
	 * 
	 * <br>
	 * <b>功能：</b>输出HTML代码<br>
	 * <b>作者：</b><br>
	 * <b>日期：</b> Dec 14, 2011 <br>
	 * @param response
	 * @param htmlStr
	 * @throws Exception
	 */
	public static void writerHtml(HttpServletResponse response,String htmlStr) {
		writer(response,htmlStr);
	}
	
	private static void writer(HttpServletResponse response,String str){
		try {
			//StringBuffer result = new StringBuffer();
			//设置页面不缓存
			
			response.setHeader("Pragma", "No-cache");
			response.setHeader("Cache-Control", "no-cache");
			response.setCharacterEncoding("UTF-8");
			//response.getOutputStream().write(str.getBytes("UTF-8"));
			PrintWriter out= null;
			out = response.getWriter();
			out.print(str);
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	} 
	
	
}
