package com.cms.common.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.cms.common.cache.GlobalCache;
import com.cms.common.cache.impl.UrlExecSqlCache;
import com.cms.common.cache.impl.UrlValidationCache;
import com.cms.common.exception.CustomException;
import com.cms.common.form.PaginForm;
import com.cms.common.form.RequestDataForm;
import com.cms.common.form.ResponseDataForm;
import com.cms.common.listener.SpringContextUtil;
import com.cms.common.service.IServiceCallback;
import com.cms.common.sqlparse.SqlResultForm;
import com.cms.common.utils.Environment;
import com.cms.common.utils.MapUtils;
import com.cms.common.utils.RegexUtils;
import com.cms.common.utils.XmlUtils;
import com.google.gson.Gson;

/**
 * ajax通用处理类
 * @author zl
 */
@Service("ajaxService")
public class AjaxService extends AbstractService {
	
	@Transactional
	public ResponseDataForm service(RequestDataForm requestDataForm) throws Exception {
		// 实现如下:
		ResponseDataForm rdf = new ResponseDataForm();
		Map<String, Object> urlSqlMap = requestDataForm.getUrlSqlMap();
		
		//执行验证
		String validation = MapUtils.getString(urlSqlMap, "VALIDATION_ID");
		if (!"".equals(validation)) {
			Map<String, Map<String, Element>> validationMap = GlobalCache.getCache(UrlValidationCache.class, Map.class);
			String[] keys = validation.split("\\.");
			Map<String, Element> map = validationMap.get(keys[1]);
			if(map==null || map.isEmpty() || !map.containsKey(keys[2])){
				throw new CustomException("validation_id["+validation+"]不存在");
			}
			NodeList sqlNodes = map.get(keys[2]).getChildNodes();//XmlUtils.getNoteListByString(validation);
			Element element = null;
			rdf.setResult(ResponseDataForm.SESSFUL);
			ArrayList<String> msgList=new ArrayList<String>();
			for (int i = 0; i < sqlNodes.getLength(); i++) {
				Node child = sqlNodes.item(i);
				if (child.getNodeType() != Node.ELEMENT_NODE)
					continue;
				element = (Element) child;
				ResponseDataForm result = validator(element,requestDataForm);
				if(ResponseDataForm.FAULAIE.equals(result.getResult())) {//服务器验证失败
					rdf.setResult(ResponseDataForm.FAULAIE);
					msgList.add(result.getResultInfo());
				}
			}
			if(ResponseDataForm.FAULAIE.equals(rdf.getResult())){
				rdf.setResultInfo(StringUtils.join(msgList,"\r\n"));
				return rdf;
			}
		}
		
		String sqlId=MapUtils.getString(urlSqlMap, "SQL_ID");
		Map<String,Map<String,String>> cache = GlobalCache.getCache(UrlExecSqlCache.class,Map.class);
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
		ArrayList<Object> relist=new ArrayList<Object>();
		for (int i = 0; i < sqlNodes.getLength(); i++) {
			Node child = sqlNodes.item(i);
			if (child.getNodeType() != Node.ELEMENT_NODE)
				continue;
			Element element = (Element) child;
			Object ajaxObject = null;
			String operator = element.getAttribute("operator");//select/insert_file/del_file/execute/callback
			
			if("select".equalsIgnoreCase(operator)){
				ajaxObject=opSelect(element,requestDataForm);
				relist.add(ajaxObject);
			}else if("execute".equalsIgnoreCase(operator)){
				opExecute(element,requestDataForm);
			}else if("insert_file".equalsIgnoreCase(operator)){
				throw new CustomException("方法未实现");
			}else if("del_file".equalsIgnoreCase(operator)){
				throw new CustomException("方法未实现");
			}else if("callback".equalsIgnoreCase(operator)){
				ResponseDataForm responseDataForm = opCallBack(element,requestDataForm);
				if(ResponseDataForm.SESSFUL.equals(responseDataForm.getResult())){
					if(responseDataForm.getResultObj()!=null){
						relist.add(responseDataForm.getResultObj());
					}
				}else{
					return responseDataForm;
				}
			}else{
				throw new CustomException("xmlconfig param[\"operator\"="+operator+"] is undefind");
			}
		}
		rdf.setResult(ResponseDataForm.SESSFUL);
		rdf.setResultInfo("操作成功");
		if(relist.size()>1){
			
//			rdf.setResultObj(new Gson().toJson(relist));
			rdf.setResultObj(relist);
		}else if(relist.size()==1){
//			rdf.setResultObj(new Gson().toJson(relist.get(0)));
			rdf.setResultObj(relist.get(0));
			System.out.println(relist.get(0));
//			System.out.println(new Gson().toJson(relist.get(0)));
		}
		return rdf;
	}
	
