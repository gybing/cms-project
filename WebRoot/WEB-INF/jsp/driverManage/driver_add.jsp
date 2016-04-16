<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>司机新增</title>
    <jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
    <jsp:include page="/WEB-INF/jsp/formSubmit.jsp"></jsp:include>
    <script type="text/javascript" src="${resRoot}/js/uuid.js" ></script>
    <script type="text/javascript" src="${resRoot}/js/jquery-form.js" ></script>
    <style>
	    /* 附件表格样式 */
		#show_driver_table tr th{
			/* font-size: 15px; */
			padding: 10px;
			background-color: #d6e4ef
		}
		#show_driver_table tr td img{
		padding: 1px 10px 1px 0px
		}
		#driverImgTable td {
			padding: 5px;
		}
		.imgTd img{
			width: 100px;
			height: 100px
		}
		.imgDiv{
			margin:10px;
			width: 108px;
			height: 108px;
			position: relative;
			display: inline-block;
		}
		.imgDiv .closeImg{
			width: 20px;
			height: 20px;
			top:-10px;
			right:-3px;
			background: url("${resRoot}/img/close.png") no-repeat scroll 0% 0%;
			position: absolute;
			cursor:pointer;
		}
		/* 附件表格样式 ===end*/
		
		
	</style>
</head>
<body class="">
	<div class="wrapper wrapper-content animated fadeInRight">
        
        <form class="form-horizontal" id="driverAddForm" method="post" action="${ctxPath}/topic/ajax/addDriver" data-id="${param.pdataId}" callback="">
        <div class="ibox">
			<div class="ibox-content" style="border-color: #fff;">
                <div class="panel panel-default">
                    <div class="panel-heading" style="padding: 5px">
                   		 <span style="font-weight: bold;">基本信息</span>
                    </div>
                    <div class="panel-body">
                            <input id="tag" name="tag" type="hidden" value="${sessionScope.SESSION_USER_LOGIN_INFO.userInfo.TAG }"/>
                            <input type="hidden" id="driverId" name="driverId" value=""/>
                            <div class="form-group">
                                <label class="col-sm-1 control-label">司机姓名:</label>
                                <div class="col-sm-2">
	                                <table>
	                               		<tr>
	                               			<td>
	                               				<input id="driverName" name="driverName"  type="text" class="form-control" required="" aria-required="true"  maxlength="20">
	                               			</td>
	                               			<td>
	                               				<span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 必填项</span>
	                               			</td>
	                               		</tr>
	                               	</table>
                                </div>
                                <label class="col-sm-1 control-label">司机代码:</label>
                                <div class="col-sm-2">
                                    <table>
	                               		<tr>
	                               			<td>
	                               				<input id="driverCode" name="driverCode" type="text" class="form-control" required="" aria-required="true" maxlength="20">
	                               			</td>
	                               			<td>
	                               				<span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 必填项</span>
	                               			</td>
	                               		</tr>
	                               	</table>
                                </div>
                                <label class="col-sm-1 control-label">档案编号:</label>
                                <div class="col-sm-2">
                                    <input id="fileNo" type="text" class="form-control" name="fileNo"  maxlength="50">
                                </div>
                                <label class="col-sm-1 control-label">职务:</label>
                                <div class="col-sm-2">
                                    <input id="due" name="due" type="text" class="form-control"  maxlength="20">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-1 control-label">出生年月:</label>
                                <div class="col-sm-2">
                                    <input id="birthday" type="text" class="layer-date form-control" name="birthday" maxlength="20" onclick="laydate({istime: true, format: 'YYYY-MM'})" placeholder="YYYY-MM">
                                </div>
                                <label class="col-sm-1 control-label">性别:</label>
                                <div class="col-sm-2">
                                    <select id="sexSelect" class="form-control" name="sex" required="" aria-required="true">
                                        <option>男</option>
                                        <option>女</option>
                                    </select>
                                </div>
                                <label class="col-sm-1 control-label">身份证号:</label>
                                <div class="col-sm-2">
                                    <input id="idCard" name="idCard"  type="text" class="form-control"  maxlength="20">
                                </div>
                                <label class="col-sm-1 control-label">组别:</label>
                                <div class="col-sm-2">
                                    <input id="groupNo" name="groupNo" type="text" class="form-control"  maxlength="20">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-1 control-label">文化程度:</label>
                                <div class="col-sm-2">
                                    <select class="form-control" id="graduation" name="graduation">
                                        <option value="">请选择</option>
                                        <option value="小学">小学</option>
                                        <option value="初中">初中</option>
                                        <option value="高中">高中</option>
                                        <option value="大学">大学</option>
                                        <option value="研究生">研究生</option>
                                        <option value="博士">博士</option>
                                    </select>
                                </div>
                                <label class="col-sm-1 control-label">调度中心:</label>
                                <div class="col-sm-2">
                                    <select class="form-control" id="scheduleCenter" name="scheduleCenter">
                                        <option>请选择</option>
                                    </select>
                                    <!-- <div class="input-group" id="A_SCHEDULECENTER"></div> -->
                                </div>
                                <label class="col-sm-1 control-label">驾驶证号:</label>
                                <div class="col-sm-2">
                                    <input id="licenseNo" name="licenseNo" type="text" class="form-control"  maxlength="50">
                                </div>
                                <label class="col-sm-1 control-label">驾驶证类别:</label>
                                <div class="col-sm-2">
                                    <input id="licenseType" name="licenseType"  type="text" class="form-control"  maxlength="20">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-1 control-label">初领证日期:</label>
                                <div class="col-sm-2">
                                    <input id="licenseDate" name="licenseDate" type="date" class="layer-date form-control" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" placeholder="YYYY-MM-DD">
                                </div>
                                <label class="col-sm-1 control-label">年审日期:</label>
                                <div class="col-sm-2">
                                    <input id="licenseLimited" name="licenseLimited" type="date" class="layer-date form-control"  onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" placeholder="YYYY-MM-DD">
                                </div>
                                <label class="col-sm-1 control-label">从业资格证:</label>
                                <div class="col-sm-2">
                                    <input id="qualification" name="qualification" type="text" class="form-control"  maxlength="50">
                                </div>
                                <label class="col-sm-1 control-label">年审日期:</label>
                                <div class="col-sm-2">
                                    <input id="qualificationLimited" name="qualificationLimited" type="date" class="layer-date form-control" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" placeholder="YYYY-MM-DD">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-1 control-label">默认车牌:</label>
                                <div class="col-sm-2">
                                	<table>
	                               		<tr>
	                               			<td>
			                                    <select class="form-control" id="defaultTruck" name="defaultTruck" required="" aria-required="true">
			                                        <option value="">请选择</option>
			                                    </select>
			                                    <!-- <div class="input-group" id="A_DEFAULTTRUCK"></div> -->
                                    		</td>
	                               			<td>
	                               				<span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 必填项</span>
	                               			</td>
	                               		</tr>
	                               	</table>
                                </div>
                                <label class="col-sm-1 control-label">车架:</label>
                                <div class="col-sm-2">
                                    <table>
	                               		<tr>
	                               			<td>
			                                    <select class="form-control" id="defaultFrame" name="defaultFrame" required="" aria-required="true">
			                                        <option value="">请选择</option>
			                                    </select> 
			                                    <!-- <div class="input-group" id="A_DEFAULTFRAME"></div> -->
                                    		</td>
	                               			<td>
	                               				<span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 必填项</span>
	                               			</td>
	                               		</tr>
	                               	</table>
                                </div>
                                <label class="col-sm-1 control-label">海关编号:</label>
                                <div class="col-sm-2">
                                    <input id="customsNo" name="customsNo" type="text" class="form-control"  maxlength="50">
                                </div>
                                <label class="col-sm-1 control-label">IC卡号:</label>
                                <div class="col-sm-2">
                                    <input id="icNo" name="icNo" type="text" class="form-control"  maxlength="50">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-1 control-label">手机号码1:</label>
                                <div class="col-sm-2">
                                	<table>
	                               		<tr>
	                               			<td>
                                    			<input id="mobile1" name="mobile1" type="text" class="form-control" required="" aria-required="true" maxlength="20">
                                			</td>
	                               			<td>
	                               				<span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 必填项</span>
	                               			</td>
	                               		</tr>
	                               	</table>
                               	</div>
                                <label class="col-sm-1 control-label">手机号码2:</label>
                                <div class="col-sm-2">
                                    <input id="mobile2" name="mobile2" type="text" class="form-control"  maxlength="20">
                                </div>
                                <label class="col-sm-1 control-label">手机号码3:</label>
                                <div class="col-sm-2">
                                    <input id="mobile3" name="mobile3" type="text" class="form-control"  maxlength="20">
                                </div>
                                <label class="col-sm-1 control-label">传真:</label>
                                <div class="col-sm-2">
                                    <input id="fax" name="fax" type="text" class="form-control"  maxlength="20">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-1 control-label">qq卡号:</label>
                                <div class="col-sm-2">
                                    <input id="qq" name="qq" type="text" class="form-control"  maxlength="20">
                                </div>
                                <label class="col-sm-1 control-label">E-Mail:</label>
                                <div class="col-sm-2">
                                    <input id="email" name="email" type="text" class="form-control email"  maxlength="50">
                                </div>
                                <label class="col-sm-1 control-label">基本工资:</label>
                                <div class="col-sm-2">
                                    <input id="salaryBase" name="salaryBase" type="text" class="form-control"  maxlength="20">
                                </div>
                                <label class="col-sm-1 control-label">地址:</label>
                                <div class="col-sm-2">
                                    <input id="addr" name="addr" type="text" class="form-control"  maxlength="50">
                                </div>
                            </div>
                            <div class="form-group">
                            	<label class="col-sm-1 control-label">当前状态:</label>
                                <div class="col-sm-2">
                                    <select class="form-control m-b" id="currentStatus" name="currentStatus">
                                        <option value="">请选择</option>
                                        <option value="在职">在职</option>
                                        <option value="离职">离职</option>
                                    </select>
                                </div>
                                <label class="col-sm-1 control-label"></label>
                                <div class="col-sm-3">
                                    <div class="col-sm-4">
                                    	<input id="tuoche" type="hidden" name="tuoche" value="0"/>
                                        <input id="tuocheCheckBox" type="checkbox" value="" name="tuocheCheckBox" onclick="clickCheckBox('tuoche')"> <i></i>拖车司机
                                    </div>
                                    <div class="col-sm-4">
										<input id="diaoche" type="hidden" name="diaoche" value="0"/>
                                        <input id="diaocheCheckBox" type="checkbox" value="" name="diaocheCheckBox" onclick="clickCheckBox('diaoche')"> <i></i>吊车司机
                                    </div>
                                    <div class="col-sm-4">
										<input id="weixiu" type="hidden" name="weixiu" value="0"/>
                                        <input id="weixiuCheckBox" type="checkbox" value="" name="weixiuCheckBox" onclick="clickCheckBox('weixiu')"> <i></i>维修工作
                                    </div>
                                </div>
                                <div class="col-sm-3"></div>
                                <div class="col-sm-2">
                                    <table>
                                    	<tr>
                                    		<td>
	                                    		<input id="waixie" type="hidden" name="waixie" value="0"/>
		                                       	<input id="waixieCheckBox" type="checkbox" value="" name="waixieCheckBox" onclick="clickCheckBox('waixie')"/> <i></i>外协
		                                   </td>
                                    		<td style="padding-left: 4px;">
	                                    		<input id="guakao" type="hidden" name="guakao" value="0"/>
		                                       	<input id="guakaoCheckBox" type="checkbox" value="" name="guakaoCheckBox" onclick="clickCheckBox('guakao')"/> <i></i>挂靠
		                                    </td>
                                    	</tr>
                                    </table>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-1 control-label">备注:</label>
                                <div class="col-sm-11">
                                    <textarea id="remark" name="remark" class="form-control" maxlength="200" cols="5" rows="5" ></textarea>
                                </div>
                            </div>
                       
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 附件 -->
        <div class="ibox">
			<div class="ibox-content" style="border-color: #fff;">
                <div class="panel panel-default">
                    <div class="panel-heading" style="padding: 5px">
                   		<span style="font-weight: bold;"> 附件</span>
                    </div>
                    <div class="panel-body">
                        <!-- 上传图片组件 -->
						<table id="driverImgTable" class="col-sm-12">
							<tr>
								<td style="padding: 5px">
									<button type="button" class="btn btn-primary" style="float: left;" onclick="addDriverPic()"><i class="glyphicon glyphicon-plus"></i> 新增附件</button>
								</td>
							</tr>
							<tr>
								<td>
									<table id="show_driver_table" class="table col-sm-12">
										<thead>
											<tr>
												<th style="min-width: 100px;text-align: center;" align="center">证件类型</th>
												<th style="min-width: 500px;max-width: 800px">图片<span style="color: red">提示:每一类只允许添加三张图片！</span></th>
												<th width="200px" style="text-align: center;" align="center">操作</th>
											</tr>
										</thead>
										<tbody>
											<input id="driver_maxImgNum" name="driver_maxImgNum" type="hidden"
												value="0" />
											<input name="defualt_prefix" type="hidden" value="driver"/>
										</tbody>
									</table>
								</td>
							</tr>
						</table>
                    </div>
                </div>
            </div>
        </div>
        <div>
			<div  id = "form_foot_tool" style="float: right ;padding-right: 20px;padding-bottom: 10px">
		    	<button class="btn btn-primary" type="button" onclick="submitAddDriverForm()"><i class="glyphicon glyphicon-ok"></i> 提 交</button>
	        </div>
		</div>
    	</form>
    </div>
	<!-- 上传图片模态窗口 -->
	<div class="modal inmodal fade" id="fileModal" tabindex="-1" role="dialog"  aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                	<form id="driverPicForm" method="post" 
						action="${ctxPath}/topic/ajax/savePic" enctype="multipart/form-data" 
						style="height: 100%" >
						<div style="height: 220px;overflow-y:scroll;"> 
						<table id="driver_fjfile">
							<tr>
								<td>
								  <select id="driver_imgtype0" name="driver_imgtype0">
								  </select>
								</td>
								<td id="fileInputTd0"><input id="driver_imgtype_img0" type="file" name="driver_imgtype_img0"></input></td>
								<td><input type="button" value="+" onclick="addRow()"></input></td>
							</tr>
						</table>
						</div>
						<input id="driver_maxFileNum" name="driver_maxFileNum" type="hidden" value="1"/>
						<input name="defualt_prefix" type="hidden" value="driver"/>
						<input id="inputFileNum" name="" type="hidden" value="1"/>
					</form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-white" data-dismiss="modal">关闭</button>
                    <button type="button" id="upImgButton2" class="btn btn-primary" onclick="subDriverPicForm()">保存</button>
                </div>
            </div>
        </div>
    </div>
