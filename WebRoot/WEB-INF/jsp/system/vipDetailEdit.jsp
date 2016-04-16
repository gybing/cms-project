<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.cms.common.utils.UserSessionBean"%>
<%@ page import="com.cms.common.form.ResponseDataForm"%>
<%@ page import="com.cms.common.utils.MapUtils"%>
<%@ page import="com.cms.common.cache.GlobalCache"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
$(function(){
	// 设置访问次数框
	$.ajax({
		url:"${ctxPath}/topic/ajax/bsm$getVIPNum",
		async:false,
		dataType:"json",
		success:function(data){
			json = data.resultObj;
			$.each(json,function(index,item){
				$("#number"+item.ID).val(item.NUMBER);
			});
		}
	});
 //${responseDataForm.resultObj.TRUCK_PLATE }
});
//提交
function submitVipLevelEdit(){
	var isOk=true;
	$.each($("input[name='number']"),function(index,item){
		$(this).val($(this).val().trim());
		if(!/^[\d]+$/g.test($(this).val())){
			alert("访问次数只能为数字");
			isOk=false;
			return ;
		}
	});
	var param=$("#vipLevelForm").serialize();
	if(isOk){
		$.ajax({
			url : "${ctxPath}/topic/ajax/bsm$saveVipDetailNum",
			type : "POST",
			data : param,
			dataType : "json",
			success : function(data, textStatus, jqXHR) {
				if (data.result == "1") {//保存成功
					alertMsg.info(data.resultInfo);
				} else if (data.result == "2") {//服务端验证失败
					alertMsg.warn(data.resultInfo);
				} else {//其他有捕获的异常
					alertMsg.warn(data.resultInfo);
				}
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alertMsg.error("请求异常:"+data.resultInfo);
			}
		});
	}
	
}
</script>
<div class="pageContent">
	<form id="vipLevelForm" method="post" action="" onsubmit="return validateCallback(this,customNavTabAjaxDone)">
		<input type="hidden" id="" value=""/>
		<input type="hidden" id="" value=""/>
		<div class="pageFormContent" layoutH="56">
		<table cellpadding="0" cellspacing="0">
			<tr>
				<td  style="padding-left:20px;padding-top:10px;" valign="top">普通会员车源信息可访问次数</td>
				<td  style="padding-left:20px;padding-top:10px;" align="left">
					<input type="hidden" name="vipId"  value="1"/>
					<input type="text" name="number" id="number1" /></td>
			</tr>
			<tr>
				<td  style="padding-left:20px;padding-top:10px;" valign="top">普通会员在线车场可访问次数:</td>
				<td  style="padding-left:20px;padding-top:10px;" align="left">
					<input type="hidden" name="vipId"  value="2"/>
					<input type="text" name="number" id="number2" /></td>
			</tr>
			<tr>
				<td  style="padding-left:20px;padding-top:10px;" valign="top">普通会员货源信息可访问次数:</td>
				<td  style="padding-left:20px;padding-top:10px;" align="left">
					<input type="hidden" name="vipId"  value="3"/>
					<input type="text" name="number" id="number3" /></td>
			</tr>
			<tr>
				<td  style="padding-left:20px;padding-top:10px;" valign="top">企业版会员非司机版会员车源信息可访问次数:</td>
				<td  style="padding-left:20px;padding-top:10px;" align="left">
					<input type="hidden" name="vipId"  value="7"/>
					<input type="text" name="number" id="number7" /></td>
			</tr>
			<tr>
				<td  style="padding-left:20px;padding-top:10px;" valign="top">企业版会员非司机版会员在线车场可访问次数:</td>
				<td  style="padding-left:20px;padding-top:10px;" align="left">
					<input type="hidden" name="vipId"  value="8"/>
					<input type="text" name="number" id="number8" /></td>
			</tr>
			<tr>
				<td  style="padding-left:20px;padding-top:10px;" valign="top">企业版会员非司机版会员货源信息可访问次数:</td>
				<td  style="padding-left:20px;padding-top:10px;" align="left">
					<input type="hidden" name="vipId"  value="9"/>
					<input type="text" name="number" id="number9" /></td>
			</tr>
			<tr>
				<td  style="padding-left:20px;padding-top:10px;" valign="top">司机版会员非企业版会员车源信息可访问次数:</td>
				<td  style="padding-left:20px;padding-top:10px;" align="left">
					<input type="hidden" name="vipId"  value="4"/>
					<input type="text" name="number" id="number4" /></td>
			</tr>
			<tr>
				<td  style="padding-left:20px;padding-top:10px;" valign="top">司机版会员非企业版会员在线车场可访问次数:</td>
				<td  style="padding-left:20px;padding-top:10px;" align="left">
					<input type="hidden" name="vipId"  value="5"/>
					<input type="text" name="number" id="number5" /></td>
			</tr>
			<tr>
				<td  style="padding-left:20px;padding-top:10px;" valign="top">司机版会员非企业版会员货源信息可访问次数:</td>
				<td  style="padding-left:20px;padding-top:10px;" align="left">
					<input type="hidden" name="vipId"  value="6"/>
					<input type="text" name="number" id="number6" /></td>
			</tr>
		</table>
		</div>
		<div class="formBar">
			<ul style="float: left;">
				<li><div class="buttonActive"><div class="buttonContent"><button type="button" onclick="submitVipLevelEdit()">提交</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div></li>
			</ul>
		</div>
	</form>
</div>