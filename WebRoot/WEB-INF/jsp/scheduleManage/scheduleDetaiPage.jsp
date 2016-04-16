<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.weimingfj.common.utils.UserSessionBean"%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>历史调度编辑</title>
    <jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
   
</head>


<body class="">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox">
					<div class="ibox-content">
						<form id="editPortFrom" class="form-horizontal">
						<input type="hidden" id="SCHEDULE_ID" name="SCHEDULE_ID" value="${param.scheduleId }"/>
						<input type="hidden" id="SHUANGTUO_SCHEDULE_ID" name="SHUANGTUO_SCHEDULE_ID"/>
						<input type="hidden" id="SHUANGTUO_BOX_ID" name="SHUANGTUO_BOX_ID" value="${responseDataForm.resultObj[0].BOX_ID}"/>
						<input type="hidden" id="add_dict_tag" name="tag" value="${sessionScope.SESSION_USER_LOGIN_INFO.userInfo.TAG }"/>
						<input type="hidden" id="IS_SHUANGTUO_BOX_ID" name="IS_SHUANGTUO_BOX_ID" value="${responseDataForm.resultObj[0].SHUANGTUO_BOX_ID}"/>
						<input type="hidden" id="IS_SHUANGTUO" name="IS_SHUANGTUO">
						<div class="panel panel-default">
							<div class="panel-heading">任务分配信息</div>
							<div class="tab-content">
								<div class="tab-pane active">
									<div class="panel-body">
										<div class="form-group form-group-sm">
											<label class="col-sm-1 control-label" ><span style="color: red;">*</span>司机：</label>
											<div class="col-sm-3">
												<select id="DRIVER"  name="DRIVER" class="form-control required">
													<option value="">请选择</option>
												</select>
											</div>
											<label class="col-sm-2 control-label"
												for="exampleInputPassword2"><span style="color: red;">*</span>派车时间:</label>
											<div class="col-sm-3">
												<input type="text" id="SEND_TIME" value="${responseDataForm.resultObj[0].SEND_TIME }"  name="SEND_TIME"  placeholder="YYYY-MM-DD hh:mm" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm'})"  class="form-control input-sm  layer-date required"/>
												<%-- <input style="width: 150px" class="form_date required" type="text" id="SEND_TIME" name="SEND_TIME" 
											value="${responseDataForm.resultObj[0].SEND_TIME }"  data-date-format="yyyy-mm-dd hh:ii" placeholder="YYYY-MM-DD hh:mm" /> --%>
											</div>
										</div>
										
										<div class="form-group form-group-sm">
											<label class="col-sm-1 control-label" ><span style="color: red;">*</span>车牌：</label>
											<div class="col-sm-3">
												<select id="TRUCK_PLATE"  name="TRUCK_PLATE" class="form-control required">
													<option value="">请选择</option>
												</select>
											</div>
											<label class="col-sm-2 control-label"
												for="exampleInputPassword2"><span style="color: red;">*</span>车架:</label>
											<div class="col-sm-3">
												<select id="TRUCK_FRAME"  name="TRUCK_FRAME" class="form-control required">
													<option value="">请选择</option>
												</select>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="panel panel-default">
							<div class="panel-heading">调度操作信息</div>
							<div class="tab-content">
								<div class="tab-pane active">
									<div class="panel-body">
										<div class="form-group form-group-sm">
											<label class="col-sm-1 control-label" ><span style="color: red;">*</span>调度名称：</label>
											<div class="col-sm-2">
												 <select id="COMMAND" name="COMMAND" disabled="disabled" class="form-control"></select> 
												<!-- <div class="input-group" id="A_COMMAND"></div> -->
											</div>
											<label class="col-sm-1 control-label" >调度中心：</label>
											<div class="col-sm-2">
												<select id="SCHEDULE_CENTER"  name="SCHEDULE_CENTER" class="form-control">
													<option value="">请选择</option>
												</select> 
												<!-- <div class="input-group" id="A_SCHEDULE_CENTER"></div> -->
											</div>
											<label class="col-sm-1 control-label"
												for="exampleInputPassword2">空重状态：</label>
											<div class="col-sm-2">
												<select id="EMPTY_STATUS"  name="EMPTY_STATUS" class="form-control">
													<option value="">请选择</option>
												</select>
												<!-- <div class="input-group" id="A_EMPTY_STATUS"></div> -->
											</div>
										</div>
										<div class="form-group form-group-sm">
											<label class="col-sm-1 control-label" ><span style="color: red;">*</span>起点：</label>
											<div class="col-sm-2">
												<!-- <select id="FROM"  name="FROM" class="form-control"></select> -->
												<div class="input-group" id="A_FROM"></div>
											</div>
											<label class="col-sm-1 control-label" ><span style="color: red;">*</span>终点：</label>
											<div class="col-sm-2">
												<!-- <select id="TO"  name="TO" class="form-control"></select> -->
												<div class="input-group" id="A_TO"></div>
											</div>
											<label class="col-sm-1 control-label" ><input type="checkbox" value="1" name="WAIXIE" id="WAIXIE"/>外协</label>
											<div class="col-sm-2">
												<input type="text" id="OUT_HELP"  name="OUT_HELP" maxlength="20"  class="form-control input-sm" value="${responseDataForm.resultObj[0].OUT_HELP }">
											</div>
										</div>
										<div class="form-group form-group-sm">
										</div>
										<div class="form-group form-group-sm">
											 <label class="col-sm-1 control-label" ><input type="checkbox" value="1" name="SHUANGTUO" id="SHUANGTUO">双拖</label>
											 <label class="col-sm-2 control-label" id="p_beigui"><input type="checkbox" value="1" name="BEIGUI" id="BEIGUI" >备柜</label>
											 <label class="col-sm-2 control-label" id="p_shuaigui"><input type="checkbox" value="1" name="SHUAIGUI" id="SHUAIGUI">甩柜</label>
											 <label class="col-sm-2 control-label" id="p_yichang" ><input type="checkbox" value="1" name="YICHANG" id="YICHANG">移场</label>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="panel panel-default" style="display: none;"  id="condition2">
							<div class="panel-heading">双拖箱子信息</div>
							<div class="tab-content">
								<div class="tab-pane active">
									<div class="panel-body">
										<div class="form-group form-group-sm">
											<div class="row">
												<div class="col-sm-12">
													<label class="col-sm-1 control-label" >箱号：</label>
													<div class="col-sm-2">
														<input type="text" id="BOX_NO" name="BOX_NO" class="form-control" />
														<select id="BOX" name="BOX" class="form-control" onchange="selectSTBox(this)">
															<option value="">请选择</option>
														</select>
													</div>
													<label class="col-sm-1 control-label"
														for="exampleInputPassword2"><span style="color: red;">*</span>调度名称:</label>
													<div class="col-sm-2">
														 <select id="COMMAND1" name="COMMAND1" class="form-control required" onchange="selectSTCommand(this)">
															 <option value="">请选择</option>
														 </select> 
														<!-- <div class="input-group" id="A_COMMAND1"></div> -->
													</div>
													<label class="col-sm-1 control-label"
														for="exampleInputPassword2">铅封号:</label>
													<div class="col-sm-2">
														<input type="text" id="SEAL_NO" name="SEAL_NO" maxlength="20" onchange="checkQfh();" value="${responseDataForm.resultObj[0].SEAL_NO }"  class="form-control input-sm"/>
													</div>
												</div>
											</div>
										</div>
										
										<div class="form-group form-group-sm">
											<label class="col-sm-1 control-label" >起点：</label>
											<div class="col-sm-2">
												<!-- <select id="FROM1"  name="FROM1" class="form-control"></select> -->
												<div class="input-group" id="A_FROM1"></div>
											</div>
											<label class="col-sm-1 control-label"
												for="exampleInputPassword2">终点:</label>
											<div class="col-sm-2">
												<!-- <select id="TO1"  name="TO1" class="form-control"></select> -->
												<div class="input-group" id="A_TO1"></div>
											</div>
										</div >
									</div>
								</div>
							</div>
						</div>
						<div class="panel panel-default">
							<div class="panel-heading">反馈信息</div>
							<div class="tab-content">
								<div class="tab-pane active">
									<div class="panel-body">
										<table>
											<c:forEach items="${responseDataForm.resultObj }" var="row"  varStatus="status">
												<tr>
													<td style="width:180px">
														<c:if test="${row.PIC_1 != null}">
																<img name="PIC_1" src='${row.PIC_1 }' style="margin-left: 10px;"  alt="" width="180" height="100" id="PIC_1" onerror="javascript:this.src='${resRoot}/img/1.png';"/>
														</c:if>
													</td>
													<td style="width:180px">
														<c:if test="${row.PIC_2 != null}">
															<img name="PIC_2" src='${row.PIC_2 }' style="margin-left: 10px;" alt="" width="180" height="100" id="PIC_2" onerror="javascript:this.src='${resRoot}/img/1.png';"/>
														</c:if>
													</td>
													<td style="width:180px">
														<c:if test="${row.PIC_3 != null}">
															<img name="PIC_3" src='${row.PIC_3 }' style="margin-left: 10px;" alt="" width="180" height="100" id=PIC_3 onerror="javascript:this.src='${resRoot}/img/1.png';"/>
														</c:if>
													</td>
													<td>
														<c:if test="${row.REMARK != null}">
															<textarea rows="5px" cols="30px"  id="REMARK" name="REMARK" disabled="disabled" >${row.REMARK }</textarea>
														</c:if>
													</td>
												</tr>
											</c:forEach>
										</table>
									<%-- <c:forEach items="${responseDataForm.resultObj }" var="row"  varStatus="status">
										<div class="form-group form-group-sm">
										<c:if test="${row.PIC_1 != null}">
											<div class="col-sm-2">
												<img name="PIC_1" src='${row.PIC_1 }' style="margin-left: 10px;"
												 alt="" width="180" height="100" id="PIC_1" onerror="javascript:this.src='${resRoot}/img/1.png';"/>
											</div>
										</c:if>
										<c:if test="${row.PIC_2 != null}">
												<div class="col-sm-2">
													<img name="PIC_2" src='${row.PIC_2 }' style="margin-left: 10px;"
													 alt="" width="180" height="100" id="PIC_2" onerror="javascript:this.src='${resRoot}/img/1.png';"/>
												</div>
										</c:if>
										<c:if test="${row.PIC_3 != null}">
												<div class="col-sm-3">
													<img name="PIC_3" src='${row.PIC_3 }' style="margin-left: 10px;"
													 alt="" width="180" height="100" id=PIC_3 onerror="javascript:this.src='${resRoot}/img/1.png';"/>
												</div>
										</c:if>
										<c:if test="${row.REMARK != null}">
											<div class="col-sm-4">
												<textarea rows="5px" cols="30px"  id="REMARK" name="REMARK" disabled="disabled" >${row.REMARK }</textarea>
											</div>
										</c:if>
										</div>
										</c:forEach> --%>
									</div>
								</div>
							</div>
							</div>
						<div id="form_foot_tool" style="float: right ;padding-right: 20px;padding-bottom: 10px">
                          <button type="button" class="btn btn-sm btn-primary" style="padding-bottom: 4px;"  onclick="save();"><i class="glyphicon glyphicon-ok">保存</i></button>
                          <button type="button" class="btn btn-sm btn-danger" style="padding-bottom: 4px;" onclick="cancelme();"><i class="glyphicon glyphicon-remove">取消</i></button>
						</div>
						</form>
					</div>
					
				</div>
			</div>
		</div>
	</div>
	</body>
