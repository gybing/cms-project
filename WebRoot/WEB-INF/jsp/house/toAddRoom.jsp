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
							<span style="font-weight: bold;">房间信息</span>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label class="col-sm-1 control-label">房间编号:</label>
								<div class="col-sm-2">
									<input id="room_no" name="room_no" maxlength="14" class="required digits form-control" type="text"/>
									<span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 必填项</span>
								</div>
								<label class="col-sm-2 control-label">楼宇编号:</label>
								<div class="col-sm-2">
		                    		<select class="combox" id="building_no" name="building_no" class="required form-control" >
										<option value="">请选择</option>
									</select>
								</div>
								<label class="col-sm-2 control-label">楼宇名称:</label>
								<div class="col-sm-2">
		                    		<input id="building_name" name="building_name" readonly maxlength="20" type="text" class="form-control" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-1 control-label">房间类型:</label>
								<div class="col-sm-2">
									<select class="combox form-control" id="room_type" name="room_type">
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
									<select class="combox" id="room_floor" name="room_floor">
										<option value="">请选择</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-1 control-label">建筑面积:</label>
								<div class="col-sm-3">
									<input id="construction_area" name="construction_area" maxlength="11" type="text" class="number form-control" />
								</div>
								<div class="col-sm-1 area_unit">
									<span>(㎡)</span>
								</div>
								<label class="col-sm-1 control-label">套内面积:</label>
								<div class="col-sm-3">
									<input id="room_area" name="room_area" maxlength="11" type="text" class="number form-control" />
								</div>
								<div class="col-sm-1 area_unit">
									<span>(㎡)</span>
								</div>
								<label class="col-sm-1 control-label">公摊面积:</label>
								<div class="col-sm-3">
									<input id="public_area" name="public_area" maxlength="11" type="text" class="number form-control" />
								</div>
								<div class="col-sm-1 area_unit">
									<span>(㎡)</span>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-1 control-label">装修情况:</label>
								<div class="col-sm-3">
									<input id="decration_state" name="decration_state" maxlength="20" type="text" class="form-control" />
								</div>
								<label class="col-sm-1 control-label">朝向:</label>
								<div class="col-sm-3">
									<input id="room_toward" name="room_toward" maxlength="20" type="text" class="form-control" />
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
	$s2.init($C("#room_type"), {
		sysdict : $sysdict.ROOM_TYPE
	});
	// 房间状态下拉框
	$s2.init($C("#room_state"), {
		sysdict : $sysdict.ROOM_STATE
	});
	// 设置楼层下拉框为 select2
	$("#room_floor").select2({
		minimumResultsForSearch:-1
	});
	// 根据选择的楼宇编号，获取楼宇名称,设置楼宇的楼层信息
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
				$("#room_floor").html(""); // 清空上一次选择的楼宇的楼层信息
				var html = "<option value=\"\">请选择</option>";
				for (var int = 1; int <= json.BUILDING_FLOORS; int++) {
					html += "<option value=\""+int+"\">"+int+"</option>";
				}
				$("#room_floor").append(html); // 重新载入选中楼宇的楼称信息
				$("#room_floor").val("").trigger("change"); // 清空上一次选择楼层信息
			}
		});
	});
	
	// 表单提交验证
	$("#building_add_form").validate({
		submitHandler : function(form) {
			// 验证楼宇编号是否选择
			if($("#building_no").val() == ''){
				layer.tips('请选择楼宇编号!', '#building_no', {
					  tips: [2,'#f21111'] //还可配置颜色
				});
				return ;
			}
			$.ajax({
				url : "${ctxPath }/topic/ajax/saveRoomInfo",
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