<script  type="text/javascript">
	function submitAddDriverForm(){
		
		/* var areaCheckedTypeSize =$("input[name='type']:checked").size();
		if(areaCheckedTypeSize==0){
			alertMsg.warn("请选择地点类型！");
			return;
		} */
		var canSubmit = true;
		$.each($sysdict.DRIVER_CARD.value,function(index,e){
			var imgNum = 0;
			$.each($("tr#driver"+e.ID+" img"),function(obj){
				imgNum++;
			});
			if(imgNum>3){
				alert("每一类最多上传三张图片");
				canSubmit = false;
			}
		});
		if(canSubmit){
			$("#driverId").val(UUID.prototype.createUUID());
			$("#driverAddForm").submit();
		}
	}
	
	function initScheduleCenter(){
		/* getSource('${ctxPath}/topic/ajax/getScheduleCenter',function(json){
	          json=json.resultObj;
	        //  console.info(json);
	          $.each(json, function(index,item){
	               var st = "";
	               if('${param.CENTER_ID}' == item.CENTER_ID){
	                   st= "selected=\"selected\"" ;
	               }
	               var option="<option " +st+" value=\""+item.CENTER_ID+ "\" >"+item.CENTER_NAME+ "</option>" ;
	              $( "#scheduleCenter").append(option);
	          });
	     }, false);  */
		//调度中心
		/* $s.init($("#A_SCHEDULECENTER"), {
			tabdict : "schedule_center",
			vID:"scheduleCenter"
		}); */
		$s2.init($("#scheduleCenter"), {
			tabdict : "schedule_center",
			isSear:1
		});

	}
	
	//初始化车架下拉框,默认车牌下拉框
	function initTruckFrame(){
		/* getSource('${ctxPath}/topic/ajax/getTruckFrameList',function(json){
	          json=json.resultObj;
	        //  console.info(json);
	          $.each(json, function(index,item){
	              var st = "";
	              if('${param.FT_ID}' == item.FT_ID){
	                  st= "selected=\"selected\"" ;
	              }
	              var option1="<option " +st+" value=\""+item.FT_ID+ "\" >"+item.CODE+ "</option>" ;
	              var option="<option " +st+" value=\""+item.FT_ID+ "\" >"+item.TRUCK_PLATE+ "</option>" ;
	              if(item.TYPE=='T'){
	              	$( "#defaultTruck" ).append(option);
	              }else if(item.TYPE=='F'){
	              	$( "#defaultFrame" ).append(option1);
	              }
	          });
	     }, false);  */
	
	    //车架
		/* $s.init($("#A_DEFAULTFRAME"), {
			tabdict : "frame",
			vID:"defaultFrame"
		});
	    $("#V_defaultFrame").addClass("required"); */
	   //车辆
		/* $s.init($("#A_DEFAULTTRUCK"), {
			tabdict : "plate",
			vID:"defaultTruck"
		});
		$("#V_defaultTruck").addClass("required"); */
		$s2.init($("#defaultFrame"), {
			tabdict : "frame",
			isSear:1
		});
		$s2.init($("#defaultTruck"), {
			tabdict : "plate",
			isSear:1
		});
		
	}
	
	//公用获取数据方法
	function getSource(url,callback,async){
	      var $callback = callback;
	      if (! $.isFunction($callback)) $callback = eval('(' + callback + ')' );
	      var $async=true;
	      if(!isEmpty(async)){
	          $async=async;
	     }
	     $.ajax({
	          type : "POST",
	          url : url,
//	        data : {"type" : type},
	          async:$async,
	          dataType : "json",
	          success : $callback,
	          error : function(XMLHttpRequest, textStatus, errorThrown) {
	              alertMsg.warn( "请求异常:" + textStatus);
	          }
	     });
	}

	function clickCheckBox(id){
		var val = $("#"+id+"CheckBox").prop("checked");
		val = val==true?'1':'0';
		$("#"+id).val(val);
	}
	
	
	//点击新增弹出添加图片框
	function addDriverPic(){
		/* $.pdialog.open(_contextPath +"/topic/addDriverPic", 
			"view", '新增图片', {mask:true, width: 460, height:300}); */
			$("#upImgButton2").removeAttr("disabled");
			$.each($("#driver_fjfile tr"),function(index,item){
				if(index>0){
					$(item).remove();
				}
			});
			$("#fileInputTd0").html("");
			var html="";
			html+="<input id=\"driver_imgtype_img0\" type=\"file\" name=\"driver_imgtype_img0\"></input>";
			$("#fileInputTd0").html(html);
			$('#fileModal').modal({"width": "460px", "height":"300px"});
		
	}

	//删除本行的信息（所有图片）
	function delThisRow(obj){
		//button --> td --> tr
		$(obj).parent().parent().remove();
	}
	//删除单张图片
	function delThisImg(obj){
		$(obj).parent().find("img").remove();
		$(obj).parent().remove();
	}
