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
							<form class="form-horizontal" id="payment_list_form">
							<input type="hidden" name="fee_name" id="fee_name" /> <!-- 费用名称 -->
							<input type="hidden" id="clickId" name="clickId">
								<div class="ibox">
									<div class="form-group">
										<label class="col-sm-1 control-label">住户姓名:</label>
										<div class="col-sm-2">
											<input id="user_name" name="user_name" maxlength="14" type="text" class="required" aria-required="true" />
										</div>
										<label class="col-sm-1 control-label">住户地址:</label>
										<div class="col-sm-2">
											<input id="move_addr" name="move_addr" maxlength="14" type="text" class="required" aria-required="true" />
										</div>
										<label class="col-sm-1 control-label">费用名称:</label>
										<div class="col-sm-2">
											<select class="combox" id="pay_type" name="pay_type"><option value="">请选择</option></select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-1 control-label">缴费时间（起）:</label>
										<div class="col-sm-2">
											<input type="text" class="form-control layer-date" id="pay_date_start" name="pay_date_start" value="${param.PAY_DATE_START }" placeholder="YYYY-MM-DD"  onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" />
										</div>
										<label class="col-sm-1 control-label">缴费时间（止）:</label>.
										<div class="col-sm-3">
											<input type="text" class="form-control layer-date" id="pay_date_end" name="pay_date_end" value="${param.PAY_DATE_END }" placeholder="YYYY-MM-DD"  onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" />
										</div>
										<div class="col-sm-3">
											<button type="button" class="btn btn-sm btn-primary " onclick="searchForm();">查    询</button>
											<button type="button" class="btn btn-sm btn-primary " onclick="resetForm('payment_list_form');">重    置</button>
											<button type="button" class="btn btn-sm btn-primary " onclick="refreshForm('payment_list_form');">刷    新</button>
										</div>
									</div>
								</div>
							</form>
							<div class="ibox-content widget-content nopadding float-e-margins">
								<div id="orderToolbar" style=" float:left; padding: 5px 5px;">
									<button type="button" class="btn btn-outline btn-default" onclick="toAddFee();">
										<i class="glyphicon glyphicon-plus"></i> 新增
									</button>
									<button type="button" class="btn btn-outline btn-default" onclick="toEditFee();">
										<i class="glyphicon glyphicon-edit"></i> 修改
									</button>
									<button type="button" class="btn btn-outline btn-default" onclick="delFee();">
										<i class="glyphicon glyphicon-remove"></i> 删除
									</button>
								</div>
							</div>
							<table id="payment_list_table" class="table table-striped table-bordered table-hover data-table with-check">
								<thead>
									<tr align="center">
										<th width="50px">序号</th>
										<th>住户姓名</th>
										<th>住户地址</th>
										<th>费用名称</th>
										<th>计费方式</th>
										<th>起始时间</th>
										<th>结束时间</th>
										<th>收费单价</th>
										<th>总量</th>
										<th>合计</th>
										<th>缴费时间</th>
										<th>是否缴清</th>
										<th>操作员</th>
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
//初始化费用类型下拉框
$s2.init($C("#pay_type"), {
	tabdict : "pay_type",
	defVal:'${param.fee_name}'
});

var table;
var cols = [
		{"data" : "NUM",// 序号
			"render" : function(data) {
				return "<div align='center' style='width:50px'>" + data + "</div>";
		}},
		{"data" : "USER_NAME"}, // 
		{"data" : "MOVE_ADDR"}, // 
		{"data" : "FEE_NAME"}, // 
		{"data" : "COUNT_TYPE"}, // 
		{"data" : "BEGIN_DATE"}, // 
		{"data" : "END_DATE"}, // 
		{"data" : "PAY_PRICE"}, // 
		{"data" : "TOTAL"}, // 
		{"data" : "TOTAL_PRICE"}, // 
		{"data" : "PAY_DATE"}, // 
		{"data" : "IS_COMPLETED",
			"render":function(data){
				if(data == '1'){
					return "是";
				}else{
					return "";
				}
		}}, // 
		{"data" : "OP_USER"}, // 
		{"data" : "REMARK"} // 
		];
// 设置哪些列不进行排序  哪些列需排序（需要改sql xml条件）
var aoColumnParam = [0],aaSortParam = [];
$(function(){
	// 加载列表信息 initTableAutoHeight(id,url,param,colsParam,aoColumnParam,aaSortParam,other); 
	// param Ajax请求时发送额外的数据(条件),colsParam 设置列属性条件,aoColumnParam 设置哪些列不排序  aaSortParam设置哪些列排序
	table = initTableAutoHeight("payment_list_table", "${ctxPath}/topic/page/qryPaymentList", null,cols,aoColumnParam,aaSortParam,"ID",getScreen());
	
	//根据选择的费用类型，加载对应费用类型相关信息
	$("#pay_type").change(function(){
		$("#fee_name").val($("#pay_type option:selected").text() != '请选择'?$("#pay_type option:selected").text():"");
	});

});

/* 搜索 查询 */
function searchForm() {
	$("#clickId").val(""); //清除之前选中的id
	table.column(0).search($('#user_name').val());
	table.column(1).search($('#move_addr').val());
	table.column(2).search($('#fee_name').val());
	table.column(3).search($('#pay_date_start').val());
	table.column(4).search($('#pay_date_end').val());
	table.draw();
}

/* 新增缴费弹窗 */
function toAddFee(){
	index = layer.open({
	    type: 2, 
	    title : "新增缴费信息",
	    area: ['95%', '87%'],
	    fix: false, //不固定
	   // maxmin: true,
	    content: _contextPath+"/topic/toAddFee"
	});
}

/* 修改缴费信息 */
function toEditFee(){
	var b_id = $("#clickId").val()?$("#clickId").val():"";
	if(b_id){
		index = layer.open({
		    type: 2, 
		    title : "修改缴费信息",
		    area: ['65%', '61%'],
		    fix: false, //不固定
		   // maxmin: true,
		    content: _contextPath+"/topic/toEditFee?b_id="+b_id
		});
	}else{
		layer.alert("请选择一条记录！", {icon: 2}, function(index){
			layer.close(index);
		});  
	}
}
/* 删除缴费信息 */
function delFee(){
	var b_id = $("#clickId").val()?$("#clickId").val():"";
	if(b_id){
		layer.confirm('您确定要删除这条记录吗?', {icon: 3, title:'提示'}, function(index){
			 $.ajax({
					url : "${ctxPath }/topic/ajax/delFeeInfo",
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