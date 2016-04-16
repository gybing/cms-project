package com.cms.cache;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.cms.common.cache.ICacheService;
import com.cms.common.dao.IJdbcDao;
import com.cms.common.utils.MapUtils;
import com.cms.pojo.Area;

@Service("areaCache")
public class AreaCache implements ICacheService {

	public static final String TAG="areaCache";
	
	public static final int LVL_REGION=0;//区域等级
	public static final int LVL_PROVINCE=1;//省等�?
	public static final int LVL_CITY=2;//市等�?
	public static final int LVL_COUNTY=3;//县区等级

	private static Logger logger = Logger.getLogger(AreaCache.class);
	
	@Resource
	private IJdbcDao jdbcDao;
	@Override
	public Map<String, ?> getCacheContext() {
		String sql="select a.CODE,a.TEXT,a.CITY_TEXT,a.FULL_TEXT,a.PIN_YIN from base_area_tab a order by a.CODE asc";
		List<Map<String, Object>> list = jdbcDao.queryForList(sql, null);
		LinkedHashMap<String, Area> areaMap=new LinkedHashMap<String, Area>();
		for(Map<String,Object> map : list){
			Area area=setArea(map);
			if(areaMap.get(area.getCode())!=null){
				Area temp=areaMap.get(area.getCode());
				area.setChildArea(temp.getChildArea());
			}
			areaMap.put(area.getCode(), area);
			if(area.getCode().endsWith("0000")){
				area.setLevel(LVL_PROVINCE);
			}else if(area.getCode().endsWith("00")){
				String parentCode=area.getCode().substring(0, 2)+"0000";
				Area parentArea=areaMap.get(parentCode);
				if(parentArea==null){
					parentArea=new Area();
					parentArea.setCode(parentCode);
					areaMap.put(parentCode, parentArea);
				}
				parentArea.addChildArea(area);
				area.setLevel(LVL_CITY);
			}else{
				String parentCode=area.getCode().substring(0, 4)+"00";
				Area parentArea=areaMap.get(parentCode);
				if(parentArea==null){
					parentArea=new Area();
					parentArea.setCode(parentCode);
					areaMap.put(parentCode, parentArea);
				}
				parentArea.addChildArea(area);
				area.setLevel(LVL_COUNTY);
			}
		}
		
		LinkedHashMap<String, Area> allMap=new LinkedHashMap<String, Area>();
		/*sql="select a.CODE,a.TEXT,a.PIN_YIN,CHILD_CODE from region_divide_tab a order by a.CODE asc";
		list = jdbcDao.queryForList(sql, null);
		for(Map<String,Object> map : list){
			map.put("CITY_TEXT", MapUtils.getString(map, "TEXT"));
			map.put("FULL_TEXT", MapUtils.getString(map, "TEXT"));
			Area area=setArea(map);
			area.setLevel(LVL_REGION);
			String childCode=MapUtils.getString(map, "CHILD_CODE");
			String[] childCodes=childCode.split(",");
			for(String code : childCodes){
				Area childArea=areaMap.get(code);
				if(childArea!=null)
					area.addChildArea(childArea);
			}
			allMap.put(area.getCode(), area);
		}*/
		allMap.putAll(areaMap);
		logger.debug("加载地区缓存完毕");
		return allMap;
	}

	private Area setArea(Map<String,Object> map){
		Area area=new Area();
		area.setCode(MapUtils.getString(map, "CODE"));
		area.setText(MapUtils.getString(map, "TEXT"));
		area.setCityText(MapUtils.getString(map, "CITY_TEXT"));
		area.setFullText(MapUtils.getString(map, "FULL_TEXT"));
		area.setPy(MapUtils.getString(map, "PIN_YIN"));
		return area;
	}

	@Override
	public long getCacheLiveTime() {
		// TODO Auto-generated method stub
		return 0;
	}
}
