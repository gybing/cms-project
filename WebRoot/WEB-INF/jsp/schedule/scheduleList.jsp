<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>调度管理列表页</title>
    <jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
 
</head>

<body class="gray-bg" >
    <div class="wrapper wrapper-content animated fadeInRight" >
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                    	<form class="form-horizontal form-search" id="scheduleSerach">
                    		<!-- 导出报表的字段名 titles js方法 getTitleInfo 获取 -->
			                <!-- 导出报表的列名 titleNames js方法 getTitleInfo 获取  -->
			                <!-- 导出报表的类型 xls/xlsx -->
			                <input type="hidden" id="ALL_EXAMINE_EXPORT_EXPORTTYPE" name="exportType" value="2007"/> 
			                <!-- 导出报表的表名 -->
			                <input type="hidden" id="ALL_EXAMINE_EXPORT_FILENAME" name="fileName" value="调度管理列表"/> 
                   			<input type="hidden" id="clickId" name="clickId">
                   			<table>
                   				<tr style="line-height: 30px;">
                   					<td><label class=" control-label">检索：</label></td>
                   					<td> <div class="input-group" id="AA_SSTJ"></div>
                   						<select name="SSTJ" id="SSTJ"  class="form-control "  style="width: 80px;">
											<option value="">请选择</option>
											<option value="TDH" <c:if test='${param.SSTJ eq "TDH"}'>selected="selected"</c:if> >提单号</option>
											<option value="XH" <c:if test='${param.SSTJ eq "XH"}'>selected="selected"</c:if> >箱号</option>
											<option value="QFH" <c:if test='${param.SSTJ eq "QFH"}'>selected="selected"</c:if> >铅封号</option>
											<option value="CC" <c:if test='${param.SSTJ eq "CC"}'>selected="selected"</c:if> >尺寸</option>
											<option value="XG" <c:if test='${param.SSTJ eq "XG"}'>selected="selected"</c:if> >箱规</option>
											<option value="CM" <c:if test='${param.SSTJ eq "CM"}'>selected="selected"</c:if> >船名</option>
											<option value="CQ" <c:if test='${param.SSTJ eq "CQ"}'>selected="selected"</c:if> >船期</option>
											<option value="HC" <c:if test='${param.SSTJ eq "HC"}'>selected="selected"</c:if> >航次</option>
											<option value="TXDD" <c:if test='${param.SSTJ eq "TXDD"}'>selected="selected"</c:if> >提箱地点</option>
											<option value="FXDD" <c:if test='${param.SSTJ eq "FXDD"}'>selected="selected"</c:if> >返箱地点</option>
											<option value="CP" <c:if test='${param.SSTJ eq "CP"}'>selected="selected"</c:if> >车牌</option>
											<option value="CJ" <c:if test='${param.SSTJ eq "CJ"}'>selected="selected"</c:if> >车架</option>
											<option value="XZ" <c:if test='${param.SSTJ eq "XZ"}'>selected="selected"</c:if> >箱主</option>
										</select>
										<input type="text" id="SSTJ_VALUE" name="SSTJ_VALUE" value="${param.SSTJ_VALUE }" placeholder="请输入检索条件" class="" style="width: 150px">
									</td>
                   					<td style="width: 61px;padding-left: 12px;"><label class=" control-label">派车时间：</label></td>
                   					<td>
                   						<!-- <input type="text" class="form-control layer-date" id="PCSJ" name="PCSJ"  placeholder="YYYY-MM-DD" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})"> -->
                   						<select name="PCSJ" id="PCSJ"  class="form-control" style="width: 150px;">
                   							<option value="">请选择</option>
                   							<option value="TODAY" <c:if test='${param.PCSJ eq "TODAY"}'>selected="selected"</c:if> >当日</option>
                   							<option value="YESTODAY" <c:if test='${param.PCSJ eq "YESTODAY"}'>selected="selected"</c:if> >次日</option>
                   							<option value="WEEK" <c:if test='${param.PCSJ eq "WEEK"}'>selected="selected"</c:if> >本周</option>
                   						</select>
                   					</td>
                   					<td style="width: 61px;padding-left: 12px;"><label class=" control-label">状态：</label></td>
                   					<td>
                   						 <select name="SSTJ_ZT" id="SSTJ_ZT"  class="form-control" style="width: 150px;">
											<option value="">请选择</option>
											<option value="WZX" <c:if test='${param.SSTJ_ZT eq "WZX"}'>selected="selected"</c:if> >未执行</option>
											<option value="ZXZ" <c:if test='${param.SSTJ_ZT eq "ZXZ"}'>selected="selected"</c:if> >执行中</option>
											<option value="YZX" <c:if test='${param.SSTJ_ZT eq "YZX"}'>selected="selected"</c:if> >已执行</option>
											<option value="YT" <c:if test='${param.SSTJ_ZT eq "YT"}'>selected="selected"</c:if> >已提</option>
											<option value="YS" <c:if test='${param.SSTJ_ZT eq "YS"}'>selected="selected"</c:if> >已送</option>
											<option value="YH" <c:if test='${param.SSTJ_ZT eq "YH"}'>selected="selected"</c:if> >已回</option>
											<option value="TZ" <c:if test='${param.SSTJ_ZT eq "TZ"}'>selected="selected"</c:if> >退装</option>
											<%-- <option value="YT" <c:if test='${param.SSTJ_ZT eq "YT"}'>selected="selected"</c:if> >已提/运作中</option>
											<option value="YS" <c:if test='${param.SSTJ_ZT eq "YS"}'>selected="selected"</c:if> >已送/运作中</option>
											<option value="YH" <c:if test='${param.SSTJ_ZT eq "YH"}'>selected="selected"</c:if> >已回/运作中</option>
											<option value="YJC" <c:if test='${param.SSTJ_ZT eq "YJC"}'>selected="selected"</c:if> >已进场/已完成</option>
											<option value="WYZ" <c:if test='${param.SSTJ_ZT eq "WYZ"}'>selected="selected"</c:if> >未运作</option>
											<option value="DR" <c:if test='${param.SSTJ_ZT eq "DR"}'>selected="selected"</c:if> >当日</option>
											<option value="CR" <c:if test='${param.SSTJ_ZT eq "CR"}'>selected="selected"</c:if> >次日</option>
											<option value="BZ" <c:if test='${param.SSTJ_ZT eq "BZ"}'>selected="selected"</c:if> >本周</option>
											<option value="YC" <c:if test='${param.SSTJ_ZT eq "YC"}'>selected="selected"</c:if> >移场</option> --%>
										  </select>
									</td>
									<td rowspan="2" style="padding-left: 20px">	
										<button type="button" class="btn btn-sm btn-primary " onclick="searchForm();">查    询</button>
				 						<button type="button" class="btn btn-sm btn-primary " onclick="resetForm('scheduleSerach');">重    置</button>
			 						</td>
                   				</tr>
                   				<tr style="line-height: 30px;">
                   					<td> <label  class=" control-label">万能搜索：</label></td>
                   					<td colspan="1">	<input type="text" id="WNSS" name="WNSS" value="${param.WNSS }" placeholder="请输入关键词" style="width: 233px;margin-top: 5px"></td>
                   					<td colspan="4"><div id="sumNum" class="col-sm-6" style="margin-top:5px"></div></td>
             
                   					
                   				</tr>
                   			</table>
                        </form>
                         <div class="ibox-content widget-content nopadding float-e-margins">          
                        	<div id="toolbar" style=" float:left; padding: 5px 5px;">
	                        	<button type="button" class="btn btn-outline btn-default" onclick="editSchedule()"> <i class="glyphicon glyphicon-edit"></i> 修改</button>
	                        	<button type="button" class="btn btn-outline btn-default" onclick="searchForm()"> <i class="glyphicon glyphicon-repeat"></i> 刷新</button>
	                        	<button type="button" class="btn btn-outline btn-default" onclick="exportExecel()"> <i class="glyphicon glyphicon-share"></i> 导出EXCEL</button>
	                        	<button type="button" class="btn btn-outline btn-default" onclick="doPrint()"> <i class="glyphicon glyphicon-print"></i> 打印</button>
	                      		<button type="button" class="btn btn-outline btn-default" onclick="toReserve('1');"><i class="glyphicon glyphicon-time"></i> 预约 </button>
								<button type="button" class="btn btn-outline btn-default" onclick="toReserve('0');"><i class="glyphicon glyphicon-time"></i> 取消预约</button>
	                    		<!-- <a onclick="editSchedule();" href="javascript:void(0);" class="btn btn-sm btn-primary"><i class="glyphicon glyphicon-edit"></i> 修改</a>
	                    		<a onclick="searchForm();" href="javascript:void(0);" class="btn btn-sm btn-success"><i class="glyphicon glyphicon-repeat"></i> 刷新</a>
	                    		<a onclick="exportExecel();" href="javascript:void(0);" class="btn btn-sm btn-info"><i class="glyphicon glyphicon-share"></i> 导出EXCEL</a>
	                    		<a onclick="doPrint();" href="javascript:void(0);" class="btn btn-sm btn-warning"><i class="glyphicon glyphicon-print"></i> 打印</a> -->
               				</div>
						<table id="ScheduleDataList" class="table table-striped table-bordered table-hover data-table with-check" >
                            <thead>
                                <tr style="text-align:center;">
                               	 	<th title="序号,NUM">序号</th>
									<th title="任务状态,SCHEDULE_STATUS">任务状态</th>
									<th title="调度名称,COMMAND">调度名称</th>
									<th title="预约送箱日期,BOOK_SEND_DATE">预约送箱日期</th>
									<th title="进出类型,IN_OUT">进出类型</th>
									<th title="调度备注,SCHEDULE_REMARK">调度备注</th>
									<th title="甩柜,SHUAIGUI">甩柜</th>
									<th title="提箱,SF_TX">回箱</th>
									<th title="是否预约,IS_RESERVE">是否预约</th>
									<th title="车架,TRUCK_FRAME">车架</th>
									<th title="货主,CARGO_OWNNER">货主</th>
									<th title="提单号,ORDER_NO">提单号</th>
									<th title="船名,SHIP_NAME">船名</th>
									<th title="航次,SHIP_VOYAGE">航次</th>
									<th title="船期,SHIP_DATE">船期</th>
									<th title="箱号,NO">箱号</th>
									<th title="铅封号,SEAL_NO">铅封号</th>
									<th title="尺寸,SIZE">尺寸</th>
									<th title="箱规,SPEC">箱规</th>
									<th title="箱主,BOX_OWNNER_1">箱主</th>
									<th title="提箱地点,BOX_TAKE">提箱地点</th>
									<th title="目的港,TO_PORT">目的港</th>
									<th title="拖箱地点,BOX_DRAG">拖箱地点</th>
									<th title="详细地址,ADDR">详细地址</th>
									<th title="装运港,LOAD_PORT">装运港</th>
									<th title="出货单号,SHIPMENT_NO">出货单号</th>
									<th title="装货联系方式,LOAD_CONTACT">装货联系方式</th>
									<th title="派车时间,SEND_TIME">派车时间</th>
									
									<!-- 列表项修改 2016年3月24日 16:41:07  -->
									<!-- <th title="车牌,TRUCK_PLATE">车牌</th>
									<th title="双拖,SHUANGTUO">双拖</th>
									<th title="终点,TONAME">终点</th>
									<th title="提箱,SF_TX">提箱</th>
									<th title="调度编号,TX_SCHEDULE_NO">调度编号</th>
									<th title="提箱司机,TX_DRIVER">提箱司机</th>
									<th title="提箱时间,TX_TIME">提箱时间</th>
									<th title="进场,SF_JC">进场</th>
									<th title="调度编号,TX_SCHEDULE_NO">调度编号</th>
									<th title="提箱司机,TX_DRIVER">回箱司机</th>
									<th title="提箱时间,TX_TIME">回箱时间</th>
									<th title="送箱,SF_SX">送箱</th>
									<th title="调度编号,SX_SCHEDULE_NO">调度编号</th>
									<th title="送箱司机,SX_DRIVER">送箱司机</th>
									<th title="送箱时间,SX_TIME">送箱时间</th>
									<th title="调度编号,JC_SCHEDULE_NO">调度编号</th>
									<th title="提箱司机,JC_DRIVER">进场司机</th>
									<th title="提箱时间,JC_TIME">进场时间</th>
									<th title="返箱地点,BOX_RETURN">返箱地点</th>
									<th title="拖箱地区,BOX_DRAG_AREA">拖箱地区</th>
									<th title="货主联系人,OWNNER_NAME">货主联系人</th>
									<th title="货主电话,OWNNER_TEL">货主电话</th>
									<th title="作业方式,LOAD_WAY">作业方式</th>
									<th title="备柜,BEIGUI">备柜</th> -->
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                      </div>
                    </div>
                </div>
            </div>
        </div>
    </div>    
    

    <script>
    	var table;
    	var cols = [
				{"data" : "NUM",// 序号
					"render" : function(data) {
						return "<div align='center'>" + data + "</div>";
				}},
				{"data" : "SCHEDULE_STATUS" // 任务状态
					,"render" : function(data) {
						if (data == "未执行") {
							return "<div class='label label-danger ' >未执行</div>";
						} else if (data == "已执行") {
							return "<div class='label label-04' >已执行</div>";
						} else if (data == "执行中") {
							return "<div class='label label-success' >执行中</div>";
						}else{
							return data;
						}
					}
				},
				{"data" : "COMMAND" // 调度名称
					,"render" : function(data) {
						return data && ("<div class='label label-0"+ data +"'  >" + $sysdictext["SCHEDULENAME_" + data] + "</div>")
					}
				},
				{"data" : "BOOK_SEND_DATE"}, // 预约送箱日期
				{"data" : "IN_OUT" ,"render" : function(data) { // 进出类型
					return data && $sysdictext["INOTYPE_" + data] ; 
				}},
				{"data" : "SCHEDULE_REMARK"}, // 调度备注
				{"data" : "SHUAIGUI","render" : function(data) { // 甩柜
					return data == 1 ? "√" : "";
				}},
				{"data" : "SF_HX","render" : function(data) { // 回箱
					return data == "Y" ? "√" : "";
				}},
				{"data" : "IS_RESERVE", // 是否预约
					"render" : function(data) {
						data = data==""?"0":data;
						var html = "<input type='hidden' id='IS_RESERVE' value='"+ data +"' />";
						return data == 1 ? html+"√" : html+"";
				}},
				{"data" : "TRUCK_FRAME"}, // 车架
				{"data" : "CARGO_OWNNER"}, // 货主
				{"data" : "ORDER_NO"}, // 提单号
				{"data" : "SHIP_NAME"}, // 船名
				{"data" : "SHIP_VOYAGE"}, // 航次
				{"data" : "SHIP_DATE"}, // 船期
				{"data" : "NO"}, // 箱号
				{"data" : "SEAL_NO"}, // 铅封号
				{"data" : "SIZE"}, // 尺寸
				{"data" : "SPEC"}, // 箱规
				{"data" : "BOX_OWNNER_1"}, // 箱主
				{"data" : "BOX_TAKE"}, // 提箱地点
				{"data" : "TO_PORT"}, // 目的港
				{"data" : "BOX_DRAG"}, // 拖箱地点
				{"data" : "ADDR"}, // 详细地址
				{"data" : "LOAD_PORT"}, // 装运港
				{"data" : "LOAD_CONTACT"}, // 装货联系方式
				{"data" : "SHIPMENT_NO"}, // 出货单号
				{"data" : "SEND_TIME_FORMAT"} // 派车时间
			
				/* 调度列表修改 2016年3月24日 16:41:45 */
				/* {"data" : "TRUCK_PLATE"}, // 车牌
				{"data" : "SHUANGTUO","render" : function(data) { // 双拖
					return data == 1 ? "√" : "";
				}},
				{"data" : "TONAME"}, // 终点
				{"data" : "JSON_HIS","render" : function(data) { // 回箱调度编号
					return data && ($.parseJSON( data )["SCHEDULE_NO_3"] || " ");
				}},
				{"data" : "JSON_HIS","render" : function(data) { // 回箱司机
					return data && ($.parseJSON( data )["DRIVER_3"] || " ");
				}},
				{"data" : "JSON_HIS","render" : function(data) { // 回箱时间
					return data && ($.parseJSON( data )["SEND_TIME_STR_3"] || " ");
				}},
				{"data" : "SF_SX","render" : function(data) { // 是否送箱
					return data == "Y" ? "√" : "";
				}},
				{"data" : "JSON_HIS","render" : function(data) { // 送箱编号
					return data && ($.parseJSON( data )["SCHEDULE_NO_2"] || " ");
				}},
				{"data" : "JSON_HIS","render" : function(data) { // 送箱司机
					return data && ($.parseJSON( data )["DRIVER_2"] || " ");
				}},
				{"data" : "JSON_HIS","render" : function(data) { // 送箱时间
					return data && ($.parseJSON( data )["SEND_TIME_STR_2"] || " ");
				}},
				{"data" : "SF_TX","render" : function(data) { // 是否提箱
					return data == "Y" ? "√" : "";
				}},
				{"data" : "JSON_HIS","render" : function(data) { // 提箱编号
					return data && ($.parseJSON( data )["SCHEDULE_NO_1"] || " ");
				}},
				{"data" : "JSON_HIS","render" : function(data) { // 提箱司机
					return data && ($.parseJSON( data )["DRIVER_1"] || " ");
				}},
				{"data" : "JSON_HIS","render" : function(data) { // 提箱时间
					return data && ($.parseJSON( data )["SEND_TIME_STR_1"] || " ");
				}},
				{"data" : "SF_JC","render" : function(data) { // 是否进场
					return data == "Y" ? "√" : "";
				}},
				{"data" : "JSON_HIS","render" : function(data) { // 进场编号
					return data && ($.parseJSON( data )["SCHEDULE_NO_4"] || " ");
				}},
				{"data" : "JSON_HIS","render" : function(data) { // 进场司机
					return data && ($.parseJSON( data )["DRIVER_4"] || " ");
				}},
				{"data" : "JSON_HIS","render" : function(data) { // 进场时间
					return data && ($.parseJSON( data )["SEND_TIME_STR_4"] || " ");
				}},
				{"data" : "BOX_RETURN"}, // 返箱地点
				{"data" : "BOX_DRAG_AREA"}, // 拖箱地区
				{"data" : "OWNNER_NAME"}, // 货主联系人
				{"data" : "OWNNER_TEL"}, // 货主电话
				{"data" : "LOAD_WAY","render" : function(data) { // 作业方式
					return data && $sysdictext["LOADWAY_" + data] ;
				}},
				{"data" : "BEIGUI","render" : function(data) { // 备柜
					return data == 1 ? "√" : "";
				}} */
			];
    	// 设置哪些列不进行排序  哪些列需排序（需要改sql xml条件）
    	var aoColumnParam = [0],aaSortParam = [];
		$(function(){
			// 加载列表信息 initTable(id,url,param,colsParam,aoColumnParam,aaSortParam,other); 
			// param Ajax请求时发送额外的数据(条件),colsParam 设置列属性条件,aoColumnParam 设置哪些列不排序  aaSortParam设置哪些列排序
        	table = initTableAutoHeight("ScheduleDataList", "${ctxPath}/topic/page/scheduleList", null,cols,null,null,"BOX_ID",getScreen());
        	// 全选 全不选  data-type
			//checkAll("userCheckAll");
			
        	// 初始化下拉框为 select2
        	$s2.init($("#SSTJ"));
        	$("#SSTJ").select2({
        		minimumResultsForSearch: Infinity,
        		width:80,
        	});
        	$s2.init($("#PCSJ"));
        	$("#PCSJ").select2({
        		minimumResultsForSearch: Infinity,
        	})
        	$s2.init($("#SSTJ_ZT"));
        	$("#SSTJ_ZT").select2({
        		minimumResultsForSearch: Infinity,
        	})
        	
			//获取统计的数据
			getScheduleSum();
			
			$("#ScheduleDataList").on( 'dblclick', 'tr', function () {
				editSchedule();
        	});
		});
			
		
		/* 搜索 查询 */
		function searchForm(formId) {
			var form;
			if(!formId){
				form = $('form.form-search');
			}else{
				form = $("#"+formId);
			}
			if(!form){
				console.log("id不存在");
				return;
			}
			
			$("#clickId").val("");
			table.column(0).search($("#SSTJ").val());
			table.column(1).search($("#SSTJ_VALUE").val());
			table.column(2).search($("#PCSJ").val());
			table.column(3).search($("#SSTJ_ZT").val());
			table.column(4).search($("#WNSS").val());
	
			table.draw();
			getScheduleSum();
		}
		
		//修改调度
		function editSchedule(){
			if(!isEmpty($("#clickId").val())) {
			 	var params = [];
				params[0] = {box_id:$("#clickId").val()};
				/**
				 * 修改信息 iUrl请求url param参数（字符串） iTitletab标签名
				 */
				editForm("${ctxPath}/topic/editSchedulePage",params,"修改箱子调度");
			}else{
				swal("", "只能选择一条信息进行修改!", "warning");
			}
		}
		
		//完成
		function doFinishSche() {
			var params = [];
			$("input[data-type='scheCheck']:checked").each(function(i) {
		    	if(this.checked == true){
		    		params[i] = {user_id:$(this).val()};
		    	}
		    });
			
			if(params.length != 1) {
				alert("请选择一条记录！");
				return;
			}
			
			/**
			 * 修改信息 iUrl请求url param参数（字符串） iTitletab标签名
			 */
			// alert();
			editForm("${ctxPath}/topic/editManagePage",params,"完成箱子调度");
		}
		
		//打印
		function doPrint() {
			var params = [];
			if(!isEmpty($("#clickId").val())) {
				params = [{box_id:$("#clickId").val()}];
			} 
			var sLength = params.length,param="",key = "";
			if (isEmpty(params) || sLength == 0 || params[0] == '') {
				swal("", "请选择一条信息进行打印!", "warning");
				return;
			}else if(sLength > 1){
				swal("", "只能选择一条信息进行修改!", "warning");
				return;
			}
			$.each(params[0], function(i) {
			    param = params[0][i],key = i;
			});
			//打开新tab页 iUrl ajax执行url,iTitle tab标签名,dataId 标签data_id（用于关闭刷新标签页）
			window.parent.newTab("${ctxPath}/topic/toPrintOrder"+"?pdataId="+ window.parent.getDataId() +"&"+ key +"="+ param,"打印调度信息");	
		}
		
		//导出
		function exportExecel(){
			if(confirm("确定要导出列表吗")){
				var titles=getTitleInfo("titles"); // 字段名
				var exportType=$("#ALL_EXAMINE_EXPORT_EXPORTTYPE").val();
				var titleNames=getTitleInfo("titleNames"); // 获取标题
				var fileName=$("#ALL_EXAMINE_EXPORT_FILENAME").val();
				var sstj = $("#SSTJ").val();
				var sstj_value = $("#SSTJ_VALUE").val();
				var pcsj = $("#PCSJ").val();
				var sstj_zt = $("#SSTJ_ZT").val();
				var wnss = $("#WNSS").val();
				
				var params ='';
				params += sstj != ''?"&sstj="+sstj:'';
				params += sstj_value != ''?"&sstj_value="+sstj_value:'';
				params += pcsj != ''?"&pcsj="+pcsj:'';
				params += sstj_zt != ''?"&sstj_zt="+sstj_zt:'';
				params += wnss != ''?"&wnss="+wnss:'';
				window.open("${ctxPath }/topic/exportExcel/exportScheduleExecel?titles="+titles+"&exportType="+exportType+"&titleNames="+titleNames+"&fileName="+fileName+params);
			}
			
		}
		
		//获取调度统计数量
		function getScheduleSum() {
			 $.ajax({
					url:"${ctxPath}/topic/ajax/scheduleSum",
					success:function(data){
						obj = eval("("+data+")").resultObj;
						
						$("#sumNum").html("");
						
// 						var html = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;提箱 &nbsp;"+obj.TXNUM;
// 							html+="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;送箱&nbsp;"+obj.SXNUM;
// 							html+="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;回箱&nbsp;"+obj.HXNUM;
// 							html+="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;进场&nbsp;"+ obj.JCNUM;
// 							html+="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;暂存&nbsp;"+ obj.ZCNUM;
// 							html+="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;空跑&nbsp;"+ obj.KPNUM;
// 							html+="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;脱空&nbsp;"+ obj.TKNUM;
// 							html+="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;退装&nbsp;"+ obj.TZNUM;
					var	html ="<a href=\"javascript:void(0)\" onclick=\"searchCommandSchedule('提箱')\"><span style=\"margin-left:10px;color:#18b4ed;\">提箱 "+(obj.TXNUM ?obj.TXNUM:"0")+"</span></a>";
						html+="<a href=\"javascript:void(0)\" onclick=\"searchCommandSchedule('送箱')\"><span style=\"margin-left:10px;color:#ff0000;\">送箱 "+(obj.SXNUM ?obj.SXNUM:"0")+"</span></a> ";
						html+="<a href=\"javascript:void(0)\" onclick=\"searchCommandSchedule('回箱')\"><span style=\"margin-left:10px;color:#009688;\">回箱 "+(obj.HXNUM ?obj.HXNUM:"0")+"</span></a> ";
						html+="<a href=\"javascript:void(0)\" onclick=\"searchCommandSchedule('进箱')\"><span style=\"margin-left:10px;color:#259b24;\">进场 "+(obj.JCNUM ?obj.JCNUM:"0")+"</span></a> ";
						html+="<a href=\"javascript:void(0)\" onclick=\"searchCommandSchedule('暂箱')\"><span style=\"margin-left:10px;color:#c21928;\">暂存 "+(obj.ZCNUM ?obj.ZCNUM:"0")+"</span></a> ";
						html+="<a href=\"javascript:void(0)\" onclick=\"searchCommandSchedule('空箱')\"><span style=\"margin-left:10px;color:#ad2a56;\">空跑 "+(obj.KPNUM ?obj.KPNUM:"0")+"</span></a> ";
						html+="<a href=\"javascript:void(0)\" onclick=\"searchCommandSchedule('脱箱')\"><span style=\"margin-left:10px;color:#68247d;\">脱空 "+(obj.TKNUM ?obj.TKNUM:"0")+"</span></a> ";
						html+="<a href=\"javascript:void(0)\" onclick=\"searchCommandSchedule('退箱')\"><span style=\"margin-left:10px;color:#527da4;\">退装 "+(obj.TZNUM ?obj.TZNUM:"0")+"</span></a> ";
						$("#sumNum").html(html);;
						//console.log(data);
		
					}
				});
		}
		
		// 点击统计项目查询对应调度信息
		function searchCommandSchedule(obj){
			$("#WNSS").val(obj);
			searchForm();
		}
		
		// 预约 1/取消 预约 0
		function toReserve(tag){
			var params = [],BOX_ID = $("#clickId").val(),tag_name = "预约",msg = "已预约";
			// 判断是否 预约或者无预约
			var ok = false;
			if(tag == "0"){//取消 预约
				tag_name = "取消预约";
				msg = "无预约";
			}
			$("#ScheduleDataList tbody tr").each(function(){
				if($(this).data("id") == BOX_ID && $(this).find('td #IS_RESERVE').val() == tag){
					ok = true;
					return false;
				}
			});
			if(ok){
				swal("", "该订单"+ msg +"，无需重复操作！", "warning");
				return;
			}
			if (!isEmpty($("#clickId").val())) {
				params = [ {BOX_ID : BOX_ID} ];
			}
			operForm("${ctxPath}/topic/ajax/toBoxScheduleReserve?IS_RESERVE="+tag, tag_name, params,searchForm);
		}
		
		/**
		 * 获取屏幕高度
		 * */
		function getScreen()
		{
			var height = document.body.clientHeight;
			var ibox_title = $(".ibox-title").height();
			var orderToolbar = $("#orderToolbar").height();
			//alert('ibox_title'+ibox_title+'orderToolbar'+orderToolbar+'height'+height);
			return height-94-ibox_title+30-orderToolbar;
		}
		/**
		 * 获取表头名称与字段名 用于导出列表
		 * */
		function getTitleInfo(type){
			var titleNames = "";
			var titles = "";
			$("#ScheduleDataList").find("th").each(function(index,item){
				titleNames += $(item).attr("title").split(",")[0] + ",";
				titles += $(item).attr("title").split(",")[1] + ",";
			});
			if(type == "titleNames"){
				return titleNames.substring(0,titleNames.lastIndexOf(","));
			}else if(type == "titles"){
				return titles.substring(0,titles.lastIndexOf(","));
			}
		}
    </script>
</body>
</html>