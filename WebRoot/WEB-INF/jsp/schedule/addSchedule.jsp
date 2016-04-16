<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>
<%
	Date date = new java.util.Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	String LgTime = sdf.format(date);  
%>
<c:set var="now" value="<%=LgTime%>" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>新增箱子调度</title>
    <jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
  <%--   <jsp:include page="/WEB-INF/jsp/formSubmit.jsp"></jsp:include> --%>
     
</head>


<body class="white-bg" >
	<div class="wrapper wrapper-content animated fadeInRight">
	
		<div class="row">
			<div class="col-sm-12">
				<form id="addSceduleForm" class="form-horizontal" action="${ctxPath}/topic/ajax/addSchedule">
				<input type="hidden" id="BOX_ID" name="BOX_ID" value="${param.box_id}" />
				<input type="hidden" id="ORDER_ID" name="ORDER_ID" value="${responseDataForm.resultObj[0].ORDER_ID}" />
				<%-- <input type="hidden" id="B_COMMAND" name="B_COMMAND" value="${param.COMMAND}" /> --%>
				<input type="hidden" id="user_tag" name="tag" value="${sessionScope.SESSION_USER_LOGIN_INFO.userInfo.TAG }"/>
				
				<div class="ibox-content" style="padding-top:5px;">
				<div class="panel panel-default" >
					<div class="panel-heading">任务分配信息</div>
					<div class="tab-content">
						<div class="tab-pane active">
							<div class="panel-body">
								<div class="form-group form-group-sm">
									<label class="col-sm-2 control-label" ><span style="color: red;">*</span>司机：</label>
									<div class="col-sm-2">
										<select class="combox" id="DRIVER_ID" name="DRIVER_ID">
											<option value="">请选择</option>
										</select>
									</div>
									<label class="col-sm-2 control-label" ></label>
									<label class="col-sm-2 control-label"
										for="exampleInputPassword2"><span style="color: red;">*</span>派车时间:</label>
									<div class="col-sm-2">
										<!-- <input style="width: 150px" class="form_date required" type="text" id="A_SEND_TIME" name="SEND_TIME" 
											value=""  data-date-format="yyyy-mm-dd hh:ii" placeholder="YYYY-MM-DD hh:mm" /> -->
										<input type="text" id="A_SEND_TIME" name="SEND_TIME"  placeholder="YYYY-MM-DD hh:mm" onclick="laydate({istime: true,start:laydate.now(0,'YYYY-MM-DD hh:mm'), format: 'YYYY-MM-DD hh:mm'})" value="${now}" class="form-control input-sm  layer-date required"/>
									</div>
								</div>
								
								<div class="form-group form-group-sm">
									<label class="col-sm-2 control-label" ><span style="color: red;">*</span>车牌：</label>
									<div class="col-sm-2">
										<select id="A_TRUCK_ID"  name="TRUCK_ID" class="form-control required">
											<option value="">请选择</option>
										</select> 
										<!-- <div class="input-group" id="AA_TRUCK_ID"></div> -->
									</div>
									<label class="col-sm-2 control-label"></label>
									<label class="col-sm-2 control-label"
										for="exampleInputPassword2"><span style="color: red;">*</span>车架:</label>
									<div class="col-sm-2">
										<select id="A_TRUCK_FRAME_ID"  name="TRUCK_FRAME_ID" class="form-control required">
											<option value="">请选择</option>
										</select>
										<!-- <div class="input-group" id="AA_TRUCK_FRAME_ID"></div> -->
									</div>
								</div>
							</div>
							
							<div class="form-group form-group-sm">
									<div class="col-sm-1 col-sm-offset-10">
		                            
		                               <!-- <button type="button" class="btn btn-white" onclick="cancelLayer()">取消</button> --> 
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
									<label class="col-sm-2 control-label" ><span style="color: red;">*</span>调度名称：</label>
									<div class="col-sm-2">
										<select id="A_COMMAND" name="A_COMMAND" class="form-control required" onchange="showCheckBox(this)">
											<option value="">请选择</option>
										</select>
										<!-- <div class="input-group" id="AA_COMMAND"></div> -->
									</div>
									<label class="col-sm-2 control-label" >调度中心：</label>
									<div class="col-sm-2">
										<select id="A_SCHEDULE_CENTER"  name="SCHEDULE_CENTER" class="form-control">
											<option value="">请选择</option>
										</select>  
										<!-- <div class="input-group" id="AA_SCHEDULE_CENTER"></div> -->
									</div>
									<label class="col-sm-2 control-label" ><input type="checkbox" value="1" name="SHUANGTUO" id="A_SHUANGTUO"  onclick="isShowShuangtuo();">双拖</label>
								</div>
								<div class="form-group form-group-sm">
									<label class="col-sm-2 control-label" ><span style="color: red;">*</span>起点：</label>
									<div class="col-sm-2">
										<!-- <select id="A_FROM"  name="FROM" class="form-control required"></select> -->
										<div class="input-group" id="AA_FROM"></div>
									</div>
									<label class="col-sm-2 control-label"
										for="exampleInputPassword2">空重状态：</label>
									<div class="col-sm-2">
										<select class="combox" id="EMPTY_STATUS" name="EMPTY_STATUS">
											<option value="">请选择</option>
										</select>
									</div>
									 <label class="col-sm-2 control-label" ><input type="checkbox" value="1" name="SHUAIGUI" id="A_SHUAIGUI">甩柜</label>
								</div>
								<div class="form-group form-group-sm">
									<label class="col-sm-2 control-label" ><span style="color: red;">*</span>终点：</label>
									<div class="col-sm-2">
										<!-- <select id="A_TO"  name="TO" class="form-control required"></select> -->
										<div class="input-group" id="AA_TO"></div>
									</div>
									<label class="col-sm-2 control-label" ><input type="checkbox"   value="1" name="WAIXIE" id="A_WAIXIE"/>外协</label>
									<div class="col-sm-2">
										<input type="text" id="A_OUT_HELP"  name="OUT_HELP"  maxlength="20" class="form-control input-sm">
									</div>
									 <label class="col-sm-2 control-label" id="p_beigui"><input type="checkbox" value="1" name="BEIGUI" id="A_BEIGUI" >备柜</label>
									 <label class="col-sm-2 control-label" id="p_yichang"><input type="checkbox" value="1" name="YICHANG" id="A_YICHANG">移场</label>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="panel panel-default" style="display: none;"  id="stxzxx">
					<div class="panel-heading">双拖箱子信息</div>
					<div class="tab-content">
						<div class="tab-pane active">
							<div class="panel-body">
								<div class="form-group form-group-sm">
									<label class="col-sm-2 control-label" >箱号：</label>
									<div class="col-sm-2">
										<!-- <select id="A_SHUANGTUO_BOX_ID"  name="SHUANGTUO_BOX_ID" onchange="getQfh();" class="form-control"></select>
										 -->
										 <!-- <div class="input-group">
				                            <input type="hidden" class="form-control" id="A_SHUANGTUO_BOX_ID" name="SHUANGTUO_BOX_ID" >
				                            <input type="text" class="form-control" id="V_SHUANGTUO_BOX_ID" name="V_SHUANGTUO_BOX_ID" >
				                            <div class="input-group-btn" >
				                                <button type="button" class="btn btn-white dropdow	n-toggle" data-toggle="dropdown">
				                                    <span class="caret"></span>
				                                </button>
				                                <ul class="dropdown-menu dropdown-menu-right" role="menu" style="">
				                                </ul>
				                            </div>
				                            /btn-group
				                        </div> -->
				                        <div class="input-group" id="AA_SHUANGTUO_BOX_ID"></div>
									</div>
									<label class="col-sm-2 control-label"
										for="exampleInputPassword2">铅封号:</label>
									<div class="col-sm-2">
										<input type="text" id="A_SEAL_NO" name="A_SEAL_NO" maxlength="20" onchange="checkQfh();"  class="form-control input-sm"/>
									</div>
								</div>
								
								<div class="form-group form-group-sm">
									<label class="col-sm-2 control-label" ><span style="color: red;">*</span>调度名称：</label>
									<div class="col-sm-2">
										<select id="ST_COMMAND" name="ST_COMMAND" class="form-control" onchange="selectSTCommand(this)">
											<option value="">请选择</option>
										</select> 
										<!-- <div class="input-group" id="A_ST_COMMAND"></div> -->
									</div>
									
								</div>
								
								<div class="form-group form-group-sm">
									<label class="col-sm-2 control-label" >起点：</label>
									<div class="col-sm-2">
										<!-- <select id="A_ST_FROM"  name="ST_FROM" class="form-control"></select> -->
										<div class="input-group" id="AA_ST_FROM"></div>
									</div>
									<label class="col-sm-2 control-label"
										for="exampleInputPassword2">终点:</label>
									<div class="col-sm-2">
										<!-- <select id="A_ST_TO"  name="ST_TO" class="form-control"></select> -->
										<div class="input-group" id="AA_ST_TO"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
				<div id = "form_foot_tool" style="float: right ;padding-right: 20px;padding-bottom: 10px">
							   <button type="button" class="btn btn-primary" onclick="saveSchedul()"><i class="glyphicon glyphicon-ok"></i>保存</button>
						</div>
				</form>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
	var last_to_area = ""; // 司机最后一条调度的终点
	var default_park = -1; // 默认停车场
	var box_take_area = -1 ; // 箱子提箱地点
	var st_box_take_area = -1; // 双拖箱子提箱地点
	$(document).ready(function(){
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
		// 获取箱子提箱地点
		$.ajax({
			url:"${ctxPath}/topic/ajax/getBoxTakeArea",
			data:{"box_id":'${param.box_id}'},
			type:"post",
			dataType:"json",
			success:function(json){
				json = json.resultObj;
				box_take_area = json.ADDR_TX;
			}
		});
		//判断是否备柜
		if("${param.COMMAND }"!="1") {
			$("#p_beigui").hide();
		}
		
		//判断是否移场
		if("${param.COMMAND }"!="2") {
			//$("#p_shuigui").hide();
			$("#p_yichang").hide();
		} 
		
		 //调度选择
		/* $s.init($("#AA_COMMAND"), {
			sysdict : $sysdict.SCHEDULENAME,
			defVal:"${param.V_COMMAND }",
			vID:"B_COMMAND"
		});	 */
/* 		$("#A_COMMAND").val('${param.COMMAND }'); */
	
		/** 加载调度名称下拉列表 ----start--- **/
		var command = "";
		var rows = parent.$("#scheduleHisList").find("tr"); // 获取调度历史列表
		$.each(rows,function(index,item){
			command += $(this).find("td").eq(2).text();// 编辑调度历史列表中已经出现的调度命令
		});
		$.each($sysdict.SCHEDULENAME.value,function(index,e){
			var temp= "";
			if('${param.COMMAND}' == e.ID){
				temp = "selected";
			}
			var disabled = "";
			if(command.indexOf(e.TEXT) != -1){ // 判断调度命令是否已经存在调度历史列表中
				disabled = "disabled"; // 设置已经存在的调度命令为不可选状态
			}
			var option="<option "+temp+" "+ disabled+ " value=\""+e.ID+ "\" >"+e.TEXT+ "</option>" ;
			$("#A_COMMAND").append(option);
		});
		$("#A_COMMAND").select2({
			minimumResultsForSearch:-1 // 取消搜索功能
		});
		/** 加载调度名称下拉列表 ----end--- **/
		
		 //双拖调度选择
		/* $s2.init($("#A_ST_COMMAND"), {
			sysdict : $sysdict.SCHEDULENAME,
			defVal:"${param.COMMAND }",
			vID:"ST_COMMAND"
		});	 */
		 //双拖调度下拉框
		$.each($sysdict.SCHEDULENAME.value,function(index,e){
			var temp= "";
			if('${param.COMMAND}' == e.ID){
				temp = "selected";
			}
			var option="<option "+temp+" value=\""+e.ID+ "\" >"+e.TEXT+ "</option>" ;
			$("#ST_COMMAND").append(option);
		});
		$s2.init($("#ST_COMMAND"));
	
		//空重状态
		$s2.init($("#EMPTY_STATUS"), {
			sysdict : $sysdict.EMPTY_STATUS,
			vID:"EMPTY_STATUS"
		});		
		
		//起点
		$s_area.init($("#AA_FROM"), {
			tabdict : "dict_area",
			vID:"FROM"
		});
// 		$s.init($("#AA_FROM"), {
// 			tabdict : "dict_area",
// 			vID:"FROM",
// 			listStyle: {
// 		        "overflow": "scroll",
// 		        "height":"200px"
// 		    }
// 		});
		
		//终点
		$s_area.init($("#AA_TO"), {
			tabdict : "dict_area",
			vID:"TO"
		});
		/* $s.init($("#AA_TO"), {
			tabdict : "dict_area",
			vID:"TO",
			listStyle: {
		        "overflow": "scroll",
		        "height":"200px"
		    }
		}); */
		
		//双拖起点
		$s_area.init($("#AA_ST_FROM"), {
			tabdict : "dict_area",
			vID:"ST_FROM"
		});
		/* $s.init($("#AA_ST_FROM"), {
			tabdict : "dict_area",
			vID:"ST_FROM",
			listStyle: {
		        "overflow": "scroll",
		        "height":"200px"
		    }
		}); */
		
		//双拖终点
		$s_area.init($("#AA_ST_TO"), {
			tabdict : "dict_area",
			vID:"ST_TO"
		});
		/* $s.init($("#AA_ST_TO"), {
			tabdict : "dict_area",
			vID:"ST_TO",
			listStyle: {
		        "overflow": "scroll",
		        "height":"200px"
		    }
		}); */
		
		//调度中心下拉框
		$s2.init($("#A_SCHEDULE_CENTER"), {
			tabdict : "schedule_center",
			defVal:"2558855", // 默认为马尾调度中心
		}); 
		/*  $s.init($("#AA_SCHEDULE_CENTER"), {
			tabdict : "schedule_center",
			vID:"SCHEDULE_CENTER",
			listStyle: {
		        "overflow": "scroll",
		        "height":"200px"
		    }
		});  */
		
		// 选择司机
		$("#DRIVER_ID").change(function(){
			setDriverInfo($(this).val()); // 设置司机对应信息：车牌号、车架号
		});
		//添加司机下拉框
		/* $s2.init($("#A_DRIVER_ID"), {
			tabdict : "driver",
			width:"250px"
		}); */
		//添加车牌下拉框
		$s2.init($C("#A_TRUCK_ID"), {// 车辆
			tabdict : "plate"
		});
		// 车辆选择变化事件
		$("#A_TRUCK_ID").change(function(){ 
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
		$s2.init($C("#A_TRUCK_FRAME_ID"), {//司机
			tabdict : "frame"
		});
		// 初始化双拖箱子下拉框
		$s.init($C("#AA_SHUANGTUO_BOX_ID"), {//箱号
			tabdict : "boxNo&boxId="+$("#BOX_ID").val(),
			vID : "SHUANGTUO_BOX_ID",
			listStyle:{
		        "overflow": "scroll",
		        "height":"200px"
		    },
		    callBack:"selectSTBox()" // 选中箱号，回调箱子相关信息：已存在调度命令，对应订单起点、终点
		});	
		$s2.init($C("#DRIVER_ID"), {//司机
			tabdict : "driver",
			isSear:1,  //【选填】 不填 下拉框默认无搜索框 
		});
		
		//表单保存校验
		$("#addSceduleForm").validate({
			submitHandler : function(form) {
				$.ajax({
		 			type : "POST",
		 			url : "${ctxPath}/topic/ajax/addSchedule",
		 			data : $("#addSceduleForm").serialize(),
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
	});
	/* 保存调度信息 */
	function saveSchedul(){
		var command = $("#A_COMMAND").val();
		var st_command = $("#ST_COMMAND").val();
		var from = $("#V_FROM").val();
		var to = $("#V_TO").val();
		var driver_id = $("#DRIVER_ID").val();
		var truck_id = $("#A_TRUCK_ID").val();
		var truck_frame_id = $("#A_TRUCK_FRAME_ID").val();
/* 		var truck_id = $("#TRUCK_ID").val();
		var truck_frame_id = $("#TRUCK_FRAME_ID").val(); */
		if(isEmpty(command)){
			alert("调度名称不能为空！");
			return false;
		}
		if($("input[id='A_SHUANGTUO']").is(':checked')) {
			if(isEmpty(st_command)){
				alert("双拖箱子调度名称不能为空！");
				return false;
			}
		}
		
		if(isEmpty(from)){
			alert("起点不能为空！");
			return false;
		}
		if(isEmpty(to)){
			alert("终点不能为空！");
			return false;
		}
		if(isEmpty(driver_id)){
			alert("司机不能为空！");
			return false;
		}
		if(isEmpty(truck_id)){
			alert("车牌不能为空！");
			return false;
		}
		if(isEmpty(truck_frame_id)){
			alert("车架不能为空！");
			return false;
		}
		
		$("#addSceduleForm").submit();
	}
	
	//是否双拖
	function isShowShuangtuo(){
		if($("input[id='A_SHUANGTUO']").is(':checked')) {
			$("#stxzxx").show();
		} else {
			$("#stxzxx").hide();
		}
	}
	
	// 双拖箱子选中事件
	function selectSTBox(){
		getSTBoxTake($("#SHUANGTUO_BOX_ID").val());// 获取双拖箱子提箱地点
		getQfh(); // 回填双拖箱子铅封号
	}
	// 获取双拖箱子的提箱地点
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
	function getQfh() {
		$.ajax({
			  type:'post',
			  url:"${ctxPath}/topic/ajax/getBoxByBoxId",
			  data:"box_id="+$("#SHUANGTUO_BOX_ID").val(),
			  dataType:'json',
			  async:false,
			  success:function(json){
				  json=json.resultObj; 
				  if(json.SEAL_NO){
					  $("#A_SEAL_NO").val(json.SEAL_NO);
				  }else{
					  $("#A_SEAL_NO").val("");
				  }
			  }
		  });
	}
	
	//判断铅封号是否存在
	function checkQfh(){
		if($("#A_SEAL_NO").val() != undefined && $("#A_SEAL_NO").val != "" ) {
			$.ajax({
				  type:'post',
				  url:"${ctxPath}/topic/ajax/checkQfhByBoxId",
				  data:{"box_id":$("#SHUANGTUO_BOX_ID").val(),"seal_no":$("#A_SEAL_NO").val()},
				  dataType:'json',
				  async:false,
				  success:function(json){
					  json=json.resultObj; 
					  if(json.NUM == 1) {
						  $("#A_SEAL_NO").focus();
						  swal("铅封号已经存在！", "", "warning");
					  }
				  }
			  });
		}
	}
	// 选中司机后调出车牌、车架信息
	function setDriverInfo(driver_id){
		// 选择司机加载对应车辆/车架信息
		if(driver_id != ''){
			$.ajax({
				url:"${ctxPath}/topic/ajax/getDriverInfo",
				data:{"driverId":driver_id},
				dataType:"json",
				type:"post",
				success:function(json){
					json = json.resultObj;
					// 设置司机的默认车牌信息
					if(json.DEFAULT_TRUCK != ''){
						$("#A_TRUCK_ID").select2().val(json.DEFAULT_TRUCK).trigger("change");;
					}else{
						$("#A_TRUCK_ID").select2().val("").trigger("change");;
					}
					// 设置司机的默认车架信息
					if(json.DEFAULT_FRAME != ''){
						$("#A_TRUCK_FRAME_ID").select2().val(json.DEFAULT_FRAME).trigger("change");;
					}else{
						$("#A_TRUCK_FRAME_ID").select2().val("").trigger("change");;
					}
				},
				error: function(XMLHttpRequest, textStatus, errorThrown){

				}
			});
		}else{ // 司机不存在默认车辆/车架时
			$("#TRUCK_ID").val("");
			$("#V_TRUCK_ID").val("");
			$("#TRUCK_FRAME_ID").val("");
			$("#V_TRUCK_FRAME_ID").val("");
		}
	}
	
	// 双拖箱子调度名称选择事件
	function selectSTCommand(obj){
		if($(obj).val()=='1'){ // 提箱操作
			if(last_to_area){ // 如果车辆存在调度信息
				setCommandDefaultArea("ST_FROM",{"name":last_to_area}); // 车辆最后一条调度的终点设为提箱起点
			}else{ // 地点管理里头设置默认停车场为提箱起点
				setCommandDefaultArea("ST_FROM",{"name":default_park}); // 设置默认起点
			}
			setCommandDefaultArea("ST_TO",{"name":st_box_take_area}); // 双拖箱子提箱地点为终点
		}else if($(obj).val()=='2'){ // 送箱操作
			// 送箱：提箱地点(起)－拖箱地点(终)
			setCommandDefaultArea("ST_FROM",{"name":st_box_take_area}); // 设置默认起点
			setCommandDefaultArea("ST_TO",{"name":'${param.box_drag}'}); // 设置默认终点
		}else if($(obj).val() == '3'){ // 回箱操作
			//拖箱地点(起)－默认停车场(终)（地点管理里头设置默认停车场）
			setCommandDefaultArea("ST_FROM",{"name":'${param.box_drag}'}); // 设置默认起点
			setCommandDefaultArea("ST_TO",{"name":default_park}); // 默认终点为停车场
		}else if($(obj).val() == '4'){ // 进场操作
			// 默认停车场(起)－返箱地点(终)
			setCommandDefaultArea("ST_FROM",{"name":default_park}); // 默认起点为停车
			setCommandDefaultArea("ST_TO",{"name":'${param.box_return}'}); // 设置默认终点
		}else{
			setCommandDefaultArea("ST_FROM",{"name":-1}); // 清空默认起点
			setCommandDefaultArea("ST_TO",{"name":-1}); // 清空默认终点
		}
	}
	
	//调度名称下拉框选中操作
	function showCheckBox(obj){
		var _io_type = '${param.in_out_type}'; // 进出类型
		if($(obj).val()=='1'){ // 提箱操作
			//进口-提箱-重箱；出口-提箱-空箱
			if(_io_type == "进口"){
				$("#EMPTY_STATUS").select2().val("重箱").trigger("change");
			}else if(_io_type == "出口"){
				$("#EMPTY_STATUS").select2().val("空箱").trigger("change");
			}
			if(last_to_area){ // 如果车辆存在调度信息
				setCommandDefaultArea("FROM",{"name":last_to_area}); // 车辆最后一条调度的终点设为提箱起点
			}else{ // 地点管理里头设置默认停车场为提箱起点
				setCommandDefaultArea("FROM",{"name":default_park}); // 设置默认起点
			}
			// 提箱地点为 默认终点 
			data = {"name":box_take_area};
			setCommandDefaultArea("TO",data); // 设置默认终点
			$("#p_yichang").hide(); // 隐藏移场选项
			$("#p_beigui").show(); // 显示备柜选项
		}else if($(obj).val()=='2'){ // 送箱操作
			if(_io_type == "出口"){
				$("#EMPTY_STATUS").select2().val("空箱").trigger("change");
			}else{
				$("#EMPTY_STATUS").select2().val("").trigger("change");
			}
			// 送箱：提箱地点(起)－拖箱地点(终)
			setCommandDefaultArea("FROM",{"name":box_take_area}); // 设置默认起点
			setCommandDefaultArea("TO",{"name":'${param.box_drag}'}); // 设置默认终点
			$("#p_yichang").show();// 显示移场选项
			$("#p_beigui").hide(); // 隐藏备柜选项
		}else if($(obj).val() == '3'){ // 回箱操作
			if(_io_type == "出口"){
				$("#EMPTY_STATUS").select2().val("重箱").trigger("change");
			}else{
				$("#EMPTY_STATUS").select2().val("").trigger("change");
			}
			//拖箱地点(起)－默认停车场(终)（地点管理里头设置默认停车场）
			setCommandDefaultArea("FROM",{"name":'${param.box_drag}'}); // 设置默认起点
			setCommandDefaultArea("TO",{"name":default_park}); // 默认终点为停车场
			$("#p_yichang").hide();// 隐藏移场选项
			$("#p_beigui").hide();// 隐藏备柜选项
		}else if($(obj).val() == '4'){ // 进场操作
			if(_io_type == "出口"){
				$("#EMPTY_STATUS").select2().val("重箱").trigger("change");
			}else{
				$("#EMPTY_STATUS").select2().val("").trigger("change");
			}
			// 默认停车场(起)－返箱地点(终)
			setCommandDefaultArea("FROM",{"name":default_park}); // 默认起点为停车
			setCommandDefaultArea("TO",{"name":'${param.box_return}'}); // 设置默认终点
			$("#p_yichang").hide();// 隐藏移场选项
			$("#p_beigui").hide();// 隐藏备柜选项
		}else{
			setCommandDefaultArea("FROM",{"name":-1}); // 清空默认起点
			setCommandDefaultArea("TO",{"name":-1}); // 清空默认终点
			$("#EMPTY_STATUS").select2().val("").trigger("change");
			$("#p_yichang").hide();// 隐藏移场选项
			$("#p_beigui").hide();// 隐藏备柜选项
		}
	}
	/*
	* 设置默认的起点、终点信息
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
	// 回调双拖箱子信息
	/* var st_box_drag = ""; // 双拖拖箱地点
	var st_load_port = ""; // 装运港
	function checkSTBoxScheduleInfo(){
		// 双拖箱子调度命令信息
		var box_take = "";
		$.ajax({
			url:"${ctxPath}/topic/ajax/getSTScheduleInfo",
			data:{"st_box_id":$("#SHUANGTUO_BOX_ID").val()?$("#SHUANGTUO_BOX_ID").val():-1},
			dataType:"json",
			type:"post",
			success:function(json){
				json = json.resultObj;
				if(json.COMMAND){
					$("#ST_COMMAND option").each(function(index,item){
						if($(this).val() != ""){
							if(json.COMMAND.indexOf($(this).val()) >-1 ){ // 已经存在的调度命令设为禁用
								$(this).attr("disabled","disabled");
							}else{
								$(this).attr("disabled",false);
							}
						}
					});
					$s2.init($("#ST_COMMAND"));
					box_take = json.BOX_TAKE; // 提箱地点
					st_box_drag = json.BOX_DRAG;
					st_load_port = json.LOAD_PORT;
				}else{
					// 移除所有禁用设置
					$("#ST_COMMAND option").each(function(index,item){
						$(this).attr("disabled",false);
					});
					$s2.init($("#ST_COMMAND"));
				}
			}
		});
		// 双拖箱子起点、终点信息
		$.ajax({
			url:"${ctxPath}/topic/ajax/getSTArea",
			data:{"st_box_id":$("#SHUANGTUO_BOX_ID").val()?$("#SHUANGTUO_BOX_ID").val():-1},
			dataType:"json",
			type:"post",
			success:function(json){
				json = json.resultObj;
				if(json.FROM){
					setCommandDefaultArea("ST_FROM",{"name":json.FROM});
				}else if(box_take){
					setCommandDefaultArea("ST_FROM",{"name":box_take});
				}else{
					setCommandDefaultArea("ST_FROM",{"name":-1});
				}
			}
		});
	} */
	</script>
</body>
</html>