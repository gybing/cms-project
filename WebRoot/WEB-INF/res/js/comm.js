window.onload=function(){  
	/** 防止回退键返回上一页面 */
	document.getElementsByTagName("body")[0].onkeydown =function(event){  
      
	    //获取事件对象  
	    var elem = event.relatedTarget || event.srcElement || event.target ||event.currentTarget;   
      
	    if(event.keyCode==8){//判断按键为backSpace键  
	       //alert(234);
	       //获取按键按下时光标做指向的element  
	        var elem =event.target || event.srcElement || event.currentTarget ;   
	        //判断是否需要阻止按下键盘的事件默认传递  
	        var name = elem.nodeName;  
	        if(name!='INPUT' && name!='TEXTAREA'){  
	            return _stopIt(event);  
	        }  
	        var type_e = elem.type.toUpperCase();  
	        if(name=='INPUT' && (type_e!='TEXT' && type_e!='TEXTAREA' && type_e!='PASSWORD' && type_e!='FILE')){  
	                return _stopIt(event);  
	        }  
	        if(name=='INPUT' && (elem.readOnly==true || elem.disabled ==true)){  
	                    return _stopIt(event);  
	        }  
        }  
    } ; 
} ; 
function _stopIt(e){  
        if(e.returnValue){  
            e.returnValue = false ;  
        }  
        if(e.preventDefault ){  
            e.preventDefault();  
        }                 
  
        return false;  
}  

//字符串替换
String.prototype.replaceAll = function(s1,s2){return this.replace(new RegExp(s1,"gm"),s2);};

/**判断对象是否为空*/
function isEmpty(str){
	if(str == '' || str == null || str.length == 0 || typeof(str) == "undefined"){
		return true;
	}
	return false;
}


/**
 * 自动补全下拉框公共方法
 * 页面调用方式：
 * 
 */
