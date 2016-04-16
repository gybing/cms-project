<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>编辑箱子调度</title>
<jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
<jsp:include page="/WEB-INF/jsp/formSubmit.jsp"></jsp:include>

</head>


<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox">
					<div class="ibox-content">
						<form id="updateSceduleForm" class="form-horizontal"
							data-id="toScheduleListPage"
							action="${ctxPath}/topic/ajax/editBoxSchedule" method="post">
							<input type="hidden" id="BOX_ID" name="BOX_ID" value="${param.box_id}" /> <input type="hidden" id="ORDER_ID" name="ORDER_ID" value="${responseDataForm.resultObj[0].ORDER_ID}" />
							<!-- 用于新增调度时回调地点信息 -->
							<input type="hidden" id="box_take_area_id" name="box_take_area_id" value="${responseDataForm.resultObj[0].BOX_TAKE_AREA_ID }"/>
							<div class="panel panel-default">
								<div class="panel-heading">集装箱信息</div>
								<div class="tab-content">
									<div class="tab-pane active">
										<div class="panel-body">
											<div class="form-group form-group-sm">
												<label class="col-sm-1 control-label">箱号：</label>
												<div class="col-sm-2">
													<input type="text" id="S_NO" name="NO" maxlength="50"
														class="form-control input-sm isContainerCode" onchange="uppercase(this)"
														value="${responseDataForm.resultObj[0].NO }" />
												</div>
												<label class="col-sm-1 control-label">铅封号：</label>
												<div class="col-sm-2">
													<input type="text" id="S_SEAL_NO" name="SEAL_NO"
														maxlength="50" class="form-control input-sm"
														value="${responseDataForm.resultObj[0].SEAL_NO }" />
												</div>
												<div class="col-sm-6" style="padding-left:66px">
														<label class="col-sm-1 control-label" for="exampleInputPassword2">尺寸：</label>
														<div class="col-sm-1">
														 	<select id="S_SIZE"  name="SIZE"  class="form-control" ></select>
															<!-- <div class="input-group" id="AS_SIZE"></div> -->
														</div>
														<label class="col-sm-1 control-label">箱规：</label>
														<div class="col-sm-1">
															<select id="S_SPEC"  name="SPEC"  class="form-control" ></select>
															<!-- <div class="input-group" id="AS_SPEC"></div> -->
														</div>
												</div>
											</div>
											<div class="form-group form-group-sm">
												<label class="col-sm-1 control-label">预约送箱日期：</label>
												<div class="col-sm-2">
													<input type="text" id="S_BOOK_SEND_DATE"
														name="BOOK_SEND_DATE" 
														placeholder="YYYY-MM-DD hh:mm"
														onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm'})"
														class="form-control input-sm"
														value="${responseDataForm.resultObj[0].BOOK_SEND_DATE }" />
												</div>

												<label class="col-sm-1 control-label"
													for="exampleInputPassword2">箱主:</label>
												<div class="col-sm-2">
													<input type="text"
														value="${responseDataForm.resultObj[0].SHORTCUT }"
														readonly="readonly" class="form-control input-sm" />
												</div>
												<div class="col-sm-1"></div>
												<div class="col-sm-1">
													<input type="hidden" id="XUNZHENG" name="XUNZHENG"
														value="${responseDataForm.resultObj[0].XUNZHENG}">
													<input id="XUNZHENG_BOX" name="XUNZHENG_BOX"
														type="checkbox" class=""
														onclick="ClickCheckBox('XUNZHENG')" /> <i></i>熏蒸
												</div>
												<div class="col-sm-1">
													<input type="hidden" id="SHANGJIAN" name="SHANGJIAN"
														value="${responseDataForm.resultObj[0].SHANGJIAN}">
													<input id="SHANGJIAN_BOX" name="SHANGJIAN_BOX"
														type="checkbox" class=""
														onclick="ClickCheckBox('SHANGJIAN')" /> <i></i>商检
												</div>
												<div class="col-sm-1">
													<input type="hidden" id="JIGUI" name="JIGUI"
														value="${responseDataForm.resultObj[0].JIGUI}"> <input
														id="JIGUI_BOX" name="JIGUI_BOX" type="checkbox" value=""
														class="" onclick="ClickCheckBox('JIGUI')" /> <i></i>寄柜
												</div>
												<div class="col-sm-1">
													<input type="hidden" id="PANGUI" name="PANGUI"
														value="${responseDataForm.resultObj[0].PANGUI}">
													<input id="PANGUI_BOX" name="PANGUI_BOX" type="checkbox"
														value="" class="" onclick="ClickCheckBox('PANGUI')" /> <i></i>盘柜
												</div>
											</div>
											<div class="form-group form-group-sm">
												<label class="col-sm-1 control-label">调度备注：</label>
												<div class="col-sm-3">
													<%-- <input type="text" id="S_SCHEDULE_REMARK"  name="SCHEDULE_REMARK"    maxlength="500" value="${responseDataForm.resultObj[0].SCHEDULE_REMARK }" class="form-control input-sm" /> --%>
													<textarea class="form-control input-sm" rows="" cols=""
														id="S_SCHEDULE_REMARK" name="SCHEDULE_REMARK"
														maxlength="500"
														>${responseDataForm.resultObj[0].SCHEDULE_REMARK }</textarea>
												</div>
												<label class="col-sm-2 control-label"></label> <label
													class="col-sm-1 control-label">箱子备注：</label>
												<div class="col-sm-3">
													<%-- <input type="text"  id="S_BOX_REMARK"  name="BOX_REMARK"  maxlength="500" value="${responseDataForm.resultObj[0].BOX_REMARK }" class="form-control input-sm" /> --%>
													<textarea class="form-control input-sm" rows="" cols=""
														id="S_BOX_REMARK" name="BOX_REMARK" maxlength="500"
														>${responseDataForm.resultObj[0].BOX_REMARK }</textarea>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="panel panel-default">
								<div class="panel-heading">订单信息</div>
								<div class="tab-content">
									<div class="tab-pane active">
										<div class="panel-body">
											<div class="form-group form-group-sm">
												<label class="col-sm-1 control-label">提单号：</label>
												<div class="col-sm-2">
													<input type="text"
														value="${responseDataForm.resultObj[0].ORDER_NO }"
														readonly="readonly" class="form-control input-sm" />
												</div>
												<label class="col-sm-1 control-label"
													for="exampleInputPassword2">船名:</label>
												<div class="col-sm-2">
													<input type="text"
														value="${responseDataForm.resultObj[0].SHIP_NAME }"
														readonly="readonly" class="form-control input-sm" />
												</div>
												<label class="col-sm-1 control-label">航次：</label>
												<div class="col-sm-2">
													<input type="text"
														value="${responseDataForm.resultObj[0].SHIP_VOYAGE }"
														readonly="readonly" class="form-control input-sm" />
												</div>
												<label class="col-sm-1 control-label"
													for="exampleInputPassword2">船期:</label>
												<div class="col-sm-2">
													<input type="text"
														value="${responseDataForm.resultObj[0].SHIP_DATE }"
														readonly="readonly" class="form-control input-sm" />
												</div>
											</div>

											<div class="form-group form-group-sm">
												<label class="col-sm-1 control-label">货主：</label>
												<div class="col-sm-2">
													<input type="text"
														value="${responseDataForm.resultObj[0].CARGO_OWNNER }"
														readonly="readonly" class="form-control input-sm" />
												</div>
												<label class="col-sm-1 control-label"
													for="exampleInputPassword2">装运港:</label>
												<div class="col-sm-2">
													<input type="text" id="load_port"
														value="${responseDataForm.resultObj[0].LOAD_PORT }"
														readonly="readonly" class="form-control input-sm" />
												</div>
												<label class="col-sm-1 control-label">目的港：</label>
												<div class="col-sm-2">
													<input type="text"
														value="${responseDataForm.resultObj[0].TO_PORT }"
														readonly="readonly" class="form-control input-sm" />
												</div>
												<label class="col-sm-1 control-label"
													for="exampleInputPassword2">接单备注:</label>
												<div class="col-sm-2">
													<input type="text"
														value="${responseDataForm.resultObj[0].ORDER_REMARK }"
														readonly="readonly" class="form-control input-sm" />
												</div>
											</div>

											<div class="form-group form-group-sm">
												<label class="col-sm-1 control-label">进出类型：</label>
												<div class="col-sm-2"> 
													<input type="text" id="in_out"
														value="${responseDataForm.resultObj[0].IN_OUT }"
														readonly="readonly" class="form-control input-sm" />
												</div>
												<label class="col-sm-1 control-label"
													for="exampleInputPassword2">提箱地点:</label>
												<div class="col-sm-2">
													<input type="text" id="_box_take"
														value="${responseDataForm.resultObj[0].BOX_TAKE }"
														readonly="readonly" class="form-control input-sm" />
												</div>
												<label class="col-sm-1 control-label">返箱地点：</label>
												<div class="col-sm-2">
													<input type="text" id="box_return"
														value="${responseDataForm.resultObj[0].BOX_RETURN }"
														readonly="readonly" class="form-control input-sm" />
												</div>
												<label class="col-sm-1 control-label"
													for="exampleInputPassword2">拖箱地区:</label>
												<div class="col-sm-2">
													<input type="text"
														value="${responseDataForm.resultObj[0].BOX_DRAG_AREA }"
														readonly="readonly" class="form-control input-sm" />
												</div>
											</div>

											<div class="form-group form-group-sm">
												<label class="col-sm-1 control-label">拖箱地点：</label>
												<div class="col-sm-2">
													<input type="text" id="box_drag"
														value="${responseDataForm.resultObj[0].BOX_DRAG }"
														readonly="readonly" class="form-control input-sm" />
												</div>

											</div>

										</div>
									</div>
								</div>
							</div>
							<div class="panel panel-default">
								<div class="panel-heading ">调度信息</div>
								<div class="tab-content">
									<div class="panel-body">
										<div class="form-group form-group-sm">
											<label class="col-sm-1 control-label">调度名称：</label>
											<div class="col-sm-2">
												<!-- <select id="S_COMMAND" name="COMMAND" onchange="updateHref();" class="form-control"></select> -->
												<div class="input-group" id="AS_COMMAND"></div>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											</div>
											<div class="col-sm-9">
												<a onclick="addSchedule();" href="javascript:void(0);"
													class="btn btn-primary"><i
													class="glyphicon glyphicon-plus"></i></a>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="panel panel-default">
								<div class="panel-heading">调度历史</div>
								<div class="tab-content">
									<div class="tab-pane active">
										<div class="panel-body">
											<table id="scheduleHisList"
												class="table table-striped table-bordered table-hover data-table with-check">
												<thead>
													<tr>
														<th width="100">序号</th>
														<th>调度编号</th>
														<th width="100">调度名称</th>
														<th width="100">任务状态</th>
														<th width="100">司机</th>
														<th width="100">车牌</th>
														<th width="100">车架</th>
														<th width="100">派车时间</th>
														<th width="100">起点</th>
														<th width="100">终点</th>
														<th width="150">操作</th>
													</tr>
												</thead>
												<tbody>
												</tbody>
											</table>

											<div class="form-group form-group-sm"
												style="float:right;">
												<div class="col-sm-12 col-sm-offset-3"></div>
											</div>
										



										<div id="form_foot_tool"
											style="float: right ;padding-right: 20px;padding-bottom: 10px">
											<ul class="button-list" style="list-style-type:none;">
												<li>
													<button type="submit" class="btn  btn-primary"><i class="glyphicon glyphicon-ok"></i>保存</button>
													<button type="button" onclick="doPrint();"
														class="btn btn-info "><i class="glyphicon glyphicon-print"></i>打印</button>
												</li>
											</ul>
										</div>
										</div>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

