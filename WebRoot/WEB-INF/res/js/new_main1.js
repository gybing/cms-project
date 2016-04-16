function width(){
	var min_w=1000;
	var max_w=1200;
	var win_w=$(window).width();
	var wrap_w=1100;
	if(win_w<min_w){
		wrap_w=min_w;
		$("body").width(min_w);
		$(".main_nav_cont").css("left",0);
		$(".main_nav_bg").width(min_w);
	}
	if(win_w>=min_w && win_w<=max_w){
		wrap_w=win_w;
		$("body").width("auto");
	/*	$(".main_nav_cont").css("left",0);*/
		$(".main_nav_cont").css("left","20px");
		$(".main_nav_bg").width("100%");
	}
	if(win_w>max_w){
		wrap_w=max_w;
		$("body").width("auto");
		/*$(".main_nav_cont").css("left",(win_w-max_w)/2);*/
		$(".main_nav_cont").css("left","20px");
		$(".main_nav_bg").width("100%");
	}
}

$(function(){
	width();
	alert_pos();
	$(".topnav_link").mouseenter(function(){
		$(this).find(".fxwrap").fadeIn();	
	}).mouseleave(function(){
		$(this).find(".fxwrap").hide();	
	});
	
	$(".topnav_link1").mouseenter(function(){
		$(this).find(".fxwrap1").fadeIn();	
	}).mouseleave(function(){
		$(this).find(".fxwrap1").hide();	
	});
	$(".reg_js,.cleartxt").focus(function(){
		if($(this).val()==$(this).attr("value")){$(this).val("");}
	}).blur(function(){
		if($(this).val().length==0){
			$(this).val($(this).attr("value"));
		}
	});
	$(".cgpassword").focus(function(){
		$(this).blur();
		$(this).hide();
		$(this).prev().show();	
		$(this).prev().focus();	
	});
	$(".cgpassword2").blur(function(){
		if($(this).val().length<=0){
			$(this).hide();
			$(this).next().show();	
		}
	});
	$(".da_close").click(function(){
		$(this).parent().parent().hide();	
	});
	$(".log_wjmm").click(function(){
		$(".logwrap").hide();
		$(".zhmmwrap").fadeIn();
	});
	$(".log_zczh").click(function(){
		$(".logwrap").hide();
		$(".zhmmwrap").hide();
		$(".regwrap").fadeIn();
	});
	$(".log_dlyb").click(function(){
		$(".regwrap").hide();
		$(".zhmmwrap").hide();
		$(".logwrap").fadeIn();
	});
	$(window).resize(function(){
		width();
		alert_pos();
	});
	$(".input_log").click(function(){
		$(this).addClass("log_show");
		$(this).select();
	}).blur(function(){
		if($(this).val().length==0){
			$(this).removeClass("log_show");
		}
	});
	$(".reg").click(function(){
		$(".alert_wrap,.regwrap").show();
	});
	$(".log").click(function(){
		$(".alert_wrap,.logwrap").show();
	});
	$(".log_close").click(function(){
		$(".alert_wrap,.logwrap,.regwrap,.zhmmwrap").hide();
	});
	$(".ctrl_tr tr").mouseenter(function(){
		$(this).find(".manage_tip_wrap").show();	
	}).mouseleave(function(){
		$(this).find(".manage_tip_wrap").hide();	
	});
	$(".cont_wrap").children("div:first").show();
	$(".centra_nav").height($(".centra").height());
	$(".quick_list").find(".quick_div:even").addClass("quick_list_bg");
	$(".quick_div").mouseenter(function(){
		$(this).addClass("quick_list_bg_flash")	;
	}).mouseleave(function(){
		$(this).removeClass("quick_list_bg_flash")	;
	});
	$(".input_text").focus(function(){
		$(this).addClass("input_text_green");	
	}).blur(function(){
		$(this).removeClass("input_text_green");	
	});
	$(".btn_submit").mouseenter(function(){
		$(this).addClass("btn_submit_atv");	
	}).mouseleave(function(){
		$(this).removeClass("btn_submit_atv");	
	});
	$(".btn_log").mouseenter(function(){
		$(this).addClass("btn_log_atv");	
	}).mouseleave(function(){
		$(this).removeClass("btn_log_atv");	
	});
	$(".btn_reg").mouseenter(function(){
		$(this).addClass("btn_reg_atv");	
	}).mouseleave(function(){
		$(this).removeClass("btn_reg_atv");	
	});
	
	$(".title1_left *").mouseenter(function(){
		$(this).parent().find("*").removeClass("atv");
		$(this).addClass("atv");
		var i=0;
		$(this).prevAll("*").each(function(){i++;});
		$(".cont_wrap").children("div").hide();
		$(".cont_wrap").children("div:eq("+i+")").show();
	});
	$(".search_nav a").mouseenter(function(){
		$(this).parent().find("a").removeClass("atv");
		$(this).parent().find("a").removeClass("search_nav_border");
		$(this).addClass("atv");
		var i=0;
		$(this).prevAll("a").each(function(){i++;});
		if(i==2){$(this).prev("a").addClass("search_nav_border");}
		$(".search_wrap").children(".search_cont").hide();
		$(".search_wrap").children(".search_cont:eq("+i+")").show();
	});
		$(".bg_change_tab").find("tr:odd").addClass("bg_change");
		$(".bg_change_tab").find("tr").mouseenter(function(){
			$(this).addClass("bg_flash");
		}).mouseleave(function(){
			$(this).removeClass("bg_flash");
		});
		$(".cy_list_wrap").children("div:odd").addClass("bg_change2");
		$(".cy_list_wrap").children("div").mouseenter(function(){
			$(this).addClass("bg_flash2");
		}).mouseleave(function(){
			$(this).removeClass("bg_flash2");
		});
	$(".cy_list_show").click(function(){
		$(".alert_wrap").show();
		$(".alert_cont").show();
	});
	$(".hyxq").click(function(){h
		$(".alert_wrap").show();
		$(".alert_cont").show();
	});
	$(".close").click(function(){
		$(".alert_wrap").hide();
		$(this).parent().hide();	
	});
	$(".alert_wrap").click(function(){
		$(".alert_wrap").hide();
		$(".regwrap,.logwrap,.alert_cont").hide();	
	});
	function alert_pos(){
		var win_width;
		//if($(window).width()<1002){$("body").width("1002");}else{$("body").width("auto");}
		if($(window).width()<1002){win_width=1002;}else{win_width=$(window).width();}
		$(".alert_wrap").width(win_width);
		$(".regwrap,.logwrap,.zhmmwrap").css("left",($(window).width()-374)/2);
		var alert_cont_w=$(".alert_cont").outerWidth(false);
		var alert_cont_h=$(".alert_cont").outerHeight(false);
		var window_w=$(window).width();
		var window_h=$(window).height();
		var scroll_top=0;
		if(window_w>alert_cont_w){
			$(".alert_cont").css("left",(window_w-alert_cont_w)/2);
		}else{
			$(".alert_cont").css("width",window_w);
			$(".alert_cont").css("left","0");
		}
		if(window_h>alert_cont_h){
			$(".alert_cont").css("top",(window_h-alert_cont_h)/2);
		}else{
			$(".alert_cont").css("height",window_h);
			$(".alert_cont").css("top","0");
		}
	}
	$(window).scroll(function(){
		$(".regwrap,.logwrap").css("top",$(document).scrollTop()+60);
		$(".alert_wrap").css("top",$(document).scrollTop());
		scroll_top=$(document).scrollTop();
	});
});