var $s = {};
$s.init = function (obj, param) {
	param = param || {};
	if(param == null || param == ''){
		return;
	}
	if(!param.vName || param.vName == ''){
		param.vName = param.vID || '';
	}
	param.defVal = param.defVal || '';
	if(!param.VdefVal){
		param.VdefVal = param.defVal || '';
	}else{
		param.VdefVal = param.VdefVal || '';
	}
	if(param.isNoKeyword){
		param.isNoKeyword = false;
	}else{
		param.isNoKeyword = true;
	}
	var iData = null;
	
	var html = "";
	if(param.isReadOnly && param.isReadOnly == '1'){
		html = "<input type=\"hidden\" id=\""+ param.vID +"\" name=\""+ param.vName +"\" value=\""+ param.defVal +"\" />";
		html += "<input style='width:150px' readonly=\"readonly\" type=\"text\" id=\"V_"+ param.vID +"\" name=\"V_"+ param.vName +"\" value=\""+ param.VdefVal +"\" />";
		obj.append(html);
		return;
	}
	html = "<input type=\"hidden\" id=\""+ param.vID +"\" name=\""+ param.vName +"\" value=\""+ param.defVal +"\" onchange=\"selChange('"+ param.vID +"')\" />";
	html += "<input style='width:150px' type=\"text\" id=\"V_"+ param.vID +"\" name=\"V_"+ param.vName +"\" value=\""+ param.VdefVal +"\" onclick=\"javascript:this.select()\" />";
	html += "<div class=\"input-group-btn\">";
	html += "<button type=\"button\" class=\"btn btn-default btn-xs dropdown-toggle\" data-toggle=\"dropdown\">";
	html += "<span class=\"caret\"></span>";
	html += "</button>";
	html += "<ul class=\"dropdown-menu dropdown-menu-right\" role=\"menu\">";
	html += "</ul></div>";
	
	obj.append(html);
	
	if(param.tabdict) {
		iData = _contextPath+"/topic/ajax/getTabSel?TYPE="+ param.tabdict +"&t="+ (new Date()).getTime() +"&sSearch_0=";
		$("#V_"+param.vID).bsSuggest({
	        getDataMethod: "url",              // 获取数据的方式，url：一直从url请求；data：从 options.data 获取；firstByUrl：第一次从Url获取全部数据，之后从options.data获取
	        url: iData,                        // 请求数据的 URL 地址
	        idField: "TEXT",                   // 每组数据的哪个字段作为 data-id，优先级高于 indexId 设置（推荐）
            keyField: "TEXT",                  // 每组数据的哪个字段作为输入框内容，优先级高于 indexKey 设置（推荐）
	        effectiveFields: ["TEXT"],         // 有效显示于列表中的字段，非有效字段都会过滤，默认全部，对自定义getData方法无效
			showBtn: false,                    // 是否显示按钮
			allowNoKeyword: param.isNoKeyword, // 是否允许无关键字时请求数据   为 false 则无输入时不执行过滤请求
			listStyle: param.listStyle,        // 列表的样式控制
            autoDropup: true,                  // 选择菜单是否自动判断向上展开。设为 true，则当下拉菜单高度超过窗体，且向上方向不会被窗体覆盖，则选择菜单向上弹出
            autoSelect: true,                  // 键盘向上/下方向键时，是否自动选择值
            listAlign: "left",                 // 提示列表对齐位置，left/right/auto
	        processData: function (json) {     // url获取数据时，对数据的处理，作为 getData 的回调函数
	            var len,data = {value: []};
	            if (!json || !json.resultObj || json.resultObj.length === 0) {
	                return false;
	            }
	            len = json.resultObj.length;
	            for(var i = 0; i < len; i++) {
	                data.value.push({
	                	"ID": json.resultObj[i].ID,
	                    "TEXT": json.resultObj[i].TEXT
	                });
	            }
	            data.defaults = param.vID;
	            return data;//字符串转化为 js 对象
	        }
	    }).on('onDataRequestSuccess', function (e, result) {
	        //console.log('onDataRequestSuccess: ', result);
	    }).on('onSetSelectValue', function (e, keyword, data) {
	        //console.log('onSetSelectValue: ', keyword, data);
	        $("#"+param.vID).val(data.ID);
	        if(param.callBack){
	        	eval('(' + param.callBack + ')');
	        }
	    }).on('onUnsetSelectValue', function (e) {
	        //console.log("onUnsetSelectValue");
	        $("#"+param.vID).val("");
	    });
	} else if(param.sysdict) {
		iData = param.sysdict;  //$sysdict.ORDERTYPE;
		$("#V_"+param.vID).bsSuggest({
	        getDataMethod: "data",              // 获取数据的方式，url：一直从url请求；data：从 options.data 获取；firstByUrl：第一次从Url获取全部数据，之后从options.data获取
	        url: null,                          // 请求数据的 URL 地址
	        data: iData,                        // 提示所用的数据
	        idField: "TEXT",                    // 每组数据的哪个字段作为 data-id，优先级高于 indexId 设置（推荐）
            keyField: "TEXT",                   // 每组数据的哪个字段作为输入框内容，优先级高于 indexKey 设置（推荐）
	        effectiveFields: ["TEXT"],          // 有效显示于列表中的字段，非有效字段都会过滤，默认全部，对自定义getData方法无效
	        allowNoKeyword: param.isNoKeyword,  // 是否允许无关键字时请求数据。为 false 则无输入时不执行过滤请求
	        listStyle: param.listStyle,         // 列表的样式控制
            autoDropup: true,                   // 选择菜单是否自动判断向上展开。设为 true，则当下拉菜单高度超过窗体，且向上方向不会被窗体覆盖，则选择菜单向上弹出
            autoSelect: true,                   // 键盘向上/下方向键时，是否自动选择值
            listAlign: "left",                  // 提示列表对齐位置，left/right/auto
			showBtn: false                      // 是否显示按钮
	    }).on('onDataRequestSuccess', function (e, result) {
	        //console.log('onDataRequestSuccess: ', result);
	    }).on('onSetSelectValue', function (e, keyword, data) {
	        //console.log('1onSetSelectValue: ', keyword, data);
	        $("#"+param.vID).val(data.ID);
	        if(param.callBack){
	        	eval('(' + param.callBack + ')');
	        }
	    }).on('onUnsetSelectValue', function (e) {
	        //console.log("onUnsetSelectValue");
	        $("#"+param.vID).val("");
	    });
	}else{
		alert("下拉框初始化失败，请检查参数/格式是否正确！");
	}
};

function selChange(id){
	if($("#"+id).val() == ''){
		$("#V_"+id).val("");
		$("#V_"+id).attr("data-id", "");		
	}
}

