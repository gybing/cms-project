<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.cms.common.utils.UserSessionBean" %> 
<%
	UserSessionBean usb = null;
	if(session.getAttribute("SESSION_USER_LOGIN_INFO")!=null) {
		usb = (UserSessionBean)session.getAttribute("SESSION_USER_LOGIN_INFO");
	}
%>
<div class="pageContent">
	<form id="pagerForm" method="post" action="${ctxPath}/topic/ajax/bsm$passwordSave" class="pageForm required-validate" onsubmit="return validateCallback(this,customNavTabAjaxDone)">
		<input type="hidden" id="navTabId" value="bsm$passwordChange"/>
		<input type="hidden" id="callbackType" value="closeCurrent"/>
		<div class="pageFormContent" layoutH="56">
		    <div class="unit">
				<label>帐号：</label>
				<input type="text" value="<%=usb.getUserCode() %>" id="EDIT_PWD_USER_CODE" maxlength="30"/>
			</div>
			<div class="unit">
				<label>姓名：</label>
				<input type="text" value="<%=usb.getUserName() %>" id="EDIT_PWD_USER_NAME" maxlength="30"/>				
			</div>
			<div class="unit">
				<label>原密码：</label>
				<input type="password" name="OLD_PASSWORD" id="OLD_PASSWORD" class="required" minlength="6" maxlength="20"/>
			</div>
			<div class="unit">
				<label>新密码：</label>
				<input type="password" name="USER_PWD1" id="USER_PWD1" class="required alphanumeric"  minlength="6" maxlength="20" />
				<span style="color:gray;margin-left:10px">字母、数字、下划线 6-20位</span>
			</div>
			<div class="unit">
				<label>确认新密码：</label>
				<input type="password" name="USER_PWD2" id="USER_PWD2" equalTo="#USER_PWD1" class="required alphanumeric" maxlength="30" />
			</div>
		</div>
		<div class="formBar">
			<ul style="float: left;">
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">提交</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div></li>
			</ul>
		</div>
	</form>
</div>