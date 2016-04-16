package com.cms.common.listener;

import javax.servlet.ServletContextEvent;

import org.springframework.web.context.ContextLoaderListener;

/**
 * @author lansb 系统监听
 */
public class ConfigListener extends ContextLoaderListener {
	public void contextInitialized(ServletContextEvent event) {
		super.contextInitialized(event);
		//ApplicationContext context = WebApplicationContextUtils
		//		.getWebApplicationContext(event.getServletContext());
	} 


	public void initApplictionContext(ServletContextEvent event) {

	}
}