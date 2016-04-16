<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
#driverEditForm td{
	padding: 5px
}
#driverInputTable td input{
	width: 255px
}
#driverTypeTr td input{
	width: 15px;
}

/* 附件表格样式 */
#show_driver_edit_table tr th{
	font-size: 15px;
	padding: 10px;
	background-color: #d6e4ef
}
#show_driver_edit_table tr td img{
padding: 1px 10px 1px 0px
}
#driverEditImgTable td {
	padding: 5px;
}
.imgTd img{
	width: 150px;
	height: 150px
}
.imgDiv{
	margin:10px;
	width: 158px;
	height: 158px;
	position: relative;
	display: inline-block;
}
.imgDiv .closeImg{
	width: 20px;
	height: 20px;
	top:-10px;
	right:-3px;
	background: url("${resRoot}/img/close.png") no-repeat scroll 0% 0%;
	position: absolute;
	cursor:pointer;
}
/* 附件表格样式 ===end*/
</style>

<div class="pageContent">
	
			
	<form id="driverEditForm" method="post" action="${ctxPath}/topic/ajax/editDriver" class="pageForm required-validate" onsubmit="return validateCallback(this,customNavTabAjaxDone)">
		<input type="hidden" id="driverId" name="driverId" value="${param.driverId }"/>
		<!-- 面板 -->
		<div id="add_driver_tabs" class="tabs">
			<div class="tabsHeader">
				<div class="tabsHeaderContent">
					<ul>
						<li><a class="icon" href="javascript:void(0)" onclick=""><span>基本信息</span></a></li>
						<li><a class="icon" href="javascript:void(0)" onclick=""><span>附件</span></a></li>
					</ul>
				</div>
			</div>
			<div class="tabsContent" layoutH="66">
				<!-- ============第一个面板START============= -->
				<div id="add_driver_info_panel" style="">
					<input type="hidden" id="navTabId" value="toDriverManage"/>
					<input type="hidden" id="callbackType" value="closeCurrent"/>
					<div class="pageFormContent" layoutH="1">
					<table id="driverInputTable">
						<tr>
							<td>司机姓名</td>
							<td><input type="text" name="driverName" id="driverName"/></td>
							<td>司机代码</td>
							<td><input type="text" name="driverCode" id="driverCode"/></td>
						</tr>
						<tr>
							<td>档案编号</td>
							<td><input type="text" name="fileNo" id="fileNo"/></td>
							<td>职&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;务</td>
							<td><input type="text" name="due" id="due"/></td>
						</tr>
						<tr>
							<td>出生年月</td>
							<td><input type="text" name="birthday" id="birthday"/></td>
							<td>性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别</td>
							<td>
								<select name="sex" id="sex">
									<option value="男">男</option>
									<option value="女">女</option>
								</select>
								<span>组&nbsp;别</span>
								<input id="groupNo" type="text" name="groupNo" style="width: 185px;float: none;"/>
							</td>
						</tr>
						<tr>
							<td>身份证号</td>
							<td><input id="idCard" type="text" name="idCard" maxlength="20"/></td>
							<td>调度中心</td>
							<td>
								<select id="scheduleCenter" name="scheduleCenter" style="width: 261px">
									<option value="">请选择</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>文化程度</td>
							<td>
								<select id="graduation" name="graduation" style="width: 261px">
									<option value="">请选择</option>
									<option value="小学">小学</option>
									<option value="初中">初中</option>
									<option value="高中">高中</option>
									<option value="大学">大学</option>
									<option value="研究生">研究生</option>
									<option value="博士">博士</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>驾驶证号</td>
							<td>
								<input id="licenseNo" type="text" name="licenseNo"/>
							</td>
							<td>驾驶证类别</td>
							<td>
								<input id="licenseType" type="text" name="licenseType"/>
							</td>
						</tr>
						<tr>
							<td>初领证日期</td>
							<td><input id="licenseDate" type="text" class="date" name="licenseDate"/></td>
							<td>年审日期</td>
							<td><input id="licenseLimited" type="text" class="date" name="licenseLimited"/></td>
						</tr>
						<tr>
							<td>从业资格证</td>
							<td><input id="qualification" type="text" class="" name="qualification"/></td>
							<td>年审日期</td>
							<td><input id="qualificationLimited" type="text" class="date" name="qualificationLimited"/></td>
						</tr>
						<tr>
							<td>默认车牌</td>
							<td>
								<select id="defaultTruck" name="defaultTruck" style="width: 261px">
									<option value="">请选择</option>
								</select>
							</td>
							<td>车&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;架</td>
							<td>
								<select id="defaultFrame" name="defaultFrame" style="width: 261px">
									<option value="">请选择</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>海关编号</td>
							<td><input id="customsNo" type="text" class="" name="customsNo"/></td>
							<td>IC&nbsp;&nbsp;&nbsp;&nbsp;卡号</td>
							<td><input id="icNo" type="text" class="" name="icNo"/></td>
						</tr>
						<tr>
							<td>手机号码1</td>
							<td><input id="mobile1" type="text" class="" name="mobile1"/></td>
							<td>手机号码2</td>
							<td><input id="mobile2" type="text" class="" name="mobile2"/></td>
						</tr>
						<tr>
							<td>手机号码3</td>
							<td><input id="mobile3" type="text" class="" name="mobile3"/></td>
							<td>传&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;真</td>
							<td><input id="fax" type="text" class="" name="fax"/></td>
						</tr>
						<tr>
							<td>qq&nbsp;&nbsp;&nbsp;&nbsp;卡号</td>
							<td><input id="qq" type="text" class="" name="qq"/></td>
							<td>E-Mail</td>
							<td><input id="email" type="text" class="" name="email"/></td>
						</tr>
						<tr>
							<td>基本工资</td>
							<td><input id="salaryBase" type="text" class="" name="salaryBase"/></td>
							<td>地&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;址</td>
							<td><input id="addr" type="text" class="" name="addr"/></td>
						</tr>
						<tr>
							<td>备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注</td>
							<td><input id="remark" type="text" name="remark"/></td>
							<td>当前状态</td>
							<td>
								<select id="currentStatus" name="currentStatus">
									<option value="">请选择</option>
									<option value="在职">在职</option>
									<option value="离职">离职</option>
								</select>
							</td>
						</tr>
						<tr id="driverTypeTr">
							<td colspan="2">
								<!-- 司机类型 -->
								<input id="tuoche" type="hidden" name="tuoche" value=""/>
								<input id="diaoche" type="hidden" name="diaoche" value=""/>
								<input id="weixiu" type="hidden" name="weixiu" value=""/>
								<input id="tuocheCheckBox" type="checkbox" value="0" name="tuocheCheckBox" onclick="clickCheckBox('tuoche')"/><span>拖车司机</span>
								<input id="diaocheCheckBox" type="checkbox" value="0" name="diaocheCheckBox" onclick="clickCheckBox('diaoche')" style="margin-left: 35px;"/><span>吊车司机</span>
								<input id="weixiuCheckBox" type="checkbox" value="0" name="weixiuCheckBox" onclick="clickCheckBox('weixiu')" style="margin-left: 35px;"/><span>维修工作</span>
							</td>
							<td colspan="2">
								<input id="waixie" type="hidden" name="waixie" value=""/>
								<input id="guakao" type="hidden" name="guakao" value=""/>
								<input id="waixieCheckBox" type="checkbox" value="0" name="waixieCheckBox" onclick="clickCheckBox('waixie')"/><span>外协</span>
								<input id="guakaoCheckBox" type="checkbox" value="0" name="guakaoCheckBox" onclick="clickCheckBox('guakao')" style="margin-left: 35px;"/><span>挂靠</span>
							</td>
						</tr>
					</table>
					</div>
				</div>
				<!-- ============第一个面板END============= -->
				<!-- ============第二个面板START============= -->
				<div id="add_driver_pic_panel" style="">
					<div class="pageFormContent" >
						<!-- 上传图片组件 -->
						<table id="driverEditImgTable">
							<tr>
								<td style="padding: 0px">相关证件：
									<button type="button" style="float: right;" onclick="addDriverPic()">新增</button>
								</td>
							</tr>
							<tr>
								<td>
									<table id="show_driver_edit_table" border="1">
										<thead>
											<tr>
												<th style="min-width: 100px" align="center">证件类型</th>
												<th style="min-width: 800px" align="center">图片</th>
												<th width="100px" align="center">操作</th>
											</tr>
										</thead>
										<tbody>
											<input id="driverEdit_maxImgNum" name="driverEdit_maxImgNum" type="hidden"
												value="0" />
											<input name="defualt_prefix" type="hidden" value="driverEdit"/>
										</tbody>
									</table>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<!-- ============第二个面板END============= -->
			</div>
		</div>
	</form>
	<div class="formBar">
		<ul style="float:left">
			<li><div class="buttonActive"><div class="buttonContent"><button type="button" onclick="submitEditDriverForm()" >保存</button></div></div></li>
			<li><div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div></li>
		</ul>
	</div>
