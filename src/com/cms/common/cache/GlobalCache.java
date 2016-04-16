package com.cms.common.cache;

import java.lang.annotation.Annotation;

import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Element;
import net.sf.ehcache.config.CacheConfiguration;
import net.sf.ehcache.config.PersistenceConfiguration;
import net.sf.ehcache.config.PersistenceConfiguration.Strategy;
import net.sf.ehcache.store.MemoryStoreEvictionPolicy;

import org.springframework.stereotype.Service;
import org.springframework.web.context.WebApplicationContext;

import com.cms.common.listener.SpringContextUtil;

public class GlobalCache {

	private static CacheManager manage=CacheManager.create();
	
	public static void setCache(String tag,Object obj,long liveTime){
		Cache cache=createCache(tag,liveTime);
		manage.addCache(cache);//要先加到CacheManager中否则提示cache is not alive
		Element e=new Element(tag, obj);
		cache.put(e);
	}
	
	private static Cache createCache(String tag,long liveTime){
		CacheConfiguration config=new CacheConfiguration(tag, 20000)
//		.eternal(true)//缓存是否永远不销毁
		.maxEntriesLocalDisk(0)
		.persistence(new PersistenceConfiguration().strategy(Strategy.LOCALTEMPSWAP))
//		.overflowToDisk(false)//当缓存中的数据达到最大值时，是否把缓存数据写入磁盘
		.memoryStoreEvictionPolicy(MemoryStoreEvictionPolicy.LFU);
		if(liveTime>0){
			config.setEternal(false);
			config.setTimeToLiveSeconds(liveTime);
		}else{
			config.setEternal(true);
		}
		return new Cache(config);
	}
	
	public static Object getCache(Class<?> clazz){
		Annotation anno=clazz.getAnnotation(Service.class);
		if(anno==null){
			return null;
		}else{
			String tag=((Service)anno).value();
			Cache cache = manage.getCache(tag);
			Object obj=null;
			if(cache!=null){
				if(cache.get(tag)==null){
					try {
						ICacheService i = SpringContextUtil.getBean(tag,ICacheService.class);
						Element e=new Element(tag, i.getCacheContext());
						cache.put(e);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				Element element = cache.get(tag);
				obj=element.getObjectValue();
			}
			return obj;
		}
	}
	
	/**
	 * 获取缓存
	 * @param cacheClass 缓存类
	 * @param retultType 返回对象的类型
	 * @return
	 */
	public static <A,T>T getCache(Class<A> cacheClass,Class<T> retultType){
		Object obj=getCache(cacheClass);
		return retultType.cast(obj);
	}
	
	/**
	 * 刷新所有缓存
	 * @param ctx
	 */
	public static void refreshAllCache(WebApplicationContext ctx){
		for(String name :manage.getCacheNames()){
			long liveTime = manage.getCache(name).getCacheConfiguration().getTimeToLiveSeconds();
			manage.removeCache(name);
			ICacheService cs = (ICacheService)ctx.getBean(name);
			setCache(name, cs.getCacheContext(),liveTime);
		}
	}
	
	public static void refreshCache(Class<?> clazz){
		Annotation anno=clazz.getAnnotation(Service.class);
		if(anno!=null){
			String tag=((Service)anno).value();
			ICacheService cs = SpringContextUtil.getBean(tag,ICacheService.class);
			Element e=new Element(tag, cs.getCacheContext());
			Cache cache = manage.getCache(tag);
			if(cache.get(tag)==null){
				cache.put(e);
			}else{
				cache.replace(e);
			}
		}
	}
	
	public static String[] getCacheNames(){
		return manage.getCacheNames();
	}
}