<script  type="text/javascript">
var st_box_take_area  = -1; // 双拖箱子的提箱地点
var default_park = -1; // 默认停车场
var last_to_area = ""; // 司机最后一条调度的终点
//双拖勾选框触发事件
$("#SHUANGTUO").change(function(){
	if($("input[id='SHUANGTUO']").is(':checked')){
		$("#condition2").show();
	}else{
		$("#condition2").hide();
	}
	
});
$("#WAIXIE").change(function(){
	if($("input[id='WAIXIE']").is(':checked')){
		$("#OUT_HELP").attr("disabled",false);
	}else{
		$("#OUT_HELP").attr("disabled",true);
		$("#OUT_HELP").val("");
		
	}
	
});
$(function(){
		
	// 获取默认停车场
	$.ajax({
		url:"${ctxPath}/topic/ajax/getDefaultPark",
		type:"post",
		dataType:"json",
		success:function(json){
			json = json.resultObj;
			default_park = json.NAME;
		}
	});
	
		/* $s.init($("#A_COMMAND"), {
			sysdict : $sysdict.SCHEDULENAME,
			defVal:"${responseDataForm.resultObj[0].COMMAND}",
			VdefVal:"${responseDataForm.resultObj[0].COMMANDTEXT}",
			vID:"COMMAND"
		}); */
		// 初始化调度名称
		$.each($sysdict.SCHEDULENAME.value,function(index,e){
			var temp= "";
			if('${responseDataForm.resultObj[0].COMMAND}' == e.ID){
				temp = "selected";
			}
			var option="<option "+temp+" value=\""+e.ID+ "\" >"+e.TEXT+ "</option>" ;
			$("#COMMAND").append(option);
		});
		
		//添加司机下拉框
		$s2.init($("#DRIVER"), {
			tabdict : "driver",
			defVal:"${responseDataForm.resultObj[0].DRIVER_ID}",
			width:"150px",
			isSear:"1"
		});
		//添加车牌下拉框
		$s2.init($("#TRUCK_PLATE"), {
			tabdict : "plate",
			defVal:"${responseDataForm.resultObj[0].TRUCK_ID}",
			width:"150px"
		});
		// 车辆选择变化事件
		$("#TRUCK_PLATE").change(function(){ 
			$.ajax({
				url:"${ctxPath}/topic/ajax/getTruckLastScheduele",
				data:{"truck_id":$(this).val()},
				dataType:"json",
				type:"post",
				success:function(json){
					json = json.resultObj;
					last_to_area = json.TO;
				}
			});
		});
		
		//添加车架下拉框
		$s2.init($("#TRUCK_FRAME"), {
			tabdict :"frame",
			defVal:"${responseDataForm.resultObj[0].TRUCK_FRAME_ID}",
			width:"150px"
		});
		// 选择司机加载对应车辆/车架信息
		$("#DRIVER").change(function(){
			var _driver_id = $(this).val();
			if(_driver_id != ''){
				$.ajax({
					url:"${ctxPath}/topic/ajax/getDriverInfo",
					data:{"driverId":_driver_id},
					dataType:"json",
					type:"post",
					success:function(json){
						json = json.resultObj;
						// 设置司机的默认车牌信息
						if(json.DEFAULT_TRUCK != ''){
							$("#TRUCK_PLATE").select2({"width":"150px"}).val(json.DEFAULT_TRUCK).trigger("change");
						}else{
							$("#TRUCK_PLATE").select2({"width":"150px"}).val("").trigger("change");
						}
						// 设置司机的默认车架信息
						if(json.DEFAULT_FRAME != ''){
							$("#TRUCK_FRAME").select2({"width":"150px"}).val(json.DEFAULT_FRAME).trigger("change");
						}else{
							$("#TRUCK_FRAME").select2({"width":"150px"}).val("").trigger("change");
						}
					},
					error: function(XMLHttpRequest, textStatus, errorThrown){

					}
				});
			}else{ // 司机不存在默认车辆/车架时
				$("#TRUCK_PLATE").select2({"width":"150px"}).val("").trigger("change");
				$("#TRUCK_FRAME").select2({"width":"150px"}).val("").trigger("change");
			}
		});
		
		//调度名称为送箱的情况下才显示移场跟甩柜
		if('${responseDataForm.resultObj[0].COMMAND}'=='2'){
			 //$("#condition").css("display","block");
// 			 $("#p_shuaigui").show();
			 $("#p_yichang").show();
		}else{
// 			 $("#p_shuaigui").hide();
			 $("#p_yichang").hide();
		}
		//调度名称为提箱时候才有备柜
		if('${responseDataForm.resultObj[0].COMMAND}'=='1'){
			 //$("#condition").css("display","block");
			 $("#p_beigui").show();
		}
		else{
			$("#p_beigui").hide(); 
		}
		//空重状态下的下拉框
		 $.each($sysdict.EMPTY_STATUS.value,function(index,e){
				var temp= "";
				if('${responseDataForm.resultObj[0].EMPTY_STATUS}' == e.ID){
					temp = "selected";
				}
				var option="<option "+temp+" value=\""+e.TEXT+ "\" >"+e.TEXT+ "</option>" ;
				$("#EMPTY_STATUS").append(option);
			});
		/* 样式设为 select2 并取消搜索框 */
		 $("#EMPTY_STATUS").select2({minimumResultsForSearch: Infinity,});
		/* $s.init($("#A_EMPTY_STATUS"), {
			sysdict : $sysdict.EMPTY_STATUS,
			defVal:"${responseDataForm.resultObj[0].EMPTY_STATUS}",
			VdefVal:"${responseDataForm.resultObj[0].EMPTY_STATUS}",
			vID:"EMPTY_STATUS"
		}); */
		/* 起点、终点下拉框初始化 */
		$s_area.init($("#A_FROM"), {
			tabdict : "dict_area",
			defVal:"${responseDataForm.resultObj[0].FROM}",
			VdefVal:"${responseDataForm.resultObj[0].FROM_TEXT}",
			vLng:"${responseDataForm.resultObj[0].FROM_LNG}",
			vLat:"${responseDataForm.resultObj[0].FROM_LAT}",
			vAreaId:"${responseDataForm.resultObj[0].FROM_AREA_ID}",
			//isRead:'${param.status}',
			vID:"FROM"
		});
		$s_area.init($("#A_TO"), {
			tabdict : "dict_area",
			defVal:"${responseDataForm.resultObj[0].TO}",
			VdefVal:"${responseDataForm.resultObj[0].TO_TEXT}",
			vLat:"${responseDataForm.resultObj[0].TO_LAT}",
			vLng:"${responseDataForm.resultObj[0].TO_LNG}",
			vAreaId:"${responseDataForm.resultObj[0].TO_AREA_ID}",
			//isRead:'${param.status}',
			vID:"TO"
		});
		// 双拖起点
		$s_area.init($("#A_FROM1"), {
			tabdict : "dict_area",
			isRead:'${param.status}',
			vID:"FROM1"
		});
		// 双拖终点
		$s_area.init($("#A_TO1"), {
			tabdict : "dict_area",
			isRead:'${param.status}',
			vID:"TO1"
		});
		//调度中心下拉框
		$s2.init($("#SCHEDULE_CENTER"), {
			tabdict : "schedule_center",
			defVal:"${responseDataForm.resultObj[0].SCHEDULE_CENTER}",
		});
/* 		$s.init($("#A_SCHEDULE_CENTER"), {
			tabdict : "schedule_center",
			defVal:"${responseDataForm.resultObj[0].SCHEDULE_CENTER}",
			VdefVal:"${responseDataForm.resultObj[0].CENTER_NAME}",
			vID:"SCHEDULE_CENTER"
		}); */
		if('${responseDataForm.resultObj[0].WAIXIE}'=='1'){
			$("#WAIXIE").attr("checked",true);
			$("#OUT_HELP").attr("disabled",false);
		}else{
			$("#OUT_HELP").attr("disabled",true);
		}
		  // 是否存在双拖信息
		if('${responseDataForm.resultObj[0].SHUANGTUO}'=='1'){
			$("#SHUANGTUO").attr("checked",true);
			$("#condition2").show();
			$("#COMMAND1").attr("disabled","disabled");
		//	$("#SHUANGTUO").attr("disabled",true);
			loadNextBox();
			$("#BOX").hide();
		}else{
			$.ajax({
				  type:'post',
				  url:"${ctxPath}/topic/ajax/boxlist?boxId="+'${param.boxId}',
				  data:"tag="+$("#add_dict_tag").val(),
				  dataType:'json',
				  async:false,
				  success:function(json){
					  json=json.resultObj; 
//	 				 console.info(json);
					  $.each(json,function(index,item){
							var st = "";
							var option="<option  value=\""+item.ID+"\" >"+item.NO+"</option>";
							$("#BOX").append(option);
						});
				  }
			  });
			  $("#BOX").select2(); 
			  $("#BOX_NO").hide();
			  
			 $s2.init($("#COMMAND1"), {
				sysdict : $sysdict.SCHEDULENAME,
			});
		}
		if('${responseDataForm.resultObj[0].SHUAIGUI}'=='1'){
			$("#SHUAIGUI").attr("checked",true);	
		}
		if('${responseDataForm.resultObj[0].BEIGUI}'=='1'){
			$("#BEIGUI").attr("checked",true);	
		}
		if('${responseDataForm.resultObj[0].YICHANG}'=='1'){
			$("#YICHANG").attr("checked",true);	
		}
		
});
<%--	function selectme(){--%>
<%--		$.pdialog.open("${ctxPath}/topic/showDriver?tag="+$("#add_dict_tag").val(), "showDriver", "司机列表", {mask:true,width:700,height:500});--%>
<%--	}--%>
	function loadNextBox(){
		var schedule_id='${responseDataForm.resultObj[0].SHUANGTUO_SCHEDULE_ID}';
		$.ajax({
			  type:'post',
			  url:"${ctxPath}/topic/ajax/shuangtuoSchedule",
			  data:"schedule_id="+schedule_id,
			  dataType:'json',
			  async:false,
			  success:function(json){
				  json=json.resultObj;
				  //alert(json.BOX_ID);
// 				  $("#BOX option[value='"+json.BOX_ID+"']").attr("selected", true);
				  //$("#COMMAND1 option[value='"+json.COMMAND+"']").attr("selected", true);
				  //$("#FROM1 option[value='"+json.FROM+"']").attr("selected", true);
				  //$("#TO1 option[value='"+json.TO+"']").attr("selected", true);
				  
				 	/* 旧初始化地点下拉框方法 */
					/* $s.init($("#A_FROM1"), {
						tabdict : "dict_area",
						defVal:json.FROM,
						VdefVal:json.FROM_TEXT,
						vID:"FROM1"
					});
					$s.init($("#A_TO1"), {
						tabdict : "dict_area",
						defVal:json.TO,
						VdefVal:json.TO_TEXT,
						vID:"TO1"
					}); */
					// 箱号可修改 使用 input 类型
					// $("#BOX").select2().val(json.BOX_ID).trigger("change");
					 $("#BOX_NO").val(json.BOX_NO);
					
					/** ******* 新 ******* **/
					setCommandDefaultArea("FROM1",{"name":json.FROM }); // 设置双拖起点
					setCommandDefaultArea("TO1",{"name":json.TO}); // 设置双拖终点
					
				  var command = json.COMMAND;
				  $s2.init($("#COMMAND1"), {
						sysdict : $sysdict.SCHEDULENAME,
						defVal:command
					});
				 /*  $("#BOX").attr("disabled",true); 箱子箱号信息可以修改*/
			  }
		  });
	}
	// 保存
