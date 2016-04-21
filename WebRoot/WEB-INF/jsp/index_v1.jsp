<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>首页-小区物业管理系统</title>
    <jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
    <style type="text/css">
     table.dataTable thead .sorting_desc::after{content: "";}
     .mainTable tr td:nth-child(1) {
		padding:3px;
	 }
	 .mainTable tr td:nth-child(2) {
		padding:2px;
	 }
	 .mainTable .dataTables_wrapper {
	    padding-bottom: 0px;
	 }
	 .driverList{
	 	width: 100%;
	 }
	 .driverList tr td{
	 	margin:0 5px;
	 	font-size: 12px;
	 	color: #828282;
	 }
	 .driverList .dl_tr1{
	 	height: 28px;
	 }	 
	 .driverList .dl_tr1 td{
	 	border-bottom:#ECECEC dashed 1px;
	 }
	 .driverList .dl_tr3 td{
	 	border-bottom:#ECECEC solid 2px;
	 }
	 .driverList .dl_tr1 td:nth-child(1){
	 	text-align: left;
	 	font-weight: bold;
	 }
	 .driverList .dl_tr1 td:nth-child(2){
	 	text-align: right;
	 	font-weight: bold;
	 }
	 .driverList .dl_tr1 td:nth-child(3) span:nth-child(1){
	 	height: 18px;
	 	position: relative;
    	top: 2px;
	 }
	 .driverList .dl_tr1 td:nth-child(3) span:nth-child(2){
	 	position: relative;
    	top: 4px;
	 }
	 .driverList .dl_tr2 td{
	 	width: 100%;
	 }
	 .driverList .dl_tr2 td:nth-child(1) div:nth-child(1){
	 	height: 16px;
	 	vertical-align: middle;
	 }
	 .driverList .dl_tr2 td:nth-child(1) div:nth-child(4){

	 }
	 .driverList .dl_tr2 td:nth-child(1) span:nth-child(1){
	 	float: left;
	 }
	 .driverList .dl_tr2 td:nth-child(1) span:nth-child(2){
	 	float: right;
	 }
	 .driverList .dl_tr2 td:nth-child(2) p{
	 	margin: 3px 0 9px 0px;
	 }
	     
	 .driverList .dl_tr2 .alert{
	 	margin-top:2px;
	 	vertical-align:middle;
	 	background-color: #00BC0E;
	 	color: white;
	 	padding: 0px;
    	margin-bottom: 0px;
	 }
	 .driverList .dl_tr2 .progress{
	 	 margin-bottom: 3px;
	 }
	 .driverList .dl_tr2 .alert p{
	 	margin:2px 4px;
	 }
	 .driverList .dl_tr2 .alert p:nth-child(2){
	 	text-align: center;
	 }
	 
    </style>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight" >
		<input type="hidden" id="clickId" />
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<div class="panel panel-default" style="margin-top: 5px;">
							<div class="panel-heading" style="padding: 5px">
								<span style="font-weight: bold;">小区整体情况</span>
							</div>
							<div class="panel-body">
								<div class="form-group" style="padding-top:2px;padding-bottom: 2px">
									<table class="mainTable" style="margin-bottom: 0px;max-width: 100%;width: 100%;">
										<tr style="height: 100%;width: 100%;">
											<td width="40%" valign="top">
												<div style="height:484px;width:100%;overflow:auto;">
												<table class="driverList" id="driverList">
													<!-- <tr class="dl_tr1">
														<td>提单号：777888888888888</td><td>李集运</td>
														<td colspan="2"><span class="badge badge-primary">送箱</span> 闽A12345/B00002</td>
													</tr>
													<tr class="dl_tr2">
														<td colspan="2">
															<div class="progress progress-striped active">
															   <div class="progress-bar progress-bar-success" role="progressbar" 
															      aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" 
															      style="width: 40%;margin-top: 0px;">
															   </div>
															   <div>40%</div>
															</div>
															<div><span>福州</span><span>泉州</span></div>															
														</td>
														<td>
															<p><i class="fa fa-clock-o"></i> 行车时长：30分钟</p>
															<p><i class="fa fa-clock-o"></i> 当前公里数：8888KM</p>															
														</td>
														<td><div class="alert"><p>预计到达时间</p><p>03-15 15:08</p></div></td>
													</tr>
													<tr class="dl_tr3"><td colspan="4">当前位置：福建省福州市仓山区ssssssssssss</td></tr> -->
												</table>
												</div>
											</td>
											<td width="width: 60%"><div style="min-height: 484px;" id="allmap" ></div></td>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
