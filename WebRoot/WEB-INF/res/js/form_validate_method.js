/*****************************************************************
                  jQuery Validate扩展验证方法  (2016.01.04 BY.lpr)       
*****************************************************************/
//必填项
jQuery.validator.addMethod("require", function(value, element) {
	return this.optional(element) || isNull(value);
}, "不能为空或者空格");
//判断中文字符 
jQuery.validator.addMethod("isCn", function(value, element) {
	return this.optional(element) || /^[\u0391-\uFFE5]+$/.test(value);
}, "只能输入中文");
//判断英文字符 
jQuery.validator.addMethod("isEnglish", function(value, element) {       
     return this.optional(element) || /^[A-Za-z]+$/.test(value);       
}, "只能包含英文字符");
//匹配中文(包括汉字和字符) 
jQuery.validator.addMethod("isChineseChar", function(value, element) {
     return this.optional(element) || /^[\u0391-\uFFE5]+$/.test(value);       
}, "请输入汉字(包括汉字和字符)");
//判断是否为合法字符(a-zA-Z0-9-_) 不能输入特殊字符
jQuery.validator.addMethod("isRightfulString", function(value, element) {       
     return this.optional(element) || /^[A-Za-z0-9_-]+$/.test(value);       
}, "只能输入字母或者数字");
//判断是否为合法数字(0-9-_) 不能输入特殊字符
jQuery.validator.addMethod("isNum", function(value, element) {       
     return this.optional(element) || /^\d+(?=\.{0,1}\d+$|$)/.test(value);       
}, "只能输入数字");
//判断手机号码
jQuery.validator.addMethod("isPhone", function(value, element) {
	return this.optional(element) || checkMobilePhone(value);
}, "联系电话格式不正确，请输入手机号码");
//电话号码验证    
jQuery.validator.addMethod("isTel", function(value, element) {    
  var tel = /^(\d{3,4}-?)?\d{7,9}$/g;    
  return this.optional(element) || (tel.test(value));    
}, "请正确填写您的电话号码");
//联系电话(手机/电话皆可)验证  
jQuery.validator.addMethod("isTelOrPhone", function(value,element) {   
    var length = value.length;   
    var mobile = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/;   
    var tel = /^(\d{3,4}-?)?\d{7,9}$/g;       
    return this.optional(element) || tel.test(value) || (length==11 && mobile.test(value));   
}, "请正确填写您的联系方式");
// 匹配qq      
jQuery.validator.addMethod("isQq", function(value, element) {       
     return this.optional(element) || /^[1-9]\d{4,12}$/.test(value);       
}, "请输入正确的QQ号");
//身份证号码验证
jQuery.validator.addMethod("isIdCardNo", function(value, element) {
  return this.optional(element) || isIdCardNo(value);    
}, "请输入正确的身份证号码");
//IP地址验证   
jQuery.validator.addMethod("ip", function(value, element) {    
  return this.optional(element) || /^(([1-9]|([1-9]\d)|(1\d\d)|(2([0-4]\d|5[0-5])))\.)(([1-9]|([1-9]\d)|(1\d\d)|(2([0-4]\d|5[0-5])))\.){2}([1-9]|([1-9]\d)|(1\d\d)|(2([0-4]\d|5[0-5])))$/.test(value);    
}, "请填写正确的IP地址");
//积分必须是100的整数倍
jQuery.validator.addMethod("multiplesOfHundred", function(value, element) {
	return this.optional(element) || (value % 100 == 0);
}, "积分必须是100的整数倍");
//验证密码 6-18位由字符数字和特殊符号组成 排除空格.
jQuery.validator.addMethod("checkPassword",function(value, element) {
	return this.optional(element) || /^[^\s]{6,18}$/.test(value);
}, "请输入6-18位由字符数字和特殊符号组成的有效密码");
//验证邮政编码 
jQuery.validator.addMethod("checkPost",function(value,element){
	return this.optional(element) || /^[0-9]{6}$/.test(value);
}, "请输入有效的邮政编码");
//验证邮箱
jQuery.validator.addMethod("checkEmail",function(value,element){
	return this.optional(element) || /^[_a-zA-Z0-9\-]+(\.[_a-zA-Z0-9\-]*)*@[a-zA-Z0-9\-]+([\.][a-zA-Z0-9\-]+)+$/.test(value);
}, "电子邮箱格式不正确，请输入有效的E_mail");
//下拉框必选
jQuery.validator.addMethod("selectNode",function(value,element){
	return this.optional(element) || (value == '') || (value == '请选择');
}, "必选项，请选择一项");

