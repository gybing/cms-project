package com.cms.cache;


import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * @author lance
 *
 */
public class DictCacheBean implements Serializable{
	private static final long serialVersionUID = -6872079515856745456L;
	private String dictJsonStr;
	private String dictkeyMapStr;
	private Map<String, String> dictKeyMap;
	Map<String, List<Map<String, Object>>> dictMap;
	public String getDictJsonStr() {
		return dictJsonStr;
	}
	public void setDictJsonStr(String dictJsonStr) {
		this.dictJsonStr = dictJsonStr;
	}
	public Map<String, String> getDictKeyMap() {
		return dictKeyMap;
	}
	public void setDictKeyMap(Map<String, String> dictKeyMap) {
		this.dictKeyMap = dictKeyMap;
	}
	public Map<String, List<Map<String, Object>>> getDictMap() {
		return dictMap;
	}
	public void setDictMap(Map<String, List<Map<String, Object>>> dictMap) {
		this.dictMap = dictMap;
	}
	public String getDictkeyMapStr() {
		return dictkeyMapStr;
	}
	public void setDictkeyMapStr(String dictkeyMapStr) {
		this.dictkeyMapStr = dictkeyMapStr;
	}
}
