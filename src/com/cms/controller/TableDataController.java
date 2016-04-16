package com.cms.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cms.common.controller.BaseController;
import com.cms.common.dao.impl.JdbcDaoImpl;
import com.cms.common.form.RequestDataForm;
import com.cms.common.form.ResponseDataForm;
import com.cms.common.listener.SpringContextUtil;
import com.cms.common.service.IService;
import com.cms.common.utils.MapUtils;
import com.cms.common.utils.Util;
import com.google.gson.Gson;

@Controller
@RequestMapping("/getTableData")
public class TableDataController extends BaseController{
	
	@Resource
	private JdbcDaoImpl jdbcDao;
	
	@RequestMapping(value="/ajax/{id}")
	public @ResponseBody Object ajaxCall(@PathVariable String id, HttpServletRequest request,HttpServletResponse response) throws Exception {
		// 封装 urlMap cache 等到自定义请求中
		RequestDataForm requestDataForm = getRequestDataForm(id, request, response);
		
		Map<String, Object> urlSqlMap = requestDataForm.getUrlSqlMap();
		String service = MapUtils.getString(urlSqlMap, "SERVICE_NAME");
		requestDataForm.setUrlSqlMap(urlSqlMap);
		//添加url表配置的参数
		String param=MapUtils.getString(urlSqlMap, "PARAMETERS");
		if(StringUtils.isNotEmpty(param)){
			Map<String, String> paramsMap = Util.getUrlParam(param);
			for(Map.Entry<String, String> entry:paramsMap.entrySet()){
				requestDataForm.put(entry.getKey(), entry.getValue());
			}
			
		}
		
		if (null == service || "".equals(service)) {
			service = "ajaxService";
		}
		try {
			ResponseDataForm rdf = SpringContextUtil.getBean(service,IService.class).service(requestDataForm);
			ArrayList<String> list = new ArrayList<String>();
			if(rdf.getResultObj() != null){
				list =  (ArrayList<String>) rdf.getResultObj();
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			ResponseDataForm responseDataForm=new ResponseDataForm();
			responseDataForm.setResult(ResponseDataForm.FAULAIE);
			responseDataForm.setResultInfo(e.getMessage());
			return responseDataForm;
		}
		
	}
}
