package com.cms.common.exposer;

import javax.servlet.ServletContext;

import org.springframework.web.context.ServletContextAware;

import com.cms.common.utils.DateUtil;

/**
 * @author lansb
 * 设置启动参数变量
 */
public class InitPathExposer implements ServletContextAware {
	private ServletContext sc; 

	public String resRoot;

	public void setServletContext(ServletContext arg0) {
		// 实现如下:
		sc = arg0;
	}

	public void init() {
		resRoot = "/res-" + DateUtil.getCurrDateStr("yyyyMMddHHmmss");
		sc.setAttribute("ctxPath", sc.getContextPath());
		sc.setAttribute("resRoot", sc.getContextPath() + resRoot);
	}

}
