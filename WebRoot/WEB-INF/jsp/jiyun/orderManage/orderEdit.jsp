<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html onkeydown="if(event.keyCode==13){event.keyCode=0;return false;}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>编辑订单</title>
    <jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
    <jsp:include page="/WEB-INF/jsp/formSubmit.jsp"></jsp:include>
	<script type="text/javascript" src="${resRoot}/js/order-method.js" charset="utf-8"></script>
	<script type="text/javascript">
	$(function(){
		$s2.init($("#SCHEDULE_CENTER"), {//调度中心
			tabdict : "schedule_center",
			defVal : "${responseDataForm.resultObj[0].SCHEDULE_CENTER}",
			isSear:1
		});
		$s2.init($C("#LOAD_WAY"), {//拖车/场装
			sysdict : $sysdict.LOADWAY,
			defVal : "${responseDataForm.resultObj[0].LOAD_WAY}"
		});
		$s2.init($C("#IN_OUT"), {//进出口类型
			sysdict : $sysdict.INOTYPE,
			defVal : "${responseDataForm.resultObj[0].IN_OUT}"
		});
		
		$s.init($C("#shipName"), {//船名
			tabdict : "ship_name",
			vID : "SHIP_NAME",
			defVal: "${responseDataForm.resultObj[0].SHIP_NAME}",
			callBack : "changeShipVoyage()"
		});	
		
		$s.init($C("#cargoOwnerId"), {//货主   cargoOwnerId 页面div中的id
			tabdict : "cargo_owner",// 类型值 匹配sys.xml 里的compareValue 【必填】
			vID : "CARGO_OWNER_ID", // 字段 ID（需存到库里的字段名） 【必填】
			defVal: "${responseDataForm.resultObj[0].CARGO_OWNER_ID}",// 默认值（针对vID存key的默认值） 【选填】
			VdefVal : "${responseDataForm.resultObj[0].CARGOOWNER}",  // 页面上显示的默认值（与key值一样时该参数可不填） 【选填】
			callBack : "changeOwnerInfo('OWNNER')" //回调函数，选中后执行 【选填】
		});
		
		$s.init($C("#cargoProxyId"), {//货代
			tabdict : "cargo_proxy",
			vID : "CARGO_PROXY_ID",
			defVal: "${responseDataForm.resultObj[0].CARGO_PROXY_ID}",
			VdefVal : "${responseDataForm.resultObj[0].CARGOPROXY}",
			callBack : "changeOwnerInfo('PROXY')"
		});	
		
		$s.init($C("#boxTake"), {//提箱地点
			tabdict : "dict_area",
			vID : "BOX_TAKE",
			defVal: "${responseDataForm.resultObj[0].BOX_TAKE}",
			VdefVal : "${responseDataForm.resultObj[0].BOXTAKE}"
		});
		
		$s.init($C("#boxDrag"), {//拖箱地区
			tabdict : "dict_area",
			vID : "BOX_DRAG",
			defVal: "${responseDataForm.resultObj[0].BOX_DRAG}",
			VdefVal : "${responseDataForm.resultObj[0].BOXDRAG}"
		});
		
		$s.init($C("#boxReturn"), {//返箱地点
			tabdict : "dict_area",
			vID : "BOX_RETURN",
			defVal: "${responseDataForm.resultObj[0].BOX_RETURN}",
			VdefVal : "${responseDataForm.resultObj[0].BOXRETURN}"
		});
		
		$s.init($C("#toPort"), { //目的港
			tabdict : "port_name",
			vID : "TO_PORT",
			defVal: "${responseDataForm.resultObj[0].TO_PORT}",
			VdefVal : "${responseDataForm.resultObj[0].TOPORT}",
			isNoKeyword : 1
		});
		
		$s.init($C("#loadPort"), { //装运港
			tabdict : "port_name",
			vID : "LOAD_PORT",
			defVal: "${responseDataForm.resultObj[0].LOAD_PORT}",
			VdefVal : "${responseDataForm.resultObj[0].LOADPORT}",
			isNoKeyword : 1
		});
		
		$s.init($C("#boxOwnner1"), {//箱主
			tabdict : "box_ownner",
			vID : "BOX_OWNNER_1",
			defVal: "${responseDataForm.resultObj[0].BOX_OWNNER_1}",
			VdefVal : "${responseDataForm.resultObj[0].BOXOWNNER1}"
		});
		
		/* $s.init($C("#boxOwnner2"), {//箱主2
			tabdict : "box_ownner",
			vID : "BOX_OWNNER_2",
			defVal: "${responseDataForm.resultObj[0].BOX_OWNNER_2}",
			VdefVal : "${responseDataForm.resultObj[0].BOXOWNNER2}"
		}); */
		//初始化 拖箱地区 省市县
		initAreaAddr("BOX_DRAG_AREA","${responseDataForm.resultObj[0].BOX_DRAG_AREA}");
		
		//加载费用信息列表
		feeListInit();
		//加载集装箱信息列表
		boxListInit();
	});
	//=====================================================================================================
	var ORDER_ID = "${param.ORDER_ID }";
	//加载 费用项目信息
	function feeListInit(){
		if(ORDER_ID == ''){
			return;
		}
		$.ajax({
			type : "POST", // 提交的类型 
			url : _contextPath+"/topic/ajax/getOrderFeeList?s="+new Date().getTime(),
			data : {"ORDER_ID" : ORDER_ID}, // 参数 
			dataType : "json",
			async : false,
			success : function(data) {
				var json = data.resultObj;
				if(data.result == '1'){
					for(var i=0;i<json.length;i++){
						var trHtml = "";
    					trHtml +="<tr height='30'>";
    					trHtml +="<td width='50'>&nbsp;</td>";
    					trHtml +="<td><select class='combox' id='FEE_TYPE"+ i +"' name='FEE_TYPE'></select></td>";
    					trHtml +="<td><input id='FEE_AMOUNT"+ i +"' name='FEE_AMOUNT' type='text' class='required isNum' onchange='changeCostAll()' style='width:80px;' value='"+ json[i].FEE_AMOUNT +"' maxlength='11'/></td>";
    					trHtml +="<td><button type=\"button\" class=\"btn btn-outline btn-default btn-xs\" onclick=\"delRow(this,'费用项目')\">";
    					trHtml +="<i class=\"glyphicon glyphicon-minus\" aria-hidden=\"true\"></i></button></td>";
    					trHtml +="</tr>";
						$C("#fyInfo").append(trHtml);
						$s2.init($C("#FEE_TYPE"+i), {
							tabdict : "fee_type",
							defVal: json[i].FEE_TYPE,
							isSear : 1
						});
					}
				}
			},error : function(data) {
				alert("feeListInit请求异常！");
			}
		});
	}
	
	//=====================================================================================================
	var iNO = 1;
	//获取集装箱信息
	function boxListInit(){
		if(ORDER_ID == ''){
			return;
		}
		$.ajax({
			type:"post",
			url : _contextPath+"/topic/ajax/getOrderBoxList?s="+new Date().getTime(),
			data : {"ORDER_ID" : ORDER_ID}, // 参数 
			dataType:"json",
			async:false,
			success : function(data) {
				var json = data.resultObj;
				if(data.result != '1'){
					alert("boxListInit "+json.resultInfo);
					return;
				}			
				for(var i=0;i<json.length;i++){
					var trHtml="";
					trHtml +="<tr target='id' rel='"+json[i].BOX_ID+"' height='30px'>";
					if((json[i].SEAL_NO != null && json[i].SEAL_NO != '') || json[i].BOX_LAST_STATE == '退载'){
						trHtml +="<td>"+ iNO +"</td>";
						trHtml +="<td>"+ (isEmpty(json[i].SIZE)?"":json[i].SIZE) +"</td>";
						trHtml +="<td>"+ (isEmpty(json[i].SPEC)?"":json[i].SPEC) +"</td>";
						trHtml +="<td>"+ (isEmpty(json[i].NO)?"":json[i].NO) +"</td>";
						trHtml +="<td>"+ (isEmpty(json[i].SEAL_NO)?"":json[i].SEAL_NO) +"</td>";
						trHtml +="<td>"+ (isEmpty(json[i].LOAD_CONTACT)?"":json[i].LOAD_CONTACT) +"</td>";
						trHtml +="<td>"+ (isEmpty(json[i].ADDR)?"":json[i].ADDR) +"</td>";
						trHtml +="<td>"+ (isEmpty(json[i].BOX_REMARK)?"":json[i].BOX_REMARK) +"</td>";
						trHtml +="<td>";
						if(json[i].BOX_LAST_STATE == '退载'){
							trHtml += "<div style='color: red;'>&nbsp;已退载&nbsp;</div>";
						}else{
							trHtml +="<input name='BOX_ID' type='hidden' value='"+ (isEmpty(json[i].BOX_ID)?"":json[i].BOX_ID) +"'/>";
							trHtml +="<input name='BOX_LAST_STATE' id='BOX_LAST_STATE"+ i +"' type='hidden'/>";
							trHtml +="<button type=\"button\" id=\"tzBtn"+ i +"\" class=\"btn btn-default\" onclick=\"tzBox('BOX_LAST_STATE"+ i +"','tzBtn"+ i +"')\">退载</button>";
						}
						trHtml +="</td></tr>";
						$C("#boxList tbody").append(trHtml);
						iNO ++;
					}else{
						trHtml +="<td>"+ iNO +"</td>";
						trHtml += "<td><select class='combox' id='SIZE"+ i +"' name='SIZE' style='width:100%;'></select></td>";
						trHtml += "<td><select class='combox' id='SPEC"+ i +"' name='SPEC' style='width:100%;'></select></td>";
						trHtml +="<td><input id='NO"+ i +"' name='NO' type='text' class='isContainerCode' value='"+ (isEmpty(json[i].NO)?"":json[i].NO) +"' style='width:100%;' maxlength='50'/></td>";
						trHtml +="<td><input id='SEAL_NO"+ i +"' name='SEAL_NO' type='text' value='"+ (isEmpty(json[i].SEAL_NO)?"":json[i].SEAL_NO) +"' style='width:100%;' maxlength='50'/></td>";
						trHtml +="<td><input id='B_LOAD_CONTACT"+ i +"' name='B_LOAD_CONTACT' type='text' value='"+ (isEmpty(json[i].LOAD_CONTACT)?"":json[i].LOAD_CONTACT) +"' style='width:100%;' maxlength='50'/></td>";
						trHtml +="<td><input id='B_ADDR"+ i +"' name='B_ADDR' type='text' value='"+ (isEmpty(json[i].ADDR)?"":json[i].ADDR) +"' style='width:100%;' maxlength='300'/></td>";
						trHtml +="<td><input id='BOX_REMARK"+ i +"' name='BOX_REMARK' type='text' value='"+ (isEmpty(json[i].BOX_REMARK)?"":json[i].BOX_REMARK) +"' style='width:100%;' maxlength='500'/></td>";
						trHtml +="<td><button type=\"button\" class=\"btn btn-default\" onclick=\"delRow(this,'集装箱','"+ (isEmpty(json[i].SCHEDULE_ID)?"":json[i].SCHEDULE_ID) +"')\">删除</button>";
						trHtml +="</td></tr>";
						//初始化下拉框
						$C("#boxList tbody").append(trHtml);
						iNO ++;
						$s2.init($C("#SIZE"+i), {
							sysdict : $sysdict.BOX_SIZE,
							defVal: json[i].SIZE
						});
						$s2.init($C("#SPEC"+i), {
							sysdict : $sysdict.BOX_TYPE,
							defVal: json[i].SPEC
						});
					}
				}
			},error : function(data) {
				alert("boxListInit请求异常！");
			}
		});
	}
	
	//退载操作
	function tzBox(id,btnId){
		swal({
			title : "您确定要退载该集装箱吗？",
			text : "退载数据待提交保存订单后生效！",
			type : "warning",
			showCancelButton : true,
			confirmButtonColor : "#DD6B55",
			confirmButtonText : "确定",
			cancelButtonText : "取消",
			closeOnConfirm : true
		}, function() {
			$("#"+id).val("退载");
			$("#"+btnId).text("已退载");
			$("#"+btnId).attr("disabled", true);
		});
	}
	</script>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">            
    <form id="orderInfoEditForm" method="post" action="${ctxPath }/topic/ajax/editOrder" data-id="${param.pdataId}" callback="" class="form-horizontal">
		<input type="hidden" name="ORDER_ID" value="${param.ORDER_ID }"/>
		<input type="hidden" name="IS_FINISH" value="${responseDataForm.resultObj[0].IS_FINISH }"/>
		<input type="hidden" id="ALL_COST" name="ALL_COST" value="${responseDataForm.resultObj[0].ALL_COST }"/>
		<input type="hidden" id="CARGO_OWNNER" name="CARGO_OWNNER" value="${responseDataForm.resultObj[0].CARGO_OWNNER }"/>
		<input type="hidden" id="CARGO_PROXY" name="CARGO_PROXY" value="${responseDataForm.resultObj[0].CARGO_PROXY }"/>
		<input type="hidden" id="T" name="T" value="edit"/>
		<div class="ibox">
			<div class="ibox-content">
				<div class="panel panel-default" style="margin-top: 5px;">
					<div class="panel-heading" style="padding: 5px"><span style="font-weight: bold;">业务接单信息</span></div>
					<div class="panel-body">
		                <div class="form-group">
		                    <label class="col-sm-1 control-label">提单号:</label>
		                    <div class="col-sm-2">
		                        <input id="ORDER_NO" name="ORDER_NO" value="${responseDataForm.resultObj[0].ORDER_NO }" maxlength="14" type="text" class="required" aria-required="true" />
		                    </div>
		                    <label class="col-sm-1 control-label">接单日期:</label>
		                    <div class="col-sm-2">
		                    	<input type="text" class="form-control layer-date" id="ORDER_DATE" name="ORDER_DATE" value="${responseDataForm.resultObj[0].ORDER_DATE }" 
		                    		placeholder="YYYY-MM-DD hh:mm" 
		                    		onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm'})" />
		                    </div>
		                    <label class="col-sm-1 control-label">调度中心:</label>
		                    <div class="col-sm-2">
		                    	<select class="combox" id="SCHEDULE_CENTER" name="SCHEDULE_CENTER"><option value="">请选择</option></select>
		                    </div>
		                    <label class="col-sm-1 control-label">作业方式:</label>
		                    <div class="col-sm-2">
		                    	<select class="combox" id="LOAD_WAY" name="LOAD_WAY"></select>
		                    </div>
		                </div>
		                <div class="form-group">
		                    <label class="col-sm-1 control-label">进出类型:</label>
		                    <div class="col-sm-2">
		                    	<select class="combox" id="IN_OUT" name="IN_OUT"><option value="">请选择</option></select>
		                    </div>
		                    <label class="col-sm-1 control-label">船期:</label>
		                    <div class="col-sm-2">
								<input type="text" class="form-control layer-date" id="SHIP_DATE" name="SHIP_DATE" 
									value="${responseDataForm.resultObj[0].SHIP_DATE }" 
									placeholder="YYYY-MM-DD" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" />
							</div>
		                    <label class="col-sm-1 control-label">船名:</label>
		                    <div class="col-sm-2">
		                    	<div class="input-group" id="shipName"></div>
		                    </div>
		                    <label class="col-sm-1 control-label">航次:</label>
		                    <div class="col-sm-2">
		                    	<input id="SHIP_VOYAGE" name="SHIP_VOYAGE" value="${responseDataForm.resultObj[0].SHIP_VOYAGE }" type="text" class="" maxlength="50" />
		                    </div>
		                    
		                </div>
					</div>
				</div>
				<!-- ************************************************* -->
				<div class="panel panel-default">
					<div class="panel-heading" style="padding: 5px"><span style="font-weight: bold;">货主信息</span></div>
					<div class="panel-body">
		                <div class="form-group">
		                    <label class="col-sm-1 control-label">货主:</label>
		                    <div class="col-sm-2">
		                    	<div class="input-group" id="cargoOwnerId"></div>
		                    </div>
		                    <label class="col-sm-1 control-label">联系人:</label>
		                    <div class="col-sm-2">
		                        <input id="OWNNER_NAME" name="OWNNER_NAME" value="${responseDataForm.resultObj[0].OWNNER_NAME }" type="text" class="" maxlength="20" />
		                    </div>
		                    <label class="col-sm-1 control-label">货主电话:</label>
		                    <div class="col-sm-2">
		                        <input id="OWNNER_TEL" name="OWNNER_TEL" value="${responseDataForm.resultObj[0].OWNNER_TEL }" type="text" class="" maxlength="20" />
		                    </div>
		                	<div class="col-sm-2">
		                		<input type="button" id="proxyBtn" value="填写更多..." onclick="showDiv('proxy')" class="btn btn-sm btn-primary" />
		                	</div>
		                </div>
		                <div class="form-group" id="proxy" style="display:none;">
		                    <label class="col-sm-1 control-label">货代:</label>
		                    <div class="col-sm-2">
		                    	<div class="input-group" id="cargoProxyId"></div>
		                    </div>
		                    <label class="col-sm-1 control-label">货代联系人:</label>
		                    <div class="col-sm-2">
		                        <input id="PROXY_NAME" name="PROXY_NAME" value="${responseDataForm.resultObj[0].PROXY_NAME }" type="text" class="" maxlength="20" />
		                    </div>
		                    <label class="col-sm-1 control-label">货代电话:</label>
		                    <div class="col-sm-2">
		                        <input id="PROXY_TEL" name="PROXY_TEL" value="${responseDataForm.resultObj[0].PROXY_TEL }" type="text" class="" maxlength="20" />
		                    </div>
		                </div>
					</div>
				</div>
				<!-- ************************************************* -->
				<div class="panel panel-default">
					<div class="panel-heading" style="padding: 5px"><span style="font-weight: bold;">详细信息</span></div>
					<div class="panel-body">
		                <div class="form-group">
		                	<%-- <label class="col-sm-1 control-label">是否预约:</label>
	                        <div class="col-sm-2" style="padding: 2px 0 0 3px;">
	                            <input type="checkbox" name="IS_RESERVE" value="1" <c:if test="${responseDataForm.resultObj[0].IS_RESERVE eq '1'}"> checked </c:if> />
	                        </div> --%>
		                    <label class="col-sm-1 control-label">提箱地点:</label>
		                    <div class="col-sm-2">
		                    	<div class="input-group" id="boxTake"></div>
		                    </div>
		                    <label class="col-sm-1 control-label">返箱地点:</label>
		                    <div class="col-sm-2">
		                    	<div class="input-group" id="boxReturn"></div>
		                    </div>
		                    <label class="col-sm-1 control-label">装运港:</label>
		                    <div class="col-sm-5">
		                    	<div class="input-group" id="loadPort"></div>
		                    </div>
		                </div>
			            <div class="form-group">
			                <label class="col-sm-1 control-label">出货单号:</label>
			                <div class="col-sm-2">
			                	<input id="SHIPMENT_NO" name="SHIPMENT_NO" value="${responseDataForm.resultObj[0].SHIPMENT_NO }" maxlength="50" type="text" class="" />
			                </div>
		                    <label class="col-sm-1 control-label">装货联系方式:</label>
		                    <div class="col-sm-2">
		                    	<input id="LOAD_CONTACT" name="LOAD_CONTACT" value="${responseDataForm.resultObj[0].LOAD_CONTACT }" maxlength="50" type="text" class="" />
		                    </div>
		                    <label class="col-sm-1 control-label">付款方:</label>
		                    <div class="col-sm-2">
		                    	<input id="PAYER" name="PAYER" value="${responseDataForm.resultObj[0].PAYER }" maxlength="50" type="text" class="" />
		                    </div>
			                <label class="col-sm-1 control-label">目的港:</label>
			                <div class="col-sm-2">
		                    	<div class="input-group" id="toPort"></div>
			                </div>
			            </div>
			            <div class="form-group">
			                <label class="col-sm-1 control-label">拖箱地点:</label>
			                <div class="col-sm-2">
		                    	<div class="input-group" id="boxDrag"></div>
			                </div>
			                <label class="col-sm-1 control-label">拖箱地区:</label>
			                <div class="col-sm-5">
								<div id="store-selector">
									<div class="text">
										<input type="hidden" name="BOX_DRAG_AREA" id="BOX_DRAG_AREA" value="${responseDataForm.resultObj[0].BOX_DRAG_AREA }" />
										<div class="areaContent"></div>
										<b></b>
									</div>
									<div onclick="setValue();" class="close"></div>
								</div>
								<!--store-selector end-->
								<div id="store-prompt">
									<strong></strong>
								</div>
							</div>
			            </div>
		                <div class="form-group">
		                    <label class="col-sm-1 control-label">详细地址:</label>
		                    <div class="col-sm-5">
		                    	<input id="ADDR" name="ADDR" value="${responseDataForm.resultObj[0].ADDR }" maxlength="100" type="text" style="width: 300px;" class="" />
		                    </div>
		                </div>
		                <div class="form-group">
		                    <label class="col-sm-1 control-label">货物备注:</label>
		                    <div class="col-sm-8">
		                    	<textarea id="CARGO_REMARK" name="CARGO_REMARK" class="" cols="80" rows="2">${responseDataForm.resultObj[0].CARGO_REMARK}</textarea>
		                    </div>
		                	<div class="col-sm-2">
		                		<input type="button" id="xxinfoBtn" value="填写更多..." onclick="showDiv('xxinfo')" class="btn btn-sm btn-primary" />
		                	</div>
		                </div>
		                <div id="xxinfo" style="display:none;">
		                    <div class="form-group">
		                        <label class="col-sm-1 control-label">品名:</label>
		                        <div class="col-sm-2">
		                        	<input id="CARGO_NAME" name="CARGO_NAME" value="${responseDataForm.resultObj[0].CARGO_NAME }" maxlength="50" type="text" class="" />
		                       	</div>
		                        <label class="col-sm-1 control-label">件数:</label>
		                        <div class="col-sm-2">
		                        	<input id="CARGO_NUM" name="CARGO_NUM" value="${responseDataForm.resultObj[0].CARGO_NUM }" maxlength="20" type="text" class="" />
		                       	</div>
		                        <label class="col-sm-1 control-label">重量:</label>
		                        <div class="col-sm-2">
		                        	<input id="CARGO_WEIGHT" name="CARGO_WEIGHT" value="${responseDataForm.resultObj[0].CARGO_WEIGHT }" maxlength="20" type="text" class="" />
		                       	</div>
		                        <label class="col-sm-1 control-label">体积:</label>
		                        <div class="col-sm-2">
		                        	<input id="CARGO_SIZE" name="CARGO_SIZE" value="${responseDataForm.resultObj[0].CARGO_SIZE }" maxlength="50" type="text" class="" />
		                       	</div>
		                    </div>
		                    <div class="form-group">
		                        <label class="col-sm-1 control-label">温度:</label>
		                        <div class="col-sm-2">
		                        	<input id="CARGO_TEMPRETURE" name="CARGO_TEMPRETURE" value="${responseDataForm.resultObj[0].CARGO_TEMPRETURE }" maxlength="20" type="text" class="" />
		                       	</div>
		                        <label class="col-sm-1 control-label">海关:</label>
		                        <div class="col-sm-2">
		                        	<input id="CUSTOMS" name="CUSTOMS" value="${responseDataForm.resultObj[0].CUSTOMS }" maxlength="50" type="text" class="" />
		                       	</div>
		                        <label class="col-sm-1 control-label">铅封来源:</label>
		                        <div class="col-sm-2">
		                        	<input id="SEAL_FROM" name="SEAL_FROM" value="${responseDataForm.resultObj[0].SEAL_FROM }" maxlength="50" type="text" class="" />
		                       	</div>
		                        <label class="col-sm-1 control-label">业务员:</label>
		                        <div class="col-sm-2">
		                        	<input id="SALESMAN" name="SALESMAN" value="${responseDataForm.resultObj[0].SALESMAN }" maxlength="25" type="text" class="" />
		                       </div>
		                    </div>
		                    <div class="form-group">
		                        <label class="col-sm-1 control-label">打单地点:</label>
		                        <div class="col-sm-2">
		                        	<input id="ORDER_PRINT" name="ORDER_PRINT" value="${responseDataForm.resultObj[0].ORDER_PRINT }" maxlength="150" type="text" class="" />
							</div>
		                        <label class="col-sm-1 control-label">包干费:</label>
		                        <div class="col-sm-2">
		                        	<input id="TARIFF" name="TARIFF" value="${responseDataForm.resultObj[0].TARIFF }" maxlength="20" type="text" class="" />
		                       	</div>
		                        <label class="col-sm-1 control-label">免费期限:</label>
		                        <div class="col-sm-2">
		                        	<input id="FEE_LIMITED" name="FEE_LIMITED" value="${responseDataForm.resultObj[0].FEE_LIMITED }" maxlength="20" type="text" class="" />
		                       	</div>
		                    </div>
		                    <div class="form-group col-sm-12">
		                        <label class="col-sm-1 control-label">其他:</label>
		                        <div style="padding: 2px 0 0 3px;" class=" col-sm-1">
		                            <input type="checkbox" name="WAIGUAN" value="1" <c:if test="${responseDataForm.resultObj[0].WAIGUAN eq '1'}"> checked </c:if> /> <span style="margin-top: 2px;">外管箱</span>
		                        </div>
		                        <div style="padding: 2px 0 0 3px;"  class="col-sm-1">
		                            <input type="checkbox" name="WEITUOBIANJIAN" value="1" <c:if test="${responseDataForm.resultObj[0].WEITUOBIANJIAN eq '1'}"> checked </c:if> /> <i></i>委托边检
		                        </div>
		                        <div style="padding: 2px 0 0 3px;"  class="col-sm-1">
		                            <input type="checkbox" name="BIANJIANEDI" value="1" <c:if test="${responseDataForm.resultObj[0].BIANJIANEDI eq '1'}"> checked </c:if> /> <i></i>边检EDI
		                        </div>
		                        <div style="padding: 2px 0 0 3px;"  class="col-sm-1">
		                            <input type="checkbox" name="FANGXIANG" value="1" <c:if test="${responseDataForm.resultObj[0].FANGXIANG eq '1'}"> checked </c:if> /> <i></i>放箱
		                        </div>
		                        <div style="padding: 2px 0 0 3px;"  class="col-sm-1">
		                            <input type="checkbox" name="XUNZHENG" value="1" <c:if test="${responseDataForm.resultObj[0].XUNZHENG eq '1'}"> checked </c:if> /> <i></i>熏蒸
		                        </div>
		                        <div style="padding: 2px 0 0 3px;"  class="col-sm-1">
		                            <input type="checkbox" name="SHENBEIDAN" value="1" <c:if test="${responseDataForm.resultObj[0].SHENBEIDAN eq '1'}"> checked </c:if> /> <i></i>设备单
		                        </div>
		                        <div style="padding: 2px 0 0 3px;"  class="col-sm-1">
		                            <input type="checkbox" name="WAIXIE" value="1" <c:if test="${responseDataForm.resultObj[0].WAIXIE eq '1'}"> checked </c:if> /> <i></i>外协
		                        </div>
		                    </div>
		         		</div>
					</div>
				</div>
				<!-- ************************************************* -->
				<div class="panel panel-default">
					<div class="panel-heading" style="padding: 5px"><span style="font-weight: bold;">备注信息</span></div>
					<div class="panel-body">
		                <div class="form-group">
		                    <label class="col-sm-1 control-label">接单备注:</label>
		                    <div class="col-sm-4">
		                    	<textarea id="ORDER_REMARK" name="ORDER_REMARK" class="" cols="70" rows="2">${responseDataForm.resultObj[0].ORDER_REMARK}</textarea>
		                    </div>
		                    <div class="col-sm-1">&nbsp;</div>
		                    <label class="col-sm-1 control-label">费用备注:</label>
		                    <div class="col-sm-4">
		                    	<textarea id="FEE_REMARK" name="FEE_REMARK" class="" cols="70" rows="2">${responseDataForm.resultObj[0].FEE_REMARK}</textarea>
		                    </div>
		                </div>
					</div>
				</div>
				<!-- ************************************************* -->
				<div class="panel panel-default">
					<div class="panel-heading" style="padding: 5px"><span style="font-weight: bold;">费用信息</span></div>
					<div class="panel-body">
		                <div class="form-group">
		                    <label class="col-sm-1 control-label">费用:</label>
		                    <label class="col-sm-1 control-label" style="text-align:left;">
		                    	<button type="button" class="btn btn-outline btn-default btn-xs" onclick="feeAddRow();">
		                            <i class="glyphicon glyphicon-plus" aria-hidden="true"></i>
		                        </button>
		                    </label>
		                    <label class="col-sm-1 control-label" style="float: right;margin-right: 20px;">
		                    	<button type="button" class="btn btn-outline btn-default btn-xs" onclick="feeAdd();">新增费用类型</button>
		                    </label>
		                </div>
		                <br />
		                <table id="fyInfo" style="width: 310px; margin-left: 55px;"></table>
		                <div style="margin: 10px 96px -2px;">
		                    <label class="control-label"><b>费用合计: <span id="costAll" style="color: red;">${responseDataForm.resultObj[0].ALL_COST}</span> 元</b></label>
		                </div>
					</div>
				</div>
				<!-- ************************************************* -->
				<div class="panel panel-default">
					<div class="panel-heading" style="padding: 5px"><span style="font-weight: bold;">集装箱信息</span></div>
		            <div class="tab-content">
						<div class="tab-pane active">
							<div class="panel-body">
								<div class="form-group">
									<label class="col-sm-1 control-label">箱主:</label>
									<div class="col-sm-5">
										<div class="input-group" id="boxOwnner1"></div>
									</div>
								</div>
								<div class="form-group form-group-sm">
									<div class="col-sm-12 col-sm-offset-3" style="margin: 5px 0px 8px;padding-left: 5.5%;">
										<ul class="button-list" style="list-style-type:none;">
											<li>
		                               			<button type="button" class="btn btn-outline btn-default" onclick="addBox();">点击增加集装箱</button>
			                					<span style="margin-left: 18px;">箱量描述：${responseDataForm.resultObj[0].BOX_NUMS}</span>
			                            	</li>
										</ul>
		                            </div>
								</div>							
								<table id="boxList" class="table table-striped table-bordered table-hover data-table with-check" style="text-align: center;">
	                                <thead>
	                                    <tr height="30px">
	                                        <th width="2%" style="text-align: center;">序号</th>
	                                        <th width="6%" style="text-align: center;">尺寸</th>
											<th width="6%" style="text-align: center;">箱规</th>
	                                        <th width="14%" style="text-align: center;">箱号</th>
	                                        <th width="14%" style="text-align: center;">铅封号</th>
	                                        <th width="15%" style="text-align: center;">装货联系方式</th>
											<th width="17%" style="text-align: center;">装货地址</th>
											<th width="18%" style="text-align: center;">箱子备注</th>
											<th width="8%" style="text-align: center;">操作</th>
	                                    </tr>
	                                </thead>
	                                <tbody></tbody>
	                            </table>
	                            <!-- <div class="form-group form-group-sm" style="float:right;padding:15px 33px 13px 0px;">
									<div class="col-sm-12 col-sm-offset-3">
										<ul class="button-list" style="list-style-type:none;">
											<li>
		                               			<button class="btn btn-primary" type="submit"><i class="glyphicon glyphicon-ok"></i>保存</button>
			                            	</li>
										</ul>
		                            </div>
								</div> -->								
								<div id="form_foot_tool" style="float: right ;padding-right: 20px;padding-bottom: 10px">
									<ul class="button-list" style="list-style-type:none;">
										<li>
											<button type="submit" class="btn btn-primary"><i class="glyphicon glyphicon-ok"></i>保存</button>
										</li>
									</ul>
								</div>
		                    </div>
		                </div>
					</div>
				</div>
			</div>
		</div>
		<!-- ************************************************* -->
	</form>
    </div>
</body>
<link type="text/css" href="${resRoot}/css/area.css" rel="stylesheet"/>
<script type="text/javascript" src="${resRoot}/js/location.js" charset="utf-8"></script>
</html>
