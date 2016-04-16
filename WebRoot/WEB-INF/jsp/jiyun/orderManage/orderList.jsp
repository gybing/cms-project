<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>业务接单管理</title>
<jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
</head>
<body class="gray-bg" >
    <div class="wrapper wrapper-content animated fadeInRight" >
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
						<form class="form-horizontal" id="orderSearchForm">
							<input type="hidden" id="clickId" name="clickId">
							<table class="dataTables_scrollBody" style="width: 80%;border: 0px;">
								<tr style="line-height: 28px;">
									<td><label class="control-label">提 单 号:</label></td>
									<td><input style="width: 150px" type="text"
										placeholder="请输入提单号" id="S_ORDER_NO" name="ORDER_NO"
										value="${param.ORDER_NO }"></td>
									<td><label class="control-label">箱主: </label></td>
									<td><div class="input-group" id="boxOwnner1"></div></td>
									<td><label class="control-label">铅封号:</label></td>
									<td><input style="width: 150px" type="text"
										placeholder="请输入铅封号" id="S_SEAL_NO" name="SEAL_NO" value="${param.SEAL_NO }" class=""></td>
									<td><label class="control-label">货主:</label></td>
									<td><div class="input-group" id="cargoOwner"></div></td>

								</tr>
								<tr style="line-height: 28px;">
									<td><label class="control-label">订单状态:</label></td>
									<td>
										<select class="combox" id="S_IS_FINISH" name="S_IS_FINISH" style="width: 150px;"><option value="">请选择</option></select>
									</td>
									<td><label class="control-label">船名:</label></td>
									<td><div class="input-group" id="shipName"></div></td>
									<td><label class="control-label">航次: </label></td>
									<td><input style="width: 150px" type="text" class=""
										placeholder="请输入航次" id="S_SHIP_VOYAGE" name="SHIP_VOYAGE"
										value="${param.SHIP_VOYAGE }"></td>
									<td><label class="control-label">船期: </label></td>
									<td>
										<input style="width: 150px" type="text" class="form-control layer-date" id="S_SHIP_DATE" name="S_SHIP_DATE" 
											value="${param.S_SHIP_DATE }" 
											placeholder="YYYY-MM-DD" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" />
									</td>
								</tr>
								<tr style="line-height: 28px;">
									<td><label class="control-label">万能搜索:</label></td>
									<td><input type="text" style="width: 150px"
										placeholder="请输入关键字" id="S_KEYWORD" name="KEYWORD"
										value="${param.KEYWORD }"></td>
									<td colspan="2">	
										<button type="button" class="btn btn-sm btn-primary " onclick="searchForm();">查    询</button>
				 						<button type="button" class="btn btn-sm btn-primary " onclick="resetForm('orderSearchForm');">重    置</button>
				 						<button type="button" class="btn btn-sm btn-primary " onclick="refreshForm('orderSearchForm');">刷    新</button>
									</td>
								</tr>
							</table>
						</form>
						<div class="ibox-content widget-content nopadding float-e-margins">	
							<div id="orderToolbar" style=" float:left; padding: 5px 5px;">
								<button type="button" class="btn btn-outline btn-default" onclick="addOrder();">
									<i class="glyphicon glyphicon-plus"></i> 新增
								</button>
								<button type="button" class="btn btn-outline btn-default" onclick="editOrder();">
									<i class="glyphicon glyphicon-edit"></i> 修改
								</button>
								<button type="button" class="btn btn-outline btn-default" onclick="delOrder();">
									<i class="glyphicon glyphicon-remove"></i> 删除
								</button>
								<button type="button" class="btn btn-outline btn-default" onclick="tzOrder();">
									<i class="glyphicon glyphicon-trash"></i> 退载
								</button>
								<button type="button" class="btn btn-outline btn-default" onclick="doPrint();"> 
									<i class="glyphicon glyphicon-print"></i> 打印
								</button>
								<button type="button" class="btn btn-outline btn-default" onclick="toReserve('1');"> 
									<i class="glyphicon glyphicon-time"></i> 预约
								</button>
								<button type="button" class="btn btn-outline btn-default" onclick="toReserve('0');"> 
									<i class="glyphicon glyphicon-time"></i> 取消预约
								</button>
							</div>
							<table id="OrderList" class="table table-striped table-bordered table-hover data-table with-check">
								<thead>
									<tr align="center">
										<!-- <th><input type="checkbox" data-type="oCheckAll">预约</th> -->
										<th>序号</th>
										<th>进出类型</th>
										<th>运单状态</th>
										<th>提单号</th>
										<th>出货单号</th>
										<th>是否预约</th>
										<th>船名</th>
										<th>航次</th>
										<th>船期</th>
										<th>货主</th>
										<th>箱主</th>
										<th>详细地址</th>
										<th>装运港</th>
										<th>箱量(尺寸箱规*数量)</th>
										<th>费用合计(元)</th>
										<th>费用备注</th>
										<th>拖箱地区</th>
										<th>提箱地点</th>
										<th>返箱地点</th>
										<th>付款方</th>
										<th>装货联系电话</th>
										<th>接单备注</th>
										<th>目的港</th>
									</tr>
								</thead>
								<tbody></tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var table, num=0, cols = [
				{
					"data" : "NUM",
					"render" : function(data) {
						return "<div align='center'>" + data + "</div>";
					}
				},
				/* {
					"data" : "",
					"render" : function() {
						num=num%table.page.len()+1;
						return "<div align='center'>" + (table.page()*table.page.len()+num) + "</div>";
					}
				
				}, */
				{
					"data" : "INO",
					"render" : function(data) {
						if (data == "进口") {
							return "<div class='label label-primary' >进&nbsp;&nbsp;口</div>";
						} else if (data == "出口") {
							return "<div class='label label-success' >出&nbsp;&nbsp;口</div>";
						} else if (data == "移场") {
							return "<div class='label label-info' >移&nbsp;&nbsp;场</div>";
						} else if (data == "内部进口") {
							return "<div class='label label-warning' >内部进口</div>";
						} else if (data == "内部出口") {
							return "<div class='label label-danger' >内部出口</div>";
						} else {
							return data;
						}
					}
				},
				{
					"data" : "ISFINISH",  //运单是否完成. N 未完成. Y 已完成.  T 退载
					"render" : function(data,type,full) {
						var t = "label-info",html = "<input type='hidden' id='orderSta' value='"+ full.IS_FINISH +"' />";
						if (data == "未完成") {
							t = "label-danger";
						} else if (data == "已完成") {
							t = "label-success";
						}else{
							data = "退&nbsp;载";
						}
						return html+"<div class='label "+ t +"'>"+ data + "</div>";
					}
				},
				{"data" : "ORDER_NO"},
				{"data" : "SHIPMENT_NO"},
				{
					"data" : "IS_RESERVE",
					"render" : function(data) {
						data = data==""?"0":data;
						var html = "<input type='hidden' id='IS_RESERVE' value='"+ data +"' />";
						return data == 1 ? html+"√" : html+"";
					}
				},
				{"data" : "SHIP_NAME"},
				{"data" : "SHIP_VOYAGE"},
				{"data" : "SHIP_DATE"},
				{"data" : "CARGO_OWNNER"},
				{"data" : "BOXOWNNER1"},
				{"data" : "ADDR"},
				{"data" : "LOADPORT"},
				{"data" : "BOX_NUMS"},
				{"data" : "ALL_COST"},
				{"data" : "FEE_REMARK"},
				{"data" : "BOXDRAGAREA"},
				{"data" : "BOXTAKE"},
				{"data" : "BOXRETURN"},
				{"data" : "PAYER"},
				{"data" : "LOAD_CONTACT"},
				{"data" : "ORDER_REMARK"},
				{"data" : "TOPORT"}];
		// 设置哪些列不进行排序aoColumnParam   哪些列需排序（需要改sql xml条件） aaSortParam（aoColumnParam放空，aaSortParam也为空时默认全部有排序）
		var sortParam = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
				16, 17, 18, 19, 20 ], columnParam = [0];
		$(function() {
			$s.init($C("#boxOwnner1"), {//箱主
				tabdict : "box_ownner",
				vID : "S_BOX_OWNNER_1"
			});

			$s.init($C("#shipName"), {//船名
				tabdict : "ship_name",
				vID : "S_SHIP_NAME"
			});
			$s2.init($C("#S_IS_FINISH"), {//运单状态
				sysdict : $sysdict.ORDERTYPE
			});
			$s.init($C("#cargoOwner"), {//货主
				tabdict : "cargo_owner",
				vID : "S_CARGO_OWNER_ID"
			});
			// 加载列表信息 initTable(id,Order,param,colsParam,aoColumnParam,aaSortParam,other); 
			// param Ajax请求时发送额外的数据(条件),colsParam 设置列属性条件,columnParam 设置哪些列不排序  sortParam设置哪些列排序
			//table = initTable("OrderList","${ctxPath}/topic/page/toOrderList?", null, cols,columnParam, sortParam, 'ORDER_ID',true);
			table = initTableAutoHeight("OrderList", "${ctxPath}/topic/page/toOrderList?", null,cols,null,null,"ORDER_ID");
			$("#OrderList").on( 'dblclick', 'tr', function () {  //双击列表行 跳转至修改页面
				editOrder();
        	});
			// 全选 全不选  data-type
			checkAll("oCheckAll");
		});

		//添加订单
		function addOrder() {
			/**
			 * 跳转页面  iUrl请求url  iTitletab标签名
			 */
			indexToPage("${ctxPath }/topic/toAddOrderPage", "新增订单");
		}
		//编辑订单
		function editOrder() {
			var params = [];
			if (!isEmpty($("#clickId").val())) {
				params = [ {
					ORDER_ID : $("#clickId").val()
				} ];
			}/*  else {
				$("input[data-type='subOCheck']:checked").each(function(i) {
					if (this.checked) {
						params[i] = {
							ORDER_ID : $(this).val()
						};
					}
				});
			} */
			/**
			 * 修改信息 iUrl请求url param参数 (数组)eg:params = [{unid:"2"}]  iTitletab标签名
			 */
			editForm("${ctxPath }/topic/toEditOrderPage", params, "编辑订单");
		}
		//删除订单
		function delOrder() {
			var params = [],ORDER_ID = $("#clickId").val();
			if (!isEmpty(ORDER_ID)) {
				params = [ {
					ORDER_ID : ORDER_ID
				} ];
			}/*  else {
				$("input[data-type='subOCheck']:checked").each(function(i) {
					if (this.checked) {
						params[i] = {
							ORDER_ID : $(this).val()
						};
					}
				});
			} */
			// 判断是否已退载 或者已完成
			var ok = false,sta = "";
			$("#OrderList tbody tr").each(function(){
				sta = $(this).find('td #orderSta').val();
				if($(this).data("id") == ORDER_ID && sta == 'Y'){  //(sta == 'T' || sta == 'Y')){
					ok = true;
					return false;
				}
			});
			if(ok){
				swal("", "该订单已完成，不能删除！", "warning");
				return;
			}

			/**
			 * 删除记录，支持批量删除（参数格式必须为数组） iUrl请求url iText提示的文本信息（只需关键字）
			 * params参数 数组eg:params = [{unid:"2"},{unid:"1"}] callBack回调函数 刷新列表页
			 */
			delForm("${ctxPath }/topic/ajax/delOrder?T=del", "删除", params, searchForm);
		}
		
		// 退载订单
		function tzOrder() {
			var params = [],ORDER_ID = $("#clickId").val();
			if (!isEmpty($("#clickId").val())) {
				params = [ {
					ORDER_ID : ORDER_ID
				} ];
			}/*  else {
				$("input[data-type='subOCheck']:checked").each(function(i) {
					if (this.checked) {
						params[i] = {
							ORDER_ID : $(this).val()
						};
					}
				});
			} */
			
			// 判断是否已退载
			var ok = false;
			$("#OrderList tbody tr").each(function(){
				if($(this).data("id") == ORDER_ID && $(this).find('td #orderSta').val() == 'T'){
					ok = true;
					return false;
				}
			});
			if(ok){
				swal("", "该订单已退载，无需重复操作！", "warning");
				return;
			}
			/**
			 * 删除记录，支持批量删除（参数格式必须为数组） iUrl请求url iText提示的文本信息（只需关键字）
			 * params参数 数组eg:params = [{unid:"2"},{unid:"1"}] callBack回调函数 刷新列表页
			 */
			operForm("${ctxPath}/topic/ajax/tzOrder?T=tz", "退载", params,searchForm);
		}
		
		// 预约 1/取消 预约 0
		function toReserve(tag){
			var params = [],ORDER_ID = $("#clickId").val(),tag_name = "预约",msg = "已预约";
			// 判断是否 预约或者无预约
			var ok = false;
			if(tag == "0"){//取消 预约
				tag_name = "取消预约";
				msg = "无预约";
			}
			$("#OrderList tbody tr").each(function(){
				if($(this).data("id") == ORDER_ID && $(this).find('td #IS_RESERVE').val() == tag){
					ok = true;
					return false;
				}
			});
			if(ok){
				swal("", "该订单"+ msg +"，无需重复操作！", "warning");
				return;
			}
			if (!isEmpty($("#clickId").val())) {
				params = [ {ORDER_ID : ORDER_ID} ];
			}
			operForm("${ctxPath}/topic/ajax/toOrderReserve?IS_RESERVE="+tag, tag_name, params,searchForm);
		}
		
		/* 搜索 查询 */
		function searchForm() {
			$("#clickId").val(""); //清除之前选中的id
			table.column(0).search($('#S_ORDER_NO').val());
			table.column(1).search($('#S_BOX_OWNNER_1').val());
			table.column(2).search($('#S_SEAL_NO').val());
			table.column(3).search($('#S_SHIP_NAME').val());
			table.column(4).search($('#S_SHIP_VOYAGE').val());
			table.column(5).search($('#S_SHIP_DATE').val());
			table.column(6).search($('#S_IS_FINISH').val());
			table.column(7).search($('#S_CARGO_OWNER_ID').val());
			table.column(8).search($('#S_KEYWORD').val());
			table.draw();
		}
		//打印
		function doPrint() {
			var params = [];
			if(!isEmpty($("#clickId").val())) {
				params = [{ORDER_ID:$("#clickId").val()}];
			} 
			var sLength = params.length,param="",key = "";
			if (isEmpty(params) || sLength == 0 || params[0] == '') {
				swal("", "请选择一条信息进行打印!", "warning");
				return;
			}else if(sLength > 1){
				swal("", "只能选择一条信息进行打印!", "warning");
				return;
			}
			$.each(params[0], function(i) {
			    param = params[0][i],key = i;
			});
			//打开新tab页 iUrl ajax执行url,iTitle tab标签名,dataId 标签data_id（用于关闭刷新标签页）
			window.parent.newTab("${ctxPath}/topic/toPrintOrderPage"+"?pdataId="+ window.parent.getDataId() +"&"+ key +"="+ param,"打印订单信息");	
		}
	</script>
</body>
</html>