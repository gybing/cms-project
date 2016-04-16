<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">

 $(function(){
	 queryUserProtocolType(3);
	 
	 $("#USER_PROTOCOL_CONFIG_HELP_TYPE").change(function(){
		 queryUserProtocolType($(this).val());
	 });
	 
});

function queryUserProtocolType(value){
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
			$("#USER_PROTOCOL_CONFIG_HELP_CONTENT").val(data.resultObj.HELP_CONTENT);
			$("#USER_PROTOCOL_CONFIG_HELP_REMARK").val(data.resultObj.HELP_REMARK);
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
				<select id="USER_PROTOCOL_CONFIG_HELP_TYPE" name="help_type">
					<option value="3">货运网用户协</option>
					<option value="4">货运网免责条款</option>
					<option value="5">手机端用户协议(司机版)</option>
					<option value="6">手机端用户协议(企业版)</option>
					<option value="7">手机端免责条款(司机版)</option>
					<option value="8">手机端免责条款(企业版)</option>
					<option value="9">活动规则(司机版)</option>
					<option value="10">活动规则(企业版)</option>
				</select>
			</div>
			<div class="unit">
				<label>帮助内容：</label>
				<textarea class="editor"  name="help_content" id="USER_PROTOCOL_CONFIG_HELP_CONTENT" rows="15" cols="100"></textarea>
			</div>		
			<div class="unit">
				<label>备注：</label>
				<textarea id="USER_PROTOCOL_CONFIG_HELP_REMARK" name="help_remark" cols="100" rows="4" style="width: 400px"  maxlength="100"></textarea>
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