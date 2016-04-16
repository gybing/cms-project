!function($) {
	$.extend({
		_jsonp : {
			scripts : {},
			counter : 1,
			charset : "gb2312",
			head : document.getElementsByTagName("head")[0],
			name : function(callback) {
				var name = "_jsonp_" + (new Date).getTime() + "_"
						+ this.counter;
				this.counter++;
				var cb = function(json) {
					eval("delete " + name), callback(json), $._jsonp.head
							.removeChild($._jsonp.scripts[name]),
							delete $._jsonp.scripts[name]
				};
				return eval(name + " = cb"), name
			},
			load : function(a, b) {
				var c = document.createElement("script");
				c.type = "text/javascript", c.charset = this.charset,
						c.src = a, this.head.appendChild(c),
						this.scripts[b] = c
			}
		},
		getJSONP : function(a, b) {
			var c = $._jsonp.name(b), a = a.replace(/{callback};/, c);
			return $._jsonp.load(a, c), this
		}
	})
}(jQuery);

var iplocation = "";
var provinceCityJson = "";
var cName = "ipLocation";
var currentProvinceId = 1;
var isUseServiceLoc = true; // 是否默认使用服务端地址
var pHtml = "";
var cHtml = "";
var tHtml = "";
var areaId="";
getAreaData(0);
var closeTrue=true;
var page_load = true;
var provinceHtml = '<div class="content"><div data-widget="tabs" class="m JD-stock" id="JD-stock">'
		+ '<div class="mt">'
		+ '    <ul class="tab">'
		+ '        <li data-index="0" data-widget="tab-item" class="curr"><a href="#none" class="hover"><em>请选择</em><i></i></a></li>'
		+ '        <li data-index="1" data-widget="tab-item" style="display:none;"><a href="#none" class=""><em>请选择</em><i></i></a></li>'
		+ '        <li data-index="2" data-widget="tab-item" style="display:none;"><a href="#none" class=""><em>请选择</em><i></i></a></li>'
		+ '        <li data-index="3" data-widget="tab-item" style="display:none;"><a href="#none" class=""><em>请选择</em><i></i></a></li>'
		+ '    </ul>'
		+ '    <div class="stock-line"></div>'
		+ '</div>'
		+ '<div class="mc" data-area="0" data-widget="tab-content" id="stock_province_item">'
		+ '    <ul class="area-list">'
		+ pHtml
		+ '    </ul>'
		+ '</div>'
		+ '<div class="mc" data-area="1" data-widget="tab-content" id="stock_city_item"></div>'
		+ '<div class="mc" data-area="2" data-widget="tab-content" id="stock_area_item"></div>'
		+ '<div class="mc" data-area="3" data-widget="tab-content" id="stock_town_item"></div>'
		+ '</div></div>';
$("#store-selector .text").after(provinceHtml);
var areaTabContainer = $("#JD-stock .tab li");
var provinceContainer = $("#stock_province_item");
var cityContainer = $("#stock_city_item");
var areaContainer = $("#stock_area_item");
var townaContainer = $("#stock_town_item");
var currentDom = provinceContainer;
// 当前地域信息
var currentAreaInfo;
// 获取地区数据
function getAreaData(parentCode) {
	$.ajax({
		url : _contextPath + "/topic/ajax/queryArea",
		type : "post",
		data : {
			"PARENT_CODE" : parentCode
		},
		async : false,
		dataType : "json",
		success : function(data) {
			iplocation = data.resultObj;
			$.each(data.resultObj, function(i, item) {
				if (!isEmpty(item[0])) {
					pHtml += "<li><a href='#none' data-value='" + item[0]
							+ "'>" + item[1] + "</a></li>";
				}
			});
		}
	});
}

// 根据省份ID获取名称
function getNameById(provinceId) {
	for ( var o in iplocation) {
		if (iplocation[o] && iplocation[o][0] == provinceId) {
			return iplocation[o][1];
		}
	}
	return "请选择";
}

