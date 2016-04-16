package com.cms.common.sqlparse;

import java.util.List;

import org.w3c.dom.Node;

import com.cms.common.bean.UserSessionBean;
import com.cms.common.form.RequestDataForm;

/**
 * @author lansb
 * sql解析
 */
public interface ISqlParse { 
	/**
	 * 解析单个sql节点，获得执行sql的相关信息，具体信息查看SqlResultForm类的定义
	 * @param element
	 * @param simpleRequestMap
	 * @param userSession
	 * @return
	 * @throws Exception
	 */
	public SqlResultForm parseNode(Node element,
			RequestDataForm requestDataForm, UserSessionBean userSession) throws Exception; 
	/**
	 * 解析指定原始sql语句，获得执行sql的相关信息，具体信息查看SqlResultForm类的定义
	 * @param sql 
	 * @param simpleRequestMap
	 * @param userSession
	 * @return
	 * @throws Exception
	 */
	public SqlResultForm parseString(String sql,
			RequestDataForm requestDataForm, UserSessionBean userSession) throws Exception; 
	
	/**
	 * 解析sqlid中的第一个sql节点内的sql语句，获得执行sql的相关信息，具体信息查看SqlResultForm类的定义
	 * @param sqlId
	 * @param requestDataForm
	 * @param userSession
	 * @return
	 * @throws Exception
	 */
	public SqlResultForm parseSqlIdByFirstSql(String sqlid,	RequestDataForm requestDataForm) throws Exception;
	
	/**
	 * 解析sqlid中的所有sql节点内的sql语句
	 * @param sqlId
	 * @param requestDataForm
	 * @param userSession
	 * @return
	 * @throws Exception
	 */
	public List<SqlResultForm> parseSqlId(String sqlId, RequestDataForm requestDataForm) throws Exception;
}