var $s_area = {};
var isRead = 1;
$s_area.init = function (obj, param) {
	param = param || {};
	if(param == null || param == ''){
		return;
	}
	if(!param.vName || param.vName == ''){
		param.vName = param.vID || '';
	}
	param.defVal = param.defVal || '';
	if(!param.VdefVal){
		param.VdefVal = param.defVal || '';
	}else{
		param.VdefVal = param.VdefVal || '';
	}
	/*纬度*/
	param.vLat = param.vLat || '';
	if(!param.vLat){
		param.vLat = param.vLat || '';
	}else{
		param.vLat = param.vLat || '';
	}
	/*经度*/
	param.vLng = param.vLng || '';
	if(!param.vLng){
		param.vLng = param.vLng || '';
	}else{
		param.vLng = param.vLng || '';
	}
	/*对应区域id*/
	param.vAreaId = param.vAreaId || '';
	if(!param.vAreaId){
		param.vAreaId = param.vAreaId || '';
	}else{
		param.vAreaId = param.vAreaId || '';
	}
//	console.log("param.vLat="+param.vLat+"  param.vLng="+param.vLng);
	var iData = null;
	var html = "";
	if(param.isRead == 2){
		html = "<input type=\"hidden\" id=\""+ param.vID +"\" name=\""+ param.vName +"\" value=\""+ param.defVal +"\" />";
		html += "<input type=\"hidden\" id=\"LAT_"+ param.vID +"\" name=\"LAT_"+ param.vName +"\" value=\""+ param.vLat +"\" />";
		html += "<input type=\"hidden\" id=\"LNG_"+ param.vID +"\" name=\"LNG_"+ param.vName +"\" value=\""+ param.vLng +"\" />";
		html += "<input type=\"hidden\" id=\"AREA_ID_"+ param.vID +"\" name=\"AREA_ID_"+ param.vName +"\" value=\""+ param.vAreaId +"\" />";
		
		html += "<input style='width:150px' type=\"text\" readonly=\"readonly\" id=\"V_"+ param.vID +"\" name=\"V_"+ param.vName +"\" value=\""+ param.VdefVal +"\"  onclick=\"javascript:this.select()\"/>";
		obj.append(html);
		return;
	}
	html = "<input type=\"hidden\" id=\""+ param.vID +"\" name=\""+ param.vName +"\" value=\""+ param.defVal +"\" />";
	html += "<input type=\"hidden\" id=\"LAT_"+ param.vID +"\" name=\"LAT_"+ param.vName +"\" value=\""+ param.vLat +"\" />";
	html += "<input type=\"hidden\" id=\"LNG_"+ param.vID +"\" name=\"LNG_"+ param.vName +"\" value=\""+ param.vLng +"\" />";
	html += "<input type=\"hidden\" id=\"AREA_ID_"+ param.vID +"\" name=\"AREA_ID_"+ param.vName +"\" value=\""+ param.vAreaId +"\" />";
	
	html += "<input style='width:150px' type=\"text\" id=\"V_"+ param.vID +"\" name=\"V_"+ param.vName +"\" value=\""+ param.VdefVal +"\"  onclick=\"javascript:this.select()\"/>";
	html += "<div class=\"input-group-btn\">";
	html += "<button type=\"button\" class=\"btn btn-default btn-xs dropdown-toggle\" data-toggle=\"dropdown\">";
	html += "<span class=\"caret\"></span>";
	html += "</button>";
	html += "<ul class=\"dropdown-menu dropdown-menu-right\" role=\"menu\">";
	html += "</ul></div>";
	obj.append(html);
	
	if(param.tabdict) {
		iData = _contextPath+"/topic/ajax/getTabSel?TYPE="+ param.tabdict +"&t="+ (new Date()).getTime() +"&sSearch_0=";
		$("#V_"+param.vID).bsSuggest({
	        allowNoKeyword: true,             // 是否允许无关键字时请求数据。为 false 则无输入时不执行过滤请求
	        getDataMethod: "url",             // 获取数据的方式，url：一直从url请求；data：从 options.data 获取；firstByUrl：第一次从Url获取全部数据，之后从options.data获取
	        url: iData,                       // 请求数据的 URL 地址
	        idField: "TEXT",                    // 每组数据的哪个字段作为 data-id，优先级高于 indexId 设置（推荐）
            keyField: "TEXT",                 // 每组数据的哪个字段作为输入框内容，优先级高于 indexKey 设置（推荐）
	        effectiveFields: ["TEXT"],        // 有效显示于列表中的字段，非有效字段都会过滤，默认全部，对自定义getData方法无效
			showBtn: false,                    // 是否显示按钮
			listStyle:param.listStyle,
	        processData: function (json) {    // url获取数据时，对数据的处理，作为 getData 的回调函数
	            var len,data = {value: []};
	            if (!json || !json.resultObj || json.resultObj.length === 0) {
	                return false;
	            }
	            len = json.resultObj.length;
	            for(var i = 0; i < len; i++) {
	                data.value.push({
	                	"ID": json.resultObj[i].ID,
	                    "TEXT": json.resultObj[i].TEXT,
	                    "AREA_ID":json.resultObj[i].AREA_ID,
	                    "LNG":json.resultObj[i].LNG,
	                    "LAT":json.resultObj[i].LAT
	                });
	            }
	            data.defaults = param.vID;
	            return data;//字符串转化为 js 对象
	        }
	    }).on('onDataRequestSuccess', function (e, result) {
	    	/*绑定光标离开事件*/
	        $(this).bind("blur",function(){
	        	if(!$("#"+param.vID).val() && $("#V_"+param.vID).val() != ''){ // 如果初始化给隐藏域中的值为空，判定输入的地址为新增加地址
					layer.confirm('改地址为新地址，是否补全并保存?', {icon: 3, title:'提示'}, function(index){
					    var area_id = "";			
						if(!isEmpty($("#AREA_ID_"+param.vID).val())) {
							area_id = $("#AREA_ID_"+param.vID).val();
							layer.open({
							    type: 2, 
							    title : "新增地点",
							    area: ['68%', '90%'],
							    fix: false, //不固定
							   // maxmin: true,
							    content: _contextPath+"/topic/toAddArea?id="+area_id+"&areaName="+$("#V_"+param.vID).val()
							});
						}
					    layer.close(index);
					});
				}
	        });
	    }).on('onSetSelectValue', function (e, keyword, data) {
	        //console.log('onSetSelectValue: ', keyword, data);
	        $("#"+param.vID).val(data.ID);
	        $("#AREA_ID_"+param.vID).val(data.AREA_ID);
	        $("#LNG_"+param.vID).val(data.LNG);
	        $("#LAT_"+param.vID).val(data.LAT);
	        if(param.callBack){
	        	eval('(' + param.callBack + ')');
	        }
	    }).on('onUnsetSelectValue', function (e) {
	        //console.log("onUnsetSelectValue");
	        $("#"+param.vID).val("");
	    });
	} else if(param.sysdict) {
		iData = param.sysdict;  //$sysdict.ORDERTYPE;
		$("#V_"+param.vID).bsSuggest({
	        allowNoKeyword: true,             // 是否允许无关键字时请求数据。为 false 则无输入时不执行过滤请求
	        getDataMethod: "data",            // 获取数据的方式，url：一直从url请求；data：从 options.data 获取；firstByUrl：第一次从Url获取全部数据，之后从options.data获取
	        url: null,                        // 请求数据的 URL 地址
	        data: iData,                      // 提示所用的数据
	        idField: "TEXT",                    // 每组数据的哪个字段作为 data-id，优先级高于 indexId 设置（推荐）
            keyField: "TEXT",                 // 每组数据的哪个字段作为输入框内容，优先级高于 indexKey 设置（推荐）
	        effectiveFields: ["TEXT"],        // 有效显示于列表中的字段，非有效字段都会过滤，默认全部，对自定义getData方法无效
	        listStyle: param.listStyle,
			showBtn: false                    // 是否显示按钮
	    }).on('onDataRequestSuccess', function (e, result) {
	        //console.log('onDataRequestSuccess: ', result);
	    }).on('onSetSelectValue', function (e, keyword, data) {
	        //console.log('1onSetSelectValue: ', keyword, data);
	        $("#"+param.vID).val(data.ID);
	        if(param.callBack){
	        	eval('(' + param.callBack + ')');
	        }
	    }).on('onUnsetSelectValue', function (e) {
	        //console.log("onUnsetSelectValue");
	        $("#"+param.vID).val("");
	    });
	}else{
		alert("下拉框初始化失败，请检查参数/格式是否正确！");
	}
};

