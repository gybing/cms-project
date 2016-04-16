
// 集装箱信息操作 ============================================================================================

/**
 * 添加集装箱 弹出窗
 */
function addBox() {
	layer.open({
		type : 2,
		title : "新增集装箱",
		area : [ '800px', '350px' ],
		fix : true, //不固定
		//maxmin: true,
		content : _contextPath+"/topic/selOrderBoxsPage"
	});
}

/**
 * 向修改页里动态添加集装箱列表记录
 * @param SIZES集装箱尺寸
 * @param SPECS箱规
 * @param NUMSS添加数量
 */
var s = 0;
function boxAddRow(SIZES,SPECS,NUMSS){
	for(var m=1; m <= SIZES.length; m++){
		var i = m-1;
		var size = SIZES[i];
		var spec = SPECS[i];
		var nums = NUMSS[i]==""?0:NUMSS[i];
		if(nums > 0){
			for(var n=1; n <= nums; n++){
				s++;
				var trHtml="";
				trHtml +="<tr height='30px'>";
				trHtml +="<td>"+ iNO +"</td>";
				trHtml +="<td><select class='combox' id='"+ i +"SIZE_"+ s +"' name='SIZE' style='width:100%;'></select></td>";
				trHtml +="<td><select class='combox' id='"+ i +"SPEC_"+ s +"' name='SPEC' style='width:100%;'></select></td>";
				trHtml +="<td><input id='"+ i +"NO_"+ s +"' name='NO' class='isContainerCode' type='text' style='width:100%;' maxlength='50'/></td>";
				trHtml +="<td><input id='"+ i +"SEAL_NO_"+ s +"' name='SEAL_NO' type='text' style='width:100%;' maxlength='50'/></td>";
				trHtml += "<td><select class='combox' id='"+ i +"ADDR_TX"+ s +"' name='ADDR_TX' style='width:100%;'></select></td>";
				trHtml +="<td><input id='"+ i +"B_LOAD_CONTACT_"+ s +"' value='"+ $("#LOAD_CONTACT").val() +"' name='B_LOAD_CONTACT' type='text' style='width:100%;' maxlength='50'/></td>";
				trHtml +="<td><input id='"+ i +"B_ADDR_"+ s +"' name='B_ADDR' value='"+ $("#ADDR").val() +"' type='text' style='width:100%;' maxlength='300'/></td>";
				trHtml +="<td><input id='"+ i +"BOX_REMARK_"+ s +"' name='BOX_REMARK' value='"+ $("#ORDER_REMARK").val() +"' type='text' style='width:100%;' maxlength='500'/></td>";
				trHtml +="<td>";
				trHtml +="<input name='BOX_ID' type='hidden' value='-1'/>";
				trHtml +="<input name='BOX_LAST_STATE' type='hidden' value='-1'/>";
				trHtml +="<button type=\"button\" class=\"btn btn-default\" onclick=\"delRow(this,'集装箱')\">删除</button>";
				trHtml +="</td></tr>";
				//初始化下拉框
				$C("#boxList tbody").append(trHtml);
				iNO ++;
				$s2.init($C("#"+ i +"SIZE_"+s), {
					sysdict : $sysdict.BOX_SIZE,
					defVal : size
				});
				$s2.init($C("#"+ i +"SPEC_"+s), {
					sysdict : $sysdict.BOX_TYPE,
					defVal : spec
				});
				$s2.init($C("#"+ i +"ADDR_TX"+s), { // 提箱地点
					tabdict : "dict_area",
					defVal: $("#BOX_TAKE").val(),
					isSear : 1
				});
			}
		}
	}
}

//费用操作 ============================================================================================
/**
 * 新增费用类型
 */
function feeAdd() {
	layer.open({
		type : 2,
		title : "新增费用类型",
		area : [ '800px', '350px' ],
		fix : true, //不固定
		//maxmin: true,
		content : _contextPath+"/topic/addOrderFeePage"
	});
}

/**
 * 费用项目 新增
 */
var maxRow = 0;
function feeAddRow(d_val){
	maxRow++;
	var trHtml = "";
	trHtml +="<tr height='30'>";
	trHtml +="<td width='50'>&nbsp;</td>";
	trHtml +="<td><select class='combox' id='"+ maxRow +"FEE_TYPE"+ maxRow +"' name='FEE_TYPE'></select></td>";
	trHtml +="<td><input id='"+maxRow+"FEE_AMOUNT"+maxRow+"' name='FEE_AMOUNT' value='0' type='text' class='required isNum' onchange='changeCostAll()' style='width:80px;' maxlength='11'/></td>";
	trHtml +="<td><input id='"+maxRow+"FEE_REMARK"+maxRow+"' name='FEE_REMARK' type='text' style='width:258px;' maxlength='150'/></td>";
	trHtml +="<td><input name='FEE_ID' type='hidden' value='-1' />";
	trHtml +="<button type=\"button\" class=\"btn btn-outline btn-default btn-xs\" onclick=\"delRow(this,'费用项目')\">";
	trHtml +="<i class=\"glyphicon glyphicon-minus\" aria-hidden=\"true\"></i></button></td>";
	trHtml +="</tr>";
	$C("#fyInfo").append(trHtml);
	$s2.init($C("#"+maxRow+"FEE_TYPE"+maxRow), {
		tabdict : "fee_type",
		defVal: d_val,
		isSear : 1
	});
}