function save(){
	//验证必填项
	if(isEmpty($("#V_FROM").val())) {
		swal("","起点不能为空！","error");
		return false;
	}
	if(isEmpty($("#V_TO").val())) {
		swal("","终点不能为空！","error");
		return false;
	}
	
	if('${responseDataForm.resultObj[0].SHUANGTUO}'=='1'){
		$("#IS_SHUANGTUO").val("0");//0表示编辑页一进来就有双拖
		$("#SHUANGTUO_SCHEDULE_ID").val('${responseDataForm.resultObj[0].SHUANGTUO_SCHEDULE_ID}');
	}else{
		if($("input[id='SHUANGTUO']").is(':checked')){
			$("#IS_SHUANGTUO").val("1");//选中双拖勾选框
		}else{
			$("#IS_SHUANGTUO").val("2");//未选中双拖勾选框
		}
	}
	
<%--	$("#editPortFrom").submit();--%>
<%--	$.pdialog.closeCurrent(); --%>
<%--	refreshScheduleList();--%>
	$("#editPortFrom").validate({
		submitHandler : function(form) {
			$.ajax({
	 			type : "POST",
	 			url : "${ctxPath}/topic/ajax/editOldBoxSchedule",
	 			data : $("#editPortFrom").serialize(),
	 			dataType : "json",
	 			async : false,
	 			success : function(json) {
	 				if (json.result == '1') {
	 					//swal("添加成功！", "", "success");
	 					//parent.refreshScheduleList();
	 					//parent.layer.close(parent.layer.getFrameIndex(window.name)); 
	 					swal({
							title : json.resultInfo,
							type : "success",
							showCancelButton : false,
							confirmButtonColor : "#A7D5EA",
							confirmButtonText : "确定",
							closeOnConfirm : false
						}, function() {
							//刷新表格，关闭弹窗
							parent.refreshScheduleList();
		 					parent.layer.close(parent.layer.getFrameIndex(window.name)); 
						});
	 				} else {
	 					swal("", json.resultInfo, "error");
	 					return;
	 				}
	 			},
	 			error : function(json) {
	 					swal("", json.responseText, "error");
	 				}
	 			}); 
		}
	});		
	$("#editPortFrom").submit();
}
function cancelme(){
	parent.layer.close(parent.layer.getFrameIndex(window.name)); 
}

