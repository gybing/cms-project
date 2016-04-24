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
										<div class="col-sm-12">
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
										<div class="col-sm-3">
											<button type="button" class="btn btn-sm btn-primary " onclick="searchForm();">查    询</button>
											<button type="button" class="btn btn-sm btn-primary " onclick="refreshForm('user_list_search_form');">刷    新</button>
											<button type="button" class="btn btn-sm btn-success " onclick="chooseUser();">确   定 </button>
										</div>
										</div>
									</div>
								</div>
							</form>
							<div class="ibox-content widget-content nopadding float-e-margins">
							</div>
							<table id="u_list_table" class="table table-striped table-bordered table-hover data-table with-check">
								<thead>
									<tr align="center">
										<th>序号</th>
										<th>姓名</th>
										<th>身份证号</th>
										<th>联系电话</th>
										<th>是否迁入</th>
										<th>入住地址</th>
										<th>迁入时间</th>
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
		{"data" : "ID_NO"}, // 
		{"data" : "PHONE"}, // 
		{"data" : "IS_MOVE_IN",
			"render":function(data){
				if(data == '1'){
					return "是";
				}else{
					return "";
				}
		}}, // 
		{"data" : "ADDR"}, // 
		{"data" : "MOVE_IN_TIME"}// 
		];
// 设置哪些列不进行排序  哪些列需排序（需要改sql xml条件）
var aoColumnParam = [0],aaSortParam = [];
$(function(){
	// 加载列表信息 initTableAutoHeight(id,url,param,colsParam,aoColumnParam,aaSortParam,other); 
	// param Ajax请求时发送额外的数据(条件),colsParam 设置列属性条件,aoColumnParam 设置哪些列不排序  aaSortParam设置哪些列排序
	table = initTable("u_list_table", "${ctxPath}/topic/page/qryUserList?",{"is_move_in":'${param.isIn}'},cols,aoColumnParam,aaSortParam,"USER_ID");
});

function chooseUser(){
	var u_id = $("#clickId").val()?$("#clickId").val():"";
	if(u_id){
		parent.loadUserInfo(u_id);
		parent.layer.close(parent.layer.getFrameIndex(window.name));
	}else{
		layer.alert("请选择一条记录！", {icon: 2}, function(index){
			layer.close(index);
		});  
	}
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
</script>
</html>