function initArea(){
	$.ajax({
		type:"post",
		data:{"PARENT_CODE":"0"},
		url:_contextPath+"/topic/ajax/queryArea",
		async:true,
		dataType:"json",
		success:function(data){
			data=data.resultObj;
			if(data.length == 0) alterMsg.error("初始化地区错误");
			$("#QUERY_SOURCE_PROV").empty();
			$("#QUERY_DESTINATION_PROV").empty();
			$.each(data,function(i,e){
				$("#QUERY_SOURCE_PROV").append("<option value='"+e[0]+"' >"+e[1] +"</option>");
				$("#QUERY_DESTINATION_PROV").append("<option value='"+e[0]+"' >"+e[1] +"</option>");
			});
		},
		error:function(XMLHttpRequest, textStatus, errorThrown){
			alert(textStatus);
		}
	});
	//添加出发点事件
	$("#QUERY_SOURCE_PROV").on("change",function(){
		if(this.value==""){
			$("#QUERY_SOURCE_CITY").empty();
			$("#QUERY_SOURCE_CITY").append("<option value='' >请选择</option>");
			$("#QUERY_SOURCE_COUNTY").empty();
			$("#QUERY_SOURCE_COUNTY").append("<option value='' >请选择</option>");
		}else{
			setArea("QUERY_SOURCE_CITY",this.value);
		}
		$("#QUERY_SOURCE").val(this.value);
	});
	$("#QUERY_SOURCE_CITY").on("change",function(){
		if(this.value==""){
			$("#QUERY_SOURCE_COUNTY").empty();
			$("#QUERY_SOURCE_COUNTY").append("<option value='' >请选择</option>");
			$("#QUERY_SOURCE").val($("#QUERY_SOURCE_PROV").val());
		}else{
			setArea("QUERY_SOURCE_COUNTY",this.value);
			$("#QUERY_SOURCE").val(this.value);
		}
	});
	$("#QUERY_DESTINATION_COUNTY").on("change",function(){
		$("#QUERY_SOURCE_COUNTY").val(this.value);
	});
	//添加目的地事件
	$("#QUERY_DESTINATION_PROV").on("change",function(){
		if(this.value==""){
			$("#QUERY_DESTINATION_CITY").empty();
			$("#QUERY_DESTINATION_CITY").append("<option value='' >请选择</option>");
			$("#QUERY_DESTINATION_COUNTY").empty();
			$("#QUERY_DESTINATION_COUNTY").append("<option value='' >请选择</option>");
		}else{
			setArea("QUERY_DESTINATION_CITY",this.value);
		}
		$("#QUERY_DESTINATION").val(this.value);
	});
	$("#QUERY_DESTINATION_CITY").on("change",function(){
		if(this.value==""){
			$("#QUERY_DESTINATION_COUNTY").empty();
			$("#QUERY_DESTINATION_COUNTY").append("<option value='' >请选择</option>");
			$("#QUERY_DESTINATION").val($("#QUERY_DESTINATION_PROV").val());
		}else{
			setArea("QUERY_DESTINATION_COUNTY",this.value);
			$("#QUERY_DESTINATION").val(this.value);
		}
	});
	$("#QUERY_DESTINATION_COUNTY").on("change",function(){
		$("#QUERY_DESTINATION").val(this.value);
	});
}