/**
 * 下拉框控件
 */
var $s2 = {};
$s2.select = function(obj,val){//下拉框根据值选中
	obj.select2().val(val).trigger("change");
};
//下拉框控件 初始化
$s2.init = function (obj, param) {
	param = param || {};
	if(!param.isSear){
		param.minimumResultsForSearch = -1;
	}
	var s2param = param;
	s2param.width = param.width||"150px";
	s2param.vType = param.vType || "";
	var url = _contextPath+"/topic/ajax/getTabSel?s=";
	if(param.vType == "radio" || param.vType == "checkbox"){//单选或者多选框
		if(param.tabdict) {
			$.ajax({
				url : url+new Date().getTime(),
				data : {"TYPE" : param.tabdict},
				dataType:"json",
				type:"post",
				success:function(data){
					var json = data.resultObj;
					$.each(json, function(index, item) {
						var temp= "";
						if(param.defVal && param.defVal == item.ID){
							temp = "checked";
						}
						var option = "<input "+ temp +" type=\""+ param.vType +"\" name=\""+ param.vID +"\" value=\""+ item.ID +"\" /> <i></i> "+item.TEXT+"&nbsp;&nbsp;";
						//var option = "<label><input "+ temp +" type=\""+ param.vType +"\" value=\""+ item.ID +"\" name=\""+ param.vID +"\"> <i></i> "+item.TEXT+"</label>";
						obj.append(option);
					});
					if(!param.defVal){//都没有选中的话 默认选中第一个
						document.getElementsByName(param.vID)[0].checked = true;
					}
				}
			});
		} else if(param.sysdict) {
			s2param.data=$.map(param.sysdict.value, function(obj){
				obj.id = obj.id || obj.ID;
				obj.text = obj.text || obj.TEXT;
				return obj;
			});
			console.log(s2param.data);
			$.each(s2param.data, function(index, item) {
				var temp= "";
				if(param.defVal && param.defVal == item.ID){
					temp = "checked";
				}
				var option = "<input "+ temp +" type=\""+ param.vType +"\" name=\""+ param.vID +"\" value=\""+ item.ID +"\" /> <i></i> "+item.TEXT+"&nbsp;&nbsp;";
				//var option = "<label><input "+ temp +" type=\""+ param.vType +"\" value=\""+ item.ID +"\" name=\""+ param.vID +"\"> <i></i> "+item.TEXT+"</label>";
				obj.append(option);
			});
			if(!param.defVal){//都没有选中的话 默认选中第一个
				document.getElementsByName(param.vID)[0].checked = true;
			}
		} else if(param.data) {
			var $select=obj.select2(s2param);
			if(param.defVal){
				$select.val(param.defVal).trigger("change");
			}
		} else {
			obj.select2(s2param); 
		}
	}else{
		if(param.tabdict) {
			$.ajax({
				url : url+new Date().getTime(),
				data : {"TYPE" : param.tabdict},
				dataType:"json",
				type:"post",
				success:function(data){
					var json = data.resultObj;
					$.each(json, function(index, item) {
						var temp= "";
						if(param.defVal && param.defVal == item.ID){
							temp = "selected";
						}
						var option = "<option "+temp+" value=\""+item.ID+"\" >"+ item.TEXT + "</option>";
						obj.append(option);
					});
					s2param.ajax=null;
					obj.select2(s2param); 
				}
			});
		} else if(param.sysdict) {
			s2param.data=$.map(param.sysdict.value, function(obj){
				obj.id = obj.id || obj.ID;
				obj.text = obj.text || obj.TEXT;
				return obj;
			});
			var $select=obj.select2(s2param);
			if(param.defVal){
				$select.val(param.defVal).trigger("change");
			}
		} else if(param.data) {
			//s2param.data=param.data;
			var $select=obj.select2(s2param);
			if(param.defVal){
				$select.val(param.defVal).trigger("change");
			}
		} else {
			obj.select2(s2param); 
		}
	}
	//回调函数
	/*if(param.callBack){
		param.callBack();
	}*/
};

