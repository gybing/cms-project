package com.cms.common.exposer;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.BeanPostProcessor;

import com.cms.common.cache.GlobalCache;
import com.cms.common.cache.ICacheService;

public class CacheBeanPostProcessor implements BeanPostProcessor {

	@Override
	public Object postProcessAfterInitialization(Object arg0, String arg1)
			throws BeansException {
		// TODO Auto-generated method stub
		return arg0;
	}

	@Override
	public Object postProcessBeforeInitialization(Object obj, String arg1)
			throws BeansException {
		if(obj instanceof ICacheService){
			ICacheService cs = (ICacheService)obj;
			GlobalCache.setCache(arg1, cs.getCacheContext(),cs.getCacheLiveTime());
		}
		return obj;
	}


}
