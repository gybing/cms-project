package com.cms.common.sqlparse.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.cms.common.bean.UserSessionBean;
import com.cms.common.cache.GlobalCache;
import com.cms.common.cache.impl.UrlExecSqlCache;
import com.cms.common.exception.CustomException;
import com.cms.common.form.RequestDataForm;
import com.cms.common.sqlparse.ISqlParse;
import com.cms.common.sqlparse.SqlResultForm;
import com.cms.common.utils.Environment;
import com.cms.common.utils.XmlUtils;

/**
 * @author lansb sql parse
 */
@Component("sqlParse")
public class SqlParseImpl implements ISqlParse { 
	// private static Logger logger = Logger.getLogger("sqlparse");
	public SqlResultForm parseNode(Node element, RequestDataForm requestDataForm, UserSessionBean userSession) throws Exception {  
		StringBuffer sb = new StringBuffer("");
		parseDynamicTags(element, sb, requestDataForm); // 获得原始的sql并存入对象sb
		SqlResultForm srf = new SqlResultForm(); 
		String orisql = sb.toString().replaceAll("( +)", " ").trim();
		srf.setOriSql(orisql);
		String parsedSql = orisql;
		parsedSql = replaceUserInfo(parsedSql, requestDataForm, userSession);//替换登陆用户信息
		CharSequence cs = parsedSql;
		//替换${}，替换为原始字符串
		Pattern pattern = Pattern.compile("\\$\\{(.*?)\\}", Pattern.DOTALL);//
		Matcher matcher = pattern.matcher(cs);
		String content = "";
		while (matcher.find()) {
			content = matcher.group();
			String key = content.replace("${", "").replace("}", "");// 获取字段名称
			String value = requestDataForm.getString(key);
			parsedSql = parsedSql.replace(content, value.replace("'", "''"));//替换sql特殊字符
		}
		//替换#{}
		cs = parsedSql;
		pattern = Pattern.compile("#\\{(.*?)\\}", Pattern.DOTALL);
		matcher = pattern.matcher(cs);
		List<String> keyList = new ArrayList<String>();// 待替换的变量
		List<Object> valueList = new ArrayList<Object>();// 存放执行的值
		while (matcher.find()) {
			content = matcher.group();
			parsedSql = parsedSql.replace(content, "?");
			content = content.replace("#{", "").replace("}", "");// 获取字段名称
			String[] contentarr = content.split(",");//格式为#{aaa, string}或者#{aaa}；后者默认为string格式
			String key = contentarr[0];
			if(requestDataForm.getString(key,null)==null) {//参数不存在
				throw new CustomException("\r\n\t需要替换的参数:“" + key + "”不存在，请先确定页面存在该参数！");
			}
			if(contentarr.length == 1) {//只有一个为string 
				valueList.add(requestDataForm.getString(key));
			} else {
				if("string".endsWith(contentarr[1])) {
					valueList.add(requestDataForm.getString(key));
				} else if ("int".endsWith(contentarr[1])) {
					valueList.add(requestDataForm.getInteger(key));
//				} else if ("float".endsWith(contentarr[1])) {
//					valueList.add(new Float(simpleRequestMap.get(key)));
				} else if ("double".endsWith(contentarr[1])) {
					valueList.add(requestDataForm.getDouble(key));
				} 
			}
			keyList.add(key);
		}
		srf.setKeyList(keyList);
		srf.setParsedSql(parsedSql);
		srf.setValueList(valueList);
		return srf;
	}
	public SqlResultForm parseString(String orisql, RequestDataForm requestDataForm, UserSessionBean userSession) throws Exception {
		//实现如下:
		SqlResultForm srf = new SqlResultForm(); 
		List<String> keyList = new ArrayList<String>();// 待替换的变量
		List<Object> valueList = new ArrayList<Object>();// 存放执行的值
		srf.setOriSql(orisql);
		String parsedSql = orisql; 
		parsedSql = replaceUserInfo(parsedSql, requestDataForm, userSession);//替换登陆用户信息
		CharSequence cs = parsedSql;
		// 替换${}，替换为原始字符串
		Pattern pattern = Pattern.compile("\\$\\{(.*?)\\}", Pattern.DOTALL);//
		Matcher matcher = pattern.matcher(cs);
		String content = "";
		while (matcher.find()) {
			content = matcher.group();
			String key = content.replace("${", "").replace("}", "");// 获取字段名称
			String value = requestDataForm.getString(key);
			parsedSql = parsedSql.replace(content, value.replace("'", "''"));
		}
		// 替换#{}
		cs = parsedSql;
		pattern = Pattern.compile("#\\{(.*?)\\}", Pattern.DOTALL);
		matcher = pattern.matcher(cs);
		while (matcher.find()) {
			content = matcher.group();
			parsedSql = parsedSql.replace(content, "?");
			content = content.replace("#{", "").replace("}", "");// 获取字段名称
			String[] contentarr = content.split(",");
			String key = contentarr[0];
			if (contentarr.length == 1) {// 只有一个为varchar
				valueList.add(requestDataForm.getString(key));
			} else {
				if ("string".endsWith(contentarr[1])) {
					valueList.add(requestDataForm.getString(key));
				} else if ("int".endsWith(contentarr[1])) {
					valueList.add(requestDataForm.getInteger(key));
//				} else if ("float".endsWith(contentarr[1])) {
//					valueList.add(new Float(simpleRequestMap.get(key)));
				} else if ("double".endsWith(contentarr[1])) {
					valueList.add(requestDataForm.getDouble(key));
				}
			}
			keyList.add(key);
		}
		srf.setKeyList(keyList);
		srf.setParsedSql(parsedSql);
		srf.setValueList(valueList);
		return srf;
	}
	
