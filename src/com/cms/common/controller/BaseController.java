package com.cms.common.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.cms.common.cache.GlobalCache;
import com.cms.common.cache.impl.UrlMappingCache;
import com.cms.common.exception.CustomException;
import com.cms.common.form.RequestDataForm;

/**
 * @author lansb
 * controller公用类
 */
public abstract class BaseController {
	protected static Logger logger = Logger.getLogger(BaseController.class);
	
	@SuppressWarnings("unchecked")
	protected RequestDataForm getRequestDataForm(String id,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("***************************");
		logger.debug("enter topic");
		logger.debug("***************************");
		// 权限
		// 查找对应的URL处理参数
//		Map<String, Object> urlSqlMap = jdbcDao.queryForMap(
//				"select * from sys_url_tab t where t.url_id=?",
//				new Object[] { id });
		Map<String, Object> urlSqlMap = null;
		
		Map<String, Object> urlCache = GlobalCache.getCache(UrlMappingCache.class, Map.class);
		
		if (!urlCache.containsKey(id)) {
			throw new CustomException(
					"error! url["+id+"] undefined");
		}else{
			urlSqlMap=(Map<String, Object>) urlCache.get(id);
		}
		
		RequestDataForm requestDataForm = RequestDataForm.create(request,response);
		requestDataForm.setUriId(id);
		requestDataForm.setUrlSqlMap(urlSqlMap); 
		 
		requestDataForm.setResponse(response);
		return requestDataForm;
	}
}
