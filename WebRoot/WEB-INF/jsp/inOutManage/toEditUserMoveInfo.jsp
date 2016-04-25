<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
		<form id="edit_move_in_form" method="post" action="#" data-id="" callback="" class="form-horizontal">
			<input type="hidden" name="u_id" id="u_id" ${responseDataForm.resultObj.USER_ID }/> <!-- 住户id -->
			<input type="hidden" name="move_addr" id="move_addr"/> <!-- 住户迁入楼房信息 -->
			<input type="hidden" name="r_id" id="room_id"/> <!-- 房间id -->
			<div class="ibox">
				<div class="ibox-content">
					<div class="panel panel-default" style="margin-top: 5px;">
						<div class="panel-heading" style="padding: 5px">
							<span style="font-weight: bold;">用户基本信息</span>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label class="col-sm-1 control-label">住户:</label>
								<div class="col-sm-2">
										<input id="user_name" name="user_name" maxlength="20" type="text" readonly class="required form-control" aria-required="true" />
								</div>
								<div class="col-sm-1">
									<!-- <button type="button" class="btn btn-success search_user_btn" onclick="selectUserToMoveIn()"><i class=""></i>选择用户</button> -->
								</div>
								<label class="col-sm-1 control-label">身份证号11:</label>
								<div class="col-sm-2">
									<input id="id_no" name="id_no" maxlength="18" type="text" readonly class="form-control" aria-required="true" />
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
							<span style="font-weight: bold;">房屋信息</span>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label class="col-sm-1 control-label">迁入楼号:</label>
								<div class="col-sm-2">
		                    		<select class="combox" id="building_no" disabled name="building_no"><option value="">请选择</option></select>
								</div>
								<label class="col-sm-2 control-label">迁入楼层:</label>
								<div class="col-sm-2">
		                    		<select class="combox" id="room_floor" name="room_floor" disabled><option value="">请选择</option></select>
								</div>
								<label class="col-sm-2 control-label">迁入房号:</label>
								<div class="col-sm-2">
									<select class="combox" id="room_no" name="room_no" disabled></select>
								</div>
							</div>
						</div>
					</div>
					<div class="panel panel-default" style="margin-top: 5px;">
						<div class="panel-heading" style="padding: 5px">
							<span style="font-weight: bold;">迁入信息</span>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label class="col-sm-1 control-label">迁入时间:</label>
								<div class="col-sm-2">
									<input type="text" class="form-control layer-date" id="move_in_time" name="move_in_time" value="${responseDataForm.resultObj.MOVE_IN_TIME }"  placeholder="YYYY-MM-DD" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" />
								</div>
								<label class="col-sm-2 control-label">是否办理手续:</label>
								<div class="col-sm-5">
									<div class="radio radio-info radio-inline">
                                        <input type="radio" id="inlineRadio1" value="1" name="formalities" <c:if test="${responseDataForm.resultObj.FORMALITIES eq '1'}"> checked=""</c:if>>
                                        <label for="inlineRadio1">是</label>
                                    </div>
                                    <div class="radio radio-inline">
                                        <input type="radio" id="inlineRadio2" value="0" name="formalities" <c:if test="${responseDataForm.resultObj.FORMALITIES eq '0'}"> checked=""</c:if>>
                                        <label for="inlineRadio2">否</label>
                                    </div>
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
									<textarea id="move_in_remark" name="move_in_remark" rows="2" cols="123" style="resize: none;">${responseDataForm.resultObj.MOVE_IN_REMARK }</textarea>
								</div> 
							</div>
						</div>
					</div>
					<div class="form-group" style="margin-top:65px;margin-right:-7px;">
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
	if('${responseDataForm.resultObj.USER_ID}'){
		loadUserInfo('${responseDataForm.resultObj.USER_ID}');
	}
	//初始化楼宇编号下拉框
	$s2.init($C("#building_no"), {
		tabdict : "building_no",
		defVal: '${responseDataForm.resultObj.BUILDING_NO }',
		isSear: 1
	});
	// 设置楼层下拉框为 select2
	$("#room_floor").select2({
		minimumResultsForSearch:-1,
	});
	
	//根据选择的楼宇编号，获取楼宇名称,设置楼宇的楼层信息
	$("#building_no").change(function(){
		var building_no = $(this).val()?$(this).val():'${responseDataForm.resultObj.BUILDING_NO }';
		$.ajax({
			url:"${ctxPath}/topic/ajax/toEditBuilding",
			type:"post",
			dataType:"json",
			data:{"b_id":building_no?building_no:-1},
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
				if('${responseDataForm.resultObj.ROOM_FLOOR}'){
					$("#room_floor").val('${responseDataForm.resultObj.ROOM_FLOOR}').trigger("change"); // 如果存在楼层信息则选中
					loadRoomSelect("room_no",building_no,'${responseDataForm.resultObj.ROOM_FLOOR}');
				}
			}
		});
	});
	$("#building_no").trigger("change"); // 手动触发楼宇编号下拉框选择事件
	
	// 楼层选择变化事件
	$("#room_floor").change(function(){
		var r_fl = $(this).val();
		var building_no	 = '${responseDataForm.resultObj.BUILDING_NO}';
		loadRoomSelect("room_no",building_no,r_fl);
	});
	
	// 表单提交
	$("#edit_move_in_form").validate({
		submitHandler : function(form) {
			if(validate() == false){ // 提交验证
				return false;
			} ;
			var move_addr = $("#building_no option:selected").text() + "-" + $("#room_floor option:selected").text() + "-" + $("#room_no option:selected").text();
			$("#move_addr").val(move_addr); // 住户楼房地址信息
			$("#room_id").val($("#room_no").val());
			$.ajax({
				url : "${ctxPath }/topic/ajax/userMoveIn",
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
	    content: _contextPath+"/topic/selectUserToMoveIn"
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
				$("#id_no").val(json.ID_NO);
				$("#phone").val(json.PHONE);
			}
		}
	});
}
/** 加载房号下拉框 
 * building_no 楼宇 id
 * room_floor 楼层
 */
function loadRoomSelect(elementId,building_no,room_floor){
	$.ajax({
		url : "${ctxPath}/topic/ajax/qryBuildingRoom",
		data : {"b_no" : building_no,"r_fl":room_floor},
		dataType:"json",
		type:"post",
		success:function(data){
			$("#"+elementId).html("");
			$("#"+elementId).html("<option value=\"\">请选择</option>");
			var json = data.resultObj;
			$.each(json, function(index, item) {
				var temp= "";
				if('${responseDataForm.resultObj.IN_ROOM_ID}' == item.ID){
					temp = "selected='selected'";
				}
				var option = "<option "+temp+" value=\""+item.ID+"\" >"+ item.TEXT + "</option>";
				$("#"+elementId).append(option);
			});
			$("#"+elementId).select2({minimumResultsForSearch:-1}); 
		}
	});
}

function validate(){
	if($("#room_no").val() == ""){
		layer.tips("请选择房号！", '#room_no', {
			tips: 2
		});
		return false;
	}
	if($("#move_in_time").val() == ""){
		layer.tips("请选择选择迁入时间！", '#move_in_time', {
			tips: 2
		});
		return false;
	}
	return true;
}

</script>
</html>