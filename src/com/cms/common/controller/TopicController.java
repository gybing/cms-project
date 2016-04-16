package com.cms.common.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.cms.common.dao.IJdbcDao;
import com.cms.common.excel.ExcelPOIUtil;
import com.cms.common.exception.CustomException;
import com.cms.common.form.PaginForm;
import com.cms.common.form.RequestDataForm;
import com.cms.common.form.ResponseDataForm;
import com.cms.common.listener.SpringContextUtil;
import com.cms.common.service.IService;
import com.cms.common.utils.Environment;
import com.cms.common.utils.JsonUtil;
import com.cms.common.utils.MapUtils;
import com.cms.common.utils.Util;
import com.cms.common.web.utils.CommonUtils;

/**
 * @author lansb 用户URL统一入口
 */
@Controller
@RequestMapping("/topic")
public class TopicController extends BaseController{
	protected static Logger logger = Logger.getLogger(TopicController.class);

	@Autowired
	private IJdbcDao jdbcDao;
	
	@RequestMapping(value = "/{id}")
	public String topic(@PathVariable String id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		RequestDataForm requestDataForm = getRequestDataForm(id, request, response);
		Map<String, Object> urlSqlMap = requestDataForm.getUrlSqlMap();
		String service = MapUtils.getString(urlSqlMap, "SERVICE_NAME");
		//添加url表配置的参数
		String param=MapUtils.getString(urlSqlMap, "PARAMETERS");
		if(StringUtils.isNotEmpty(param)){
			Map<String, String> paramsMap = Util.getUrlParam(param);
			for(Map.Entry<String, String> entry:paramsMap.entrySet()){
				requestDataForm.put(entry.getKey(), entry.getValue());
			}
			
		}
		String sqlid=MapUtils.getString(urlSqlMap, "SQL_ID");
		if (StringUtils.isEmpty(service) && StringUtils.isEmpty(sqlid)) {// service为空，直接跳转到页面
			return MapUtils.getString(urlSqlMap, "PAGE");
		} else {
			if(StringUtils.isEmpty(service)){
				service = "ajaxService";
			}
//			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
//			ResponseDataForm responseDataForm = ((IService) ctx.getBean(service)).service(requestDataForm);
			ResponseDataForm responseDataForm = SpringContextUtil.getBean(service,IService.class).service(requestDataForm);
			request.setAttribute("responseDataForm", responseDataForm);
			String page = responseDataForm.getPage();
			if(StringUtils.isEmpty(page)) {
				page = MapUtils.getString(urlSqlMap, "PAGE");
			}
			return page;
		}
	}
	