	/**
	 * 执行查询语句
	 * @param element
	 * @param requestDataForm
	 * @return
	 * @throws Exception
	 */
	private Object opSelect(Element element,RequestDataForm requestDataForm) throws Exception{
		String resultType = element.getAttribute("resultType");
		if(StringUtils.isEmpty(resultType)){
			resultType="list";
		}
		Object obj = null;
		if("string".equals(resultType)) {
			SqlResultForm srf = sqlParse.parseNode(element, requestDataForm, requestDataForm.getUserSession());
			obj = jdbcDao.queryForString(srf.getParsedSql(), srf.getValueList().toArray());
		} else if("map".equals(resultType)) {
			SqlResultForm srf = sqlParse.parseNode(element, requestDataForm, requestDataForm.getUserSession());
			obj = jdbcDao.queryForMap(srf.getParsedSql(), srf.getValueList().toArray());
		} else if("list".equals(resultType)){
			SqlResultForm srf = sqlParse.parseNode(element, requestDataForm, requestDataForm.getUserSession());
			obj = jdbcDao.queryForList(srf.getParsedSql(), srf.getValueList().toArray());
		} else if("autoPaging".equals(resultType)){
			SqlResultForm srf = sqlParse.parseNode(element, requestDataForm, requestDataForm.getUserSession());
			PaginForm paginForm = new PaginForm();
			String parsedSql = "select count(1) from (" + srf.getParsedSql() + ") aa";
			int count = Integer.parseInt(jdbcDao.queryForString(parsedSql, srf.getValueList().toArray()));//获取总数
			paginForm.setTotalCount(count);
			int numPerPage = requestDataForm.getInteger(Environment.CTRL_NUMPERPAGE,0) == 0 ? Integer.parseInt(Environment.DEFAULT_NUMPERPAGE) : requestDataForm.getInteger(Environment.CTRL_NUMPERPAGE,0);
			int pageNum = requestDataForm.getInteger(Environment.CTRL_PAGENUM,0)==0 ? Integer.parseInt(Environment.DEFAULT_PAGENUM) : requestDataForm.getInteger(Environment.CTRL_PAGENUM,0); 
			int startNum = numPerPage*(pageNum-1);
			int endNum = numPerPage;
			requestDataForm.put(Environment.CTRL_PAGESTART, String.valueOf(startNum));
			requestDataForm.put(Environment.CTRL_PAGEEND, String.valueOf(endNum));
			requestDataForm.put(Environment.CTRL_NUMPERPAGE, String.valueOf(numPerPage));
			paginForm.setPageNum(pageNum);
			paginForm.setNumPerPage(numPerPage);
			paginForm.setStartNum(startNum);
			paginForm.setPageNumShown(requestDataForm.getInteger(Environment.CTRL_PAGENUMSHOWN,0) == 0 ? Integer.parseInt(Environment.DEFAULT_PAGENUMSHOWN) : requestDataForm.getInteger(Environment.CTRL_PAGENUMSHOWN,0));
			parsedSql = srf.getParsedSql() + " limit " + startNum + "," + endNum;
			List<Map<String, Object>> rsList = jdbcDao.queryForList(parsedSql, srf.getValueList().toArray());
			paginForm.setDataList(rsList);
			obj=paginForm;
//			obj = rsList;
		} else if("paging".equals(resultType)){
			PaginForm paginForm = new PaginForm();
			requestDataForm.put(Environment.CTRL_QUERYCOUNT, "havet");//新增查询总数条件,值为随意
			SqlResultForm srfCount = sqlParse.parseNode(element, requestDataForm, requestDataForm.getUserSession());
			requestDataForm.remove(Environment.CTRL_QUERYCOUNT);//移除查询总数条件
			int count = Integer.parseInt(jdbcDao.queryForString(srfCount.getParsedSql(), srfCount.getValueList().toArray()));//获取总数
			paginForm.setTotalCount(count);
			int numPerPage = requestDataForm.getInteger(Environment.CTRL_NUMPERPAGE,0) == 0 ? Integer.parseInt(Environment.DEFAULT_NUMPERPAGE) : requestDataForm.getInteger(Environment.CTRL_NUMPERPAGE,0);
			int pageNum = requestDataForm.getInteger(Environment.CTRL_PAGENUM,0)==0 ? Integer.parseInt(Environment.DEFAULT_PAGENUM) : requestDataForm.getInteger(Environment.CTRL_PAGENUM,0); 
			int startNum = numPerPage*(pageNum-1);
			int endNum = numPerPage;
			requestDataForm.put(Environment.CTRL_PAGESTART, String.valueOf(startNum));
			requestDataForm.put(Environment.CTRL_PAGEEND, String.valueOf(endNum));
			requestDataForm.put(Environment.CTRL_NUMPERPAGE, String.valueOf(numPerPage));
			paginForm.setPageNum(pageNum);
			paginForm.setNumPerPage(numPerPage);
			paginForm.setStartNum(startNum);
			paginForm.setPageNumShown(requestDataForm.getInteger(Environment.CTRL_PAGENUMSHOWN,0) == 0 ? Integer.parseInt(Environment.DEFAULT_PAGENUMSHOWN) : requestDataForm.getInteger(Environment.CTRL_PAGENUMSHOWN,0));
			SqlResultForm srf = sqlParse.parseNode(element, requestDataForm, requestDataForm.getUserSession());
			List<Map<String, Object>> rsList = jdbcDao.queryForList(srf.getParsedSql(), srf.getValueList().toArray());//获取数据
			paginForm.setDataList(rsList);
			obj=paginForm;
		}
		return obj;
	}
	