<script type="text/javascript">
	var table;
	$(document).ready(function() {
		//箱子尺寸
		$s2.init($C("#S_SIZE"), {
			sysdict : $sysdict.BOX_SIZE,
			width:"50px",
			defVal : "${responseDataForm.resultObj[0].SIZE }",
		});
		//箱规
		$s2.init($C("#S_SPEC"), {
			sysdict : $sysdict.BOX_TYPE,
			width:"50px",
			defVal : "${responseDataForm.resultObj[0].SPEC }",
		});
		/* $s.init($C("#boxNo"), {//箱号
			tabdict : "boxNo",
			defVal:"${responseDataForm.resultObj[0].BOX_ID }",
			VdefVal:"${responseDataForm.resultObj[0].NO }",
			vID : "NO"
		});	 */
		//调度选择
		$s.init($C("#AS_COMMAND"), {
			sysdict : $sysdict.SCHEDULENAME,
			vID : "COMMAND"
		});
		//熏蒸、商检、寄柜、盘柜复选框
		if ('${responseDataForm.resultObj[0].XUNZHENG}' == '1') {
			$("#XUNZHENG_BOX").attr("checked", "checked");
		}
		if ('${responseDataForm.resultObj[0].SHANGJIAN}' == '1') {
			$("#SHANGJIAN_BOX").attr("checked", "checked");
		}
		if ('${responseDataForm.resultObj[0].JIGUI}' == '1') {
			$("#JIGUI_BOX").attr("checked", "checked");
		}
		if ('${responseDataForm.resultObj[0].PANGUI}' == '1') {
			$("#PANGUI_BOX").attr("checked", "checked");
		}

		/* $("#addSch").attr("href","${ctxPath}/topic/addSchedulePage?COMMAND="+ $("#S_COMMAND").val() + "&box_id="+ $("#BOX_ID").val()); */
		table = $('#scheduleHisList').dataTable({
			"aoColumns": [  //设定各列宽度   
                           {"sWidth": "15px"},   
                           {"sWidth": "50px"},   
                           {"sWidth": "50px"},   
                           {"sWidth": "60px"},   
                           {"sWidth": "60px"}, 
                           {"sWidth": "60px"},   
                           {"sWidth": "60px"},   
                           {"sWidth": "100px"},   
                           {"sWidth": "140px"},   
                           {"sWidth": "120px"},   
                           {"sWidth": "*"}
			             ],
			"scrollY": "200px",
			"paging" : false,
			"searching" : false,
			"bSort" : false,
			"language": {  //自定义语言设置
	            "processing": "正在加载中......",
	            "lengthMenu": "每页显示 _MENU_ 条记录",
	            "zeroRecords": "对不起，查询不到相关数据！",
	            "infoEmpty": "",
	            "info": "",
	            "infoFiltered": "",
	            "search": "搜索",
	            "paginate": {
	                "first": "首页",
	                "previous": "上一页",
	                "next": "下一页",
	                "last": "末页"
	            }
			}
		});
		refreshScheduleList();
});
		