//双拖箱子选中事件
function selectSTBox(obj){
	var value = $(obj).val();
	getSTBoxTake(value);// 获取双拖箱子提箱地点
	getQfh(value);
}
//获取双拖箱子的提箱地点
function getSTBoxTake(boxId){
	$.ajax({
		url:"${ctxPath}/topic/ajax/getBoxTakeArea",
		data:{"box_id":boxId},
		type:"post",
		dataType:"json",
		success:function(json){
			json = json.resultObj;
			st_box_take_area = json.ADDR_TX;
		}
	});
}
//获取铅封号
function getQfh(value) {
	$.ajax({
		  type:'post',
		  url:"${ctxPath}/topic/ajax/getBoxByBoxId",
		  data:"box_id="+value,
		  dataType:'json',
		  async:false,
		  success:function(json){
			  json=json.resultObj; 
			  if(json.SEAL_NO){
				  $("#SEAL_NO").val(json.SEAL_NO);
			  }else{
				  $("#SEAL_NO").val("");
			  }
		  }
	  });
}


//判断铅封号是否存在
function checkQfh(){
	if($("#SEAL_NO").val() != undefined && $("#SEAL_NO").val != "" ) {
		$.ajax({
			  type:'post',
			  url:"${ctxPath}/topic/ajax/checkQfhByBoxId",
			  data:{"box_id":$("#SHUANGTUO_BOX_ID").val(),"seal_no":$("#SEAL_NO").val()},
			  dataType:'json',
			  async:false,
			  success:function(json){
				  json=json.resultObj; 
				  if(json.NUM == 1) {
					  $("#SEAL_NO").focus();
					  swal("铅封号已经存在！", "", "warning");
				  }
				
			  }
		  });
	}
	
}