	/**
	 * ajax请求统一调用改方法
	 * @param id
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/ajax/{id}")
	public @ResponseBody Object ajaxCall(@PathVariable String id, HttpServletRequest request,HttpServletResponse response) throws Exception {
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
			return SpringContextUtil.getBean(service,IService.class).service(requestDataForm);
		} catch (Exception e) {
			e.printStackTrace();
			ResponseDataForm responseDataForm=new ResponseDataForm();
			responseDataForm.setResult(ResponseDataForm.FAULAIE);
			responseDataForm.setResultInfo(e.getMessage());
			return responseDataForm;
		}
	}
	
	/**
	 * 加载 dataTables 数据统一入口
	 * @param id
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/loadTable/{id}")
	public @ResponseBody Object loadTablesData(@PathVariable String id, HttpServletRequest request,HttpServletResponse response) throws Exception {
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
//			return SpringContextUtil.getBean(service,IService.class).service(requestDataForm);
			/** ===================================================== **/
			ResponseDataForm responseDataForm = SpringContextUtil.getBean(service,IService.class).service(requestDataForm);
			Map<String, Object> map = new HashMap<String, Object>();
			PaginForm pf = (PaginForm) responseDataForm.getResultObj();
			map.put("recordsFiltered", pf.getTotalCount());
			map.put("recordsTotal", pf.getTotalCount());
			map.put("data", pf.getDataList());
			map.put("draw", requestDataForm.getString("draw"));  // 1
			return map;
			/** ===================================================== **/
		} catch (Exception e) {
//			e.printStackTrace();
//			ResponseDataForm responseDataForm=new ResponseDataForm();
//			responseDataForm.setResult(ResponseDataForm.FAULAIE);
//			responseDataForm.setResultInfo(e.getMessage());
//			return responseDataForm;
			/** ===================================================== **/
			e.printStackTrace();
			final String message = e.getMessage();
			return new HashMap<String, String>() {
				private static final long serialVersionUID = 1L;
				{
					put("result", "3");
					put("resultInfo", message);
				}
			};
			/** ===================================================== **/
			
		}
	}
	
	
	@RequestMapping(value = "/exportExcel/{id}")
	public void export(@PathVariable String id, HttpServletRequest request, HttpServletResponse response) throws Exception {
		RequestDataForm requestDataForm = getRequestDataForm(id, request, response);
		Map<String, Object> urlSqlMap = requestDataForm.getUrlSqlMap();
		String service = MapUtils.getString(urlSqlMap, "SERVICE_NAME");
		String fileName=requestDataForm.getString("fileName");
		String exportType=requestDataForm.getString("exportType");
		String titles=requestDataForm.getString("titles");
		String titleNames=requestDataForm.getString("titleNames");
		String fileSuffix=".xlsx";
		if(StringUtils.isEmpty(fileName)){
			fileName="导出";
		}
		if(exportType.equalsIgnoreCase("2003")){
			fileSuffix=".xls";
		}
		requestDataForm.setUrlSqlMap(urlSqlMap);
		if (null == service || "".equals(service)) {
			service = "ajaxService";
		}
		try {
			ResponseDataForm responseDataForm = SpringContextUtil.getBean(service,IService.class).service(requestDataForm);
			List list = (List) responseDataForm.getResultObj();
			response.reset();
			 //客户端不缓存   
			response.addHeader("Pargam", "no-cache");   
			response.addHeader("Cache-Control", "no-cache");
			 // 设置response的Header
			response.setContentType("application/octet-stream;charset=iso-8859-1");   
			//response.addHeader("Content-Disposition", "attachment;filename=" + java.net.URLEncoder.encode("用户信息采集.xlsx","UTF-8"));
			response.addHeader("Content-Disposition", "attachment; filename=" + new String((fileName+fileSuffix).getBytes(),"iso-8859-1"));
			
			LinkedHashMap<String, String> titleMap=new LinkedHashMap<String, String>();
			String[] title=titles.split(",");
			String[] titleName=titleNames.split(",");
			for(int i=0;i<title.length;i++){
				titleMap.put(title[i], titleName[i]);
			}
			
			ExcelPOIUtil util=new ExcelPOIUtil();
			util.writeExecl2007(response.getOutputStream(), fileName, titleMap, list);
			response.flushBuffer();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "/uploadImg/{id}")
	public @ResponseBody Object uploadImg(@PathVariable String id, HttpServletRequest request,HttpServletResponse response) throws Exception {
		RequestDataForm requestDataForm = getRequestDataForm(id, request, response);
		Map<String, Object> urlSqlMap = requestDataForm.getUrlSqlMap();
		String service = MapUtils.getString(urlSqlMap, "SERVICE_NAME");
		if (null == service || "".equals(service)) {// service为空，直接跳转到页面
			return MapUtils.getString(urlSqlMap, "PAGE");
		} else {
			request.setAttribute(Environment.URL_SQL_MAP, urlSqlMap);// add
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
			ResponseDataForm responseDataForm = ((IService) ctx.getBean(service)).service(requestDataForm);
			
			request.setAttribute("responseDataForm", responseDataForm);
			String fileid =  jdbcDao.queryForString("select max(att_id) lastId from sys_attachment_tab", null);
			Map<String, Object> m = new HashMap<String, Object>();
			m.put("error", 0);
			m.put("message", "上传成功");
			m.put("url", request.getContextPath() + "/topic/getFile/" + fileid);
			return m;
		}
	}	
	
	@RequestMapping(value = "/getFile/{id}")
	public  Object getFile(@PathVariable String id,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> urlSqlMap = jdbcDao.queryForMap(
				"select * from sys_attachment_tab a where a.att_id=?",
				new Object[] { id });
		if (urlSqlMap == null || urlSqlMap.size() == 0) {
			throw new CustomException(
					"附件不存在!.");
		}
		String path = urlSqlMap.get("SAVE_FILE_NAME").toString();
		String filename = urlSqlMap.get("UP_FILE_NAME").toString();
		File file = new File(path);
        // 取得文件名。
        // 取得文件的后缀名。

        // 以流的形式下载文件。
        InputStream fis = new BufferedInputStream(new FileInputStream(path));
        byte[] buffer = new byte[fis.available()];
        fis.read(buffer);
        fis.close();
        // 清空response
        response.reset();
        // 设置response的Header
        response.setContentType("appliation/octet-stream"); 
		response.setHeader("Content-disposition", "attachment; filename=" + new String(filename.getBytes(Environment.ENCODING), "ISO-8859-1"));
        response.addHeader("Content-Length", "" + file.length());
        OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
        toClient.write(buffer);
        toClient.flush();
        toClient.close();
        return null;
	}
	
	/**
	 * 编辑器文件上传
	 * @param request
	 * @param response
	 * @throws Exception
	 */
//	@RequestMapping(value = "/uploadImg", method = RequestMethod.POST)
	public void EditFileUpload(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		// 验证用户是否登录
		OutputStream fos = null;
		InputStream ins = null;
		PrintWriter out = response.getWriter();
		try {
			response.setCharacterEncoding("UTF-8");
			MultipartResolver resolver = new CommonsMultipartResolver(request
					.getSession().getServletContext());
			MultipartHttpServletRequest multipartRequest = resolver
					.resolveMultipart(request);
			MultipartFile imgFile = multipartRequest.getFile("imgFile");
			boolean flag = true;
			String imgName = "";
			String message = "";
			if (imgFile != null) {
				if (imgFile.getSize() > 2097152) {
					message = "上传文件内容太大，请上传2M以内的图片";
					flag = false;
				} else {
					String suffix = imgFile.getOriginalFilename().substring(
							imgFile.getOriginalFilename().lastIndexOf(".")); // 获取文件后缀名
					imgName = "park_"
							+ CommonUtils.getFormatDate(new Date(),
									"yyyyMMddhhmmss") + suffix; // 生成文件名
					if (!suffix.equalsIgnoreCase(".jpg") && !suffix.equalsIgnoreCase(".png")) {
						message = "上传图片格式不正确，请上传 .jpg 或者 .png 图片";
						flag = false;
					} else {
						String savepath = request
								.getSession()
								.getServletContext()
								.getRealPath(
										"/WEB-INF/res/upload"
												+ File.separator
												+ CommonUtils.getFormatDate(
														new Date(), "yyyyMMdd"));
						File createFile = new File(savepath);
						if (!createFile.exists()) {
							createFile.mkdirs();
						}
						fos = new FileOutputStream(savepath + "/" + imgName);
						ins = imgFile.getInputStream();
						byte[] buffer = new byte[2 * 1024*1024];
						int length = 0;
						while (-1 != (length = ins.read(buffer))) {
							fos.write(buffer, 0, length);
						}
						try {
							fos.close();
							ins.close();
						} catch (IOException e) {
							e.printStackTrace();
						}
					}

				}
			} else {
				flag = false;
				message = "请选择图片";
			}
			if (flag) {
				map.put("error", 0);
				map.put("url",
						request.getSession().getServletContext()
								.getAttribute("resRoot")
								+ "/upload/"
								+ CommonUtils.getFormatDate(new Date(),
										"yyyyMMdd") + "/" + imgName);
			} else {
				map.put("error", 1);
				map.put("message", message);
			}
			out.print(JsonUtil.beanToJson(map));
			out.flush();
			out.close();
		} catch (Exception e1) {
			e1.printStackTrace();
			map.put("error", 1);
			map.put("message", e1.getMessage());
			out.print(JsonUtil.beanToJson(map));
			out.flush();
			out.close();
		} 
		
	}
	
}