function setArea(id,parentCode){
	$.ajax({
		type:"post",
		data:{"PARENT_CODE":parentCode},
		url:_contextPath+"/topic/ajax/queryArea",
		async:true,
		dataType:"json",
		success:function(data){
			data=data.resultObj;
			if(data.length == 0) alterMsg.error("初始化地区错误");
			$("#"+id).empty();
			$.each(data,function(i,e){
				$("#"+id).append("<option value='"+e[0]+"' >"+e[1] +"</option>");
			});
		},
		error:function(XMLHttpRequest, textStatus, errorThrown){
			alert(textStatus);
		}
	});
}

/**获取企业描述*/
function get_firstInfo() {
	$.ajax({
		type : "post",
		url : _contextPath+"/topic/ajax/cpwb$zwyCompanyInfo",
		dataType : "json",
		async : false,
		success : function(data) {
			if(data.resultObj!=null){
				$(".cp_desc").html(data.resultObj.COMPANY_DESC);
			}

		}
	});
}
/**调整企业描述div的位置*/
function adjustCpDesc(){
	var imgH=$("#img1").height();
	
	//alert(imgH);
//	$(".cp_desc_bg").height(Math.floor(imgH*0.7));
//	$(".cp_desc").height(Math.floor(imgH*0.7));
//	$(".cp_desc").offset({left:$(".cp_desc_bg").offset().left});
}