/**
 * 计算费用合计
 */
function changeCostAll() {
	var tempVal = 0, val = 0.00;
	$("input[name='FEE_AMOUNT']").each(function() {
		tempVal = $(this).val();
		if (!isNaN(tempVal)) {
			val = Number(val || 0) + Number(tempVal || 0);
		}
	});
	if(val == 0){
		val = 0.00;
	}
	$("#costAll").html(val);
	$("#ALL_COST").val(val);
}

//刷新费用下拉框
function refreshFeeType(){
	$("select[name='FEE_TYPE']").each(function(i){
		var obj=$(this);
		$s2.init(obj, {
			tabdict : "fee_type",
			defVal: obj.val(),
			isSear : 1
		});
	});
}
// 删除TR ===========================================================================

/**
 * 删除TR
 * @param obj集装箱尺寸
 * @param tag标志 费用项目 集装箱
 */
function delRow(obj, tag,id) {
	if(tag == '集装箱' && !isEmpty(id)){
		swal("", "该集装箱已被调度,不能删除!", "error");
		return;
	}
	swal({
		title : "您确定要删除该" + tag + "吗？",
		type : "warning",
		showCancelButton : true,
		confirmButtonColor : "#DD6B55",
		confirmButtonText : "确定",
		cancelButtonText : "取消",
		closeOnConfirm : true
	}, function() {
		$(obj).parent().parent().remove();
		if(tag == '费用项目'){  //刪除項目費用 計算總費用
			changeCostAll();
		}else{
			var i = 1;
			$("#boxList tr td:nth-child(1)").each(function(){  //序号
				$(this).text(i);
				i++;
            });
		}
	});
}
// 信息回填 =============================================================================================
/**
 * 选中船名时回填航线信息
 */
function changeShipVoyage(){
	var SHIP_NAME = $("#SHIP_NAME").val();
	if(SHIP_NAME == ''){
		return;
	}
	$.ajax({
		type : "POST", // 提交的类型 
		url : _contextPath+"/topic/ajax/getOrderShipVoyage?s="+new Date().getTime(),
		data : {"SHIP_NAME" : SHIP_NAME}, // 参数 
		dataType : "json",
		async : false,
		success : function(data) {
			var json = data.resultObj;
			if(data.result == '1'){
				$("#SHIP_VOYAGE").val(json.LINE);
			}
		},error : function(data) {
			alert("changeShipVoyage请求异常！");
		}
	});
}

/**
 * 选中货主时回填货主其他信息
 * @param type类型OWNNER货主  PROXY货代
 */
function changeOwnerInfo(type){
	var OWNNER_ID = "0";
	if(type == "OWNNER"){
		OWNNER_ID = $("#CARGO_OWNER_ID").val();
	}else if(type == "PROXY"){
		OWNNER_ID = $("#CARGO_PROXY_ID").val();
	}
	$.ajax({
		type : "POST", // 提交的类型 
		url : _contextPath+"/topic/ajax/getOrderOwnerInfo?s="+new Date().getTime(),
		data : {"OWNNER_ID" : OWNNER_ID}, // 参数 
		dataType : "json",
		async : false,
		success : function(data) {
			var json = data.resultObj;
			if(data.result == '1'){
				$("#CARGO_"+type).val(json.COMPANY); // 货主    CARGO_OWNNER CARGO_PROXY
				$("#"+ type +"_NAME").val(json.LINKMAN);	// 货主联系人
				$("#"+ type +"_TEL").val(json.LINKTEL);	// 货主电话
				if($("#PAYER").val() == '' || 'add' == $("#T").val()){
					if(type == 'PROXY' && $("#CARGO_"+type).val() != ''){  //OWNNER PROXY 
						$("#PAYER").val($("#CARGO_"+type).val());
					}else{
						$("#PAYER").val(json.COMPANY);	// 详细信息中的付款方 为空时默认为货主
					}
				}
			}
		},error : function(data) {
			alert("changeOwnerInfo请求异常！");
		}
	});
}

// 收起  添加更多信息 ==============================================================================
/**
 * 添加更多信息  收起
 * @param idDIV的id
 */
function showDiv(id){
	if($("#"+id).css("display")=='none'){//如果show是隐藏的
		$("#"+id).css("display","block");//show的display属性设置为block（显示）
		$("#"+ id +"Btn").val("收起");
	}else{//如果show是显示的
		$("#"+id).css("display","none");//show的display属性设置为none（隐藏）
		$("#"+ id +"Btn").val("填写更多...");
	}
}
