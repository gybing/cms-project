<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
<style type="text/css">
.has-success .control-label{
	color:inherit;
}
.area_unit{
    margin-left: -42px;
    width: 10px;
    margin-top: 4px;
	}
</style>
<%-- <jsp:include page="/WEB-INF/jsp/formSubmit.jsp"></jsp:include> --%>
<title>新增住户</title>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<form id="building_add_form" method="post" action="#" data-id="" callback="" class="form-horizontal">
			<div class="ibox">
				<div class="ibox-content">
					<div class="panel panel-default" style="margin-top: 5px;">
						<div class="panel-heading" style="padding: 5px">
							<span style="font-weight: bold;">费用类型信息</span>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label class="col-sm-1 control-label">类型代码:</label>
								<div class="col-sm-2">
									<input id="fee_type_code" name="fee_type_code" maxlength="14" class="required digits form-control" type="text"/>
									<span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 必填项</span>
								</div>
								<label class="col-sm-2 control-label">类型名称:</label>
								<div class="col-sm-2">
		                    		<input id="type_name" name="type_name" maxlength="20" type="text" class="required form-control" />
									<span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 必填项</span>
								</div>
								<label class="col-sm-2 control-label">收费方式:</label>
								<div class="col-sm-2">
		                    		<select class="combox" id="pay_way" name="pay_way" class="required form-control" >
										<option value="">请选择</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-1 control-label">计费方式:</label>
								<div class="col-sm-2">
									<select class="combox form-control" id="count_type" name="count_type">
										<option value="">请选择</option>
									</select>
								</div>
								<label class="col-sm-2 control-label">收费类型:</label>
								<div class="col-sm-2">
									<select class="combox" id="pay_type" name="pay_type">
										<option value="">请选择</option>
									</select>
								</div>
								<label class="col-sm-2 control-label">计费周期数:</label>
								<div class="col-sm-2">
									<select class="combox" id="pay_cycle" name="pay_cycle">
										<option value="">请选择</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-1 control-label">周期单位:</label>
								<div class="col-sm-3">
									<select class="combox form-control" id="cycle_unit" name="cycle_unit">
										<option value="">请选择</option>
									</select>
								</div>
								<label class="col-sm-1 control-label">计费单价:</label>
								<div class="col-sm-3">
									<input id="pay_price" name="pay_price" maxlength="14" class="required number form-control" type="text"/><span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 必填项</span>
								</div>
								<label class="col-sm-1 control-label">计费单位:</label>
								<div class="col-sm-3">
									<select class="combox form-control" id="unit" name="unit">
										<option value="">请选择</option>
									</select>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group" style="margin-top:80px;margin-right:-7px;">
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
	$s2.init($C("#pay_way"), {
		sysdict : $sysdict.PAY_WAY
	});
	$s2.init($C("#count_type"), {
		sysdict : $sysdict.COUNT_TYPE
	});
	$s2.init($C("#pay_type"), {
		sysdict : $sysdict.PAY_TYPE
	});
	$s2.init($C("#pay_cycle"), {
		sysdict : $sysdict.PAY_CYCLE
	});
	$s2.init($C("#cycle_unit"), {
		sysdict : $sysdict.CYCLE_UNIT
	});
	$s2.init($C("#pay_unit"), {
		sysdict : $sysdict.PAY_UNIT
	});
	$s2.init($C("#unit"), {
		sysdict : $sysdict.UNIT
	});
	// 表单提交验证
	$("#building_add_form").validate({
		submitHandler : function(form) {
			// 验证楼宇编号是否选择
			$.ajax({
				url : "${ctxPath }/topic/ajax/saveFeeType",
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