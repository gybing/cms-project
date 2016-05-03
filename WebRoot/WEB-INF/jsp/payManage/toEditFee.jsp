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
		<form id="edit_pay_info_form" method="post" action="#" data-id="" callback="" class="form-horizontal">
			<input type="hidden" name="fee_name" id="fee_name" /> <!-- 费用名称 -->
			<input type="hidden" name="p_id" id="p_id" value="${param.p_id }"/> <!-- 住户id -->
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
										<input id="user_name" name="user_name" value="${responseDataForm.resultObj.USER_NAME }" maxlength="20" type="text" readonly class="required form-control" aria-required="true" />
								</div>
								<label class="col-sm-2 control-label">房号:</label>
								<div class="col-sm-2">
									<input id="room_addr" name="room_addr" value="${responseDataForm.resultObj.MOVE_ADDR }" maxlength="20" type="text" readonly class="form-control" aria-required="true" />
								</div>
								<label class="col-sm-2 control-label">联系电话:</label>
								<div class="col-sm-2">
		                    		<input id="phone" name="phone" value="${responseDataForm.resultObj.PHONE }" maxlength="14" type="text" readonly class="form-control" aria-required="true" />
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
									<input id="pay_type" name="pay_type" value="${responseDataForm.resultObj.FEE_NAME }" maxlength="14" type="text" readonly class="form-control" aria-required="true" />
								</div>
								<label class="col-sm-1 control-label">计费方式:</label>
								<div class="col-sm-2">
									<input id="count_type" name="count_type" value="${responseDataForm.resultObj.COUNT_TYPE }" maxlength="14" type="text" readonly class="form-control" aria-required="true" />
								</div>
								<label class="col-sm-1 control-label">收费单价:</label>
								<div class="col-sm-2">
									<input id="pay_price" name="pay_price" value="${responseDataForm.resultObj.PAY_PRICE }" maxlength="14" type="text" readonly class="form-control" aria-required="true" />
								</div>
								<label class="col-sm-1 control-label">单位:</label>
								<div class="col-sm-2">
									<input id="unit_text" name="unit_text" value="${responseDataForm.resultObj.UNIT_TEXT }"  maxlength="14" readonly type="text" class="required form-control" aria-required="true" />
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
									<input type="text" class="form-control layer-date" id="begin_date" name="begin_date" value="${responseDataForm.resultObj.BEGIN_DATE }"  placeholder="YYYY-MM-DD" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" />
								</div>
								<label class="col-sm-1 control-label">结束时间:</label>
								<div class="col-sm-2">
									<input type="text" class="form-control layer-date" id="end_date" name="end_date" value="${responseDataForm.resultObj.END_DATE }"  placeholder="YYYY-MM-DD" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" />
								</div>
								<label class="col-sm-1 control-label">缴费时间:</label>
								<div class="col-sm-2">
									<input type="text" class="form-control layer-date" id="pay_date" name="pay_date"  value="${responseDataForm.resultObj.PAY_DATE }"  placeholder="YYYY-MM-DD hh:mm:ss" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})" />
								</div>
								<label class="col-sm-1 control-label">数量:</label>
								<div class="col-sm-2">
									<input id="total" name="total" maxlength="14" value="${responseDataForm.resultObj.TOTAL }" type="text" class="number form-control" aria-required="true" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-1 control-label">应缴金额:</label>
								<div class="col-sm-2">
									<input id="cnt" name="cnt" value="${responseDataForm.resultObj.TOTAL_PRICE }" maxlength="14" type="text" readonly class="form-control" aria-required="true" />
								</div>
								<label class="col-sm-1 control-label">实缴金额:</label>
								<div class="col-sm-2">
									<input id="fact_of_fee" name="fact_of_fee" value="${responseDataForm.resultObj.FACT_OF_FEE }" maxlength="14" type="text" class="required number form-control" aria-required="true" />
								</div>
								<label class="col-sm-1 control-label">是否缴清:</label>
								<div class="col-sm-2">
									<div class="radio radio-inline">
                                        <input type="radio" id="inlineRadio1" value="1" name="is_completed" <c:if test="${responseDataForm.resultObj.IS_COMPLETED eq '1'}"> checked=""</c:if>>
                                        <label for="inlineRadio1">是</label>
                                    </div>
                                    <div class="radio radio-inline">
                                        <input type="radio" id="inlineRadio2" value="0" name="is_completed" <c:if test="${responseDataForm.resultObj.IS_COMPLETED eq '0'}"> checked=""</c:if>>
                                        <label for="inlineRadio2">否</label>
                                    </div>
								</div>
								<label class="col-sm-1 control-label">欠款金额:</label>
								<div class="col-sm-2">
									<input id="arrears" name="arrears" value="${responseDataForm.resultObj.ARREARS }" maxlength="14" type="text" class="number form-control" aria-required="true" />
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
									<textarea id="remark" name="remark" rows="1" cols="133" style="resize: none;">${responseDataForm.resultObj.REMARK }</textarea>
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
	// 光标离开数量输入框时
	$("#total").blur(function(){
		if($("#pay_price").val()){
			$("#cnt").val($("#pay_price").val()*$("#total").val());
		}
	});
	
	// 光标离开实缴金额输入框时
	$("#fact_of_fee").blur(function(){
		var fact_of_fee = $("#fact_of_fee").val(); // 获取实缴金额
		var cnt = $("#cnt").val(); // 获取应缴金额
		var tmp = cnt - fact_of_fee; // 精算差值
		if(tmp > 0){
			$("#arrears").val(tmp); // 应缴金额与实缴金额的差值赋值给欠款金额输入框
			$("#inlineRadio2").iCheck("check"); // 同时设定是否缴清为否
			$("#inlineRadio1").iCheck("uncheck"); // 移除checked属性
		}else if(tmp == 0){ // 如果实缴金额与实缴金额相同
			$("#arrears").val(""); // 清空欠款金额输入框
			$("#inlineRadio1").iCheck("check"); // 同时设定是否缴清为是
			$("#inlineRadio2").iCheck("uncheck"); // 移除checked属性
		}else{
			layer.alert("实缴金额大于应缴金额，请确认！",{icon: 2}, function(index){
			$("#inlineRadio1").iCheck("check"); // 设定是否缴清为是
			$("#inlineRadio2").iCheck("uncheck"); // 移除checked属性
				$("#arrears").val(""); // 清空欠款金额输入框
				layer.close(index); // 关闭提示窗
			});  
		}
	});
	
	// 表单提交
	$("#edit_pay_info_form").validate({
		submitHandler : function(form) {
			$.ajax({
				url : "${ctxPath }/topic/ajax/updatePayment",
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


</script>
</html>