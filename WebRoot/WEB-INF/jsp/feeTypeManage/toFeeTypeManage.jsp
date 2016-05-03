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
							<form class="form-horizontal" id="fee_type_list_form">
							<input type="hidden" id="clickId" name="clickId">
								<div class="ibox">
									<div class="form-group">
										<label class="col-sm-1 control-label">费用代码:</label>
										<div class="col-sm-2">
											<input id="fee_type_code" name="fee_type_code" maxlength="14" type="text" class="required" aria-required="true" />
										</div>
										<label class="col-sm-1 control-label">费用名称:</label>
										<div class="col-sm-2">
											<input id="type_name" name="type_name" maxlength="20" type="text" class="required" aria-required="true" />
										</div>
										<div class="col-sm-3">
											<button type="button" class="btn btn-sm btn-primary " onclick="searchForm();">查    询</button>
											<button type="button" class="btn btn-sm btn-primary " onclick="resetForm('fee_type_list_form');">重    置</button>
											<button type="button" class="btn btn-sm btn-primary " onclick="refreshForm('fee_type_list_form');">刷    新</button>
										</div>
									</div>
								</div>
							</form>
							<div class="ibox-content widget-content nopadding float-e-margins">
								<div id="orderToolbar" style=" float:left; padding: 5px 5px;">
									<button type="button" class="btn btn-outline btn-default" onclick="toAddFeeType();">
										<i class="glyphicon glyphicon-plus"></i> 新增
									</button>
									<button type="button" class="btn btn-outline btn-default" onclick="toEditfeeType();">
										<i class="glyphicon glyphicon-edit"></i> 修改
									</button>
									<button type="button" class="btn btn-outline btn-default" onclick="delfeeType();">
										<i class="glyphicon glyphicon-remove"></i> 删除
									</button>
								</div>
							</div>
							<table id="fee_type_list_table" class="table table-striped table-bordered table-hover data-table with-check">
								<thead>
									<tr align="center">
										<th width="50px">序号</th>
										<th>费用编号</th>
										<th>费用名称</th>
										<th>收费方式</th>
										<th>计费方式</th>
										<th>收费类型</th>
										<th>计费周期数</th>
										<th>计费周期单位</th>
										<th>收费单价</th>
										<th>收费单位</th>
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
		{"data" : "FEE_TYPE_CODE"}, // 
		{"data" : "TYPE_NAME"}, // 
		{"data" : "PAY_WAY"}, // 
		{"data" : "COUNT_TYPE"}, // 
		{"data" : "PAY_TYPE"}, // 
		{"data" : "PAY_CYCLE"}, // 
		{"data" : "CYCLE_UNIT"}, // 
		{"data" : "PAY_PRICE"}, // 
		{"data" : "UNIT"} // 
		];
// 设置哪些列不进行排序  哪些列需排序（需要改sql xml条件）
var aoColumnParam = [0],aaSortParam = [];
$(function(){
	// 加载列表信息 initTableAutoHeight(id,url,param,colsParam,aoColumnParam,aaSortParam,other); 
	// param Ajax请求时发送额外的数据(条件),colsParam 设置列属性条件,aoColumnParam 设置哪些列不排序  aaSortParam设置哪些列排序
	table = initTableAutoHeight("fee_type_list_table", "${ctxPath}/topic/page/qryFeeTypeList", null,cols,aoColumnParam,aaSortParam,"ID");
});

/* 搜索 查询 */
function searchForm() {
	$("#clickId").val(""); //清除之前选中的id
	table.column(0).search($('#fee_type_code').val());
	table.column(1).search($('#type_name').val());
	table.draw();
}

/* 新增费用类型弹窗 */
function toAddFeeType(){
	index = layer.open({
	    type: 2, 
	    title : "新增费用类型信息",
	    area: ['65%', '61%'],
	    fix: false, //不固定
	   // maxmin: true,
	    content: _contextPath+"/topic/toAddFeeType"
	});
}

/* 修改费用类型信息 */
function toEditfeeType(){
	var fee_id = $("#clickId").val()?$("#clickId").val():"";
	if(fee_id){
		index = layer.open({
		    type: 2, 
		    title : "修改费用类型信息",
		    area: ['65%', '61%'],
		    fix: false, //不固定
		   // maxmin: true,
		    content: _contextPath+"/topic/toEditfeeType?fee_id="+fee_id
		});
	}else{
		layer.alert("请选择一条记录！", {icon: 2}, function(index){
			layer.close(index);
		});  
	}
}
/* 删除费用类型信息 */
function delfeeType(){
	var fee_id = $("#clickId").val()?$("#clickId").val():"";
	if(fee_id){
		layer.confirm('您确定要删除这条记录吗?', {icon: 3, title:'提示'}, function(index){
			 $.ajax({
					url : "${ctxPath }/topic/ajax/delfeeTypeInfo",
					dataType : "json",
					type : "post",
					data:{"f_id":fee_id},
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

</script>
</html>