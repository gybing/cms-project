<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.weimingfj.common.form.ResponseDataForm"%>
<%@ page import="com.weimingfj.common.cache.GlobalCache"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=vaOdcXMsIjnesIldud46GOtT"></script>
<script type="text/javascript">
	var marker;
	// 百度地图API功能
	$(function(){
		map = new BMap.Map("areaSelectMap");
		var myCity = new BMap.LocalCity();
		myCity.get(function(result){
			var cityName = result.name;
			var lng = result.center.lng;
			var lat = result.center.lat;
			marker = new BMap.Marker(new BMap.Point(lng, lat));
			map.addOverlay(marker);              // 将标注添加到地图中
			map.centerAndZoom(new BMap.Point(lng, lat), 7);
			map.setCenter(cityName);
			//alert("当前定位城市:"+result.name);
			marker.enableDragging();
			map.addControl(new BMap.NavigationControl());// 添加平移缩放控件
			map.enableScrollWheelZoom();//启用滚轮放大缩小
			
			var gc = new BMap.Geocoder();//地址解析类
			//监听标注的dragend拖拽事件
			marker.addEventListener("dragend", function(e){    
				 //alert("当前位置：" + e.point.lng + ", " + e.point.lat);    
				//获取地址信息
			    gc.getLocation(e.point, function(rs){
			        showLocationInfo(e.point, rs);
			    });
			});
			
			//添加标记点击监听
			marker.addEventListener("click", function(e){
			   gc.getLocation(e.point, function(rs){
			        showLocationInfo(e.point, rs);
			    });
			});
		});
		//marker = new BMap.Marker(new BMap.Point(116.404, 36.905));
		//map.addOverlay(marker);              // 将标注添加到地图中
		//map.centerAndZoom(new BMap.Point(116.404, 36.905), 7);
		//marker.enableDragging();
		//map.addControl(new BMap.NavigationControl());// 添加平移缩放控件
		//map.enableScrollWheelZoom();//启用滚轮放大缩小
		
		//var gc = new BMap.Geocoder();//地址解析类
		//监听标注的dragend拖拽事件
		//marker.addEventListener("dragend", function(e){    
			 //alert("当前位置：" + e.point.lng + ", " + e.point.lat);    
			//获取地址信息
		    //gc.getLocation(e.point, function(rs){
		    //    showLocationInfo(e.point, rs);
		    //});
		//});
		
		//添加标记点击监听
		//marker.addEventListener("click", function(e){
		//   gc.getLocation(e.point, function(rs){
		//        showLocationInfo(e.point, rs);
		//    });
		//});
		
	});
	
	
	//显示地址信息窗口
	function showLocationInfo(pt, rs){
	    var opts = {
	      width : 250,     //信息窗口宽度
	      height: 100,     //信息窗口高度
	      title : ""  //信息窗口标题
	    }
	     
	    var addComp = rs.addressComponents;
	    var addr = "当前位置：" + addComp.province + "" + addComp.city + " " + addComp.district + " " + addComp.street + " " + addComp.streetNumber + "<br/>";
	    addr += "纬度: " + pt.lat + ", " + "经度：" + pt.lng;
	    //alert(addr);
	     
	    var infoWindow = new BMap.InfoWindow(addr, opts);  //创建信息窗口对象
	    marker.openInfoWindow(infoWindow);
	    
	    $("#writeAddr").val(addComp.district + addComp.street + addComp.streetNumber);
	    $("#mapSelectLng").val(pt.lng);
	    $("#mapSelectLat").val(pt.lat);
	}
	
	function saveArea(){
		$("#areaAddr").val($("#writeAddr").val());
		$("#lng").val($("#mapSelectLng").val());
		$("#lat").val($("#mapSelectLat").val());
		$.pdialog.closeCurrent();
	}
</script>

<style>
</style>

<body style="padding: 10px">
	<!-- <input type="hidden" id="mapSelectAddr" name="mapSelectAddr"/> -->
	<input type="hidden" id="mapSelectLng" name="mapSelectLng"/>
	<input type="hidden" id="mapSelectLat" name="mapSelectLat"/>
	<div id="areaSelectMap" style="width: 750px;height:400px;"></div>
	手动填写地址：<input type="text" id="writeAddr" name="writeAddr" style="width: 200px"/>
	<div style="text-align: center;"><input type="button" value="保存地址信息" onclick="saveArea();" /></div>
</body>