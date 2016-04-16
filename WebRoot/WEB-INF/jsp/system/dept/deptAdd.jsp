<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<div class="pageContent">
	<form id="userInfoForm" method="post" action="${ctxPath}/topic/ajax/cpwb$addDept" class="pageForm required-validate" onsubmit="return validateCallback(this,customDialogAjaxDone)">
		<div class="pageFormContent" layoutH="58">
			<input type="hidden" id="A_P_DEPT_ID" name="F_DEPT_ID" value="${param.P_DEPT_ID }"/>
			<input type="hidden" id="navTabId" value="cpwb$toDeptListPage"/>
			<input type="hidden" id="callbackType" value="closeCurrent"/>
			<div class="unit">
				<label>所属部门：</label>
				<input type="text" id="A_F_DEPT_NAME" name="F_DEPT_NAME" readonly="readonly" value="${responseDataForm.resultObj }"/>
			</div>
			<div class="unit">
				<label>部门名称：</label>
				<input type="text" id="A_DEPT_NAME" name="DEPT_NAME" onchange="chkDeptName(this);" size="20" maxlength="20" class="required"/>
			</div>
			<div class="unit">
				<label>部门电话：</label>
				<input type="text" id="A_DEPT_TEL" name="DEPT_TEL" size="15" maxlength="20" onkeyup="value=value.replace(/[\u4E00-\u9FA5]/ig,'')"/>
			</div>
			<div class="unit">
				<label>备注：</label>
				<textarea id="A_REMARK" name="REMARK" rows="5" cols="56" maxlength="60"></textarea>
			</div>
		</div>
		<div class="formBar">
			<ul style="float: left;">
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">提交</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
			</ul>
		</div>
	</form>
</div>