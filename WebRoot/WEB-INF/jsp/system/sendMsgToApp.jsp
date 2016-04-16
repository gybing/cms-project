<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
$(function(){
	/* 设置默认选中 */
	$("#SEND_TO_MASS",navTab.getCurrentPanel()).attr("checked","checked");
});

//点击发送全部时操作（隐藏收件人帐号列）
function checkAll(){
	$("#SEND_TO_APP_CODE_RE",navTab.getCurrentPanel()).hide();
	$("#SEND_TO_MASS",navTab.getCurrentPanel()).removeAttr("checked");
}

//点击群发信息时操作（展开收件人帐号列）
function checkNoAll(){
	$("#SEND_TO_APP_CODE_RE",navTab.getCurrentPanel()).show();
	$("#SEND_TO_ALL",navTab.getCurrentPanel()).removeAttr("checked");
}

//提交时操作
function checkChoose(obj,callback){
	
	//未填信息内容提醒
	if($("#msg_content",navTab.getCurrentPanel()).val().trim().length == 0){
		alertMsg.warn("请填写信息内容！");
		return false;
	}
	
	// 发送全部
	if($("#SEND_TO_ALL",navTab.getCurrentPanel()).attr("checked") == "checked"){
		$("#SEND_TO_APP_SEND_TYPE",navTab.getCurrentPanel()).val(2);
		return validateCallback(obj,callback);
	// 群发信息
	}else if($("#SEND_TO_MASS",navTab.getCurrentPanel()).attr("checked") == "checked"){
		//未选中用户提醒
		if($("#CHOOOSE_USER_DIALOG_USER_ID",navTab.getCurrentPanel()).val() == ""){
			alertMsg.warn("请选择用户！");
			return false;
		}
		
		$("#SEND_TO_APP_SEND_TYPE",navTab.getCurrentPanel()).val(1);
		return validateCallback(obj,callback);
	}
	return false;
}
</script>
	<div class="pageContent">
		<form id="SEND_TO_APP_FORM" method="post" action="${ctxPath}/topic/ajax/bsm$sendMsgToAPP" class="pageForm required-validate" onsubmit="return checkChoose(this,customNavTabAjaxDone)">
		<input type="hidden" id="SEND_TO_APP_SEND_TYPE" name="type"/>
		<input type="hidden" id="CHOOOSE_USER_DIALOG_USER_ID" name="userId"/>
		<input type="hidden" id="CHOOOSE_USER_DIALOG_USER_TEL"/>
		<input type="hidden" id="navTabId" value="bsm$toUserListPage"/>
		<input type="hidden" id="callbackType" value="closeCurrent"/>
		<div class="pageFormContent" layoutH="56">
				<table>
					<tr>
						<td style="padding-left:20px;padding-top:10px;"><span>发送全部</span><input id="SEND_TO_ALL" type="radio" name="sendMsg"  onclick="checkAll()" /></td>
						<td style="padding-left:20px;padding-top:10px;"><span>群发信息</span><input id="SEND_TO_MASS" type="radio" name="sendMsg" onclick="checkNoAll()" /></td>
					</tr>
					<tr id="SEND_TO_APP_CODE_RE">
						<td style="padding-left:20px;padding-top:10px;"><span style="color:red">*</span><span>收信人号码：</span></td>
						<td id="CHECKED_USER_TEL" style="padding-left:20px;padding-top:10px;"></td>
						<td style="padding-left:20px;padding-top:10px;"><a class="button" target="dialog"
							href="${ctxPath}/topic/bsm$selectUser?type=3" mask="true" width="1200"
							height="500" rel="sendAppSelectUser"><span>选择用户</span></a>
						</td>
					</tr>
					<tr>
						<td colspan="100" style="padding-left:20px;padding-top:10px;">
							<textarea name="content" id="msg_content" rows="6" cols="100" maxlength="250"></textarea>
						</td style="padding-left:20px;padding-top:10px;">
					</tr>
				</table>
				</div>
		<div class="formBar">
			<ul style="float: left;">
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit" >提交</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div></li>
			</ul>
		</div>
		</form>
		
	</div>
	