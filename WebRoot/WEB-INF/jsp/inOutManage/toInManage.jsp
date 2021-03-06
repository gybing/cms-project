<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
<title>房间管理</title>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
			<div class="ibox">
				<div class="ibox-title">
					<div class="panel panel-default" style="margin-top: 5px;">
						<div class="panel-body">
							<form class="form-horizontal" id="user_list_search_form">
							<input type="hidden" id="clickId" name="clickId">
								<div class="ibox">
									<div class="form-group">
										<label class="col-sm-1 control-label">房间编号:</label>
										<div class="col-sm-2">
											<input id="room_no" name="room_no" maxlength="20" type="text" class="required form-control" aria-required="true" />
										</div>
										<label class="col-sm-1 control-label">房间状态:</label>
										<div class="col-sm-2">
											<select class="combox" id="room_state" name="room_state">
												<option value="">请选择</option>
											</select>
										</div>
										<label class="col-sm-1 control-label">楼宇编号:</label>
										<div class="col-sm-2">
											<select class="combox" id="building_no" name="building_no">
												<option value="">请选择</option>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-1 control-label">房间类型:</label>
										<div class="col-sm-2">
											<select class="combox" id="room_type" name="room_type">
												<option value="">请选择</option>
											</select>
										</div>
										<!-- <label class="col-sm-1 control-label">楼宇名称:</label>
										<div class="col-sm-3">
											<input id="building_name" name="building_name" maxlength="20" type="text" class="required form-control" aria-required="true" />
										</div> -->
										<div class="col-sm-3">
											<button type="button" class="btn btn-sm btn-primary " onclick="searchForm();">查    询</button>
											<button type="button" class="btn btn-sm btn-primary " onclick="resetForm('user_list_search_form');">重    置</button>
											<button type="button" class="btn btn-sm btn-primary " onclick="refreshForm('user_list_search_form');">刷    新</button>
										</div>
									</div>
								</div>
							</form>
							<div class="ibox-content widget-content nopadding float-e-margins">
								<div id="orderToolbar" style=" float:left; padding: 5px 5px;">
									<button type="button" class="btn btn-outline btn-default" onclick="toMoveIn();">
										<i class="glyphicon glyphicon-import"></i> 迁入
									</button>
									<button type="button" class="btn btn-outline btn-default" onclick="toEditMoveInfo();"> 
										<i class="glyphicon glyphicon-export"></i> 编辑
									</button>
								</div>
							</div>
							<table id="room_list_table" class="table table-striped table-bordered table-hover data-table with-check">
								<thead>
									<tr style="text-align:center;">
										<th>序号</th>
										<th>房间编号</th>
										<th>房间状态</th>
										<th>所在楼层</th>
										<th>楼宇编号</th>
										<!-- <th>楼宇名称</th> -->
										<th>房间类型</th>
										<th>住户姓名</th>
										<th>入住时间</th>
										<th>装修情况</th>
										<th>朝向</th>
										<th>备注</th>
									</tr>
								</thead>
								<tbody></tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
	</div>
</body>
<script type="text/javascript">
//房间状态下拉框
$s2.init($C("#room_state"), {
	sysdict : $sysdict.ROOM_STATE,
	defVal:'${param.room_state}'
});
//房间类型下拉框
$s2.init($C("#room_type"), {
	sysdict : $sysdict.ROOM_TYPE,
	defVal:'${param.room_type}'
});
//初始化楼宇编号下拉框
$s2.init($C("#building_no"), {
	tabdict : "building_no",
	defVal:'${param.building_no}',
	isSear: 1
});

var table;
var cols = [
		{"data" : "NUM",// 序号
			"render" : function(data) {
				return "<div align='center'>" + data + "</div>";
		}},
		{"data" : "ROOM_NO"}, // .
		{"data" : "ROOM_STATE" // 任务状态
			,"render" : function(data) {
				if (data == "入住") {
					return "<div class='label label-danger ' >入住</div>";
				} else if (data == "空房") {
					return "<div class='label label-04' >空房</div>";
				} else{
					return "<div class='label label-03' >"+data+"</div>";
				}
			}
		},
		{"data" : "ROOM_FLOOR"}, // .
		{"data" : "BUILDING_NO"}, // .
	/* 	{"data" : "BUILDING_NAME"}, // . */
		{"data" : "ROOM_TYPE"}, // .
		{"data" : "USER_NAME"}, // .
		{"data" : "MOVE_IN_TIME"}, // .
		{"data" : "DECRATION_STATE"}, // .
		{"data" : "ROOM_TOWARD"}, // .
		{"data" : "REMARK"} // .
		];
// 设置哪些列不进行排序  哪些列需排序（需要改sql xml条件）
var aoColumnParam = [0],aaSortParam = [];
$(function(){
	// 加载列表信息 initTableAutoHeight(id,url,param,colsParam,aoColumnParam,aaSortParam,other); 
	// param Ajax请求时发送额外的数据(条件),colsParam 设置列属性条件,aoColumnParam 设置哪些列不排序  aaSortParam设置哪些列排序
	table = initTableAutoHeight("room_list_table", "${ctxPath}/topic/page/qryRoomList", {"user_move_in":"0"},cols,aoColumnParam,aaSortParam,"ID");
});

/* 搜索 查询 */
function searchForm() {
	$("#clickId").val(""); //清除之前选中的id
	table.column(0).search($('#room_no').val());
	table.column(1).search($('#room_state').val());
	table.column(2).search($('#building_no').val());
	table.column(3).search($('#room_type').val());
	/* table.column(4).search($('#building_name').val()); */
	table.draw();
}

/* 迁入弹窗 */
function toMoveIn(){
	var r_id = $("#clickId").val()?$("#clickId").val():-1;
	if(r_id != -1){
		var existUser = false;
		var r_state_text = "";
		$("#room_list_table tr").each(function(index,item){
			if($(this).attr("data-id") == r_id){
				if($(item.childNodes[2]).text() != "空房"){
					existUser = true;
					r_state_text = $(item.childNodes[2]).text();
				}
			}
		});
		if(existUser){
			layer.alert("该房间为"+r_state_text+"状态，请选择空房状态的房间！", {icon: 2}, function(index){
				layer.close(index);
			});  
		}else{
			index = layer.open({
			    type: 2, 
			    title : "住户迁入登记",
			    area: ['95%', '83%'],
			    fix: false, //不固定
			   // maxmin: true,
			    content: _contextPath+"/topic/toUserMoveIn?r_id="+r_id
			});
		}
		
	}else{
		layer.alert("请选择一条记录！", {icon: 2}, function(index){
			layer.close(index);
		});  
	}
}

/* 编辑用户迁入信息弹出 */
function toEditMoveInfo(){
	var r_id = $("#clickId").val()?$("#clickId").val():-1;
	if(r_id != -1){
		var existUser = false;
		$("#room_list_table tr").each(function(index,item){
			if($(this).attr("data-id") == r_id){
				if($(item.childNodes[2]).text() == "空房"){
					existUser = true;
				}
			}
		});
		if(existUser){
			layer.alert("该房间尚未入住，无法编辑入住信息！", {icon: 2}, function(index){
				layer.close(index);
			});  
		}else{
			index = layer.open({
			    type: 2, 
			    title : "编辑迁入信息",
			    area: ['95%', '83%'],
			    fix: false, //不固定
			   // maxmin: true,
			    content: _contextPath+"/topic/toEditUserMoveInfo?r_id="+r_id
			});
		}
		
	}else{
		layer.alert("请选择一条记录！", {icon: 2}, function(index){
			layer.close(index);
		});  
	}
}
</script>
</html>