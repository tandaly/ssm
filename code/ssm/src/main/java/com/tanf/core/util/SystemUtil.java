package com.tanf.core.util;

import java.util.List;

import com.tanf.core.spring.SpringFactory;
import com.tanf.system.admin.beans.Params;
import com.tanf.system.admin.service.ParamsService;
import com.tanf.system.common.util.ParamsConstants;
/**
 * 系统辅助类
 * @author tanf
 * @date 2013-7-16 下午2:03:10
 */
public class SystemUtil
{

	 /**
     * 加载系统全局参数
     */
    public static void loadSystemParams()
    {
    	ParamsService paramsService = SpringFactory.getBean(ParamsService.class);
    	
    	List<Params> paramses = paramsService.queryParamses(null);
    	
    	if(StringUtil.isNotEmpty(paramses))
    	{
    		for(Params params:paramses)
    		{
    			ParamsConstants.SYSTEM_PARAMS.put(params.getName(), params.getValue());
    		}
    	}
    }
}
