package com.cms.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cms.common.bean.UserSessionBean;
import com.cms.common.dao.impl.JdbcDaoImpl;
import com.cms.common.form.RequestDataForm;
import com.cms.common.form.ResponseDataForm;
import com.cms.common.service.IService;
import com.cms.common.utils.Environment;
import com.cms.common.utils.MapUtils;
import com.cms.common.utils.MenuUtil;


/**
 * 用户登录service
 * @author Linpr
 *
 */
@Service("loginService")
public class LoginService implements IService {
	
	@Resource
	private JdbcDaoImpl jdbcDao;

	@Autowired(required = false)
	@Qualifier("sysCode")
	private String sysCode;

	@Override
	@Transactional
	public ResponseDataForm service(RequestDataForm requestDataForm) throws Exception {
		
		ResponseDataForm rdf = new ResponseDataForm();
		
		String NAME = requestDataForm.getString("usercode");  // 用户名
		
		String PWD = requestDataForm.getString("passwd");  // 密码
		String YSPWD = requestDataForm.getString("passwd");  // 密码
		
		String AUTOLOGIN = requestDataForm.getString("autologin");  // 自动登录设置
		
		if(StringUtils.isEmpty(NAME) && StringUtils.isEmpty(PWD)){
			rdf.setResult(ResponseDataForm.FAULAIE);
			rdf.setPage("login");
		}
		
		String sql = "";  //sql
		
		if(StringUtils.isEmpty(NAME) || StringUtils.isEmpty(PWD)){
			rdf.setResult(ResponseDataForm.FAULAIE);
			rdf.setResultInfo("用户名或密码不能为空！");
			rdf.setPage("login");
		}else{
			PWD = DigestUtils.md5Hex(PWD);  // 用户密码加密
			
			sql = "SELECT U.USER_ID,U.TAG,U.USER_CODE,U.USER_NAME,U.IS_DISABLED,U.PIC,(SELECT R.ROLE_NAME FROM role_bsm_tab R WHERE R.ROLE_ID=T.ROLE_ID) ROLE_NAME,SCHEDULE_CENTER ";
			sql += " FROM user_tab U LEFT JOIN user_role_bsm_tab T on T.USER_ID=U.USER_ID ";
			sql += " WHERE U.IS_DEL='N' AND U.USER_PWD=? AND (U.USER_CODE=? OR U.USER_NAME=?)";
			
			Map<String, Object> userMap = jdbcDao.queryForMap(sql, new Object[]{PWD,NAME,NAME});
			
			if(userMap==null || userMap.isEmpty()){
				rdf.setResult(ResponseDataForm.FAULAIE);
				rdf.setResultInfo("用户不存在或密码输入有误！");
				rdf.setPage("login");
			}else{
				String IS_DISABLED = MapUtils.getString(userMap, "IS_DISABLED");
				String USER_ID = MapUtils.getString(userMap, "USER_ID");
				
				// 判断用户是否已经禁用，0：禁用 1：未禁用 被禁用的用户不能登录
				if(IS_DISABLED!=null && "0".equals(IS_DISABLED)){
					rdf.setResult(ResponseDataForm.FAULAIE);
					rdf.setResultInfo("用户帐号已经失效，请联系客服人员！");
					rdf.setPage("login");
				}
				
				
				UserSessionBean usb = new UserSessionBean();
				String user_id = MapUtils.getString(userMap, "USER_ID");
				usb.setUserId(user_id); // 用户id
				usb.setUserCode(MapUtils.getString(userMap, "USER_CODE")); // 用户登录名
				usb.setUserName(MapUtils.getString(userMap, "USER_NAME")); // 用户姓名
				//usb.setUserRole(MapUtils.getString(userMap, "ROLE_NAME")); // 用户角色名
				
				usb.setUserInfo(userMap); // 用户信息
				usb.setUserPrivIds(getUserPrivs(USER_ID)); //获取用户权限
				
				requestDataForm.getRequest().getSession().setAttribute(Environment.SESSION_USER_LOGIN_INFO, usb);  //SESSION_USER_LOGIN_INFO 页面调用 用
				
				// 获取用户类型 session_role_type 角色类型，标识角色是否固化，如果是固化角色，则禁止界面编辑和删除; “0”为非固化角色；“1”为固化角色
				/*sql =  "SELECT MAX(R.ROLE_TYPE) ROLE_TYPE FROM sys_role_tab R WHERE R.ROLE_ID IN (SELECT ROLE_ID FROM sys_user_role_tab WHERE USER_ID=?)";
				String role_type = jdbcDao.queryForString(sql, new Object[]{MapUtils.getString(userMap, "USER_ID")}, "0");				
				requestDataForm.getRequest().getSession().setAttribute(com.weimingfj.system.utils.Environment.SESSION_ROLE_TYPE, role_type);
				*/
				//===================================================================================
				//记录登录日志
				sql = "INSERT INTO sys_log_tab (LOGIN_IP,USER_CODE,ADD_TIME,USER_ID,USER_NAME) SELECT ?,?,now(),?,?";
				jdbcDao.execute(sql,new Object[] { 
						requestDataForm.getRequest().getRemoteAddr(),
						MapUtils.getString(userMap, "USER_CODE"),USER_ID,MapUtils.getString(userMap, "USER_NAME")});
				
				//自动登录实现
				if(AUTOLOGIN != null && "on".equals(AUTOLOGIN)) {
					String userCode64 = Base64.encodeBase64String(usb.getUserCode().getBytes("UTF-8"));
					userCode64 = userCode64.replace("\r\n", "");              
					userCode64 = userCode64.replace("\n", "");
					String userEncoder = java.net.URLEncoder.encode(userCode64, Environment.ENCODING);
					Cookie usercookie = new Cookie("weiming-jiyun-usercode", userEncoder); 
					
					String passwd64 = Base64.encodeBase64String(YSPWD.getBytes("UTF-8"));
					passwd64 = passwd64.replace("\r\n", "");              
					passwd64 = passwd64.replace("\n", "");
					String pwdEncoder = java.net.URLEncoder.encode(passwd64, Environment.ENCODING);
					Cookie passwdcookie = new Cookie("weiming-jiyun-passwd",pwdEncoder); 
					
					usercookie.setPath("/");
					passwdcookie.setPath("/");
					usercookie.setMaxAge(60 * 60 * 24 * 360);//一年以内
					passwdcookie.setMaxAge(60 * 60 * 24 * 360);//一年以内
					requestDataForm.getResponse().addCookie(usercookie);
					requestDataForm.getResponse().addCookie(passwdcookie);
				} else {
					String usercoo = "weiming-jiyun-usercode";
		            Cookie usercookie = new Cookie(usercoo,null);
		            usercookie.setMaxAge(0);
		            usercookie.setPath("/");
		            requestDataForm.getResponse().addCookie(usercookie);
		            
		            String passwd = "weiming-jiyun-passwd";
		            Cookie passwdcookie = new Cookie(passwd,null);
		            passwdcookie.setMaxAge(0);
		            passwdcookie.setPath("/");
		            requestDataForm.getResponse().addCookie(passwdcookie);
				}
				//===================================================================================
								
				// 获取用户 菜单列表
				String ctxPath = String.valueOf(requestDataForm.getRequest().getSession().getServletContext().getAttribute("ctxPath"));  // 获取项目路径
				sql = "SELECT A.MENU_ID,A.PARENT_MENU_ID,A.MENU_NAME,A.SEQUENCE MENU_SEQ,A.MENU_PATH,A.MENU_TYPE,A.MENU_CODE,A.URL_ID,A.REMARK,B.PRIV_ID" +
						" FROM sys_menu_tab A LEFT JOIN sys_url_tab B ON A.URL_ID = B.URL_ID WHERE A.SYS_ABBR=? ORDER BY A.PARENT_MENU_ID,A.SEQUENCE";
				// 菜单列表
				List<Map<String, Object>> menu_list = jdbcDao.queryForList(sql, new Object[] { sysCode });
			
				String menuHtml = MenuUtil.createMenu(ctxPath, menu_list, usb.getUserPrivIds(), usb.getUserCode());  //创建登录用户菜单
				
				rdf.setResult(ResponseDataForm.SESSFUL);
				requestDataForm.getRequest().getSession().setAttribute("MENU_SESSIONN_INFO", menuHtml);
//				rdf.setResultObj(menuHtml);
			}
		}
		return rdf;
	}
	
