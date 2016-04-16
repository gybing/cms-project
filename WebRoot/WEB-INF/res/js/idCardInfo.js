/******************************根据设备读取身份证信息**************************************/

/********开始读卡*********/
function StartRead() {
	var ret = GT2ICROCX.ReadCard();
	//读卡成功
	if (ret == "0"){
		clearAllData();
		return true;
	}
	//读卡失败
	alert("读卡错误,错误原因:" + ret);
	return false;
} 
/**填充数据**/
function fillIdCardData() {
	//alert("born:" +GT2ICROCX.Born+" addr"+GT2ICROCX.Address+"  cardno"+GT2ICROCX.CardNo);
	//名字
	fillData("A_USER_NAME",GT2ICROCX.Name);
	//设置性别
	var sex = GT2ICROCX.Sex == "2" ? 'F' : 'M';
	if(sex=='F'){
		$("#GENDER").val(sex);
	}else{
		$("#GENDER").val(sex);
	}
	
	//民族
	//fillData("nation",GT2ICROCX.NationL);
	//出生日期
	var date=GT2ICROCX.Born.substr(0,4)+"-"+GT2ICROCX.Born.substr(4,2)+"-"+GT2ICROCX.Born.substr(6,2);
	fillData("A_BIRTHDAY", date);
	//地址
	fillData("A_LOCATION",GT2ICROCX.Address);
	//身份号码
	fillData("A_IDCARD_NO",GT2ICROCX.CardNo);
	//签发机关
	//fillData("issuedAt",GT2ICROCX.Police);
	//起始有效期
	//fillData("effectedDate", simpleDateFormat(GT2ICROCX.activityfrom));
	//终止有效期
	//fillData("expiredDate", simpleDateFormat(GT2ICROCX.ActivityTo));
	//身份证头像
	//fillData("base64Jpg",GT2ICROCX.Base64Jpg);
	//身份证正面
	//fillData("base64FaceJpg",GT2ICROCX.Base64FaceJpg);
	//身份证反面
	//fillData("base64BackJpg",GT2ICROCX.Base64BackJpg);
	//身份证正面照显示
	//$("#idCardImg", navTab.getCurrentPanel()).attr("src","data:image/jpg;base64,"+GT2ICROCX.Base64FaceJpg);
	//$("#idCardBackImg", navTab.getCurrentPanel()).attr("src","data:image/jpg;base64,"+GT2ICROCX.Base64BackJpg);
}
/****填充数据*****/
function fillData(id,val) {
	//先判断元素是否存在
	if(existsElement(id)){
		$("#"+id, navTab.getCurrentPanel()).val(val);
	}
}
/******清空所有的值***/
function clearAllData()
{
	//出生日期
	clearData("A_BIRTHDAY");
	//地址
	clearData("A_LOCATION");
	//身份号码
	clearData("A_IDCARD_NO");
	//用户姓名
	clearData("A_USER_NAME");
}
/******清空数据*****/
function clearData(id){
	//先判断元素是否存在
	if(existsElement(id)){
		$("#"+id, navTab.getCurrentPanel()).val("");
	}
}

/*****元素是否存在******/
function existsElement(id){
	if($("#"+id, navTab.getCurrentPanel()).length > 0 && $("#"+id).length == 1)
	{
		return true;
	}
	return  false;
}