function $c(cselname) {
	//return $(cselname ,navTab.getCurrentPanel());
	return $(cselname);
}
function $C(cselname) {
	//return $(cselname ,navTab.getCurrentPanel());
	return $(cselname);
}

/**
 * 重置form表单
 * @param formId 表单id
 * @param target dialog或navTab
 */
function resetForm(formId){
	var $form="";
	if(!formId){
		$form = $('form.form-search');
	}else{
		$form = $("#"+formId);
	}
	/*$("input[type='text']",$form).each(function(i){
		$(this).val("");
	});	*/
	
	$("input",$form).each(function(i){
		console.log($(this).val());
		$(this).val("");
	});
	$("select",$form).each(function(i){
		if(this.options.length>0){
			var value=this.options[0].value;
			$(this).val(value);
		}
	});
	$("select",$form).each(function(i){
		$s2.select($C(this),"");
	});
	$(".combox select",$form).each(function(i){
		var id=	this.id;
		if(id.length>5){//处理省市县联动的combox
			if(id.substr(id.length-5)=="_prov"){
				$("#"+id.substring(0,id.length-5),$form).val("");
			}
		}
		if(this.options.length>0){
			var value=this.options[0].value;
			$(this).setVal(value);
		}
	});
}
/**
 * 刷新列表页
 * @param formId 表单id
 * @param target dialog或navTab
 */
