<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">

 $(function(){
	 queryHelpType(0);
	 
	 $("#HELP_CONFIG_HELP_TYPE").change(function(){
		queryHelpType($(this).val());
	 });
	 
});

function queryHelpType(value){
	if (value === "") {
		return;
	}
	$.ajax({
		url:"${ctxPath}/topic/ajax/bsm$queryHelpConfigType",
		type:"POST",
		async:false,
		data:"help_type="+value,
		dataType:"json",
		success:function(data){
			$("#HELP_CONFIG_HELP_CONTENT").val(data.resultObj.HELP_CONTENT);
			$("#HELP_CONFIG_HELP_REMARK").val(data.resultObj.HELP_REMARK);
		},
	});
}
 
</script>
<div class="tabContent">
	<form id="HELP_CONFIG_FORM" method="post" action="${ctxPath}/topic/ajax/bsm$saveHelpConfig" class="pageForm required-validate" onsubmit="return validateCallback(this,customNavTabAjaxDone)">
		<input type="hidden" id="navTabId" value="bsm$toHelpConfig"/>
		<input type="hidden" id="callbackType" value="closeCurrent"/>
		<div class="pageFormContent" layoutH="56">
			<div class="unit">
				<label>帮助类型：</label>
				<select id="HELP_CONFIG_HELP_TYPE" name="help_type">
					<option value="0">司机版</option>
					<option value="1">企业版</option>
					<option value="2">货运网</option>
				</select>
			</div>
			<div class="unit">
				<label>帮助内容：</label>
				<textarea class="editor"  name="help_content" id="HELP_CONFIG_HELP_CONTENT" rows="15" cols="100"></textarea>
			</div>		
			<div class="unit">
				<label>备注：</label>
				<textarea id="HELP_CONFIG_HELP_REMARK" name="help_remark" cols="100" rows="4" style="width: 400px"  maxlength="100"></textarea>
			</div>
		</div>
		
		<div class="formBar">
			<ul style="float: left;">
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit" >提交</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div></li>
			</ul>
		</div>
	</form>
</div>