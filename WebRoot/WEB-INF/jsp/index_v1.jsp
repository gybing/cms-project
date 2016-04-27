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
 <script src="${resRoot }/hplus/js/plugins/echarts/echarts-all.js"></script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content" style="padding:20px">
		<div class="row">
			<div class="col-sm-3">
				<div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <span class="label label-success pull-right"></span>
                        <h5>房间总量</h5>
                    </div>
                    <div class="ibox-content">
                        <h1 class="no-margins">${responseDataForm.resultObj.roomCnt}</h1>
                    </div>
                </div>
			</div>
			<div class="col-sm-3">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <span class="label label-info pull-right">全年</span>
                        <h5>入住人数</h5>
                    </div>
                    <div class="ibox-content">
                        <h1 class="no-margins">${responseDataForm.resultObj.moveInCnt}</h1>
                    </div>
                </div>
            </div>
            <div class="col-sm-3">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <span class="label label-primary pull-right">月</span>
                        <h5>费用总计</h5>
                    </div>
                    <div class="ibox-content">
                        <h1 class="no-margins">${responseDataForm.resultObj.mPay}</h1>
                    </div>
                </div>
            </div>
            <div class="col-sm-3">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <span class="label label-danger pull-right">全年</span>
                        <h5>费用总计</h5>
                    </div>
                    <div class="ibox-content">
                        <h1 class="no-margins">${responseDataForm.resultObj.yPay}</h1>
                    </div>
                </div>
            </div>
		</div>
		<div class="row">
			<div class="col-sm-6">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>小区住房使用情况</h5>
                    </div>
                    <div class="ibox-content">
                        <div class="echarts" id="echarts-pie-chart"></div>
                    </div>
                </div>
            </div>
			<div class="col-sm-6">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>当月缴费组成</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                            <a class="dropdown-toggle" data-toggle="dropdown" href="graph_flot.html#">
                                <i class="fa fa-wrench"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-user">
                                <li><a href="graph_flot.html#">选项1</a>
                                </li>
                                <li><a href="graph_flot.html#">选项2</a>
                                </li>
                            </ul>
                            <a class="close-link">
                                <i class="fa fa-times"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="echarts" id="echarts-pie-chart2"></div>
                    </div>
                </div>
            </div>
		</div>
	</div>
</body>
<script type="text/javascript">
var dd = "";
$(function(){
	
	//基于准备好的dom，初始化echarts实例
	var myChart = echarts.init(document.getElementById('echarts-pie-chart'));
	var myChart2 = echarts.init(document.getElementById('echarts-pie-chart2'));
	option = {
		title: {
			text: "小区住房使用情况",
			subtext: "",
			x: "center"
		},
		tooltip: {
			trigger: "item",
			formatter: "{a} <br/>{b} : {c} ({d}%)"
		},
		legend: {
			orient: "vertical",
			x: "left",
			data: roomLegendData('${responseDataForm.resultObj.RoomLegendData}')
//	 		data: ["已入住", "空房", "装修中", "未装修"]
		},
		calculable: !0,
		series: [{
			name: "",
			type: "pie",
			radius: "55%",
			center: ["50%", "60%"],
			data: roomSeriesData('${responseDataForm.resultObj.RoomSeriesData}')
// 	 		data: [{
// 	 			value: 335,
// 	 			name: "已入住"
// 	 		}, {
// 	 			value: 310,
// 	 			name: "空房"
// 	 		}, {
// 	 			value: 234,
// 	 			name: "装修中"
// 	 		}, {
// 	 			value: 135,
// 	 			name: "未装修"
// 	 		}]
		}]	
	};

	option2 = {
			title: {
				text: "当月缴费组成情况",
				subtext: "",
				x: "center"
			},
			tooltip: {
				trigger: "item",
				formatter: "{a} <br/>{b} : {c} ({d}%)"
			},
			legend: {
				orient: "vertical",
				x: "left",
				data: roomLegendData('${responseDataForm.resultObj.PayLegendData}')
			},
			calculable: !0,
			series: [{
				type: "pie",
				radius: "55%",
				center: ["50%", "60%"],
				data: roomSeriesData('${responseDataForm.resultObj.PaySeriesData}')
			}]
		};
	//使用刚指定的配置项和数据显示图表。
	myChart.setOption(option);
	myChart2.setOption(option2);

	
});
/**
 * 获取饼图数据项
 * @param data 服务器返回的数据项字符串
 */
function roomLegendData(data){
	var obj = eval(data);
	var res = [];
	var length = obj.length;
	while(length -- ){
		var name = obj[length].NAME;
		res.push(name);
	}
	return res;
}
/**
 * 获取饼图数据
 * @param data 服务器返回的数据 list<map>
 */
function roomSeriesData(data){
	var obj = eval(data);
	var res = [];
	var length = obj.length;
	while(length -- ){
		var name = obj[length].NAME;
		var value = obj[length].VALUE;
		res.push({
			"value":value,
			"name":name
		});
	}
	return res;
}
</script>
</html>