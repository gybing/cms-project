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
		<form id="orderInfoEditForm" method="post" action="${ctxPath }/topic/ajax/addOrder" data-id="${param.pdataId}" callback="" class="form-horizontal">
			<input type="hidden" name="ORDER_ID" value="" />
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
									<input id="user_name" name="user_name" maxlength="14" type="text" class="required" aria-required="true" />
								</div>
								<label class="col-sm-2 control-label">身份证号:</label>
								<div class="col-sm-2">
									<input id="id_no" name="id_no" maxlength="14" type="text" class="required" aria-required="true" />
								</div>
								<label class="col-sm-2 control-label">联系电话:</label>
								<div class="col-sm-2">
		                    		<input id="phone" name="phone" maxlength="14" type="text" class="required" aria-required="true" />
								</div>
							</div>
						</div>
					</div>
					<div class="panel panel-default" style="margin-top: 5px;">
						<div class="panel-heading" style="padding: 5px">
							<span style="font-weight: bold;">迁出信息</span>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label class="col-sm-1 control-label">迁出楼号:</label>
								<div class="col-sm-2">
		                    		<select class="combox" id="building_id" name="building_id"><option value="">请选择</option></select>
								</div>
								<label class="col-sm-2 control-label">迁出楼层:</label>
								<div class="col-sm-2">
		                    		<select class="combox" id="floor_id" name=""floor_id""><option value="">请选择</option></select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-1 control-label">迁出房号:</label>
								<div class="col-sm-2">
									<select class="combox" id="room_id" name="room_id"><option value="">请选择</option></select>
								</div>
								<label class="col-sm-2 control-label">迁出时间:</label>
								<div class="col-sm-2">
									<input type="text" class="form-control layer-date" id="move_in_time" name="move_in_time" value="${responseDataForm.resultObj[0].SHIP_DATE }"  placeholder="YYYY-MM-DD" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" />
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
									<textarea rows="2" cols="123" style="resize: none;"></textarea>
								</div> 
							</div>
						</div>
					</div>
					<div class="form-group" style="margin-top:20px;margin-right:-7px;">
						<div class="col-sm-1" style="float:right">
                    		<button type="submit" class="btn btn-primary"><i class="glyphicon glyphicon-ok"></i>取消</button>
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
	
});
</script>
</html>