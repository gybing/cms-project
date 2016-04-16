package com.cms.common.web.utils;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.WebApplicationContext;

import com.cms.common.dao.IJdbcDao;


/**
 * @author lansb
 * @version 1.0
 */
public class HttpsUtils {
	public HttpsUtils() {
	}

	/**
	 * 得到WEB的根路径
	 * 
	 * @param request
	 *            HttpServletRequest
	 * @return String
	 */
	public static String getBasePath(HttpServletRequest request) {
		String path = request.getContextPath();
		String basePath = request.getScheme() + "://" + request.getServerName()
				+ ":" + request.getServerPort() + path + "/";
		return basePath;
	}
	
	/**
	 * 获得request请求参数,null值返回空值
	 * 
	 * @param paraName参数名称
	 * @return
	 */
	public static String getParameter(HttpServletRequest request,
			String paraName) {
		return request.getParameter(paraName) == null ? "" : request
				.getParameter(paraName);
	}

	public static WebApplicationContext wac = null;
	
	public static IJdbcDao jdbcDao = null;
}