</div>
<script  type="text/javascript">
	function submitEditDriverForm(){
		
		/* var areaCheckedTypeSize =$("input[name='type']:checked", navTab.getCurrentPanel()).size();
		if(areaCheckedTypeSize==0){
			alertMsg.warn("请选择地点类型！");
			return;
		} */
		var canSubmit = true;
		$.each($sysdict.DRIVER_CARD,function(index,e){
			var imgNum = 0;
			$.each($("tr#driverEdit"+e.ID+" img", navTab.getCurrentPanel()),function(obj){
				imgNum++;
			});
			if(imgNum>3){
				alert("每一类最多上传三张图片");
				canSubmit = false;
			}
		});
		if(canSubmit)
			$("#driverEditForm", navTab.getCurrentPanel()).submit();
	}
	
	function initScheduleCenter(){
		getSource('${ctxPath}/topic/ajax/getScheduleCenter',function(json){
	          json=json.resultObj;
	        //  console.info(json);
	          $.each(json, function(index,item){
	               var st = "";
	               if('${param.regSource}' == item.REGSOURCE){
	                   st= "selected=\"selected\"" ;
	               }
	               var option="<option " +st+" value=\""+item.CENTER_ID+ "\" >"+item.CENTER_NAME+ "</option>" ;
	              $( "#scheduleCenter" , navTab.getCurrentPanel()).append(option);
	          });
	     }, false); 

	}
	//初始化车架下拉框,默认车牌下拉框
	function initTruckFrame(){
		getSource('${ctxPath}/topic/ajax/getTruckFrameList',function(json){
	          json=json.resultObj;
	        //  console.info(json);
	          $.each(json, function(index,item){
	              var st = "";
	              if('${param.FT_ID}' == item.FT_ID){
	                  st= "selected=\"selected\"" ;
	              }
	              var option="<option " +st+" value=\""+item.FT_ID+ "\" >"+item.TRUCK_PLATE+ "</option>" ;
	              if(item.TYPE=='T'){
	              	$( "#defaultTruck" , navTab.getCurrentPanel()).append(option);
	              }else if(item.TYPE=='F'){
	              	$( "#defaultFrame" , navTab.getCurrentPanel()).append(option);
	              }
	          });
	     }, false); 

	}
	
	function getSource(url,callback,async){
	      var $callback = callback;
	      if (! $.isFunction($callback)) $callback = eval('(' + callback + ')' );
	      var $async=true;
	      if(!isEmpty(async)){
	          $async=async;
	     }
	     $.ajax({
	          type : "POST",
	          url : url,
//	        data : {"type" : type},
	          async:$async,
	          dataType : "json",
	          success : $callback,
	          error : function(XMLHttpRequest, textStatus, errorThrown) {
	              alertMsg.warn( "请求异常：" + textStatus);
	          }
	     });
	}
	
	//初始化原始数据
	function initEditData(id){
	     $.ajax({
	          type : "POST",
	          url : '${ctxPath}/topic/ajax/getDriverInfo',
		      data : {"driverId" : id},
	          async:false,
	          dataType : "json",
	          success : function(json){
	        	  json=json.resultObj;
	        	  //alert(json.ID+"|"+json.NAME);
	        	  $( "#driverName" , navTab.getCurrentPanel()).val(json.NAME);
	        	  $( "#driverCode" , navTab.getCurrentPanel()).val(json.CODE);
	        	  $( "#fileNo" , navTab.getCurrentPanel()).val(json.FILE_NO);
	        	  $( "#due" , navTab.getCurrentPanel()).val(json.DUE);
	        	  $( "#birthday" , navTab.getCurrentPanel()).val(json.BIRTHDAY);
	        	  $( "#sex" , navTab.getCurrentPanel()).val(json.SEX);
	        	  $( "#groupNo" , navTab.getCurrentPanel()).val(json.GROUPNO);
	        	  $( "#idCard" , navTab.getCurrentPanel()).val(json.IDCARD);
	        	  $( "#graduation" , navTab.getCurrentPanel()).val(json.GRADUATION);
	        	  $( "#licenseNo" , navTab.getCurrentPanel()).val(json.LICENSE_NO);
	        	  $( "#licenseType" , navTab.getCurrentPanel()).val(json.LICENSE_TYPE);
	        	  $( "#licenseDate" , navTab.getCurrentPanel()).val(json.LICENSE_DATE);
	        	  $( "#licenseLimited" , navTab.getCurrentPanel()).val(json.LICENSE_LIMITED);
	        	  $( "#qualification" , navTab.getCurrentPanel()).val(json.QUALIFICATION);
	        	  $( "#qualificationLimited" , navTab.getCurrentPanel()).val(json.QUALIFICATION_LIMITED);
	        	  $( "#defaultTruck" , navTab.getCurrentPanel()).val(json.DEFAULT_TRUCK);
	        	  $( "#defaultFrame" , navTab.getCurrentPanel()).val(json.DEFAULT_FRAME);
	        	  $( "#customsNo" , navTab.getCurrentPanel()).val(json.CUSTOMS_NO);
	        	  $( "#icNo" , navTab.getCurrentPanel()).val(json.IC_NO);
	        	  $( "#mobile1" , navTab.getCurrentPanel()).val(json.MOBILE_1);
	        	  $( "#mobile2" , navTab.getCurrentPanel()).val(json.MOBILE_2);
	        	  $( "#mobile3" , navTab.getCurrentPanel()).val(json.MOBILE_3);
	        	  $( "#fax" , navTab.getCurrentPanel()).val(json.FAX);
	        	  $( "#qq" , navTab.getCurrentPanel()).val(json.QQ);
	        	  $( "#email" , navTab.getCurrentPanel()).val(json.EMAIL);
	        	  $( "#salaryBase" , navTab.getCurrentPanel()).val(json.SALARY_BASE);
	        	  $( "#addr" , navTab.getCurrentPanel()).val(json.ADDR);
	        	  $( "#remark" , navTab.getCurrentPanel()).val(json.REMARK);
	        	  $( "#currentStatus" , navTab.getCurrentPanel()).val(json.CURRENT_STATUS);
	        	  
	        	  $( "#tuoche" , navTab.getCurrentPanel()).val(json.TUOCHE=='1'?"1":"0");
	        	  $( "#tuocheCheckBox" , navTab.getCurrentPanel()).attr("checked",json.TUOCHE=='1'?true:false);
	        	  $("#diaoche",navTab.getCurrentPanel()).val(json.DIAOCHE=='1'?"1":"0");
	        	  $( "#diaocheCheckBox" , navTab.getCurrentPanel()).attr("checked",json.DIAOCHE=='1'?true:false);
	        	  $("#weixiu",navTab.getCurrentPanel()).val(json.WEIXIU=='1'?"1":"0");
	        	  $( "#weixiuCheckBox" , navTab.getCurrentPanel()).attr("checked",json.WEIXIU=='1'?true:false);
	        	  $("#waixie",navTab.getCurrentPanel()).val(json.WAIXIE=='1'?"1":"0");
	        	  $( "#waixieCheckBox" , navTab.getCurrentPanel()).attr("checked",json.WAIXIE=='1'?true:false);
	        	  $("#guakao",navTab.getCurrentPanel()).val(json.GUAKAO=='1'?"1":"0");
	        	  $( "#guakaoCheckBox" , navTab.getCurrentPanel()).attr("checked",json.GUAKAO=='1'?true:false);
	        	  
	        	  //初始复选框
	        	 /*  var driverType = json.DRIVER_TYPE;
	        	  var driverTypeArray = driverType.split(",");
	        	  if(driverTypeArray.length>0){
		        	  for(var i=0;i<driverTypeArray.length;i++){
		        		  var val = driverTypeArray[i];
		        		  $("input[name='driverType'][value='"+val+"']", navTab.getCurrentPanel()).attr("checked", true);
		        	  }
	        	  }
	        	  //初始复选框
	        	  var driverRelationType = json.DRIVER_RELATION_TYPE;
	        	  var driverRelationTypeArray = driverRelationType.split(",");
	        	  if(driverRelationTypeArray.length>0){
		        	  for(var i=0;i<driverRelationTypeArray.length;i++){
		        		  var val = driverRelationTypeArray[i];
		        		  $("input[name='driverRelationType'][value='"+val+"']", navTab.getCurrentPanel()).attr("checked", true);
		        	  }
	        	  } */
	        	  //初始化所属调度中心
	        	  $( "#scheduleCenter" , navTab.getCurrentPanel()).val(json.SCHEDULE_CENTER);
	        	  
	          },
	          error : function(XMLHttpRequest, textStatus, errorThrown) {
	              alertMsg.warn( "请求异常：" + textStatus);
	          }
	     });
	}
	
	function clickCheckBox(id){
		var val = $("#"+id+"CheckBox",navTab.getCurrentPanel()).attr("checked");
		val = val=="checked"?'1':'0';
		$("#"+id,navTab.getCurrentPanel()).val(val);
	}
	
	//点击新增弹出添加图片框
	function addDriverPic(){
		$.pdialog.open(_contextPath +"/topic/addDriverEditPic", 
			"view", '新增图片', {mask:true, width: 460, height:300});
	}

	//删除本行的信息（所有图片）
	function delThisRow(obj){
		//button --> td --> tr
		$(obj).parent().parent().remove();
	}
	//删除单张图片
	function delThisImg(obj){
		$(obj).parent().find("img").remove();
		$(obj).parent().remove();
	}
	
	//回填司机证件图片
	function initImgTable(){
		//获取图片
		$.ajax({
			type : "post",
				url : "${ctxPath}/topic/ajax/getDriverPic",
				dataType : "json",
				data:{
					driverId:$("#driverId",navTab.getCurrentPanel()).val()
				},
				async : false,
				success : function(data) {
					data = data.resultObj;
					$("#driverEdit_maxImgNum").val(data.length);
					var html = "";
					for(var i=0;i<data.length;i++){
						var path = data[i].PATH;
						var remotePath = data[i].REMOTEPATH;
						var text = data[i].TEXT;
						var code = data[i].CODE;
						var html="";
						//填充表格
						if($("tr[id='driverEdit"+code+"']").length >= 1){
							html +="<div class='imgDiv'><div class='closeImg' onclick='delThisImg(this)'></div><img id='"+""+"' src=\"${ctxPath }/pic/"+path+"\" ></img>";
							html +="<input type=\"hidden\" name='remote_img_"+i+"' value=\""+remotePath+"\"></input>";
							html +="<input type=\"hidden\" name='img_"+i+"' value=\""+code+"~"+path+"\"></input></div>";
							$("#show_driver_edit_table tbody tr[id='driverEdit"+code+"'] td.imgTd").append(html);
						}else{
							var tr_index = $("#show_driver_edit_table tbody tr").length;
							html+="<tr id=\"driverEdit"+code+"\" class='imgTr'>";
							html+="<td align=\"center\"><span>"+text+"</span></td>";
							html+="<td class=\"imgTd\">";
							html+="<div class='imgDiv'><div class='closeImg' onclick='delThisImg(this)'></div><img id='"+""+"' src=\"${ctxPath }/pic/"+path+"\" ></img>";
							html +="<input type=\"hidden\" name='remote_img_"+i+"' value=\""+remotePath+"\"></input>";
							html +="<input type=\"hidden\" name='img_"+i+"' value=\""+code+"~"+path+"\"></input></div>";
							html+="</td>";
							html+="<td align=\"center\"><button type=\"button\" onclick='delThisRow(this)'>删除</button></td>";
							html+="</tr>";
							$("#show_driver_edit_table tbody").append(html);
						}
					}
				}
		});
	}
</script>
<script type="text/javascript">
	$(function(){
		//初始化所属调度中心下拉框
		initScheduleCenter();
		//初始化车架下拉框
		initTruckFrame();
		//初始化原始数据
		initEditData('${param.driverId}');
		//回填图片
		initImgTable();
	});
</script>