// 熏蒸 商检 寄柜 盘柜 点击事件
function ClickCheckBox(id) {
	$("#" + id).val($("#" + id).val() == '1' ? '0' : '1');
}

/* function updateHref() {
	$("#addSch").attr("href","${ctxPath}/topic/addSchedulePage?COMMAND="+ $("#S_COMMAND").val() + "&box_id="+ $("#BOX_ID").val());
} */

//添加调度
function addSchedule() {
	_box_take_area_id = $("#box_take_area_id").val()?$("#box_take_area_id").val():null; // 提箱地点id
	_box_drag = $("#box_drag").val()?$("#box_drag").val():null; // 拖箱地点
	_in_out_type = $("#in_out").val()?$("#in_out").val():null; // 进出类型 
	_box_return = $("#box_return").val()?$("#box_return").val():null; // 返箱地点
	index = layer.open({
		type : 2,
		area : [ '900px', '435px' ],
		fix : false, //不固定
		title : "新增调度",
		// maxmin: true,
		content : "${ctxPath}/topic/addSchedulePage?"
				+ "V_COMMAND=" + $("#V_COMMAND").val() 
				+ "&COMMAND=" + $("#COMMAND").val() 
				+ "&box_id=" + $("#BOX_ID").val() 
				+ "&box_drag=" + _box_drag 
				+ "&in_out_type=" + _in_out_type
				+ "&from_id="+_box_take_area_id
				+ "&box_return="+ _box_return
	});

}

