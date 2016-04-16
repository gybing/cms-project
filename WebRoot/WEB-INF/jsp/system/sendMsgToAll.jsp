<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
$(function() {
	$.ajax({  
		type:"post",  
	    dataType:"json",  
	    contentType:"application/json;charset=utf-8",  
	    url:_contextPath+"/topic/ajax/queryMsgList", 
	    success:function(result){ 
	    	var json = result.resultObj.dataList;
	            $.each(json,function(index,item){  	 
	    	    	$("#SMTA_temName").append("<option tcont="+item.TEM_TEXT+" value='"+item.TEM_ID+"'>"+item.TEM_NAME+"</option>");  
	            }); 
	    },  
	    error : function(XMLHttpRequest, textStatus, errorThrown) {  
	                alert(errorThrown);  
	            },  
	    async:false,           //false表示同步  	
	});
	// 获取“用户列表”中勾选的需要发送短信的用户 yeq 2015年12月7日 15:34:44
	var userTelList = $("#userteltomsg").val();
	var userNameList = $("#usernametomsg").val();
	userTelList = !userTelList?"":userTelList.substring(0,userTelList.lastIndexOf(","));
	userNameList = !userNameList?"":userNameList.substring(0,userNameList.lastIndexOf(","));
	$("#phone").html(userTelList.replace(",","\n")); // 替换“,”字符为“\n”
	$("#toUserName").val(userNameList);// 设置姓名
	/* var allTels1='${param.userTels }'.replace("{", "");
	var allTels2=allTels1.replace("}", "");
	var allTels=allTels2.replace(/,/g, "\n");
	var allUsers1='${param.userNames }'.replace("{", "");
	var allUsers=allUsers1.replace("}", "");
	if(allTels.length>0&&allUsers.length>0){
		$("#phone").html(allTels);
		$("#toUserName").val(allUsers);
	}else if(allTels.length>0&&allUsers.length<=0){
		alert("注意：部分用户的真实姓名未知！");
		$("#phone").html(allTels);
	} */
});
function setValue(obj) {
	var textval=$("#SMTA_temName").find("option:selected").attr("tcont");
	$("#content").val(textval);
}
function checkPhone() {
	if($("#phone").val().split("\n").length>10){
		 alert("收件人不能超过10人，请检查");
	 }
}
function checkNumber(str){
	String.prototype.replaceAll = function(s1,s2) { 
	    return this.replace(new RegExp(s1,"gm"),s2); 
	};
	str=str.replaceAll(" ","");
	 //$("#phone").val(str);
	return /^(\d+\n)*(\d+)$/.test(str);
}
function sendMsgSub() {
	if($("#phone").val().split("\n").length>10){
		 alert("收件人不能超过10人，请检查");
		 return;
	 }
	var ph=$("#phone").val().split("\n");
	var count=0;
	$.each(ph,function(key,val){
		if(!checkNumber(val)){
			alert("请输入合法电话号码");
			count++;
			return false;
		}
	});
	if(count>0){
		return;
	}
	$("#sendMsgToPhoneInfoForm").submit();
}
</script>
<div class="pageContent">
	<form id="sendMsgToPhoneInfoForm" method="post" action="${ctxPath}/topic/ajax/bsm$sendMsgToAll" class="pageForm required-validate" onsubmit="return validateCallback(this,customNavTabAjaxDone)">
		<input type="hidden" id="navTabId" value="bsm$toMsgTemManage"/>
		<input type="hidden" id="callbackType" value="closeCurrent"/>
		<input type="hidden" id="sendType" name="type" value="2"/>
		<input type="hidden" id="toUserName" name="toUserName" />
		<input type="hidden" id="sendMsgToAllUserId"/>
		<div class="pageFormContent" layoutH="56">
			<div class="unit">
				<label>收件人号码:</label>
				<textarea cols="100" rows="8" class="required" id="phone" name="phone"
							style="width:200px"  maxlength="150" onchange="javascript:if(!checkNumber(this.value)){alert('请输入合法电话号码');}" onblur="checkPhone()"></textarea>
				<div style="margin-top:125px;">
					<a class="button" target="dialog" href="${ctxPath}/topic/bsm$selectUser?type=3" mask="true" width="1200" height="500" rel="sendMsgSelectUser"> <span>选择用户</span></a>
				</div>
				<div>
					<span style="color:blue">提示信息：（群发格式：多个收件人回车换行隔开，每次最多发10人）</span>	
				</div>			
			</div>
			<div class="unit">
				<label>短信模板:</label>
				<select id="SMTA_temName" name="temName" onchange="setValue(this)" class="combox">
				<option value="0" tcont="" selected="selected">请选择</option></select></td>
				</select>
			</div>
			<div class="unit">
				<label>短信内容:</label>
				<textarea cols="100" rows="8" class="required" id="content" name="content"
							style="width:200px"  maxlength="150"></textarea>
				<div style="margin-top:125px;">
					<span style="color:blue">提示信息：（短信模板内容最多150个字符）</span>	
				</div>			
			</div>
			<div class="unit">
				<label>备注:</label>
				<textarea cols="100" rows="8" id="remark" name="remark"
							style="width:200px"  maxlength="150"></textarea>			
			</div>
            
		</div>
		
		<div class="formBar">
			<ul style="float: left;">
				<li><div class="buttonActive"><div class="buttonContent"><button type="button" onclick="sendMsgSub()">发送信息</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
			</ul>
		</div>
	</form>
</div>