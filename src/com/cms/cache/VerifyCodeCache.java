/**
 * 
 */
package com.cms.cache;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Service;

import com.cms.common.cache.ICacheService;

/**
 * @author yange
 * @类描述 ：发送短信验证码缓存
 * 2016年1月29日
 */
@Service("verifyCodeCache")
public class VerifyCodeCache implements ICacheService {

	@Override
	public Map<String,Object> getCacheContext() {
		// TODO Auto-generated method stub
		return new ConcurrentHashMap<String ,Object>();
	}

	@Override
	public long getCacheLiveTime() {
		// TODO Auto-generated method stub
		return 0;
	}

}