	/**
	 * 获取登录用户的权限
	 * @param userId
	 * @return
	 */
	private List<String> getUserPrivs(String userId){
		String privSql="SELECT PRIV_ID FROM role_priv_bsm_tab WHERE ROLE_ID IN (SELECT ROLE_ID FROM user_role_bsm_tab WHERE USER_ID=?)";
		List<Map<String, Object>> privList = jdbcDao.queryForList(privSql, new Object[]{userId});
		ArrayList<String> privs=new ArrayList<String>();
		for(Map<String,Object> map:privList){
			privs.add(MapUtils.getString(map, "priv_id"));
		}
		privs.add(Environment.LOGIN_NO_PRIV);//登录后可访问
		return privs;
	}
	
	/**
	 * 自动登录
	 */
	public ResponseDataForm autoLogin(String userId,RequestDataForm requestDataForm){
		ResponseDataForm rdf = new ResponseDataForm();
		String loginsql = "select * from user_tab where user_code=?  and IS_DEL='N' and IS_DISABLED='1'";
		Map<String, Object> map = jdbcDao.queryForMap(loginsql,
				new Object[] { userId });
		if (map == null || map.size() == 0) {// login faiule
			rdf.setResult(ResponseDataForm.FAULAIE);
			rdf.setResultInfo("用户不存在或密码输入有误！");
			return rdf;//登录失败，用户名或密码有误，请重新输入！
		} 
		UserSessionBean usb = new UserSessionBean();
		usb.setUserCode(map.get("USER_CODE").toString());
		usb.setUserId(map.get("USER_ID").toString());
		usb.setUserName(map.get("USER_NAME").toString());
//		usb.setMobile(map.get("MOBILE").toString());
		usb.setUserInfo(map);
		usb.setUserPrivIds(getUserPrivs(map.get("USER_ID").toString())); //获取用户权限
		// 设置登录信息
		requestDataForm.getRequest().getSession().setAttribute(Environment.SESSION_USER_LOGIN_INFO, usb);
		// 获取用户 菜单列表
		String ctxPath = String.valueOf(requestDataForm.getRequest().getSession().getServletContext().getAttribute("ctxPath"));  // 获取项目路径
		String sql = "SELECT A.MENU_ID,A.PARENT_MENU_ID,A.MENU_NAME,A.SEQUENCE MENU_SEQ,A.MENU_PATH,A.MENU_TYPE,A.MENU_CODE,A.URL_ID,A.REMARK,B.PRIV_ID" +
				" FROM sys_menu_tab A LEFT JOIN sys_url_tab B ON A.URL_ID = B.URL_ID WHERE A.SYS_ABBR=? ORDER BY A.PARENT_MENU_ID,A.SEQUENCE";
		
		// 菜单列表
		List<Map<String, Object>> menu_list = jdbcDao.queryForList(sql, new Object[] { sysCode });
	
		String menuHtml = MenuUtil.createMenu(ctxPath, menu_list, usb.getUserPrivIds(), usb.getUserCode());  //创建登录用户菜单
		
		rdf.setResult(ResponseDataForm.SESSFUL);
		requestDataForm.getRequest().getSession().setAttribute("MENU_SESSIONN_INFO", menuHtml);
		rdf.setResult(ResponseDataForm.SESSFUL);
		return rdf;
	}

}
