<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.weimingfj.common.form.ResponseDataForm"%>
<script type="text/javascript">


$(function(){
	
	// 获取分组信息
	$.ajax({
		url:"${ctxPath}/topic/ajax/bsm$getGroupInfo",
		type:"post",
		dataType:"json",
		success:function(data){
			var html = "";
			data = data.resultObj.dataList;
			$.each(data,function(i,e){
				var st="";
				if('${param.group_id}' == $(this)[0].GROUP_ID){
					st = "selected=\"selected\"";
				}
				html += "<option "+st+" value=\""+$(this)[0].GROUP_ID+"\">"+$(this)[0].GROUP_NAME+"</option>";
			});
			$("#choose_group").append(html);
		}
	});
	$("#toUserName").val("");
	$("#phone").html("");
	
});
function selectAll(obj){
	
	var c = $(obj).attr("checked");
	if(c == "checked"){
		
		$("#T_TABLE input[type=checkbox]").each(function(){
				var checkedBox = $(this);
				var user_tel = $(checkedBox).attr("USER_TEL");
				var user_name = $(checkedBox).attr("USER_NAME");
				$("#phone").html($("#phone").html()+user_tel+"\n");
				$("#toUserName").val($("#toUserName").val()+user_name+",");
			
		});
		showUser();
	}else{
		$("#T_TABLE input[type=checkbox]").each(function(){
			var checkedBox = $(this);
			var user_tel = $(checkedBox).attr("USER_TEL");
			var user_name = $(checkedBox).attr("USER_NAME");
			var userNameList = $("#toUserName").val().split(",");
			var userCodeList = $("#phone").html().split("\n");
			userNameList=$.grep(userNameList,function(n,i){
				return n==user_name;
			},true);
			userCodeList=$.grep(userCodeList,function(n,i){
				return n==user_tel;
			},true);
			$("#toUserName").val(userNameList)
			$("#phone").html(userCodeList);
		});
		showUser();
	}
			
}
function checked(obj) {
	var check=$(obj).find("input[type='checkbox']");
	if(check.is(':checked')){
		check.attr("checked",false);
	}else{
		check.attr("checked","checked");
	}
	isChecked(check);
}
function isChecked(obj){
		var user_tel = $(obj).attr("USER_TEL");
		var user_name = $(obj).attr("USER_NAME");
			
	if($(obj).attr("checked")=="checked"){
		//alert(user_tel+"\r\n"+user_name);
		if($("#phone").html().length>0){
			$("#phone").html($("#phone").html()+"\n"+user_tel+"\n");
			$("#toUserName").val($("#toUserName").val()+user_name+",");
		}else{
			$("#phone").html(user_tel+"\n");
			$("#toUserName").val(user_name+",");
		}
		
	}else{
		var userNameList = $("#toUserName").val().split(",");
		var userCodeList = $("#phone").html().split("\n");
		var newUserNameList=$.grep(userNameList,function(n){
			
			return n==user_name;
		},true);
		var newUserCodeList=$.grep(userCodeList,function(n){
			
			return n==user_tel;
		},true);
		var telStr="";
		var nameStr="";
		for(var i=0;i<newUserCodeList.length;i++){
			telStr=telStr+newUserCodeList[i]+"\n";
		};
		for(var i=0;i<newUserNameList.length;i++){
			nameStr=nameStr+newUserCodeList[i]+",";
		};
		$("#toUserName").val(nameStr);
		$("#phone").html(telStr); 
	}
	showUser();
	
}
function showUser(){
// 	去除末尾最后的“，”
	var temp = $("#phone").html();
     temp = temp.substring(0,temp.lastIndexOf("\n"));
	$("#phone").html(temp);
	var Utemp = $("#toUserName").val();
	Utemp = Utemp.substring(0,Utemp.lastIndexOf(","));
	$("#toUserName").html(temp);
}

function resetChooseUserDialog(){
	resetForm('pagerForm','dialog');
	$("#pagerForm", $.pdialog.getCurrent()).submit();
}

</script>
<div class="pageContent">
<!-- 查询部分 -->
	<div class="pageHeader">
		<div class="searchBar">
			<form method="post"
				action="${ctxPath }/topic/bsm$chooseGroupUserDialog?type=3"
				onsubmit="return dialogSearch(this);" id="pagerForm">
				<input type="hidden" name="pageNum" value="1" /> <input
					type="hidden" name="numPerPage" value="${param.numPerPage }" />
				<table class="searchContent">
					<tbody>
						<tr>
							<td>姓名：<input type="text" id="CHOOOSE_USER_DIALOG_USER_NAME" name="userName"
								value="${param.userName }" /></td>
							<td>手机号码：<input type="text" id="CHOOOSE_USER_DIALOG_TEL" name="TEL"
								value="${param.TEL }" /></td>
							<td>分组：
								<select id="choose_group" name="group_id">
									<option value="">请选择</option>
								</select>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="subBar">
					<ul>
						<li><div class="buttonActive">
								<div class="buttonContent">
									<button type="submit" >查询</button>
								</div>
							</div></li>
						<li><div class="button">
								<div class="buttonContent">
									<button type="button" onclick="resetChooseUserDialog()">重置</button>
								</div>
							</div></li>
					</ul>
				</div>
			</form>
		</div>
	</div>
	<!-- 列表部分 -->
	<table class="table" id="userChooseInfo" width="100%" layoutH="158">
		<thead>
			<tr>
				<th width="22"><input type="checkbox" group="ids" onclick="selectAll(this)" class="checkboxCtrl"></th>
				<th width="100">用户名</th>
				<th width="100">真实姓名</th>
				<th width="100">联系电话</th>
			</tr>
		</thead>
		<tbody id="T_TABLE">
			<c:forEach items="${responseDataForm.resultObj.dataList }" var="row">
				<tr target="CHOOOSE_USER_DIALOG_ID" rel="${row.USER_ID}" onclick="checked(this)">
					<td><input name="ids" value="${row.USER_CODE}" USER_TEL="${row.TEL}" USER_NAME="${row.USER_NAME}" type="checkbox" onclick="isChecked(this)"></td>
					<td>${row.USER_CODE }</td>
					<td>${row.USER_NAME}</td>
					<td>${row.TEL}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="formBar">
			<ul style="float: left;">
				<li><div class="buttonActive"><div class="buttonContent"><button type="button" class="close" >确定</button></div></div></li>
			</ul>
	</div>
	<jsp:include page="../comm/dialogPagingBar.jsp"></jsp:include>
</div>