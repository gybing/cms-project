package com.cms.common.sqlparse;

import java.util.List;

/**
 * @author lansb
 * 执行sql对象存放form
 */
public class SqlResultForm {
	private String oriSql;//解析前sql 
	private String parsedSql;//解析后待执行的sql
	private List<String> keyList;//待替换参数
	private List<Object> valueList;//替换值
	public List<String> getKeyList() { 
		return keyList;
	}
	public void setKeyList(List<String> keyList) {
		this.keyList = keyList;
	}
	public String getOriSql() {
		return oriSql;
	}
	public void setOriSql(String oriSql) {
		this.oriSql = oriSql;
	}
	public String getParsedSql() {
		return parsedSql;
	}
	public void setParsedSql(String parsedSql) {
		this.parsedSql = parsedSql;
	}
	public List<Object> getValueList() {
		return valueList;
	}
	public void setValueList(List<Object> valueList) {
		this.valueList = valueList;
	}
}