</script>
<script type="text/javascript">
	$(function(){
		//初始化所属调度中心下拉框
		initScheduleCenter();
		//初始化车架下拉框
		initTruckFrame();
		
		$s2.init($("#sexSelect"));
		$s2.init($("#graduation"));
		$s2.init($("#currentStatus"));
	});
</script>

<!-- *************** -->
<script>
	$(function() {	
		$.each($sysdict.DRIVER_CARD.value,function(index,e){
			var option="<option value=\""+e.ID+ "\" >"+e.TEXT+ "</option>" ;
			$("#driver_imgtype0").append(option);
		});
		
	});	
	
	function subDriverPicForm(){
		$("#upImgButton2").attr("disabled","disabled");
		$("#driverPicForm").ajaxSubmit(function(data){
			//console.info(data);
			data =  JSON.parse(data);
			if (data.result == "1") {
				//先循环添加的内容
				data =  data.resultObj;
		 		for(var i=0;i<=maxRow;i++){
					var type = $("#driver_imgtype"+i).val();//下拉框值
					var text = $("#driver_imgtype"+i).find("option:selected").text();//下拉框值
					var driver_maxImgNum = parseInt($("#driver_maxImgNum").val());
					driver_maxImgNum = $("#driver_maxImgNum").val();
					if(text=="" || type =="undefined"){
						continue;
					}
					//每个tr有id对应着某一类型(比如身份证)
					var html="";
					if($("tr[id='driver"+type+"']").length >= 1){
						var tr_img_num = $("tr[id='"+type+"'] .imgTd img").length;
						var tr_index = $(".imgTr").index($("#"+type));
						html +="<div class='imgDiv'><div class='closeImg' onclick='delThisImg(this)'></div><img id='"+""+"' src=\"${ctxPath }/pic/"+data["pic"+i].path+"\" ></img>";
						html +="<input type=\"hidden\" name='remote_img_"+driver_maxImgNum+"' value=\""+data["pic"+i].qiniuPath+"\"></input>";
						html +="<input type=\"hidden\" name='img_"+driver_maxImgNum+"' value=\""+type+"~"+data["pic"+i].path+"\"></input></div>";
						$("#show_driver_table tbody tr[id='driver"+type+"'] td.imgTd").append(html);
					}else{
						var tr_index = $("#show_driver_table tbody tr").length;
						html+="<tr id=\"driver"+type+"\" class='imgTr'>";
						html+="<td align=\"center\"><span>"+text+"</span></td>";
						html+="<td class=\"imgTd\">";
						html+="<div class='imgDiv'><div class='closeImg' onclick='delThisImg(this)'></div><img id='"+""+"' src=\"${ctxPath }/pic/"+data["pic"+i].path+"\"></img>";
						html +="<input type=\"hidden\" name='remote_img_"+driver_maxImgNum+"' value=\""+data["pic"+i].qiniuPath+"\"></input>";
						html +="<input type=\"hidden\" name='img_"+driver_maxImgNum+"' value=\""+type+"~"+data["pic"+i].path+"\"></input></div>";
						html+="</td>";
						html+="<td align=\"center\"><button type=\"button\" class=\"btn\" onclick='delThisRow(this)'>删除</button></td>";
						html+="</tr>";
						$("#show_driver_table tbody").append(html);
					}
					//$("#show_driver_table tbody tr#"+type)
					$("#driver_maxImgNum").val(parseInt(driver_maxImgNum)+1);
				}
				/* $("td img").each(function(i){
					var objEvt = $._data($(this)[0], "events"); 
					//判断是否存在click事件
					if (objEvt && objEvt["click"]){
					}else{
						$(this).on("click",function(){
							openPhoto($("td img"),i);
						});
					}
				}); */
			}else{
				alert(data.resultInfo);
			}
			$("#fileModal").modal('hide');
		    return false;
		});
	}
	
	
	
	var maxRow=0;
	function addRow(){
		if($("#inputFileNum").val()>5){
			return;
		}else{
			var inputFileNum= parseInt($("#inputFileNum").val());
			$("#inputFileNum").val(inputFileNum+1);
		}
		maxRow++;
		var html = "";
		html += "<tr>";
		html += "<td><select id='driver_imgtype"+maxRow+"' name='driver_imgtype"+maxRow+"'></select></td>";
		html += "<td><input type='file' id='driver_imgtype_img"+maxRow+"' name='driver_imgtype_img"+maxRow+"'></input></td>";
		html += "<td><input type='button' value='-' onclick='delRow(this)'></input></td>";
		html +="</tr>";
		
		$("#driver_maxFileNum").val(maxRow);
		$("#driver_fjfile").append(html);
		var option="";
		option = $("#driver_imgtype0").html();
		$("#driver_imgtype"+maxRow).append(option);
	}
	
	function delRow(obj){
		var inputFileNum= parseInt($("#inputFileNum").val());
		$("#inputFileNum").val(inputFileNum-1);
		var id = $(obj).attr("id");
		$(obj).parent().parent().remove();
	}
</script>
</body>
</html>