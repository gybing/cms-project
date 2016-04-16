package com.cms.common.bean;

import java.util.List;
import java.util.Map;

public class UserSessionBean {
	
	/**
	 * 多租户登录名称
	 */
	private String userCode;
	/**
	 * 用户ID
	 */
	private String userId;
	/**
	 * 用户名称
	 */
	private String userName;
	/**
	 * 用户其他信息
	 */
	private Map<String, Object> userInfo;
	
	private List<String> userPrivIds;
	
	public String getUserCode() {
		return userCode;
	}
	public void setUserCode(String userCode) {
		this.userCode = userCode;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public Map<String, Object> getUserInfo() {
		return userInfo;
	}
	public void setUserInfo(Map<String, Object> userInfo) {
		this.userInfo = userInfo;
	}
	public List<String> getUserPrivIds() {
		return userPrivIds;
	}
	public void setUserPrivIds(List<String> userPrivIds) {
		this.userPrivIds = userPrivIds;
	}
}
