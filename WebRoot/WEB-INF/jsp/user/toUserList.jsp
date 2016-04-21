<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
<title>用户管理</title>
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
										<label class="col-sm-1 control-label">姓名:</label>
										<div class="col-sm-2">
											<input id="user_name" name="user_name" maxlength="14" type="text" class="required" aria-required="true" />
										</div>
										<label class="col-sm-1 control-label">身份证号:</label>
										<div class="col-sm-2">
											<input id="id_no" name="id_no" maxlength="14" type="text" class="required" aria-required="true" />
										</div>
										<label class="col-sm-1 control-label">联系电话:</label>
										<div class="col-sm-2">
											<input id="phone" name="phone" maxlength="14" type="text" class="required" aria-required="true" />
										</div>
										<label class="col-sm-1 control-label">是否迁出:</label>
										<div class="col-sm-2">
											<select class="combox" id="is_move_out" name="is_move_out">
												<option value="">请选择</option>
												<option value="0">否</option>
												<option value="1">是</option>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-1 control-label">迁入时间（起）:</label>
										<div class="col-sm-2">
											<input type="text" class="form-control layer-date" id="move_in_time_start" name="move_in_time_start" value="${responseDataForm.resultObj[0].MOVE_IN_TIME }" placeholder="YYYY-MM-DD hh:mm"  onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm'})" />
										</div>
										<label class="col-sm-1 control-label">迁入时间（止）:</label>
										<div class="col-sm-2">
											<input type="text" class="form-control layer-date" id="move_in_time_end" name="move_in_time_end" value="${responseDataForm.resultObj[0].MOVE_IN_TIME }" placeholder="YYYY-MM-DD hh:mm"  onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm'})" />
										</div>
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
									<button type="button" class="btn btn-outline btn-default" onclick="toAddUser();">
										<i class="glyphicon glyphicon-plus"></i> 新增
									</button>
									<button type="button" class="btn btn-outline btn-default" onclick="toEditUser();">
										<i class="glyphicon glyphicon-edit"></i> 修改
									</button>
									<button type="button" class="btn btn-outline btn-default" onclick="delOrder();">
										<i class="glyphicon glyphicon-remove"></i> 删除
									</button>
									<button type="button" class="btn btn-outline btn-default" onclick="toMoveIn();">
										<i class="glyphicon glyphicon-import"></i> 迁入
									</button>
									<button type="button" class="btn btn-outline btn-default" onclick="toMoveOut();"> 
										<i class="glyphicon glyphicon-export"></i> 迁出
									</button>
									<button type="button" class="btn btn-outline btn-default" onclick="toPayment('1');"> 
										<i class="fa fa-rmb"></i> 缴费
									</button>
									<!-- <button type="button" class="btn btn-outline btn-default" onclick="toReserve('0');"> 
										<i class="glyphicon glyphicon-time"></i> 取消预约
									</button> -->
								</div>
							</div>
							<table id="user_list_table" class="table table-striped table-bordered table-hover data-table with-check">
								<thead>
									<tr align="center">
										<th>序号</th>
										<th>姓名</th>
										<th>性别</th>
										<th>身份证号</th>
										<th>联系电话</th>
										<th>邮箱</th>
										<th>是否迁入</th>
										<th>入住地址</th>
										<th>迁入时间</th>
										<th>是否迁出</th>
										<th>迁出时间</th>
										<th>迁出原因</th>
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
var table;
var cols = [
		{"data" : "NUM",// 序号
			"render" : function(data) {
				return "<div align='center'>" + data + "</div>";
		}},
		{"data" : "USER_NAME"}, // 
		{"data" : "SEX",
			"render":function(data){
				if(data == 'F'){
					return "女";
				}else if(data == 'M'){
					return "男";
				}
			}}, // 
		{"data" : "ID_NO"}, // 
		{"data" : "PHONE"}, // 
		{"data" : "EMAIL"}, // 
		{"data" : "IS_MOVE_IN",
			"render":function(data){
				if(data == '1'){
					return "是";
				}else{
					return "";
				}
		}}, // 
		{"data" : "MOVE_ADDR"}, // 
		{"data" : "MOVE_IN_TIME"}, // 
		{"data" : "IS_MOVE_OUT",
			"render":function(data){
				if(data == '1'){
					return "是";
				}else{
					return "";
				}
		}}, // 
		{"data" : "MOVE_OUT_TIME"}, // 
		{"data" : "MOVE_OUT_REASON"} // 
		];
// 设置哪些列不进行排序  哪些列需排序（需要改sql xml条件）
var aoColumnParam = [0],aaSortParam = [];
$(function(){
	// 加载列表信息 initTableAutoHeight(id,url,param,colsParam,aoColumnParam,aaSortParam,other); 
	// param Ajax请求时发送额外的数据(条件),colsParam 设置列属性条件,aoColumnParam 设置哪些列不排序  aaSortParam设置哪些列排序
	table = initTableAutoHeight("user_list_table", "${ctxPath}/topic/page/qryUserList", null,cols,aoColumnParam,aaSortParam,"USER_ID",getScreen());
});

/* 新增住户信息 */
function toAddUser(){
	/* 跳转页面  iUrl请求url  iTitletab标签名 */
	indexToPage("${ctxPath }/topic/toAddUser", "新增住户信息");
}

/* 编辑住户信息  */
function toEditUser(){
	/* 跳转页面  iUrl请求url  iTitletab标签名 */
	indexToPage("${ctxPath }/topic/toEditUser", "编辑住户信息");
}

/* 搜索 查询 */
function searchForm() {
	$("#clickId").val(""); //清除之前选中的id
	table.column(0).search($('#user_name').val());
	table.column(1).search($('#id_no').val());
	table.column(2).search($('#phone').val());
	table.column(3).search($('#is_move_out').val());
	table.column(4).search($('#move_in_time_start').val());
	table.column(5).search($('#move_in_time_end').val());
	table.draw();
}

/* 迁入弹窗 */
function toMoveIn(){
	index = layer.open({
	    type: 2, 
	    title : "住户迁出",
	    area: ['65%', '51%'],
	    fix: false, //不固定
	   // maxmin: true,
	    content: _contextPath+"/topic/toUserMoveIn"
	});
}

/* 迁出弹窗 */
function toMoveOut(){
	index = layer.open({
	    type: 2, 
	    title : "住户迁出",
	    area: ['65%', '71%'],
	    fix: false, //不固定
	   // maxmin: true,
	    content: _contextPath+"/topic/toUserMoveOut"
	});
}
/**
 * 获取屏幕高度
 * */
function getScreen()
{
	var height = document.body.clientHeight;
	var ibox_title = $(".ibox-title").height();
	var toolbar = $("#toolbar").height();
	return height-94-ibox_title-40-toolbar;
}
</script>
</html>