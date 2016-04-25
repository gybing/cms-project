<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>
<%
	Date date = new java.util.Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String LgTime = sdf.format(date);  
%>
<c:set var="now" value="<%=LgTime%>" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
<title>新增住户</title>
<style type="text/css">
.search_user_btn{
    height: 24px;
    padding-left: 0px;
    padding-right: 0px;
    margin-left: 13px;
    font-size: 12px;
}
</style>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<form id="reg_pay_info_form" method="post" action="#" data-id="" callback="" class="form-horizontal">
			<input type="hidden" name="fee_name" id="fee_name" /> <!-- 费用名称 -->
			<input type="hidden" name="user_id" id="u_id" /> <!-- 住户id -->
			<div class="ibox">
				<div class="ibox-content">
					<div class="panel panel-default" style="margin-top: 5px;">
						<div class="panel-heading" style="padding: 5px">
							<span style="font-weight: bold;">缴费用户信息</span>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label class="col-sm-1 control-label">住户:</label>
								<div class="col-sm-2">
										<input id="user_name" name="user_name" maxlength="20" type="text" readonly class="required form-control" aria-required="true" />
								</div>
								<div class="col-sm-1">
									<button type="button" class="btn btn-success search_user_btn" onclick="selectUserToMoveIn()"><i class=""></i>选择用户</button>
								</div>
								<label class="col-sm-1 control-label">房号:</label>
								<div class="col-sm-2">
									<input id="room_addr" name="room_addr" maxlength="20" type="text" readonly class="form-control" aria-required="true" />
								</div>
								<label class="col-sm-2 control-label">联系电话:</label>
								<div class="col-sm-2">
		                    		<input id="phone" name="phone" maxlength="14" type="text" readonly class="form-control" aria-required="true" />
								</div>
							</div>
						</div>
					</div>
					<div class="panel panel-default" style="margin-top: 5px;">
						<div class="panel-heading" style="padding: 5px">
							<span style="font-weight: bold;">费用类型信息</span>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label class="col-sm-1 control-label">费用类型:</label>
								<div class="col-sm-2">
		                    		<select class="combox" id="pay_type" name="pay_type"><option value="">请选择</option></select>
								</div>
								<label class="col-sm-2 control-label">计费方式:</label>
								<div class="col-sm-2">
									<input id="count_type" name="count_type" maxlength="14" type="text" readonly class="form-control" aria-required="true" />
								</div>
								<label class="col-sm-2 control-label">收费单价:</label>
								<div class="col-sm-2">
									<input id="pay_price" name="pay_price" maxlength="14" type="text" readonly class="form-control" aria-required="true" />
								</div>
							</div>
						</div>
					</div>
					<div class="panel panel-default" style="margin-top: 5px;">
						<div class="panel-heading" style="padding: 5px">
							<span style="font-weight: bold;">缴费统计信息</span>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label class="col-sm-1 control-label">起始时间:</label>
								<div class="col-sm-2">
									<input type="text" class="form-control layer-date" id="begin_date" name="begin_date" value="${responseDataForm.resultObj[0].SHIP_DATE }"  placeholder="YYYY-MM-DD" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" />
								</div>
								<label class="col-sm-2 control-label">结束时间:</label>
								<div class="col-sm-2">
									<input type="text" class="form-control layer-date" id="end_date" name="end_date" value="${responseDataForm.resultObj[0].SHIP_DATE }"  placeholder="YYYY-MM-DD" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" />
								</div>
								<label class="col-sm-2 control-label">总量:</label>
								<div class="col-sm-2">
									<input id="total" name="total" maxlength="14" type="text" class="number form-control" aria-required="true" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-1 control-label">缴费时间:</label>
								<div class="col-sm-2">
									<input type="text" class="form-control layer-date" id="pay_date" name="pay_date"  value="${now}"  placeholder="YYYY-MM-DD hh:mm:ss" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})" />
								</div>
								<label class="col-sm-2 control-label">是否缴清:</label>
								<div class="col-sm-2">
									<div class="radio radio-info radio-inline">
                                        <input type="radio" id="inlineRadio1" value="1" name="is_completed" checked="">
                                        <label for="inlineRadio1">是</label>
                                    </div>
                                    <div class="radio radio-inline">
                                        <input type="radio" id="inlineRadio2" value="0" name="is_completed">
                                        <label for="inlineRadio2">否</label>
                                    </div>
								</div>
								<label class="col-sm-2 control-label">费用合计:</label>
								<div class="col-sm-2">
									<input id="cnt" name="cnt" maxlength="14" type="text" readonly class="form-control" aria-required="true" />
								</div>
							</div>
						</div>
					</div>
					<div class="panel panel-default" style="margin-top: 5px;">
						<div class="panel-heading" style="padding: 5px">
							<span style="font-weight: bold;">备注信息</span>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<div class="col-sm-2">
									<textarea id="remark" name="remark" rows="1" cols="133" style="resize: none;"></textarea>
								</div> 
							</div>
						</div>
					</div>
					<div class="form-group" style="margin-top:20px;margin-right:-7px;">
						<div class="col-sm-1" style="float:right">
                    		<button type="button" class="btn btn-default" onclick="cancelLayer()"><i class="glyphicon glyphicon-remove"></i>取消</button>
						</div>
						<div class="col-sm-1" style="float:right">
                    		<button type="submit" class="btn btn-primary"><i class="glyphicon glyphicon-ok"></i>保存</button>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
