package com.cms.interceptor;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.cms.common.bean.UserSessionBean;
import com.cms.common.dao.impl.JdbcDaoImpl;
import com.cms.common.form.RequestDataForm;
import com.cms.common.form.ResponseDataForm;
import com.cms.common.listener.SpringContextUtil;
import com.cms.common.utils.Environment;
import com.cms.service.LoginService;


/**
 * 登录拦截器
 *  */
public class LoginInterceptor implements HandlerInterceptor {
	
	@Resource
	private JdbcDaoImpl jdbcDao;
	
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object arg2) throws Exception {
		HttpSession session = request.getSession();
		String path = request.getContextPath();
		String reqUrl = request.getServletPath();
		
//		|| "/topic/bsm$toLogin".equals(reqUrl)
//		if("/topic/logout".equals(reqUrl) || "/topic/toLogin".equals(reqUrl) || "/topic/login".equals(reqUrl)) 
//			return true;//登录页面不进行过滤、
		if("/topic/bsm$logout".equals(reqUrl) || "/topic/bsm$login".equals(reqUrl)|| "/topic/bsm$toLogin".equals(reqUrl)) 
			return true;//登录页面不进行过滤
		
		String returnUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/topic/bsm$toLogin";
		UserSessionBean usb = (UserSessionBean) session.getAttribute(Environment.SESSION_USER_LOGIN_INFO);
		if(usb == null) {
			Cookie[] cookies = request.getCookies();
			LoginService loginService=SpringContextUtil.getBean("loginService",LoginService.class);
			RequestDataForm requestDataForm=RequestDataForm.create(request, response);
			if(cookies!=null){
				for(Cookie cookie : cookies) {
						if ("weiming-gswl-usercode".equals(cookie.getName())) {// 自动登录
							String usercode = cookie.getValue();
							usercode = new String(
									org.apache.commons.codec.binary.Base64.decodeBase64(java.net.URLDecoder
											.decode(usercode, "UTF-8")), "UTF-8");
							ResponseDataForm rdf = loginService.autoLogin(usercode,requestDataForm);
							if(ResponseDataForm.FAULAIE.equals(rdf.getResult())){
								response.sendRedirect(returnUrl);
								return false;
							}
							request.setAttribute("responseDataForm", rdf);
							return true;
						}
				}
				if(session.isNew()){
					response.sendRedirect(returnUrl);
				}else{
					response.sendRedirect(returnUrl+"?err=2");
				}
				return false;
			}else{
				response.sendRedirect(returnUrl);
				return false;
			}
		}
		return true;
	}

	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3) throws Exception {
		// TODO Auto-generated method stub
		
	}
}
