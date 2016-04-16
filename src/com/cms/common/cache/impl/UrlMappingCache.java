package com.cms.common.cache.impl;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.cms.common.cache.ICacheService;
import com.cms.common.dao.IJdbcDao;
import com.cms.common.utils.Environment;

@Service("urlMappingCache")
public class UrlMappingCache implements ICacheService {

	@Resource
	private IJdbcDao jdbcDao;
	
	@Autowired(required=false)
	@Qualifier("sysCode")
	private String sysCode;
	
	@Override
	public Map<String, Object> getCacheContext() {
		String sql="select * from sys_url_tab ";
		Object[] params=null;
		if(StringUtils.isNotEmpty(sysCode)){
			sql+=" where sys_code=? or sys_code=?";
			params=new Object[]{sysCode,Environment.PUBLIC_SYS_CODE_MARK};
		}
		List<Map<String, Object>> list = jdbcDao.queryForList(sql, params);
		ConcurrentHashMap<String,Object> resultMap=new ConcurrentHashMap<String, Object>();
		for(Map<String,Object> map : list){
			String id=String.valueOf(map.get("URL_ID"));
			resultMap.put(id,map);
		}
		return resultMap;
	}

	@Override
	public long getCacheLiveTime() {
		return 0;
	}

}