</body>
<script type="text/javascript">
$(function(){
	//初始化费用类型下拉框
	$s2.init($C("#pay_type"), {
		tabdict : "pay_type",
		isSear: 1
	});
	
	// 光标离开总量输入框时
	$("#total").blur(function(){
		if($("#pay_price").val()){
			$("#cnt").val($("#pay_price").val()*$("#total").val());
		}
	});
	//根据选择的费用类型，加载对应费用类型相关信息
	$("#pay_type").change(function(){
		var pay_type = $(this).val()?$(this).val():-1;
		$.ajax({
			url:"${ctxPath}/topic/ajax/getFeeTypeInfo",
			type:"post",
			dataType:"json",
			data:{"fee_id":pay_type},
			success:function(json){
				if(json.result == 1){
					json = json.resultObj;
					$("#fee_name").val(json.TYPE_NAME);
					$("#count_type").val(json.S_COUNT_TYPE);
					$("#pay_price").val(json.PAY_PRICE);
				}
			}
		});
	});
	
	// 表单提交
	$("#reg_pay_info_form").validate({
		submitHandler : function(form) {
			$.ajax({
				url : "${ctxPath }/topic/ajax/savePayment",
				dataType : "json",
				data : $(form).serialize(),
				type : "post",
				success : function(json) {
					if (json.result == '1') {
						layer.alert(json.resultInfo, function(index){
							//刷新表格，关闭弹窗
							parent.searchForm();
							parent.layer.close(parent.layer.getFrameIndex(window.name));
							layer.close(index);
						});  
					} else {
						layer.alert(json.resultInfo,{icon: 2}, function(index){
							layer.close(index);
						});  
						return;
					}
			}});
		}
	});

});

// 选择用户
function selectUserToMoveIn(){
	layer.open({
	    type: 2,
	    title : "选择用户",
	    area: ['95%', '80%'],
	    fix: false, //不固定
	    content: _contextPath+"/topic/selectUserToMoveIn?isIn="+1
	});
}

// 加载用户信息到页面元素
function loadUserInfo(u_id){
	$("#u_id").val(u_id);
	$.ajax({
		url:"${ctxPath}/topic/ajax/qryUserInfoByKey",
		type:"post",
		data:{"user_id":u_id},
		dataType:"json",
		success:function(json){
			if(json.result == 1){
				json = json.resultObj;
				$("#user_name").val(json.USER_NAME);
				$("#room_addr").val(json.MOVE_ADDR); // 住户房间地址
				$("#phone").val(json.PHONE);
			}
		}
	});
}
</script>
</html>