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
				<div class="ibox-content">
					<div class="panel panel-default" style="margin-top: 5px;">
						<div class="panel-body">
							<form class="form-horizontal" id="building_list_form">
							<input type="hidden" id="clickId" name="clickId">
								<div class="ibox">
									<div class="form-group">
										<label class="col-sm-1 control-label">负责人:</label>
										<div class="col-sm-2">
											<input id="user_name" name="user_name" maxlength="20" type="text" class="required" aria-required="true" />
										</div>
										<label class="col-sm-1 control-label">联系电话:</label>
										<div class="col-sm-2">
											<input id="phone" name="phone" maxlength="14" type="text" class="required" aria-required="true" />
										</div>
										<label class="col-sm-1 control-label">楼层数量:</label>
										<div class="col-sm-2">
											<input id="id_no" name="id_no" maxlength="18" type="text" class="required" aria-required="true" />
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
									<button type="button" class="btn btn-outline btn-default" onclick="toAddBuilding();">
										<i class="glyphicon glyphicon-plus"></i> 新增
									</button>
									<button type="button" class="btn btn-outline btn-default" onclick="toEditBuilding();">
										<i class="glyphicon glyphicon-edit"></i> 修改
									</button>
									<button type="button" class="btn btn-outline btn-default" onclick="delBuilding();">
										<i class="glyphicon glyphicon-remove"></i> 删除
									</button>
								</div>
							</div>
							<table id="building_list_table" class="table table-striped table-bordered table-hover data-table with-check">
								<thead>
									<tr align="center">
										<th width="50px">序号</th>
										<th>楼宇编号</th>
										<th>楼宇名称</th>
										<th>楼宇层数</th>
										<th>楼宇地址</th>
										<th>楼宇类型</th>
										<th>楼宇结构</th>
										<th>楼宇朝向</th>
										<th>创建时间</th>
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
var table;
var cols = [
		{"data" : "NUM",// 序号
			"render" : function(data) {
				return "<div align='center' style='width:50px'>" + data + "</div>";
		}},
		{"data" : "BUILDING_NO"}, // 
		{"data" : "BUILDING_NAME"}, // 
		{"data" : "BUILDING_FLOORS"}, // 
		{"data" : "BUILDING_ADDR"}, // 
		{"data" : "BUILDING_TYPE"}, // 
		{"data" : "BUILDING_STRUCTURE"}, // 
		{"data" : "BUILDING_TOWARD"}, // 
		{"data" : "CREATE_DATE"}, // 
		{"data" : "REMARK"} // 
		];
// 设置哪些列不进行排序  哪些列需排序（需要改sql xml条件）
var aoColumnParam = [0],aaSortParam = [];
$(function(){
	// 加载列表信息 initTableAutoHeight(id,url,param,colsParam,aoColumnParam,aaSortParam,other); 
	// param Ajax请求时发送额外的数据(条件),colsParam 设置列属性条件,aoColumnParam 设置哪些列不排序  aaSortParam设置哪些列排序
	table = initTableAutoHeight("building_list_table", "${ctxPath}/topic/page/qryBuildingList", null,cols,aoColumnParam,aaSortParam,"ID",getScreen());
});

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

/* 新增楼宇弹窗 */
function toAddBuilding(){
	index = layer.open({
	    type: 2, 
	    title : "新增楼宇信息",
	    area: ['65%', '61%'],
	    fix: false, //不固定
	   // maxmin: true,
	    content: _contextPath+"/topic/toAddBuilding"
	});
}

/* 修改楼宇信息 */
function toEditBuilding(){
	var b_id = $("#clickId").val()?$("#clickId").val():"";
	if(b_id){
		index = layer.open({
		    type: 2, 
		    title : "修改楼宇信息",
		    area: ['65%', '61%'],
		    fix: false, //不固定
		   // maxmin: true,
		    content: _contextPath+"/topic/toEditBuilding?b_id="+b_id
		});
	}else{
		layer.alert("请选择一条记录！", {icon: 2}, function(index){
			layer.close(index);
		});  
	}
}
/* 删除楼宇信息 */
function delBuilding(){
	var b_id = $("#clickId").val()?$("#clickId").val():"";
	if(b_id){
		layer.confirm('您确定要删除这条记录吗?', {icon: 3, title:'提示'}, function(index){
			 $.ajax({
					url : "${ctxPath }/topic/ajax/delBuildingInfo",
					dataType : "json",
					type : "post",
					data:{"b_id":b_id},
					success : function(json) {
						if (json.result == '1') {
							layer.alert(json.resultInfo, function(index){
								//刷新表格，关闭弹窗
								searchForm();
								layer.close(index);
							});  
						} else {
							layer.alert(json.resultInfo,{icon: 2}, function(index){
								layer.close(index);
							});  
							return;
						}
				}});
		});
	}else{
		layer.alert("请选择一条记录！", {icon: 2}, function(index){
			layer.close(index);
		});  
	}
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