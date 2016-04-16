<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html onkeydown="if(event.keyCode==13){event.keyCode=0;return false;}"> 
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>新增订单</title>
<jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
<jsp:include page="/WEB-INF/jsp/formSubmit.jsp"></jsp:include>
<script type="text/javascript">
	$(function() {
		$s2.init($("#SCHEDULE_CENTER"), {//调度中心
			tabdict : "schedule_center",
			defVal : "${SESSION_USER_LOGIN_INFO.userInfo.SCHEDULE_CENTER }",
			isSear:1
		});
		$s2.init($C("#LOAD_WAY"), {//拖车/场装
			sysdict : $sysdict.LOADWAY
		});
		$s2.init($C("#IN_OUT"), {//进出口类型
			sysdict : $sysdict.INOTYPE
		});
		
		
		$s.init($C("#shipName"), {//船名
			tabdict : "ship_name",
			vID : "SHIP_NAME",
			callBack : "changeShipVoyage()"
		});
		$s.init($C("#cargoOwnerId"), {//货主
			tabdict : "cargo_owner",
			vID : "CARGO_OWNER_ID",
			callBack : "changeOwnerInfo('OWNNER')"
		});
		$s.init($C("#cargoProxyId"), {//货代
			tabdict : "cargo_proxy",
			vID : "CARGO_PROXY_ID",
			callBack : "changeOwnerInfo('PROXY')"
		});
		$s.init($C("#boxTake"), {//提箱地点
			tabdict : "dict_area",
			vID : "BOX_TAKE"
		});
		$s.init($C("#boxDrag"), {//拖箱地区
			tabdict : "dict_area",
			vID : "BOX_DRAG"
		});
		$s.init($C("#boxReturn"), {//返箱地点
			tabdict : "dict_area",
			vID : "BOX_RETURN"
		});
		$s.init($C("#toPort"), { //目的港
			tabdict : "port_name",
			vID : "TO_PORT",
			isNoKeyword : 1
		});
		$s.init($C("#loadPort"), { //装运港
			tabdict : "port_name",
			vID : "LOAD_PORT",
			isNoKeyword : 1
		});

		$s.init($C("#boxOwnner1"), {//箱主
			tabdict : "box_ownner",
			vID : "BOX_OWNNER_1"
		});

		/* $s.init($C("#boxOwnner2"), {//箱主
			tabdict : "box_ownner",
			vID : "BOX_OWNNER_2",
			defVal: "${responseDataForm.resultObj[0].BOX_OWNNER_2}",
			VdefVal : "${responseDataForm.resultObj[0].BOXOWNNER2}"
		}); */
		//初始化 拖箱地区 省市县
		initAreaAddr("BOX_DRAG_AREA");
		
		// 费用默认4个   单证费、吊箱费、铅封费、港杂费
		feeAddRow("dz");
		feeAddRow("dx");
		feeAddRow("qf");
		feeAddRow("gz");
	});
	var iNO = 1;