	/**
	 * 替换登陆用户信息
	 * @param sql
	 * @param parameter
	 * @return
	 * @throws CustomException
	 */
	private String replaceUserInfo(String sql,  RequestDataForm requestDataForm, UserSessionBean userSession) throws CustomException {
		sql = sql.replace(Environment.UUID, UUID.randomUUID().toString());
		if(userSession != null){
			if(StringUtils.isNotEmpty(userSession.getUserCode())){
				sql=sql.replace(Environment.USER_CODE, userSession.getUserCode());
			}
			if(StringUtils.isNotEmpty(userSession.getUserId())){
				sql=sql.replace(Environment.USER_ID, userSession.getUserId());
			}
			if(StringUtils.isNotEmpty(userSession.getUserName())){
				sql=sql.replace(Environment.USER_NAME, userSession.getUserName());
			}
		}
		return sql;
	}
	/**
	 * 组装sql
	 * @param node
	 * @param sbsql
	 * @param parameter
	 * @throws Exception
	 */
	private void parseDynamicTags(Node node, StringBuffer sbsql, RequestDataForm requestDataForm)
			throws Exception {
		NodeList children = node.getChildNodes();
		for (int i = 0, len = children.getLength(); i < len; i++) {
			Node child = (Node) children.item(i);
			String nodeName = child.getNodeName();
			if (child.getNodeType() == Node.TEXT_NODE || child.getNodeType() == Node.CDATA_SECTION_NODE) {
				String data = child.getNodeValue();
				sbsql.append(" " + data.replaceAll("(\t|\n|\r|(\r\n))", " ").trim());
				continue;
			} 
			if ("isNotEmpty".equalsIgnoreCase(nodeName))
				isNotEmptyNode((Element) child, sbsql, requestDataForm);
			else if ("isEmpty".equalsIgnoreCase(nodeName))
				isEmptyNode((Element) child, sbsql, requestDataForm);
			else if ("isEqual".equalsIgnoreCase(nodeName))
				isEqualNode((Element) child, sbsql, requestDataForm);
			else if ("isNotEqual".equalsIgnoreCase(nodeName))
				isNotEqualNode((Element) child, sbsql, requestDataForm);
			else 
				new CustomException("\t\n\r error node name : '" + nodeName + "'");
		}
	}

	private void isNotEmptyNode(Element node, StringBuffer sbsql, RequestDataForm requestDataForm)
			throws Exception {
		String property = node.getAttribute("property");
		if("".equals(property)) {
			throw new CustomException("\t\n\r未定义property！");
		}
		if (!"".equals(requestDataForm.getString(property)))
			parseDynamicTags(node, sbsql, requestDataForm);
	}
	