function getAreaList(parentCode) {
	getAreaData(parentCode);
	var html = [ "<ul class='area-list'>" ];
	var longhtml = [];
	var longerhtml = [];
	if (iplocation && iplocation.length > 1) {
		for (var i = 0, j = iplocation.length; i < j; i++) {
			iplocation[i][1] = iplocation[i][1].replace(" ", "");
			if(iplocation[i][1]==currentAreaInfo.currentProvinceName){
				return "";
			}
			if(!isEmpty(iplocation[i][0])){
				if (iplocation[i][1].length > 12) {
					longerhtml
							.push("<li class='longer-area'><a href='#none' data-value='"
									+ iplocation[i][0]
									+ "'>"
									+ iplocation[i][1]
									+ "</a></li>");
				} else if (iplocation[i][1].length > 5) {
					longhtml
							.push("<li class='long-area'><a href='#none' data-value='"
									+ iplocation[i][0]
									+ "'>"
									+ iplocation[i][1]
									+ "</a></li>");
				} else {
					html.push("<li><a href='#none' data-value='" + iplocation[i][0]
							+ "'>" + iplocation[i][1] + "</a></li>");
				}
			}
		}
	} else {
		html.push("<li><a href='#none' data-value='"
				+ currentAreaInfo.currentFid + "'> </a></li>");
		setValue();
	}
	html.push(longhtml.join(""));
	html.push(longerhtml.join(""));
	html.push("</ul>");
	return html.join("");
}
function cleanKuohao(str) {
	if (str && str.indexOf("(") > 0) {
		str = str.substring(0, str.indexOf("("));
	}
	if (str && str.indexOf("（") > 0) {
		str = str.substring(0, str.indexOf("（"));
	}
	return str;
}