	/**
	 * 执行insert、update、delete的sql语句
	 * @param element
	 * @param requestDataForm
	 * @throws Exception
	 */
	private void opExecute(Element element,RequestDataForm requestDataForm) throws Exception{
		String iterFields = element.getAttribute("iterfields");// 多个变量用,号隔开，循环迭代标志，页面迭代的参数，多个用,号隔开；可以是页面直接提交多个数值或一个数值配合iterfieldsplit参数进行分解,如果为多个，必须保证页面提交参数的数值个数必须相同
		String iterFieldSplit = element.getAttribute("iterfieldsplit");// 可以为空，为空，则按页面提交参数的个数（参考iterfields中的第一个）进行迭代，如果此参数不为空，将iterfield按此参数进行分解并迭代。如iterfields=rights,iterFieldSplit=“,”，页面提交的rights参数值为101,102，迭代的次数为2
		int iterSize = 1;
		String[] iterFieldArr = null;
		if (!"".equals(iterFields)) {
			iterFieldArr = iterFields.split(",");
			if ("".equals(iterFieldSplit)) {// 按照提交的数值个数进行循环
				iterSize = requestDataForm.getStringList(iterFieldArr[0]).size();
			} else {
				if(StringUtils.isEmpty(requestDataForm.getString(iterFieldArr[0]))){
					iterSize=0;
				}else
					iterSize = requestDataForm.getString(iterFieldArr[0]).split(iterFieldSplit).length;
			}
		}
		HashMap<String,String[]> fieldsMap=new HashMap<String,String[]>();
		if (iterFieldArr != null) {
			for (String piterfield : iterFieldArr) {
				if ("".equals(iterFieldSplit)) {
					fieldsMap.put(piterfield, requestDataForm.getStringList(piterfield).toArray(new String[]{}));
				}else{
					fieldsMap.put(piterfield,requestDataForm.getString(piterfield).split(iterFieldSplit));
				}
			}
		}
		
		for (int i = 0; i < iterSize; i++) {// 循环的次数
			if(!fieldsMap.isEmpty()){
				for(Map.Entry<String, String[]> entry:fieldsMap.entrySet()){
					requestDataForm.put(entry.getKey(), entry.getValue()[i]);
				}
			}
			SqlResultForm srf = sqlParse.parseNode(element, requestDataForm, requestDataForm.getUserSession());
			jdbcDao.execute(srf.getParsedSql(), srf.getValueList().toArray());
		}
	}
	