/**查询货源*/
function select_HYXX(pageParams) {
	var param={
		pageNum : pageParams.pageNum,
		numPerPage : pageParams.numPerPage,
		S_CODE : $("#QUERY_SOURCE").val(),
		T_CODE : $("#QUERY_DESTINATION").val(),
		session_company_id:"095e6064-00fd-11e5-a5cb-08606ee6d0d3",
		IS_SHOW:"0"
	};
	$.ajax({
		type : "post",
		url : _contextPath+"/topic/ajax/cpwb$toCargoManage",
		data : param,
		dataType : "json",
		async : true,
		success : function(data) {
			pageParams.totalCount = data.resultObj.totalCount;
			var html = [];
			$.each(
				data.resultObj.dataList,
				function(i, item) {
					html.push("<div class=\"cy_list clr\" style=\"cursor:default;text-decoration:none\"><div class=\"cy_list_show\"><span class=\"cy_weight\">");
					html.push(item.S_AREA==null?"":item.S_AREA);
					html.push("</span><span class=\"cy_split\">至</span><span class=\"cy_weight\">");
					html.push(item.T_AREA==null?"":item.T_AREA);
					html.push("</span><span class=\"cy_weight\">&nbsp;&nbsp;&nbsp;&nbsp;");
					html.push(item.G_TYPE==null?"":item.G_TYPE);
					html.push("</span><span class=\"cy_weight\">");
					html.push(item.NUM==null?"":item.NUM);
					html.push("</span><span class=\"cy_weight\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;求");
					html.push(item.C_LENGTH==null?"":item.C_LENGTH +"&nbsp;&nbsp;"+item.C_TYPE==null?"":item.C_TYPE);
					html.push("</span><br /><span class=\"cy_contact\">联系人：");
					html.push(item.PUB_NAME==null?"":item.PUB_NAME);
					html.push("</span><span class=\"cy_contact\">联系电话：");
					html.push(item.PUB_MOBILE==null?"":item.PUB_MOBILE);
					html.push("</span><span class=\"cy_contact\">发布时间：");
					html.push(item.UTIME==null?"":item.UTIME);
					html.push("</span></div></div>");
			});
			$(".cy_list_wrap").empty();
			$(".cy_list_wrap").append(html.join(""));
			$(".cy_list div:odd").parent().css("background-color", "#E6E6FA");
			pageParams.chagePages(select_HYXX);
		}
	});
}

/**查询车辆信息*/
function select_CLXX(pageParams) {
	$.ajax({
		type : "post",
		url : _contextPath+"/topic/ajax/cpwb$truckManage_all",
		data : {
			pageNum : pageParams.pageNum,
			numPerPage : pageParams.numPerPage
		},
		dataType : "json",
		async : true,
		success : function(data) {
			if (data.resultObj) {
				$("#progressList_body_CLXX").empty();
				pageParams.totalCount = data.resultObj.totalCount;
				var html = [];
				$.each(data.resultObj.dataList, function(i, item) {
					html.push("<tr style='height:60px;'>");
					html.push("<td>"+ (item.TRUCK_PLATE==null?"":item.TRUCK_PLATE)+ "</td>");
					html.push("<td>"+ (item.TRUCK_TYPE == null ? "": item.TRUCK_TYPE)+"</td>");
					html.push("<td>"+ (item.TRUCK_LENGTH == null ? "": item.TRUCK_LENGTH+"米")+"</td>");
					html.push("<td>"+ (item.TRUCK_TON == null ? "": item.TRUCK_TON+"吨")+"</td>");
					html.push("<td>"+ (item.OFTEN_RUN_AREA == null ? "": item.OFTEN_RUN_AREA)+"</td>");
					html.push("<td>"+ (item.LAST_LOC_TIME1==null ?"":item.LAST_LOC_TIME1)+"</td>");
					html.push("<td>"+ (item.LAST_LOC_ADDR==null?"":item.LAST_LOC_ADDR)+"</td>");
					html.push("</tr>");
				});
				if(data.resultObj.dataList.length<pageParams.numPerPage){
					var num=pageParams.numPerPage-data.resultObj.dataList.length;
					for(var i=0;i<num;i++){
						html.push("<tr style='height:60px;'>");
						html.push("<td></td>");
						html.push("<td></td>");
						html.push("<td></td>");
						html.push("<td></td>");
						html.push("<td></td>");
						html.push("<td></td>");
						html.push("<td></td>");
						html.push("</tr>");
					}
				}
				$("#progressList_body_CLXX").append(html.join(""));
				$("#progressList_body_CLXX tr:odd").css("background-color", "#cccccc");
				pageParams.chagePages(select_CLXX);
			}
		}
	});
}
/**仓储信息*/
function select_CCXX(pageParams) {
	$.ajax({
		type : "post",
		url : _contextPath+"/topic/ajax/cpwb$storehouselist",
		data : {
			pageNum : pageParams.pageNum,
			numPerPage : pageParams.numPerPage
		},
		dataType : "json",
		async : false,
		success : function(data) {
			$("#progressList_body_CCXX").empty();
			pageParams.totalCount = data.resultObj.totalCount;
			var html=[];
			$.each(data.resultObj.dataList, function(i, item) {
				html.push("<tr style='height:60px;'>");
				html.push("<td>"+(item.STOREHOUSE_NAME==null?"":item.STOREHOUSE_NAME)+"</td>");
				html.push("<td>"+(item.AREA_COVERED==null?"":item.AREA_COVERED)+"</td>");
				html.push("<td>"+(item.FLOOR_HEIGHT==null?"":item.FLOOR_HEIGHT)+"</td>");
				html.push("<td>"+(item.FLOOR_NUMBER==null?"":item.FLOOR_NUMBER)+"</td>");
				html.push("<td>"+(item.GROUND_LOAD==null?"":item.GROUND_LOAD)+"</td>");
				html.push("<td>"+(item.UNINSTALL_PLATFORM==null?"":item.UNINSTALL_PLATFORM)+"</td>");
				html.push("<td>"+(item.VEHICLE_LANE==null?"":item.VEHICLE_LANE)+"</td></tr>");
			});
			if(data.resultObj.dataList.length<pageParams.numPerPage){
				var num=pageParams.numPerPage-data.resultObj.dataList.length;
				for(var i=0;i<num;i++){
					html.push("<tr style='height:60px;'>");
					html.push("<td></td>");
					html.push("<td></td>");
					html.push("<td></td>");
					html.push("<td></td>");
					html.push("<td></td>");
					html.push("<td></td>");
					html.push("<td></td>");
					html.push("</tr>");
				}
			}
			$("#progressList_body_CCXX").append(html.join(""));
			$("#progressList_body_CCXX tr:even").css("background-color", "#ffffff");
			$("#progressList_body_CCXX tr:odd").css("background-color", "#cccccc");
			pageParams.chagePages(select_CCXX);
		}
	});
}

