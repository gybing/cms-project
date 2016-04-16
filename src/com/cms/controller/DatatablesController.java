package com.cms.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cms.common.controller.BaseController;
import com.cms.common.form.PaginForm;
import com.cms.common.form.RequestDataForm;
import com.cms.common.form.ResponseDataForm;
import com.cms.common.listener.SpringContextUtil;
import com.cms.common.service.IService;
import com.cms.common.utils.Environment;
import com.cms.common.utils.MapUtils;

@Controller
@RequestMapping("/topic")
public class DatatablesController extends BaseController{
	protected static Logger logger = Logger.getLogger(DatatablesController.class);
	
	@RequestMapping(value = "/page/{id}")
	public @ResponseBody Object dataTabelsPageData(@PathVariable String id, HttpServletRequest request,HttpServletResponse response) throws Exception {
		RequestDataForm requestDataForm = getRequestDataForm(id, request, response);
		Map<String, Object> urlSqlMap = requestDataForm.getUrlSqlMap();
		String service = MapUtils.getString(urlSqlMap, "SERVICE_NAME");
		if (null == service || "".equals(service)) {
			service = "ajaxService";
		}
		try {
			//开始显示条数
			int startIndex = requestDataForm.getInteger("start");
			//当前页显示条数
			int rows = requestDataForm.getInteger("length");
			requestDataForm.putString(Environment.CTRL_NUMPERPAGE, String.valueOf(rows));
			requestDataForm.putString(Environment.CTRL_PAGENUM, String.valueOf((startIndex/rows)+1));
			ResponseDataForm responseDataForm = SpringContextUtil.getBean(service,IService.class).service(requestDataForm);
			
			Map<String, Object> map = new HashMap<String, Object>();
			PaginForm pf = (PaginForm) responseDataForm.getResultObj();
			map.put("recordsFiltered", pf.getTotalCount());
			map.put("recordsTotal", pf.getTotalCount());
			map.put("data", pf.getDataList());
			map.put("draw", requestDataForm.getString("draw"));  // 1
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			final String message = e.getMessage();
			return new HashMap<String, String>() {
				private static final long serialVersionUID = 1L;
				{
					put("result", "3");
					put("resultInfo", message);
				}
			};
		}
	}

	@RequestMapping(value = "/page1/{id}")
	public @ResponseBody Object dataTabelsPageData1(@PathVariable String id, HttpServletRequest request,HttpServletResponse response) throws Exception {
		RequestDataForm requestDataForm = getRequestDataForm(id, request, response);
		Map<String, Object> urlSqlMap = requestDataForm.getUrlSqlMap();
		String service = MapUtils.getString(urlSqlMap, "SERVICE_NAME");
		if (null == service || "".equals(service)) {
			service = "ajaxService";
		}
		try {
			//开始显示条数
			int startIndex = requestDataForm.getInteger("iDisplayStart");
			//当前页显示条数
			int rows = requestDataForm.getInteger("iDisplayLength");
			requestDataForm.putString(Environment.CTRL_NUMPERPAGE, String.valueOf(rows));
			requestDataForm.putString(Environment.CTRL_PAGENUM, String.valueOf((startIndex/rows)+1));
			ResponseDataForm responseDataForm = SpringContextUtil.getBean(service,IService.class).service(requestDataForm);
			
			Map<String, Object> map = new HashMap<String, Object>();
			PaginForm pf = (PaginForm) responseDataForm.getResultObj();
			map.put("iTotalDisplayRecords", pf.getTotalCount());
			map.put("iTotalRecords", pf.getDataList().size());
			map.put("aaData", pf.getDataList());
			map.put("sEcho", requestDataForm.getString("sEcho"));  // 1
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			final String message = e.getMessage();
			return new HashMap<String, String>() {
				private static final long serialVersionUID = 1L;
				{
					put("result", "3");
					put("resultInfo", message);
				}
			};
		}
	}	
}
