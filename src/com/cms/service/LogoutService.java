package com.cms.service;

import javax.servlet.http.Cookie;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cms.common.form.RequestDataForm;
import com.cms.common.form.ResponseDataForm;
import com.cms.common.service.IService;
import com.cms.common.utils.Environment;

@Service("logoutService")
public class LogoutService implements IService {
	
	@Override
	@Transactional
	public ResponseDataForm service(RequestDataForm requestDataForm) throws Exception {
		ResponseDataForm rdf=new ResponseDataForm();
		requestDataForm.getRequest().getSession().removeAttribute(Environment.SESSION_USER_LOGIN_INFO);
		requestDataForm.getRequest().getSession().invalidate();
		Cookie[] cookies = requestDataForm.getRequest().getCookies();
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				if (cookies[i].getName().equals("weiming-gswl-usercode")) {
					Cookie cookie = new Cookie("weiming-gswl-usercode", null);
					cookie.setMaxAge(0);
					cookie.setPath("/");
					requestDataForm.getResponse().addCookie(cookie);
				}
			}
		}
		rdf.setResult(ResponseDataForm.SESSFUL);
		return rdf;
	}

}