var PageParams=function(tag,numPerPage){
	this.tag=tag;
	this.pageNum=1;//页数
	this.numPerPage=numPerPage||5;//每页显示几条
	this.totalCount=0;//总记录数
//	this.totalPage=0;//总页数
	/**总页数*/
	this.getTotalPage=function(){
		return Math.ceil(this.totalCount / this.numPerPage);
	}
	
	this.chagePages=function(fun){
		var _this=this;
		$("#btnStart_"+this.tag).off("click");
		$("#btnPre_"+this.tag).off("click");
		$("#btnEnd_"+this.tag).off("click");
		$("#btnNext_"+this.tag).off("click");
		if (this.pageNum <= 1) {
			$("#btnStart_"+this.tag).addClass("a_disabled");
			$("#btnPre_"+this.tag).addClass("a_disabled");
			$("#btnStart_"+this.tag).off("click");
			$("#btnPre_"+this.tag).off("click");
		} else {
			$("#btnStart_"+this.tag).removeClass("a_disabled");
			$("#btnPre_"+this.tag).removeClass("a_disabled");
			$("#btnStart_"+this.tag).on("click", function() {
				_this.pageNum=1;
				fun(_this);
			});
			$("#btnPre_"+this.tag).on("click", function() {
				_this.pageNum--;
				fun(_this);
			});
		}
		if (this.pageNum >= this.getTotalPage()) {
			$("#btnNext_"+this.tag).addClass("a_disabled");
			$("#btnEnd_"+this.tag).addClass("a_disabled");
			$("#btnNext_"+this.tag).off("click");
			$("#btnEnd_"+this.tag).off("click");
		} else {
			$("#btnNext_"+this.tag).removeClass("a_disabled");
			$("#btnEnd_"+this.tag).removeClass("a_disabled");
			$("#btnEnd_"+this.tag).on("click", function() {
			_this.pageNum=_this.getTotalPage();
				fun(_this);
			});
			$("#btnNext_"+this.tag).on("click", function() {
				_this.pageNum++;
				fun(_this);
			});
		}
	}
}

function resetSearch(obj) {
	$(obj).parent().parent().parent().find("select").val("");
	$(obj).parent().parent().parent().find("select[id$='prov']").change();
	$(obj).parent().parent().parent().find("input").val("");
	$(obj).parent().parent().parent().find(".city_input").val("请选择/输入城市名称");
	$(obj).parent().parent().parent().parent().find(".btn41").click();
}