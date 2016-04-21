<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
<title>新增住户</title>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<form id="building_edit_form" method="post" action="#" data-id="" callback="" class="form-horizontal">
			<input type="hidden" name="b_id" value="${param.b_id }" /> <!-- 楼宇id -->
			<div class="ibox">
				<div class="ibox-content">
					<div class="panel panel-default" style="margin-top: 5px;">
						<div class="panel-heading" style="padding: 5px">
							<span style="font-weight: bold;">楼宇信息</span>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label class="col-sm-1 control-label">楼宇编号:</label>
								<div class="col-sm-3">
		                    		<input id="building_no" name="building_no" value="${responseDataForm.resultObj.BUILDING_NO }" maxlength="11" type="text" class="digits required form-control" aria-required="true" />
								</div>
								<label class="col-sm-1 control-label">楼宇名称:</label>
								<div class="col-sm-3">
		                    		<input id="building_name" name="building_name" value="${responseDataForm.resultObj.BUILDING_NAME }" maxlength="50" type="text" class="required form-control" aria-required="true" />
								</div>
								<label class="col-sm-1  control-label">楼宇层数:</label>
								<div class="col-sm-3">
									<input id="building_floors" name="building_floors" value="${responseDataForm.resultObj.BUILDING_FLOORS }" maxlength="11" class="required number form-control" type="text"/>
									<span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 必填项</span>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-1 control-label">楼宇地址:</label>
								<div class="col-sm-3">
									<input id="building_addr" name="building_addr" value="${responseDataForm.resultObj.BUILDING_ADDR }" maxlength="150" class="form-control" type="text" aria-required="true" />
								</div>
								<label class="col-sm-1 control-label">楼宇类型:</label>
								<div class="col-sm-3">
									<input id="building_type" name="building_type" value="${responseDataForm.resultObj.BUILDING_TYPE }" maxlength="20" class="form-control" type="text" aria-required="true" />
								</div>
								<label class="col-sm-1 control-label">楼宇结构:</label>
								<div class="col-sm-3">
									<input id="building_structure" name="building_structure" value="${responseDataForm.resultObj.BUILDING_STRUCTURE }" maxlength="20" class="form-control" type="text" aria-required="true" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-1 control-label">楼宇朝向:</label>
								<div class="col-sm-3">
									<input id="building_toward" name="building_toward" value="${responseDataForm.resultObj.BUILDING_TOWARD }" class="form-control" maxlength="20" type="text" aria-required="true" />
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
									<textarea id="remark" name="remark" rows="2" cols="123" style="resize: none;">${responseDataForm.resultObj.REMARK }</textarea>
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
$(function() {
	$("#building_edit_form").validate({
		submitHandler : function(form) {
			$.ajax({
				url : "${ctxPath }/topic/ajax/updateBuildingInfo",
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