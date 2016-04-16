<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
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
							<span style="font-weight: bold;">楼宇信息</span>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label class="col-sm-1 control-label">房间编号:</label>
								<div class="col-sm-2">
									<input id="building_addr" name="building_addr" maxlength="14" type="text"/>
								</div>
								<label class="col-sm-2 control-label">楼宇编号:</label>
								<div class="col-sm-2">
		                    		<select class="combox" id="building_no" name="building_no">
										<option value="">请选择</option>
									</select>
								</div>
								<label class="col-sm-2 control-label">楼宇名称:</label>
								<div class="col-sm-2">
		                    		<input id="building_name" name="building_name" readonly maxlength="14" type="text" aria-required="true" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-1 control-label">房间类型:</label>
								<div class="col-sm-2">
									<select class="combox" id="room_type" name="room_type">
										<option value="">请选择</option>
									</select>
								</div>
								<label class="col-sm-2 control-label">房间状态:</label>
								<div class="col-sm-2">
									<select class="combox" id="room_state" name="room_state">
										<option value="">请选择</option>
									</select>
								</div>
								<label class="col-sm-2 control-label">所在楼层:</label>
								<div class="col-sm-2">
									<select class="combox" id="sex" name="sex">
										<option value="">请选择</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-1 control-label">建筑面积:</label>
								<div class="col-sm-3">
									<input id="building_type" name="building_type" maxlength="14" type="text" aria-required="true" />
								</div>
								<label class="col-sm-1 control-label">套内面积:</label>
								<div class="col-sm-3">
									<input id="building_structure" name="building_structure" maxlength="14" type="text" aria-required="true" />
								</div>
								<label class="col-sm-1 control-label">公摊面积:</label>
								<div class="col-sm-3">
									<input id="building_toward" name="building_toward" maxlength="14" type="text" aria-required="true" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-1 control-label">装修情况:</label>
								<div class="col-sm-3">
									<input id="building_type" name="building_type" maxlength="14" type="text" aria-required="true" />
								</div>
								<label class="col-sm-1 control-label">朝向:</label>
								<div class="col-sm-3">
									<input id="building_structure" name="building_structure" maxlength="14" type="text" aria-required="true" />
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
									<textarea id="remark" name="remark" rows="2" cols="123" style="resize: none;"></textarea>
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
	// 初始化楼宇编号下拉框
	$s2.init($C("#building_no"), {
		tabdict : "building_no",
		isSear: 1
	});
	// 房间类型下拉框
	$s2.init($C("#room_type"), {//运单状态
		sysdict : $sysdict.ROOM_TYPE
	});
	// 房间类型下拉框
	$s2.init($C("#room_state"), {//运单状态
		sysdict : $sysdict.ROOM_STATE
	});
	// 根据选择的楼宇编号，获取楼宇名称
	$("#building_no").change(function(){
		var _b_id = $(this).val();
		$.ajax({
			url:"${ctxPath}/topic/ajax/toEditBuilding",
			type:"post",
			dataType:"json",
			data:{"b_id":_b_id?_b_id:-1},
			success:function(json){
				json = json.resultObj;
				$("#building_name").val(json.BUILDING_NAME);
			}
		});
	});
	// 表单提交验证
	$("#building_add_form").validate({
		submitHandler : function(form) {
			$.ajax({
				url : "${ctxPath }/topic/ajax/saveBuildingInfo",
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