//删除调度
function deleteSchedule(id,boxId) {

	swal({
		title : "您确定要删除这条调度吗？",
		type : "warning",
		showCancelButton : true,
		confirmButtonColor : "#DD6B55",
		confirmButtonText : "确定",
		cancelButtonText : "取消",
		closeOnConfirm : false
	}, function() {
		$.ajax({
			url:"${ctxPath}/topic/ajax/checkIsShuangTuo",
			dataType:"json",
			type:"post",
			data:{"scheduleId":id},
			success:function(json){
				json = json.resultObj;
				if(json.SHUANGTUO){
					var title = json.NO?"“"+json.NO+"”":"对应双拖";
					swal({
						title : "此条调度信息为双拖，如删除该调度信息将删除"+title+"箱子的调度信息？",
						type : "warning",
						showCancelButton : true,
						confirmButtonColor : "#DD6B55",
						confirmButtonText : "确定",
						cancelButtonText : "取消",
						closeOnConfirm : false
					}, function() {
						$.ajax({
							url : "${ctxPath}/topic/ajax/deleteSchedule",
							data : {
								"id" : id,
								"box_id":boxId
							},
							success : function(data) {
								//alertMsg.correct("删除成功！");
								swal("删除成功！", "", "success");
								refreshScheduleList();
							}
						});
					});
				}else{
					$.ajax({
						url : "${ctxPath}/topic/ajax/deleteSchedule",
						data : {
							"id" : id,
							"box_id":boxId
						},
						success : function(data) {
							//alertMsg.correct("删除成功！");
							swal("删除成功！", "", "success");
							refreshScheduleList();
						}
					});
				}
			}
		});
	});

}

