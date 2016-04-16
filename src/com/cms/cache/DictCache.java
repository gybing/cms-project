package com.cms.cache;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.cms.common.cache.ICacheService;
import com.cms.common.dao.IJdbcDao;
import com.google.gson.Gson;

@Service("dictCache")
public class DictCache implements ICacheService {

	private static Logger logger = Logger.getLogger(DictCache.class);
	@Resource
	private IJdbcDao jdbcDao;
	
	/*@Override
	public Map<String, ?> getCacheContext() {
		String sql="select * from dict_common where is_del='N' order by type,seq";
		List<Map<String, Object>> list = jdbcDao.queryForList(sql, null);
		ConcurrentHashMap<String,Map<String, Map<String, Object>>> resultMap=new ConcurrentHashMap<String, Map<String, Map<String, Object>>>();
		for(Map<String, Object> map : list){
			String tmpType=MapUtils.getString(map, "TYPE");
			if(!resultMap.containsKey(tmpType)){
				resultMap.put(tmpType, new LinkedHashMap<String, Map<String, Object>>());
			}
			String code=MapUtils.getString(map, "CODE");
			resultMap.get(tmpType).put(code, map);
		}
		logger.debug("加载数据字典表完成");
		return resultMap;
	}*/
	@Override
	public Object getCacheContext() {
		
		DictCacheBean dcb = new DictCacheBean();
		
		String sql = "SELECT DISTINCT D.TYPE FROM dict_common D WHERE D.IS_DEL='N' ORDER BY D.TYPE,D.SEQ";
		List<Map<String, Object>> dictTypeList = jdbcDao.queryForList(sql, null);  //获取字典类型列表

		//Map<String, List<Map<String, Object>>> dictMap = new HashMap<String, List<Map<String, Object>>>();
		Map<String, Map<String,List<Map<String, Object>>>> dictMap = new HashMap<String, Map<String,List<Map<String, Object>>>>();
		
		Map<String, String> dictKeyMap = new HashMap<String, String>();
		
		Map<String,List<Map<String, Object>>> dMap = null;
		String TYPE = ""; //字典类型
		for(Map<String, Object> dictType : dictTypeList) {			
			TYPE = dictType.get("TYPE").toString(); //字典类型
			sql = "SELECT D.CODE ID, D.TEXT FROM dict_common D WHERE D.IS_DEL='N' AND D.TYPE=? ORDER BY D.SEQ";
			List<Map<String, Object>> dictList = jdbcDao.queryForList(sql, new String[]{TYPE});  //根据字典类型获取字典列表
			//{"value": [{ID=N, TEXT=未完成}, {ID=Y, TEXT=已完成}, {ID=T, TEXT=退载}]}
			dMap = new HashMap<String,List<Map<String, Object>>>();
			dMap.put("value", dictList);			
			
			for(Map<String, Object> dm : dictList) {
				dictKeyMap.put(TYPE + "_" + (dm.get("ID") == null ? "" : dm.get("ID").toString()), dm.get("TEXT")== null ? "" : dm.get("TEXT").toString());
			}
			//dictMap.put(TYPE,dictList);
			dictMap.put(TYPE,dMap);
		}
		
		dcb.setDictJsonStr(new Gson().toJson(dictMap));
		dcb.setDictKeyMap(dictKeyMap);
		//dcb.setDictMap(dictMap);
		dcb.setDictkeyMapStr(new Gson().toJson(dictKeyMap));
		
		logger.debug("加载数据字典表(dict_common)完成!");
		return dcb;
	}

	@Override
	public long getCacheLiveTime() {
		// TODO Auto-generated method stub
		return 0;
	}

}
