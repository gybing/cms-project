package com.cms.common.cache;


public interface ICacheService {
	
	/**
	 * 获取缓存内容
	 * @return
	 */
	public Object getCacheContext();
	
	/**
	 * 缓存存活时间，秒数，为0时表示永久有效
	 * @return
	 */
	public long getCacheLiveTime();
}
