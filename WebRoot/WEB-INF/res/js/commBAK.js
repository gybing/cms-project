function readObject(obj){
	var arr = [];
	for(var n in obj){
		arr.push(n + ":" + obj[n]);
	} 
	return arr.join(",");
}

/**判断对象是否为空*/
function isEmpty(str){
	if(str === '' || str == null || str.length == 0 || str == undefined){
		return true;
	}
	return false;
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
 * 初始化地区选择控件， 
 */
function initArea(id,tag){
	var obj=navTab.getCurrentPanel();
	if(tag && tag=="dialog"){
		obj = $.pdialog.getCurrent();
	}
	var value=$("#"+id, obj).val();
	var suffix_prov="_prov";
	var suffix_city="_city";
	var suffix_county="_county";

	$("#"+id+suffix_prov, obj).attr("ref",id+suffix_city);
	$("#"+id+suffix_prov, obj).attr("refUrl",_contextPath+"/topic/ajax/queryArea?PARENT_CODE={value}");
	$("#"+id+suffix_city, obj).attr("ref",id+suffix_county);
	$("#"+id+suffix_city, obj).attr("refUrl",_contextPath+"/topic/ajax/queryArea?PARENT_CODE={value}");
	
	$("select[id^='"+id+"_']", obj).bind('change',function(){
		var objId=this.id;
		var prefix=objId.substring(0,objId.lastIndexOf("_"));//前缀
		var suffix=objId.substring(objId.lastIndexOf("_"));//后缀
		if($(this).val()!=""){
			$("#"+id, obj).val($(this).val());
		}else{
			if(suffix==suffix_prov){
				$("#"+id, obj).val($(this).val());
			}else if(suffix==suffix_city){
				var tmp=$("#"+prefix+suffix_prov, obj).val();
				if(tmp!=""){
					$("#"+id, obj).val(tmp);
				}
			}else{
				var tmp=$("#"+prefix+suffix_city, obj).val();
				if(tmp==""){
					tmp=$("#"+prefix+suffix_prov, obj).val();
				}
				$("#"+id, obj).val(tmp);
			}
		}
	});
	if(!isEmpty(value) && value.length==6){
		var parent="0";
		var index=value.indexOf("00");
		index=index!=2&&index!=4?-1:index;
		switch (index) {
		case -1:
			parent=value.substring(0,4)+"00";
			setArea(id+suffix_county,parent,value,obj);
		case 4:
			parent=value.substring(0,2)+"0000";
			value=value.substring(0,4)+"00";
			setArea(id+suffix_city,parent,value,obj);
			if(index==4){
				setArea(id+suffix_county,value,obj);
			}
		case 2:
			parent="0";
			value=value.substring(0,2)+"0000";
			setArea(id+suffix_prov,parent,value,obj);
			if(index==2){
				setArea(id+suffix_city,value,obj);
			}
		}
	}else{
		setArea(id+suffix_prov,"0","",obj);
	}
}
/***
 * 地区选择控件设置地址
 * */
function setArea(id,parentCode,defValue,obj){
	$.ajax({
		type:"post",
		data:{"PARENT_CODE":parentCode},
		url:_contextPath+"/topic/ajax/queryArea",
		async:false,
		dataType:"json",
		success:function(data){
			data=data.resultObj;
			if(data.length == 0) alterMsg.error("初始化地区错误");
			$("#"+id, obj).empty();
			$.each(data,function(i,e){
				var selected="";
				if(!isEmpty(defValue) && e[0]==defValue){
					selected="selected=\"selected\"";
				}
				$("#"+id, obj).append("<option value='"+e[0]+"' "+selected+" >"+e[1] +"</option>");
			});
		},error:function(XMLHttpRequest, textStatus, errorThrown){
			alert(textStatus);
		}
	});
}
/**
 * 获取字典表数据
 * */
function getDict(type,callback,async){
	var $callback = callback;
	if (! $.isFunction($callback)) $callback = eval('(' + callback + ')');
	var $async=true;
	if(!isEmpty(async)){
		$async=async;
	}
	$.ajax({
		type : "POST",
		url : _contextPath+'/topic/ajax/getDict',
		data : {"type" : type},
		async:$async,
		dataType : "json",
		success : $callback, 
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alertMsg.warn("请求异常：" + textStatus);
		}
	});
}

function readObject(obj){
	var arr = [];
	for(var n in obj){
		arr.push(n + ":" + obj[n]);
	} 
	return arr.join(",");
}