// 起止时间比对
jQuery.validator.addMethod("endDate", function(value, element) { 
	var startDate = $('#start_date').val();
	return this.optional(element) || new Date(Date.parse(startDate.replace("-", "/"))) <= new Date(Date.parse(value.replace("-", "/"))); 
}, "结束日期必须大于开始日期");

//判断是不是集装箱号
jQuery.validator.addMethod("isContainerCode", function(value, element) {
	var Charcode = "0123456789A?BCDEFGHIJK?LMNOPQRSTU?VWXYZ";
	if(value.length <1){return true;}
	if (value.length != 11) return false;
	var num = 0;
	for (var i = 0; i < 10; i++) {
		var idx = Charcode.indexOf(value[i]);
		if (idx == -1 || Charcode[idx] == '?') {
			result = false;
			break;
		}
		idx = idx * Math.pow(2, i);
		num += idx;
	}
	num = (num % 11) % 10;
	return this.optional(element) || parseInt(value[10]) == num;
}, "集装箱号格式不正确，请输入集装箱号");

/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

//表单验证默认设置
$.validator.setDefaults({
	highlight : function(e) {
		$(e).closest(".form-group").removeClass("has-success").addClass("has-error");
	},
	success : function(e) {
		e.closest(".form-group").removeClass("has-error").addClass("has-success");
	},
	errorElement : "span",
	errorPlacement : function(e, r) {
		e.appendTo(r.is(":radio") || r.is(":checkbox") ? r.parent().parent().parent(): r.parent());
	},
	errorClass : "help-block m-b-none",
	validClass : "help-block m-b-none"
});

//校验手机号码正则
function checkMobilePhone(str) {
	str = str.trim();
	if (str != "") {
		if (str.length == 12) {
			return /^0?(0\d{11})$/.test(str);
		} else{
			return /^0?(1[3-9]\d{9})$/.test(str);
		}
	} else{
		return true;
	}
}
//身份证号码的验证规则
function isIdCardNo(num){
    //if (isNaN(num)) {alert("输入的不是数字！"); return false;} 
	var len = num.length, re = "";
	if (len == 15){
		re = new RegExp(/^(\d{6})()?(\d{2})(\d{2})(\d{2})(\d{2})(\w)$/); 
	} else if (len == 18) {
	    re = new RegExp(/^(\d{6})()?(\d{4})(\d{2})(\d{2})(\d{3})(\w)$/); 
	} else {
	     //alert("输入的数字位数不对。"); 
	     return false;
	 }
	var a = num.match(re);
	if (a != null){
		var D="",B="";
		if(len == 15){
			D = new Date("19"+a[3]+"/"+a[4]+"/"+a[5]);
			B = D.getYear()==a[3]&&(D.getMonth()+1)==a[4]&&D.getDate()==a[5];
		}else{
			D = new Date(a[3]+"/"+a[4]+"/"+a[5]);
			B = D.getFullYear()==a[3]&&(D.getMonth()+1)==a[4]&&D.getDate()==a[5];
		}
		if(!B){
			//alert("输入的身份证号 "+ a[0] +" 里出生日期不对。"); 
			return false;
		}
	}
	if(!re.test(num)){
	     //alert("身份证最后一位只能是数字和字母。");
	     return false;
	}
	return true; 
}

/*
用途：检查输入字符串是否为空或者全部都是空格
输入：str
返回：
如果全是空返回true,否则返回false
*/
function isNull(str){
	if ( str == "" ) return true;
	var regu = "^[ ]+$";
	var re = new RegExp(regu);
	return re.test(str);
}