</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<form id="orderInfoEditForm" method="post"
			action="${ctxPath }/topic/ajax/addOrder" data-id="${param.pdataId}"
			callback="" class="form-horizontal">
			<input type="hidden" name="ORDER_ID" value="" />
			<input type="hidden" name="IS_FINISH" value="N" />
			<input type="hidden" id="ALL_COST" name="ALL_COST" value="0" /> 
			<input type="hidden" id="CARGO_OWNNER" name="CARGO_OWNNER" value=""/>
			<input type="hidden" id="CARGO_PROXY" name="CARGO_PROXY" value=""/>
			<input type="hidden" id="T" name="T" value="add" />
			<div class="ibox">
				<div class="ibox-content">
					<div class="panel panel-default" style="margin-top: 5px;">
						<div class="panel-heading" style="padding: 5px">
							<span style="font-weight: bold;">业务接单信息</span>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label class="col-sm-1 control-label">提单号:</label>
								<div class="col-sm-2">
									<input id="ORDER_NO" name="ORDER_NO" maxlength="14" type="text"
										class="required" aria-required="true" />
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
		                    		<select class="combox" id="IN_OUT" name="IN_OUT"></select>
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
									<input id="SHIP_VOYAGE" name="SHIP_VOYAGE" type="text" class="" maxlength="50" />
								</div>
							</div>
						</div>
					</div>
					<!-- ************************************************* -->
					<div class="panel panel-default">
						<div class="panel-heading" style="padding: 5px">
							<span style="font-weight: bold;">货主信息</span>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label class="col-sm-1 control-label">货主:</label>
								<div class="col-sm-2">
									<div class="input-group" id="cargoOwnerId"></div>
								</div>
								<label class="col-sm-1 control-label">联系人:</label>
								<div class="col-sm-2">
									<input id="OWNNER_NAME" name="OWNNER_NAME" type="text"
										class="" maxlength="20" />
								</div>
								<label class="col-sm-1 control-label">货主电话:</label>
								<div class="col-sm-2">
									<input id="OWNNER_TEL" name="OWNNER_TEL" type="text" class="" maxlength="20" />
								</div>
								<div class="col-sm-2">
									<input type="button" id="proxyBtn" value="填写更多..." onclick="showDiv('proxy')" class="btn btn-sm btn-primary" />
								</div>
							</div>
							<div class="form-group" id="proxy" style="display: none;">
								<label class="col-sm-1 control-label">货代:</label>
								<div class="col-sm-2">
									<div class="input-group" id="cargoProxyId"></div>
								</div>
								<label class="col-sm-1 control-label">货代联系人:</label>
								<div class="col-sm-2">
									<input id="PROXY_NAME" name="PROXY_NAME" type="text"
										class="" maxlength="20" />
								</div>
								<label class="col-sm-1 control-label">货代电话:</label>
								<div class="col-sm-2">
									<input id="PROXY_TEL" name="PROXY_TEL" type="text"
										class="" maxlength="20" />
								</div>
							</div>
						</div>
					</div>
					<!-- ************************************************* -->
					<div class="panel panel-default">
						<div class="panel-heading" style="padding: 5px">
							<span style="font-weight: bold;">详细信息</span>
						</div>
						<div class="panel-body">
							<div class="form-group">
			                	<!-- <label class="col-sm-1 control-label">是否预约:</label>
		                        <div class="col-sm-2" style="padding: 2px 0 0 3px;">
		                            <input type="checkbox" name="IS_RESERVE" value="1" />
		                        </div> -->
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
									<input id="SHIPMENT_NO" name="SHIPMENT_NO" maxlength="50"
										type="text" class="" />
								</div>
								<label class="col-sm-1 control-label">装货联系方式:</label>
								<div class="col-sm-2">
									<input id="LOAD_CONTACT" name="LOAD_CONTACT" maxlength="50"
										type="text" class="" />
								</div>
								<label class="col-sm-1 control-label">付款方:</label>
								<div class="col-sm-2">
									<input id="PAYER" name="PAYER" maxlength="50" type="text" class="" />
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
											<input type="hidden" name="BOX_DRAG_AREA" id="BOX_DRAG_AREA" />
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
									<input id="ADDR" name="ADDR" maxlength="100" type="text" style="width: 300px;" class="" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-1 control-label">货物备注:</label>
								<div class="col-sm-8">
									<textarea id="CARGO_REMARK" name="CARGO_REMARK"
										class="" cols="80" rows="2"></textarea>
								</div>
								<div class="col-sm-2">
									<input type="button" id="xxinfoBtn" value="填写更多..."
										onclick="showDiv('xxinfo')" class="btn btn-sm btn-primary" />
								</div>
							</div>
							<div id="xxinfo" style="display: none;">
								<div class="form-group">
									<label class="col-sm-1 control-label">品名:</label>
									<div class="col-sm-2">
										<input id="CARGO_NAME" name="CARGO_NAME" maxlength="50"
											type="text" class="" />
									</div>
									<label class="col-sm-1 control-label">件数:</label>
									<div class="col-sm-2">
										<input id="CARGO_NUM" name="CARGO_NUM" maxlength="20"
											type="text" class="" />
									</div>
									<label class="col-sm-1 control-label">重量:</label>
									<div class="col-sm-2">
										<input id="CARGO_WEIGHT" name="CARGO_WEIGHT" maxlength="20"
											type="text" class="" />
									</div>
									<label class="col-sm-1 control-label">体积:</label>
									<div class="col-sm-2">
										<input id="CARGO_SIZE" name="CARGO_SIZE" maxlength="50"
											type="text" class="" />
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-1 control-label">温度:</label>
									<div class="col-sm-2">
										<input id="CARGO_TEMPRETURE" name="CARGO_TEMPRETURE"
											maxlength="20" type="text" class="" />
									</div>
									<label class="col-sm-1 control-label">海关:</label>
									<div class="col-sm-2">
										<input id="CUSTOMS" name="CUSTOMS" maxlength="50" type="text"
											class="" />
									</div>
									<label class="col-sm-1 control-label">铅封来源:</label>
									<div class="col-sm-2">
										<input id="SEAL_FROM" name="SEAL_FROM" maxlength="50"
											type="text" class="" />
									</div>
									<label class="col-sm-1 control-label">业务员:</label>
									<div class="col-sm-2">
										<input id="SALESMAN" name="SALESMAN" maxlength="25"
											type="text" class="" value="${SESSION_USER_LOGIN_INFO.userName }" />
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-1 control-label">打单地点:</label>
									<div class="col-sm-2">
										<input id="ORDER_PRINT" name="ORDER_PRINT" maxlength="150"
											type="text" class="" />
									</div>
									<label class="col-sm-1 control-label">包干费:</label>
									<div class="col-sm-2">
										<input id="TARIFF" name="TARIFF" maxlength="20" type="text"
											class="" />
									</div>
									<label class="col-sm-1 control-label">免费期限:</label>
									<div class="col-sm-2">
										<input id="FEE_LIMITED" name="FEE_LIMITED" maxlength="20"
											type="text" class="" />
									</div>
								</div>
								<div class="form-group col-sm-12">
									<label class="col-sm-1 control-label">其他:</label>
									<div style="padding: 2px 0 0 3px;" class=" col-sm-1">
										<input type="checkbox" name="WAIGUAN" value="1" /> <i></i>外管箱
									</div>
									<div style="padding: 2px 0 0 3px;" class=" col-sm-1">
										<input type="checkbox" name="WEITUOBIANJIAN" value="1" /> <i></i>委托边检
									</div>
									<div style="padding: 2px 0 0 3px;" class=" col-sm-1">
										<input type="checkbox" name="BIANJIANEDI" value="1" /> <i></i>边检EDI
									</div>
									<div style="padding: 2px 0 0 3px;" class=" col-sm-1">
										<input type="checkbox" name="FANGXIANG" value="1" /> <i></i>放箱
									</div>
									<div style="padding: 2px 0 0 3px;" class=" col-sm-1">
										<input type="checkbox" name="XUNZHENG" value="1" /> <i></i>熏蒸
									</div>
									<div style="padding: 2px 0 0 3px;" class=" col-sm-1">
										<input type="checkbox" name="SHENBEIDAN" value="1" /> <i></i>设备单
									</div>
									<div style="padding: 2px 0 0 3px;" class=" col-sm-1">
										<input type="checkbox" name="WAIXIE" value="1" /> <i></i>外协
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- ************************************************* -->
					<div class="panel panel-default">
						<div class="panel-heading" style="padding: 5px">
							<span style="font-weight: bold;">备注信息</span>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label class="col-sm-1 control-label">接单备注:</label>
								<div class="col-sm-10">
									<textarea id="ORDER_REMARK" name="ORDER_REMARK" class="" cols="80" rows="2"></textarea>
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
			                    <label class="control-label"><b>费用合计: <span id="costAll" style="color: red;">0</span> 元</b></label>
			                </div>
						</div>
					</div>
					<!-- ************************************************* -->
					<div class="panel panel-default">
						<div class="panel-heading" style="padding: 5px">
							<span style="font-weight: bold;">集装箱信息</span>
						</div>
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
													<button type="button" class="btn btn-outline btn-default"
														onclick="addBox();">点击增加集装箱</button> <%-- <span style="margin-left: 18px;">箱量描述：${responseDataForm.resultObj[0].BOX_NUMS}</span> --%>
												</li>
											</ul>
										</div>
									</div>
									<table id="boxList"
										class="table table-striped table-bordered table-hover data-table with-check"
										style="text-align: center;">
										<thead>
											<tr height="30px">
		                                        <th width="2%" style="text-align: center;">序号</th>
		                                        <th width="6%" style="text-align: center;">尺寸</th>
												<th width="6%" style="text-align: center;">箱规</th>
		                                        <th width="14%" style="text-align: center;">箱号</th>
		                                        <th width="14%" style="text-align: center;">铅封号</th>
	                                        	<th width="8%" style="text-align: center;">提箱地点</th>
		                                        <th width="15%" style="text-align: center;">装货联系方式</th>
												<th width="15%" style="text-align: center;">装货地址</th>
												<th width="15%" style="text-align: center;">箱子备注</th>
												<th width="5%" style="text-align: center;">操作</th>
											</tr>
										</thead>
										<tbody></tbody>
									</table>
									<div id="form_foot_tool" style="float: right ;padding-right: 20px;padding-bottom: 10px">
										<ul class="button-list" style="list-style-type:none;">
											<li>												
												是否代打单 <input type="checkbox" name="IS_INSTEAD" value="1" />&nbsp;&nbsp;
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
<link type="text/css" href="${resRoot}/css/area.css" rel="stylesheet" />
<script type="text/javascript" src="${resRoot}/js/location.js" charset="utf-8"></script>
<script type="text/javascript" src="${resRoot}/js/order-method.js" charset="utf-8"></script>
</html>