function refreshForm(formId){
	resetForm(formId); //清空查询条件内容	
	searchForm(formId);//刷新列表
}

/**
 * alert(leftPad("123",6,'0'));
 * @param s
 * @param mL
 * @param seq
 * @returns
 */
function leftPad(s,mL,seq){
	return Array(mL+1).join(seq).replace(eval('/'+(seq?seq:',')+'/g'), function(m,i){ with(s){return mL-length>i?m:split('')[i-(mL-length)];}});
}

/**
 * 自定义tab的ajax回调
 * navTabId:要重新加载的navTabId
 * rel：需要局部刷新的元素id
 * callbackType如果是closeCurrent就会关闭当前tab
 * 只有callbackType="forward"时需要forwardUrl值
 * @param json
 */
function customNavTabAjaxDone(json){
	navTabAjaxDone(buildAjaxJson(json,navTab.getCurrentPanel()));
}

function customDialogAjaxDone(json){
	dialogAjaxDone(buildAjaxJson(json,$.pdialog.getCurrent()));
}

function buildAjaxJson(json,obj){
	var navTabId=$("#navTabId",obj).val();
	var callbackType=$("#callbackType",obj).val();
	var forwardUrl=$("#forwardUrl",obj).val();
	var rel=$("#rel",obj).val();
	if(!isEmpty(navTabId)){
		json.navTabId=navTabId;
	}
	if(!isEmpty(callbackType)){
		json.callbackType=callbackType;
	}
	if(!isEmpty(forwardUrl)){
		json.forwardUrl=forwardUrl;
	}
	if(!isEmpty(rel)){
		json.rel=rel;
	}
	return json;
}

/**
 * 初始化地区选择控件 省市县
 */
function initArea(id){
	var value = $("#"+id).val();  //存储最低一级的地区编码即可
	
	var _prov = "_PROV" || "_prov";
	var _city = "_CITY" || "_city";
	var _county = "_COUNTY" || "_county";
	
	$("#"+id+_prov).attr("ref",id+_city);
	$("#"+id+_prov).attr("refUrl",_contextPath+"/topic/ajax/queryArea?PARENT_CODE={value}");
	$("#"+id+_city).attr("ref",id+_county);
	$("#"+id+_city).attr("refUrl",_contextPath+"/topic/ajax/queryArea?PARENT_CODE={value}");
	
	$("select[id^='"+id+"_']").bind('change',function(){
		var objId=this.id;
		var prefix=objId.substring(0,objId.lastIndexOf("_"));//前缀
		var suffix=objId.substring(objId.lastIndexOf("_"));//后缀
		if($(this).val()!=""){
			$("#"+id).val($(this).val());
			if(suffix==_prov){
				setArea(id+_city,$(this).val());
			}else if(suffix==_city){//++++++
				setArea(id+_county,$(this).val());
			}
		}else{
			if(suffix==_prov){
				$("#"+id).val($(this).val());
			}else if(suffix==_city){
				var tmp=$("#"+prefix+_prov).val();
				if(tmp!=""){
					$("#"+id).val(tmp);
				}
			}else if(suffix==_county){  //=================
				var tmp=$("#"+prefix+_city).val();
				if(tmp!=""){
					$("#"+id).val(tmp);
				}
			}else{
				var tmp=$("#"+prefix+_city).val();
				if(tmp==""){
					tmp=$("#"+prefix+_prov).val();
				}
				$("#"+id).val(tmp);
			}
		}
	});
	if(!isEmpty(value) && value.length==6){   //有值的情况下 默认值回填处理
		var parent="0";
		var index=value.indexOf("00");
		
		switch (index) {
		case -1:
			parent=value.substring(0,4)+"00";
			setArea(id+_county,parent,value);
		case 4:
			parent=value.substring(0,2)+"0000";
			value=value.substring(0,4)+"00";
			setArea(id+_city,parent,value);
			if(index==4){
				setArea(id+_county,value);
			}
		case 2:
			parent="0";
			value=value.substring(0,2)+"0000";
			setArea(id+_prov,parent,value);
			if(index==2){
				setArea(id+_city,value);
			}
		}
	}else{
		setArea(id+_prov,"0");
	}
}
/***
 * 地区选择控件设置地址
 * */