	/**
	 * 执行回调节点
	 * @param element
	 * @param requestDataForm
	 * @return
	 * @throws Exception
	 */
	private ResponseDataForm opCallBack(Element element,RequestDataForm requestDataForm) throws Exception{
		ResponseDataForm rdf=new ResponseDataForm();
		String clazz = element.getAttribute("class");//可选，用于opertor为callbak回调适用的类
		try{
			rdf = SpringContextUtil.getBean(clazz,IServiceCallback.class).serviceCallback(requestDataForm);
		}catch(Exception e){
			e.printStackTrace();
			rdf.setResult(ResponseDataForm.FAULAIE);
			rdf.setResultInfo("操作出错,"+e.getMessage());
		}
//		Class<?> cls = Class.forName(clazz);
//		Object newInstance = cls.newInstance();
//		if(newInstance instanceof IServiceCallback){
//			IServiceCallback sc=(IServiceCallback) newInstance;
//			rdf = ((IServiceCallback) newInstance).serviceCallback(requestDataForm);
//			Method method = cls.getMethod("serviceCallback", new Class[] { RequestDataForm.class, ResponseDataForm.class });
//			method.invoke(newInstance,new Object[] { requestDataForm, rdf});
//		}else{
//			throw new CustomException(clazz + "未实现 IServiceCallback 接口!");
//		}
		return rdf;
	}
	
	private ResponseDataForm validator(Element data, RequestDataForm requestDataForm) throws Exception{
		ResponseDataForm rdf=new ResponseDataForm();
		String field = data.getAttribute("field");// 验证的参数名称
		String method = "".equals("method") ? "reg" : data.getAttribute("method");// 验证方法，reg/database为空时候为reg
		String msg = data.getAttribute("msg");// 提示信息
		boolean required = "".equals("required") ? true : Boolean.parseBoolean(data.getAttribute("required"));// true/false是否必填,为空时候为true
		String reg = data.getAttribute("reg");// 正则表达式，可以为空，
		int maxlength = (data.getAttribute("maxlength") == null || "".equals( data.getAttribute("maxlength"))) ? -1 : Integer.parseInt(data.getAttribute("maxlength"));// 最大长度,数字，可以为空
		int minlength = (data.getAttribute("minlength") == null || "".equals( data.getAttribute("minlength")))? -1 : Integer.parseInt(data.getAttribute("minlength"));// 最小长度,数字，可以为空
		String orisql = data.getAttribute("sql");// 验证方式为database，判断的sql
		if (method.equals("database")) {
			SqlResultForm srf = sqlParse.parseString(orisql, requestDataForm,requestDataForm.getUserSession());
			String result = jdbcDao.queryForString(srf.getParsedSql(), srf.getValueList().toArray());
			if(!"0".equals(result)){
				rdf.setResult(ResponseDataForm.FAULAIE);
				rdf.setResultInfo(msg);
				return rdf;
			}
		} else if (method.equals("reg")) {
			if(requestDataForm.getString(field,null)==null) {
				throw new CustomException("\t\r\n需要验证的参数:[" + field + "]不存在,请确定表单有存在该参数!");
			}
			String value = requestDataForm.getString(field);
			if ("".equals(value) && !required){
				rdf.setResult(ResponseDataForm.FAULAIE);
				msg=StringUtils.isEmpty(msg)?("["+field+"]参数不能为空"):msg;
				rdf.setResultInfo(msg);
				return rdf;
			}
			if(!RegexUtils.match(reg, value)){
				rdf.setResult(ResponseDataForm.FAULAIE);
				msg=StringUtils.isEmpty(msg)?("["+field+"]的内容格式不正确"):msg;
				rdf.setResultInfo(msg);
				return rdf;
			}
			if (minlength > 0 && value.length() < minlength) {
				rdf.setResult(ResponseDataForm.FAULAIE);
				msg=StringUtils.isEmpty(msg)?("["+field+"]的内容长度不能小于"+minlength):msg;
				rdf.setResultInfo(msg);
				return rdf;
			}
			if (maxlength > 0 && value.length() > maxlength) {
				rdf.setResult(ResponseDataForm.FAULAIE);
				msg=StringUtils.isEmpty(msg)?("["+field+"]的内容长度不能大于"+maxlength):msg;
				rdf.setResultInfo(msg);
				return rdf;
			}
		} else {
			throw new CustomException("\t\r\n验证方法:" + method + "不存在，数据库验证请使用：database，正则表达式验证请使用：reg!");
		}
		rdf.setResult(ResponseDataForm.SESSFUL);
		return rdf;
	}
}
