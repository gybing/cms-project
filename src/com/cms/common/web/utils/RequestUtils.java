package com.cms.common.web.utils;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.cms.common.form.RequestDataForm;
import com.cms.common.utils.Environment;
import com.cms.common.web.httpobjects.HttpRequestObject;
import com.cms.common.web.httpobjects.ServletInputStreamParse;


/**
 * @author lansb
 *
 */
public class RequestUtils {

	//private static Log logger = LogFactory.getLog(RequestUtils.class);
	/**
	 * 处理http请求
	 *@param request
	 *@return RequestDataForm
	 *@throws Exception
	 */
	public static RequestDataForm getRequestDataForm(RequestDataForm requestDataForm) throws Exception{
		String type = RequestUtils.getExtractType(requestDataForm.getRequest());
		if (type == null 
				|| !type.toLowerCase().startsWith("multipart/form-data")) {
			RequestUtils.getHttpRequestInfo(requestDataForm.getRequest(), requestDataForm);
		} else {//附件上传方式
			ServletInputStreamParse input = new ServletInputStreamParse(requestDataForm.getRequest());
			input.getHttpRequestInfo(requestDataForm);
		}
		getSessionInfo(requestDataForm);
		return requestDataForm; 
	}

	/**
	 * get request enctype type
	 * 
	 * @param request
	 * @return
	 * @throws IOException
	 */
	public static String getExtractType(HttpServletRequest request)
			throws IOException {
		String type = null;
		String type1 = request.getHeader("Content-Type");
		String type2 = request.getContentType();
		if (type1 == null && type2 != null) {
			type = type2;
		} else if (type2 == null && type1 != null) {
			type = type1;
		} else if (type1 != null && type2 != null) {
			type = (type1.length() > type2.length() ? type1 : type2);
		}
		return type;
	}

	// ---------form enctype !=
	// multipart/form-data--------------------------------------------------
	/**
	 * get LinkedHashMap key=lsh ,value=HttpRequestObject form enctype !=
	 * multipart/form-dat
	 */
	public static void getHttpRequestInfo(HttpServletRequest request, RequestDataForm requestDataForm) throws Exception {
//		Map<String, List<HttpRequestObject>> multipleRequestMap = new LinkedHashMap<String, List<HttpRequestObject>>();
//		Map<String, String> simpleRequestMap = new HashMap<String, String>();
		@SuppressWarnings("rawtypes")
		Enumeration names = request.getParameterNames();
		while (names.hasMoreElements()) {
			String name = (String) names.nextElement();
			String[] values = request.getParameterValues(name);
			if (null == values) {
				HttpRequestObject hro = new HttpRequestObject();
				hro.setParamType("param");
				hro.setName(name);
				hro.setValue("".getBytes(Environment.ENCODING));
//				simpleRequestMap.put(name, "");
				requestDataForm.put(name, "");
			} else {
				if(values.length==1){
					requestDataForm.put(name, values[0]);
				}else{
					List<HttpRequestObject> list = new LinkedList<HttpRequestObject>();
					for (String value : values) {
						HttpRequestObject hro = new HttpRequestObject();
						hro.setParamType("param");
						hro.setName(name);
						hro.setValue(null == value ? "".getBytes(Environment.ENCODING) : value.getBytes(Environment.ENCODING));
						list.add(hro);
					}
					requestDataForm.put(name, list);
				}
			}
		}
	}

	/**
	 * put request param to HashMap param must be single String form enctype !=
	 * multipart/form-dat
	 * 
	 * @param request
	 * @return HashMap key=value, name=StringValue
	 * @throws UnsupportedEncodingException 
	 */
	public static Map<String, String> getSimpleParameter(HttpServletRequest request) throws UnsupportedEncodingException {
		Map<String, String> map = new HashMap<String, String>();
		@SuppressWarnings("rawtypes")
		Enumeration names = request.getParameterNames();
		while (names.hasMoreElements()) {
			String key = (String) names.nextElement();
			String value = request.getParameter(key);
			value = value == null ? "" : value.trim(); 
			map.put(key, value);
		}
		return map;
	}

	private static void getSessionInfo(RequestDataForm requestDataForm) throws Exception {
		HttpSession session=requestDataForm.getRequest().getSession();
		Enumeration names = session.getAttributeNames();
		while (names.hasMoreElements()) {
			String name = (String) names.nextElement();
			Object obj=session.getAttribute(name);
			if(obj instanceof String){
				requestDataForm.put(name, String.valueOf(obj));
			}
		}
	}
}