function setArea(id,parentCode,defValue){
	$.ajax({
		type:"post",
		data:{"PARENT_CODE":parentCode},
		url:_contextPath+"/topic/ajax/queryArea",
		async:false,
		dataType:"json",
		success:function(data){
			data = data.resultObj;
			//if(data.length == 0) alterMsg.error("初始化地区错误");
			$("#"+id).empty();
			$.each(data,function(i,e){
				var selected="";
				if(!isEmpty(defValue) && e[0]==defValue){
					selected="selected=\"selected\"";
				}
				$("#"+id).append("<option value='"+e[0]+"' "+selected+" >"+e[1] +"</option>");
			});
			//$("#"+id).reLoad();
		},
		error:function(XMLHttpRequest, textStatus, errorThrown){
			alert(textStatus);
		}
	});
}

//过滤数组,提出空字符串
function filterNullArray(arr){
	var newArr = [];
	for(var i = 0; i< arr.length; i++){
		if(!isEmpty(arr[i]) && arr[i] != 'null'){
			newArr.push(arr[i]);
		}
	}
	return newArr;
}
//去除数组中重复值
function uniqueArray(arr) {
    var result = [], hash = {};
    for (var i = 0, elem; (elem = arr[i]) != null; i++) {
        if (!hash[elem]) {
            result.push(elem);
            hash[elem] = true;
        }
    }
    return result;
}

/**
 * 获取digit位数随机数
 * @param digit
 */
function getMathRand(digit) { 
	var Num=""; 
	for(var i=0;i<parseInt(digit);i++) { 
		Num+=Math.floor(Math.random()*10); 
	} 
	return Num;
}

/**
 * 判断是否为图片
 * 
 */
function isImage(obj){
	var test = $(obj).val();
	var tests= new Array(); //定义一数组
	tests=test.split(".");
	//BMP、JPG、JPEG、PNG、GIF
	var lastname = tests[1].toUpperCase();
	if(lastname=="JPG"||lastname=="PNG"||lastname=="JPEG"||lastname=="GIF"||lastname=="BMP"){
		return true;
	}else{
		alertMsg.warn("图片格式不对");
		$(obj).val("");
		return false;
	}
}

/**
 * 打开图片 弹出图层
 */
var gallery;//PhotoSwipe对象
function openPhoto(imgArrObj,index) {
    var pswpElement = document.querySelectorAll('.pswp')[0];
    var items = [];
    $(imgArrObj).each(function(i){
    	items.push({ src: $(this).attr("src"), w: 2000,h: 1500,title:$(this).attr("title"),i:1});
    });    
    var options = {
        history: false,
        focus: false,
        showAnimationDuration: 0,
        hideAnimationDuration: 0,
        bgOpacity:0.7,//背景透明度
        shareEl: false,
        addCaptionHTMLFn: function(item, captionEl, isFake) {//设置图片标题
            if(!item.title) {
                captionEl.children[0].innerHTML = '';
                return false;
            }
            captionEl.children[0].innerHTML = item.title;
            return true;
        }
    };
    
    
    gallery = new PhotoSwipe( pswpElement, PhotoSwipeUI_Default, items, options);
    gallery.listen('beforeChange', function(index, item) {
    	gallery.currItem.i=1;
    });
    gallery.init();
    gallery.goTo(index);
};

//图片旋转
function imgRotate(){
	var img=$("img",gallery.currItem.container);
	img.rotate({animateTo: gallery.currItem.i*90});
	gallery.currItem.i++;
}

//获取鼠标点击的html属性
function getEventTarget(e) {  
    e = e || window.event;
    if(!e)return "";
    return e.target || e.srcElement;  
    }