function getElementsValuesByName(eName){
	var aaa = document.getElementsByName(eName);
	var arr = [];
	for(var i = 0; i <aaa.length; i++){
		arr.push(aaa[i].value);
	}
	return arr;
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
function isEmpty(str){
	if(str === '' || str == null || str.length == 0 || str == undefined){
		return true;
	}
	return false;
}
function openDialog(_width, _height, _title, _url){
	$.pdialog.open(_url, 
			"view", _title, {mask:true, width: _width, height:_height});
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
 * alert(leftPad("123",6,'0'));
 * @param s
 * @param mL
 * @param seq
 * @returns
 */
function leftPad(s,mL,seq){
	return Array(mL+1).join(seq).replace(eval('/'+(seq?seq:',')+'/g'), function(m,i){ with(s){return mL-length>i?m:split('')[i-(mL-length)];}});
}
//对Date的扩展，将 Date 转化为指定格式的String
//月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
//年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
//例子： 
//(new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
//(new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
Date.prototype.Format = function (fmt) { //author: meizz 
 var o = {
     "M+": this.getMonth() + 1, //月份 
     "d+": this.getDate(), //日 
     "H+": this.getHours(), //小时 
     "m+": this.getMinutes(), //分 
     "s+": this.getSeconds(), //秒 
     "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
     "S": this.getMilliseconds() //毫秒 
 };
 if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
 for (var k in o)
 if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
 return fmt;
};
//时间对比
function compareTime(startDate, endDate) {  
	if (startDate.length > 0 && endDate.length > 0) {  
	    var startDateTemp = startDate.split(" ");  
	    var endDateTemp = endDate.split(" ");  
	
	    var arrStartDate = startDateTemp[0].split("-");  
	    var arrEndDate = endDateTemp[0].split("-");  
	
	    var arrStartTime = startDateTemp[1].split(":");  
	    var arrEndTime = endDateTemp[1].split(":");  
	
		var allStartDate = new Date(arrStartDate[0], arrStartDate[1], arrStartDate[2], arrStartTime[0], arrStartTime[1], arrStartTime[2]);  
		var allEndDate = new Date(arrEndDate[0], arrEndDate[1], arrEndDate[2], arrEndTime[0], arrEndTime[1], arrEndTime[2]);  
	
		if (allStartDate.getTime() >= allEndDate.getTime()) {  
		        return false;  
		} else {  
		    return true;  
		}  
	} else {  
	    return false;  
	}  
}

/**
 * 重置form表单
 * @param formId 表单id
 * @param target dialog或navTab
 */
function resetForm(formId,target){
	var box=target=="dialog"?$.pdialog.getCurrent():navTab.getCurrentPanel();
	var $form=$("#"+formId,box);
	$("input[type='text']",$form).each(function(i){
		$(this).val("");
	});
	$("select",$form).each(function(i){
		if(this.options.length>0){
			var value=this.options[0].value;
			$(this).val(value);
		}
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
 * 下拉框控件
 */
var $s2 = {}; 
$s2.select = function(obj,val){//下拉框根据值选中
	obj.select2().val(val).trigger("change");
}
//下拉框控件 初始化
$s2.init = function (obj, param) {
	param = param || {};
	var s2param = param;
	s2param.width = param.width||"150px";
	s2param.vType = param.vType;
	if(param.vType == "radio" || param.vType == "checkbox"){//单选或者多选框
		if(param.tabdict) {
			$.ajax({
				url : _contextPath+"/topic/ajax/getTabSel?s="+new Date().getTime(),
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
						var option = "<input "+ temp +" type=\""+ param.vType +"\" name=\""+ param.vID +"\" value=\""+ item.ID +"\" />"+item.TEXT;
						obj.append(option);
					});
					if(!param.defVal){//都没有选中的话 默认选中第一个
						document.getElementsByName(param.vID)[0].checked = true;
					}
				}
			});
		} else if(param.sysdict) {
			s2param.data=$.map(param.sysdict, function(obj){
				obj.id = obj.id || obj.ID;
				obj.text = obj.text || obj.TEXT;
				return obj;
			});
			
			$.each(s2param.data, function(index, item) {
				var temp= "";
				if(param.defVal && param.defVal == item.ID){
					temp = "checked";
				}
				var option = "<input "+ temp +" type=\""+ param.vType +"\" name=\""+ param.vID +"\" value=\""+ item.ID +"\" />"+item.TEXT;
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
				url : _contextPath+"/topic/ajax/getTabSel?s="+new Date().getTime(),
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
			s2param.data=$.map(param.sysdict, function(obj){
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
	return $(cselname ,navTab.getCurrentPanel());
}
function $C(cselname) {
	return $(cselname ,navTab.getCurrentPanel());
}


/**
 * 将查询控件的值都设为空
 */
var $R = {};
$R.reset = function(obj){
	obj.find("input").each(function(){//input 
		$(this).val("");
	});
	obj.find("select").each(function(){
		$s2.select($C(this),"");//设置select
	});
};

/**
 * 判断是否为图片
 * */
function isImage(obj)
{
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
		return;
	}
}
var gallery;//PhotoSwipe对象
function openPhoto(imgArrObj,index) {
    var pswpElement = document.querySelectorAll('.pswp')[0];
    var items = [];
    $(imgArrObj).each(function(i){
    	var img = new Image();
    	var imgHeight;
    	var imgWidth;
    	img.src=$(this).attr("src");
    	imgHeight=img.height*2;
    	imgWidth=img.width*2;
    	items.push({ src: $(this).attr("src"), w: imgWidth,h: imgHeight,title:$(this).attr("title"),i:1});
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
// 重置并刷新表单
function resetCurrentPagerForm(){
	resetForm('pagerForm','navTab');
	$("#pagerForm", navTab.getCurrentPanel()).submit();
}