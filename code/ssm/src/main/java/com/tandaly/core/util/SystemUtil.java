package com.tandaly.core.util;

import java.util.List;

import com.tandaly.core.spring.SpringFactory;
import com.tandaly.system.admin.beans.Params;
import com.tandaly.system.admin.service.ParamsService;
import com.tandaly.system.common.util.ParamsConstants;

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
