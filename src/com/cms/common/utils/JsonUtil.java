package com.cms.common.utils;

import java.util.List;
import java.util.Map;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

public class JsonUtil {
	
	private static Gson gson=new Gson();

	/**
	 * 将json转换成list
	 * @param jsonStr
	 * @return
	 */
	public static List<Map<String, String>> jsonToList(String jsonStr){
		return gson.fromJson(jsonStr, new TypeToken<List<Map<String, String>>>(){}.getType());
	}
	
	/**
	 * 将json转换成map
	 * @param jsonStr
	 * @return
	 */
	public static Map<String, String> jsonToMap(String jsonStr){
		return gson.fromJson(jsonStr, new TypeToken<Map<String, String>>(){}.getType());
	}
	
	public static String beanToJson(Object obj){
		return gson.toJson(obj);
	}
	
	public static Map<String, Object> jsonToMapObject(String jsonStr){
		return gson.fromJson(jsonStr, new TypeToken<Map<String, Object>>(){}.getType());
	}
}
