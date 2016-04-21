<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
<title>编辑住户</title>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<form id="edit_user_info_form" method="post" action="#" data-id="" callback="" class="form-horizontal">
		<input type="hidden" id="user_id" name="user_id" value="${param.user_id }"> <!-- 住户id -->
			<div class="ibox">
				<div class="ibox-content">
					<div class="panel panel-default" style="margin-top: 5px;">
						<div class="panel-heading" style="padding: 5px">
							<span style="font-weight: bold;">用户基本信息</span>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label class="col-sm-1 control-label">姓名:</label>
								<div class="col-sm-2">
									<input id="user_name" name="user_name" value="${responseDataForm.resultObj.USER_NAME }" maxlength="50" type="text" class="required" aria-required="true" />
									<span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 必填项</span>
								</div>
								<label class="col-sm-2 control-label">性别:</label>
								<div class="col-sm-2">
									<select class="combox" id="sex" name="sex">
										<option value="">请选择</option>
										<option value="M" <c:if test="${responseDataForm.resultObj.SEX eq 'M' }">selected=""</c:if> >男</option>
										<option value="F" <c:if test="${responseDataForm.resultObj.SEX eq 'F' }">selected=""</c:if> >女</option>
									</select>
								</div>
								<label class="col-sm-2 control-label">身份证号:</label>
								<div class="col-sm-2">
									<input id="id_no" name="id_no" value="${responseDataForm.resultObj.ID_NO }" maxlength="18" type="text" class="required isIdCardNo" aria-required="true" />
									<span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 必填项</span>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-1 control-label">联系电话:</label>
								<div class="col-sm-2">
		                    		<input id="phone" name="phone" value="${responseDataForm.resultObj.PHONE }" maxlength="14" type="text" class="required number" aria-required="true" />
									<span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 必填项</span>
								</div>
								<label class="col-sm-2 control-label">身份证地址:</label>
								<div class="col-sm-2">
		                    		<input id="addr" name="addr" value="${responseDataForm.resultObj.ADDR }" maxlength="150" type="text" class="" aria-required="true" />
								</div>
								<label class="col-sm-2 control-label">邮箱:</label>
								<div class="col-sm-2">
									<input id="email" name="email" value="${responseDataForm.resultObj.EMAIL }" maxlength="50" type="text" class="email" aria-required="true" />
								</div>
							</div>
						</div>
					</div>
					<div class="panel panel-default" style="margin-top: 5px;">
						<div class="panel-heading" style="padding: 5px">
							<span style="font-weight: bold;">单位基本信息</span>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label class="col-sm-1 control-label">单位名称:</label>
								<div class="col-sm-2">
		                    		<input id="work" name="work" value="${responseDataForm.resultObj.WORK }" maxlength="100" type="text" class="required" aria-required="true" />
								</div>
								<label class="col-sm-2 control-label">单位地址:</label>
								<div class="col-sm-2">
		                    		<input id="work_addr" name="work_addr" value="${responseDataForm.resultObj.WORK_ADDR }" maxlength="150" type="text" class="required" aria-required="true" />
								</div>
								<label class="col-sm-2 control-label">单位电话:</label>
								<div class="col-sm-2">
									<input id="work_tel" name="work_tel" value="${responseDataForm.resultObj.WORK_TEL }" maxlength="14" type="text" class="number" aria-required="true" />
								</div>
							</div>
						</div>
					</div>
					<%-- <div class="panel panel-default" style="margin-top: 5px;">
						<div class="panel-heading" style="padding: 5px">
							<span style="font-weight: bold;">入住信息</span>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label class="col-sm-1 control-label">迁入楼号:</label>
								<div class="col-sm-2">
		                    		<select class="combox" id="building_id" name="building_id"><option value="">请选择</option></select>
								</div>
								<label class="col-sm-1 control-label">迁入楼层:</label>
								<div class="col-sm-2">
		                    		<select class="combox" id="floor_id" name=""floor_id""><option value="">请选择</option></select>
								</div>
								<label class="col-sm-1 control-label">迁入房号:</label>
								<div class="col-sm-2">
									<select class="combox" id="room_id" name="room_id"><option value="">请选择</option></select>
								</div>
								<label class="col-sm-1 control-label">迁入时间:</label>
								<div class="col-sm-2">
									<input type="text" class="form-control layer-date" id="move_in_time" name="move_in_time" value="${responseDataForm.resultObj[0].SHIP_DATE }"  placeholder="YYYY-MM-DD" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" />
								</div>
							</div>
						</div>
					</div> --%>
					<div class="panel panel-default" style="margin-top: 5px;">
						<div class="panel-heading" style="padding: 5px">
							<span style="font-weight: bold;">备注信息</span>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<div class="col-sm-2">
									<textarea id="remarak" name="remark" rows="2" cols="119" maxlength="200" style="resize: none;">${responseDataForm.resultObj.REMARK }</textarea>
								</div> 
							</div>
						</div>
					</div>
					<div class="form-group" style="margin-top:20px;margin-right:-7px">
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
	$("#sex").select2({
		minimumResultsForSearch:-1
	});
	// 表单提交
	$("#edit_user_info_form").validate({
		submitHandler : function(form) {
			$.ajax({
				url : "${ctxPath }/topic/ajax/updateUserInfo",
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
							//刷新表格，关闭弹窗
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