	private void isEmptyNode(Element node, StringBuffer sbsql, RequestDataForm requestDataForm)
		throws Exception {
		String property = node.getAttribute("property");
		if("".equals(property)) {
			throw new CustomException("\t\n\r未定义property！");
		}
		if ("".equals(requestDataForm.getString(property)))
			parseDynamicTags(node, sbsql, requestDataForm);
	}
	private void isEqualNode(Element node, StringBuffer sbsql, RequestDataForm requestDataForm)
		throws Exception {
		String property = node.getAttribute("property");
		if("".equals(property)) {
			throw new CustomException("\t\n\r未定义property！");
		}
		String compareProperty = node.getAttribute("compareProperty");
		String compareValue = node.getAttribute("compareValue");
		if("".equals(compareProperty) && "".equals(compareValue)) {
			throw new CustomException("\t\n\r未定义compareProperty或compareValue！");
		}
		if (compareProperty != null && requestDataForm.getString(property).equals(requestDataForm.getString(compareProperty))) 
			parseDynamicTags(node, sbsql, requestDataForm);
		else if(requestDataForm.getString(property).equals(compareValue)) parseDynamicTags(node, sbsql, requestDataForm);
	}
	private void isNotEqualNode(Element node, StringBuffer sbsql, RequestDataForm requestDataForm)
	throws Exception {
		String property = node.getAttribute("property");
		if("".equals(property)) {
			throw new CustomException("\t\n\r未定义property！");
		}
		String compareProperty = node.getAttribute("compareProperty");
		String compareValue = node.getAttribute("compareValue");
		if("".equals(compareProperty) && "".equals(compareValue)) {
			throw new CustomException("\t\n\r未定义compareProperty或compareValue！");
		}
		if (!"".equals(compareProperty) && !requestDataForm.getString(property).equals(requestDataForm.getString(compareProperty))) 
			parseDynamicTags(node, sbsql, requestDataForm);
		else if(!requestDataForm.getString(property).equals(compareValue)) parseDynamicTags(node, sbsql, requestDataForm);
	}
	@Override
	public SqlResultForm parseSqlIdByFirstSql(String sqlId, RequestDataForm requestDataForm) throws Exception {
		Map<String,Map<String,String>> cache = GlobalCache.getCache(UrlExecSqlCache.class,Map.class);
		UserSessionBean userSession=requestDataForm.getUserSession();
		String[] keys = sqlId.split("\\.");
		Map<String, String> map = cache.get(keys[1]);
		if(map==null || map.isEmpty()){
			throw new CustomException("sql_id["+sqlId+"]不存在");
		}
		if(!map.containsKey(keys[2])){
			throw new CustomException("sql_id["+sqlId+"]不存在");
		}
		String xml=map.get(keys[2]);
		Element root = XmlUtils.getElementByString(xml);
		NodeList sqlNodes = root.getChildNodes();
		Node child = null;
		for (int i = 0; i < sqlNodes.getLength(); i++) {
			child = sqlNodes.item(i);
			if (child.getNodeType() == Node.ELEMENT_NODE){
				break;
			}
		}
		return parseNode(child,requestDataForm,userSession);
	}
	
	@Override
	public List<SqlResultForm> parseSqlId(String sqlId, RequestDataForm requestDataForm) throws Exception {
		Map<String,Map<String,String>> cache = GlobalCache.getCache(UrlExecSqlCache.class,Map.class);
		UserSessionBean userSession=requestDataForm.getUserSession();
		String[] keys = sqlId.split("\\.");
		Map<String, String> map = cache.get(keys[1]);
		if(map==null || map.isEmpty()){
			throw new CustomException("sql_id["+sqlId+"]不存在");
		}
		if(!map.containsKey(keys[2])){
			throw new CustomException("sql_id["+sqlId+"]不存在");
		}
		String xml=map.get(keys[2]);
		Element root = XmlUtils.getElementByString(xml);
		ArrayList<SqlResultForm> list=new ArrayList<SqlResultForm>();
		NodeList sqlNodes = root.getChildNodes();
		for (int i = 0; i < sqlNodes.getLength(); i++) {
			Node child = sqlNodes.item(i);
			if (child.getNodeType() != Node.ELEMENT_NODE)
				continue;
			list.add(parseNode(child,requestDataForm,userSession));
		}
		return list;
	}
}
