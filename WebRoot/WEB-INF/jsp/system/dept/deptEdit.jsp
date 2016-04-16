<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<div class="pageContent">
	<form id="userInfoForm" method="post" action="${ctxPath}/topic/ajax/cpwb$editDept" class="pageForm required-validate" onsubmit="return validateCallback(this,customDialogAjaxDone)">
		<div class="pageFormContent" layoutH="58">
			<input type="hidden" id="E_DEPT_ID" name="DEPT_ID" value="${param.DEPT_ID }" />
			<input type="hidden" id="OLD_DEPT_NAME" name="OLD_DEPT_NAME"/>
			<input type="hidden" id="navTabId" value="cpwb$toDeptListPage"/>
			<input type="hidden" id="callbackType" value="closeCurrent"/>
			<div class="unit">
				<label>所属部门：</label>
				<input type="text" id="E_F_DEPT_NAME" name="F_DEPT_NAME" readonly="readonly" value="${responseDataForm.resultObj.F_DEPT_NAME}"/>
			</div>
			<div class="unit">
				<label>部门名称：</label>
				<input type="text" id="E_DEPT_NAME" name="DEPT_NAME" size="20" maxlength="20" class="required" value="${responseDataForm.resultObj.DEPT_NAME}"/>
			</div>
			<div class="unit">
				<label>部门电话：</label>
				<input type="text" id="E_DEPT_TEL" name="DEPT_TEL" size="30" maxlength="15" onkeyup="value=value.replace(/[\u4E00-\u9FA5]/ig,'')" value="${responseDataForm.resultObj.DEPT_TEL}"/>
			</div>
			<div class="unit">
				<label>备注：</label>
				<textarea id="E_REMARK" name="REMARK" rows="5" cols="56" maxlength="60">${responseDataForm.resultObj.REMARK}</textarea>
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