//刷新调度历史列表
function refreshScheduleList() {
	$.ajax({
		url : "${ctxPath}/topic/ajax/getSchedulelistByBoxId",
		data : {
			"box_id" : $("#BOX_ID").val()
		},
		success : function(data) {
			data = eval("(" + data + ")").resultObj;
			var html = new Array();
			$('#scheduleHisList').dataTable().fnClearTable();
			for (var i = 0; i < data.length; i++) {
				var status = "";
				var edit = "<span style=\"padding-left:0px;\"><a href='javascript:void(0);' onclick='editSchedule(\""+ data[i].SCHEDULE_ID+ "\",\""+data[i].SCHEDULE_STATUS+"\")'>编辑</a></span>";
				var del = "<span style=\"padding-left:20px;\"><a href='javascript:void(0);' onclick='deleteSchedule(\""+ data[i].SCHEDULE_ID+ "\",\""+$("#BOX_ID").val()+"\")' >删除</a></span>";
				var finishStr = "<span style=\"padding-left:20px;\"><a href='javascript:void(0);' onclick='finishSchedule(\""+ data[i].SCHEDULE_ID + "\",\""+data[i].COMMAND+"\")'>完成</a></span>";
				var operator = "";
				if (data[i].SCHEDULE_STATUS == 0) {
					status = "未执行";
					operator += edit+del+finishStr;
				} else if (data[i].SCHEDULE_STATUS == 1) {
					status = "执行中";
					operator += edit+del+finishStr;
					
				} else if (data[i].SCHEDULE_STATUS == 2) {
					status = "已执行";
					operator += edit;
				}
				operator += "<input type=\"text\" hidden value=\""+data[i].DRIVER_ID+"\" id=\"dirver_id\"/>";
				/* html.push("<tr class='hover' id='dd_"+data[i].SCHEDULE_ID+"'>");
				html.push("<td>"+(i+1)+"</td><td>"+data[i].COMMAND+"</td>");
				html.push("<td>"+status+"</td>");
				html.push("<td>"+(isEmpty(data[i].DRIVER)?"":data[i].DRIVER)+"</td>");
				html.push("<td>"+(isEmpty(data[i].TRUCK_PLATE)?"":data[i].TRUCK_PLATE)+"</td>");
				html.push("<td>"+(isEmpty(data[i].TRUCK_FRAME)?"":data[i].TRUCK_FRAME)+"</td>");
				html.push("<td>"+(isEmpty(data[i].SEND_TIME)?"":data[i].SEND_TIME)+"</td>");
				html.push("<td>"+(isEmpty(data[i].FROMNAME)?"":data[i].FROMNAME)+"</td>");
				html.push("<td>"+(isEmpty(data[i].TONAME)?"":data[i].TONAME)+"</td>");
				html.push("<td><a href='${ctxPath }/topic/toBoxDetailPage?scheduleId="+data[i].SCHEDULE_ID+"' id='updateSch' mask='true' target='dialog' width='1000' height='680' title='编辑调度'>编辑</a>"+
						"&nbsp;&nbsp;&nbsp;<a href='javascript:void(0);' onclick='deleteSchedule(\""+data[i].SCHEDULE_ID+"\")' >删除&nbsp;&nbsp;&nbsp;</a>&nbsp;&nbsp;&nbsp;"+finishStr+"</td>");
				html.push("</tr>");
				$("#refreshScheduleList tbody tr").empty();
				$("#refreshScheduleList tbody ").html(html.join("")); */
				// 向调度历史列表中填充数据
				$('#scheduleHisList').dataTable().fnAddData(
					[(i + 1),
					 data[i].SCHEDULE_NO,
					 data[i].COMMAND,
					 status,
					 (isEmpty(data[i].DRIVER) ? "": data[i].DRIVER),
					 (isEmpty(data[i].TRUCK_PLATE) ? "": data[i].TRUCK_PLATE),
					 (isEmpty(data[i].TRUCK_FRAME) ? "": data[i].TRUCK_FRAME),
					 (isEmpty(data[i].SEND_TIME) ? "": data[i].SEND_TIME),
					 (isEmpty(data[i].FROMNAME) ? "": data[i].FROMNAME),
					 (isEmpty(data[i].TONAME) ? "": data[i].TONAME),
					 operator
					 ]);
			}
		}
	});
}
//编辑历史调度
function editSchedule(schedule_id,status) {
	st_box_drag_area = $("#box_drag").val()?$("#box_drag").val():null; // 拖箱地点
	layer.open({
		type : 2,
		area : [ '80%', '80%' ],
		fix : false, //不固定
		title : "编辑历史调度",
		// maxmin: true,
		content : "${ctxPath }/topic/toBoxDetailPage?scheduleId="
				+ schedule_id+"&boxId="+$("#BOX_ID").val()
				+ "&st_box_drag_area=" + st_box_drag_area // 拖箱地点
	});
}
//完成调度
function finishSchedule(id,command) {
	swal({
		title : "完成调度",
		text : "您确定要完成这条调度信息吗？",
		type : "warning",
		showCancelButton : true,
		confirmButtonColor : "#DD6B55",
		confirmButtonText : "确定",
		cancelButtonText : "取消",
		closeOnConfirm : false
	}, function() {
		$.ajax({
			url : "${ctxPath}/topic/ajax/finishSchedule",
			data : {
				"id" : id,
				"command":command
			},
			success : function(data) {
				//alertMsg.correct("操作成功！");
				swal("操作成功！", "", "success");
				refreshScheduleList();
			}
		});
	}); //alert end 
}

//打印
function doPrint() {
	var params = [ {
		box_id : $("#BOX_ID").val()
	} ];

	/**
	 * 修改信息 iUrl请求url param参数（字符串） iTitletab标签名
	 */
	// alert();
	editForm("${ctxPath}/topic/toPrintOrder", params, "打印调度");
}
// 转换成大写
function uppercase(obj){
	$(obj).val($(obj).val().toUpperCase());
}
</script>
</body>
</html>