//双拖箱子调度名称选择事件
function selectSTCommand(obj){
	 // 如果原先不是双拖箱子
	if('${responseDataForm.resultObj[0].SHUANGTUO}'!='1'){
		if($(obj).val()=='1'){ // 提箱操作
			if(last_to_area){ // 如果车辆存在调度信息
				setCommandDefaultArea("FROM1",{"name":last_to_area}); // 车辆最后一条调度的终点设为提箱起点
			}else{ // 地点管理里头设置默认停车场为提箱起点
				setCommandDefaultArea("FROM1",{"name":default_park}); // 设置默认起点
			}
			setCommandDefaultArea("TO1",{"name":st_box_take_area}); // 双拖箱子提箱地点为终点
		}else if($(obj).val()=='2'){ // 送箱操作
			// 送箱：提箱地点(起)－拖箱地点(终)
			setCommandDefaultArea("FROM1",{"name":st_box_take_area}); // 设置默认起点
			setCommandDefaultArea("TO1",{"name":'${param.st_box_drag_area}'}); // 设置默认终点
		}else if($(obj).val() == '3'){ // 回箱操作
			//拖箱地点(起)－默认停车场(终)（地点管理里头设置默认停车场）
			setCommandDefaultArea("FROM1",{"name":'${param.st_box_drag_area}'}); // 设置默认起点
			setCommandDefaultArea("TO1",{"name":default_park}); // 默认终点为停车场
		}else if($(obj).val() == '4'){ // 进场操作
			// 默认停车场(起)－返箱地点(终)
			setCommandDefaultArea("FROM1",{"name":default_park}); // 默认起点为停车
			setCommandDefaultArea("TO1",{"name":'${param.box_return}'}); // 设置默认终点
		}else{
			setCommandDefaultArea("FROM1",{"name":-1}); // 清空默认起点
			setCommandDefaultArea("TO1",{"name":-1}); // 清空默认终点
		}
	}
}
/*
* obj:html 元素 id 仅  FROM / TO 
* data:请求参数 data:{id:"",name:""}
*/
function setCommandDefaultArea(obj,data){
	$.ajax({
		url:"${ctxPath}/topic/ajax/getAreaById",
		data:data,
		dataType:"json",
		type:"post",
		success:function(json){
			json = json.resultObj;
			$("#"+obj).val(json.CODE);
			$("#LAT_"+obj).val(json.LAT);
			$("#LNG_"+obj).val(json.LNG);
			$("#AREA_ID_"+obj).val(json.ID);
			$("#V_"+obj).val(json.NAME);
		}
	});
}
//回调双拖箱子信息
/* var st_box_drag = ""; // 双拖拖箱地点
var st_load_port = ""; // 装运港
function checkSTBoxScheduleInfo(value){
	// 双拖箱子调度命令信息
	var box_take = "";
	$.ajax({
		url:"${ctxPath}/topic/ajax/getSTScheduleInfo",
		data:{"st_box_id":value},
		dataType:"json",
		type:"post",
		success:function(json){
			json = json.resultObj;
			if(json.COMMAND){
				$("#COMMAND1 option").each(function(index,item){
					if($(this).val() != ""){
						if(json.COMMAND.indexOf($(this).val()) >-1 ){ // 已经存在的调度命令设为禁用
							$(this).attr("disabled","disabled");
						}else{
							$(this).attr("disabled",false);
						}
					}
				});
				$s2.init($("#COMMAND1"));
				box_take = json.BOX_TAKE; // 提箱地点
				st_box_drag = json.BOX_DRAG;
				st_load_port = json.LOAD_PORT;
			}else{
				// 移除所有禁用设置
				$("#COMMAND1 option").each(function(index,item){
					$(this).attr("disabled",false);
				});
				$s2.init($("#COMMAND1"));
			}
		}
	});
	// 双拖箱子起点、终点信息
	$.ajax({
		url:"${ctxPath}/topic/ajax/getSTArea",
		data:{"st_box_id":value},
		dataType:"json",
		type:"post",
		success:function(json){
			json = json.resultObj;
			if(json.FROM){
				setCommandDefaultArea("FROM1",{"name":json.FROM});
			}else if(box_take){
				setCommandDefaultArea("FROM1",{"name":box_take});
			}else{
				setCommandDefaultArea("FROM1",{"name":-1});
			}
		}
	});
} */
</script>
</html>