function getStockOpt(id, name) {
	if (currentAreaInfo.currentLevel == 3) {
		currentAreaInfo.currentAreaId = id;
		currentAreaInfo.currentAreaName = name;
		if (!page_load) {
			currentAreaInfo.currentTownId = 0;
			currentAreaInfo.currentTownName = "";
		}
	} else if (currentAreaInfo.currentLevel == 4) {
		currentAreaInfo.currentTownId = id;
		currentAreaInfo.currentTownName = name;
	}
	// 添加20140224
	setValue();
	// setCommonCookies(currentAreaInfo.currentProvinceId,currentLocation,currentAreaInfo.currentCityId,currentAreaInfo.currentAreaId,currentAreaInfo.currentTownId,!page_load);
	if (page_load) {
		page_load = false;
	}
	// 替换gSC
	var address = currentAreaInfo.currentProvinceName
			+ currentAreaInfo.currentCityName + currentAreaInfo.currentAreaName
			+ currentAreaInfo.currentTownName;
	$("#store-selector .text div").html(
			currentAreaInfo.currentProvinceName
					+ cleanKuohao(currentAreaInfo.currentCityName)
					+ cleanKuohao(currentAreaInfo.currentAreaName)
					+ cleanKuohao(currentAreaInfo.currentTownName)).attr(
			"title", address);
}
function getAreaListcallback(r) {
	currentDom.html(getAreaList(r));
	if (currentAreaInfo.currentLevel >= 2) {
		currentDom.find("a").click(function() {
			if (page_load) {
				page_load = false;
			}
			if (currentDom.attr("id") == "stock_area_item") {
				currentAreaInfo.currentLevel = 3;
			} else if (currentDom.attr("id") == "stock_town_item") {
				currentAreaInfo.currentLevel = 4;
			}
			getStockOpt($(this).attr("data-value"), $(this).html());
		});
		if (page_load) { // 初始化加载
			currentAreaInfo.currentLevel = currentAreaInfo.currentLevel == 2 ? 3
					: 4;
			if (currentAreaInfo.currentAreaId
					&& new Number(currentAreaInfo.currentAreaId) > 0) {
				getStockOpt(currentAreaInfo.currentAreaId, currentDom
						.find(
								"a[data-value='"
										+ currentAreaInfo.currentAreaId + "']")
						.html());
			} else {
				getStockOpt(currentDom.find("a").eq(0).attr("data-value"),
						currentDom.find("a").eq(0).html());
			}
		}
	}
}
// 省份
function chooseProvince(provinceId, provinceName) {
	provinceContainer.hide();
	currentAreaInfo.currentLevel = 1;
	currentAreaInfo.currentProvinceId = provinceId;
	currentAreaInfo.currentProvinceName = provinceName;
	areaTabContainer.eq(0).removeClass("curr").find("em").html(currentAreaInfo.currentProvinceName);
	areaTabContainer.eq(1).addClass("curr").show().find("em").html("请选择");
	areaTabContainer.eq(2).hide();
	areaTabContainer.eq(3).hide();
	cityContainer.show();
	areaContainer.hide();
	townaContainer.hide();
	var cHtml=getAreaList(provinceId);
	if(isEmpty(cHtml)){//是否是直辖市
		cityContainer.html("");
		areaContainer.show().html(getAreaList(provinceId.substring(0,2)+"0100"));
		areaContainer.find("a").click(function() {
			if (page_load) {
				page_load = false;
			}
			$("#store-selector").unbind("mouseout");
			chooseArea($(this).attr("data-value"), $(this).html());
		});
		if(currentAreaInfo.currentAreaId!="0"){
			chooseArea(currentAreaInfo.currentAreaId, areaContainer.find("a[data-value='"+currentAreaInfo.currentAreaId+"']").html());
		}
	}else{
		cityContainer.html(cHtml);
		cityContainer.find("a").click(function() {
			if (page_load) {
				page_load = false;
			}
			$("#store-selector").unbind("mouseout");
			chooseCity($(this).attr("data-value"), $(this).html());
		});
		if(currentAreaInfo.currentCityId!="0"){
			chooseCity(currentAreaInfo.currentCityId, cityContainer.find("a[data-value='"+currentAreaInfo.currentCityId+"']").html());
		}else if(page_load){
			page_load=false;
			setValue();
		}
	}
}
// 城市
function chooseCity(cityId, cityName) {
	provinceContainer.hide();
	cityContainer.hide();
	currentAreaInfo.currentLevel = 2;
	currentAreaInfo.currentCityId = cityId;
	currentAreaInfo.currentCityName = cityName;
	areaTabContainer.eq(1).removeClass("curr").find("em").html(cityName);
	areaTabContainer.eq(2).addClass("curr").show().find("em").html("请选择");
	areaTabContainer.eq(3).hide();
	areaContainer.show().html(getAreaList(cityId));
	townaContainer.hide();
	areaContainer.find("a").click(function() {
		$("#store-selector").unbind("mouseout");
		chooseArea($(this).attr("data-value"), $(this).html());
	});
	if(currentAreaInfo.currentAreaId!="0"){
		chooseArea(currentAreaInfo.currentAreaId, areaContainer.find("a[data-value='"+currentAreaInfo.currentAreaId+"']").html());
	}else if(page_load){
		page_load=false;
		setValue();
	}
}
// 地区
function chooseArea(areaId, areaName) {
	provinceContainer.hide();
	cityContainer.hide();
	currentAreaInfo.currentLevel = 3;
	currentAreaInfo.currentAreaId = areaId;
	currentAreaInfo.currentAreaName = areaName;
	areaTabContainer.eq(2).removeClass("curr").find("em").html(areaName);
	page_load=false;
	setValue();
	
}
function setValue(){//设置隐藏域的值及下拉框显示文本
	$(".areaContent").text(currentAreaInfo.currentProvinceName+currentAreaInfo.currentCityName+currentAreaInfo.currentAreaName);
	if(currentAreaInfo.currentAreaId=="0"){
		if(currentAreaInfo.currentCityId=="0"){
			if(currentAreaInfo.currentProvinceId=="0"){
				$("#"+areaId).val("");
			}else{
				$("#"+areaId).val(currentAreaInfo.currentProvinceId);
			}
		}else{
			$("#"+areaId).val(currentAreaInfo.currentCityId);
		}
	}else{
		$("#"+areaId).val(currentAreaInfo.currentAreaId);
	}
	$('#store-selector').removeClass('hover');
}
// 初始化当前地域信息
function CurrentAreaInfoInit(value) {
	var currentProvinceId=0;
	var currentCityId=0;
	var currentAreaId=0;
	if(!isEmpty(value)){
		if(value.substring(2,6)!="0000"){
			if(value.substring(4,6)!="00"){
				currentAreaId=value;
			}
			currentCityId=value.substring(0,4)+"00";
		}
		currentProvinceId=value.substring(0,2)+"0000";
	}else{
		page_load=false;
	}
	currentAreaInfo = {
		"currentLevel" : 1,
		"currentProvinceId" : currentProvinceId,
		"currentProvinceName" : "请选择",
		"currentCityId" : currentCityId,
		"currentCityName" : "",
		"currentAreaId" : currentAreaId,
		"currentAreaName" : "",
		"currentTownId" : 0,
		"currentTownName" : "",
		"currentAreaCode" :value
	};
}
function initAreaAddr(id,value){
	areaId=id;
	$("#store-selector").unbind("click").bind("click", function(e) {
		var tag = getEventTarget(e);
		if (tag.className != "text" && tag.className != "areaContent")// 判断点击区域是否为弹出地区下来框区域
			return;
		$('#store-selector').addClass('hover');
		$("#store-selector .content,#JD-stock").show();
	}).find("dl").remove();
	CurrentAreaInfoInit(value);// 初始化地区
	areaTabContainer.eq(0).find("a").click(function() {
		areaTabContainer.removeClass("curr");
		areaTabContainer.eq(0).addClass("curr").show();
		currentAreaInfo.currentCityId=0;
		currentAreaInfo.currentCityName="";
		currentAreaInfo.currentAreaId=0;
		currentAreaInfo.currentAreaName="";
		provinceContainer.show();
		cityContainer.hide();
		areaContainer.hide();
		townaContainer.hide();
		areaTabContainer.eq(1).hide();
		areaTabContainer.eq(2).hide();
		areaTabContainer.eq(3).hide();
	});
	areaTabContainer.eq(1).find("a").click(function() {
		areaTabContainer.removeClass("curr");
		areaTabContainer.eq(1).addClass("curr").show();
		currentAreaInfo.currentAreaId=0;
		currentAreaInfo.currentAreaName="";
		provinceContainer.hide();
		cityContainer.show();
		areaContainer.hide();
		townaContainer.hide();
		areaTabContainer.eq(2).hide();
		areaTabContainer.eq(3).hide();
	});
	areaTabContainer.eq(2).find("a").click(function() {
		areaTabContainer.removeClass("curr");
		areaTabContainer.eq(2).addClass("curr").show();
		provinceContainer.hide();
		cityContainer.hide();
		areaContainer.show();
		townaContainer.hide();
		areaTabContainer.eq(3).hide();
	});
	provinceContainer.find("a").click(function() {
		if (page_load) {
			page_load = false;
		}
		$("#store-selector").unbind("mouseout");
		chooseProvince($(this).attr("data-value"), $(this).html());
	}).end();
	if(!isEmpty(value)){
		chooseProvince(currentAreaInfo.currentProvinceId,provinceContainer.find("a[data-value='"+currentAreaInfo.currentProvinceId+"']").html());
	}
}

function getCookie(name) {
	var start = document.cookie.indexOf(name + "=");
	var len = start + name.length + 1;
	if ((!start) && (name != document.cookie.substring(0, name.length))) {
		return null;
	}
	if (start == -1)
		return null;
	var end = document.cookie.indexOf(';', len);
	if (end == -1)
		end = document.cookie.length;
	return unescape(document.cookie.substring(len, end));
};

