<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.weimingfj.common.utils.UserSessionBean" %>
<style>
#driverAddForm td{
	padding: 5px
}
#driverInputTable td input{
	width: 255px
}
#driverTypeTr td input{
	width: 15px;
}

/* 附件表格样式 */
#show_driver_table tr th{
	font-size: 15px;
	padding: 10px;
	background-color: #d6e4ef
}
#show_driver_table tr td img{
padding: 1px 10px 1px 0px
}
#driverImgTable td {
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
	
			
	<form id="driverAddForm" method="post" action="${ctxPath}/topic/ajax/addDriver" class="pageForm required-validate" onsubmit="return validateCallback(this,customNavTabAjaxDone)">
		<input type="hidden" id="navTabId" value="toDriverManage"/>
		<input type="hidden" id="callbackType" value="closeCurrent"/>
		<input type="hidden" id="driverId" name="driverId" value=""/>
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
					<input id="tag" name="tag" type="hidden" value="${sessionScope.SESSION_USER_LOGIN_INFO.userInfo.TAG }"/>
					<div class="pageFormContent" >
						<table id="driverInputTable">
							<tr>
								<td>司机姓名</td>
								<td><input type="text" name="driverName" maxlength="20"/></td>
								<td>司机代码</td>
								<td><input type="text" name="driverCode" maxlength="20"/></td>
							</tr>
							<tr>
								<td>档案编号</td>
								<td><input type="text" name="fileNo" maxlength="50"/></td>
								<td>职&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;务</td>
								<td><input type="text" name="due" maxlength="20"/></td>
							</tr>
							<tr>
								<td>出生年月</td>
								<td><input type="text" name="birthday" maxlength="20"/></td>
								<td>性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别</td>
								<td>
									<select name="sex">
										<option value="男">男</option>
										<option value="女">女</option>
									</select>
									组&nbsp;别
									<input type="" name="groupNo" style="width: 185px" maxlength="20"/>
								</td>
							</tr>
							<tr>
								<td>身份证号</td>
								<td><input type="" name="idCard" maxlength="20"/></td>
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
									<input type="text" name="licenseNo" maxlength="50"/>
								</td>
								<td>驾驶证类别</td>
								<td>
									<input type="text" name="licenseType" maxlength="20"/>
								</td>
							</tr>
							<tr>
								<td>初领证日期</td>
								<td><input type="text" class="date" name="licenseDate"/></td>
								<td>年审日期</td>
								<td><input type="text" class="date" name="licenseLimited"/></td>
							</tr>
							<tr>
								<td>从业资格证</td>
								<td><input type="text" class="" name="qualification" maxlength="50"/></td>
								<td>年审日期</td>
								<td><input type="text" class="date" name="qualificationLimited"/></td>
							</tr>
							<tr>
								<td>默认车牌</td>
								<td>
									<select id="defaultTruck" name="defaultTruck" style="width: 261px" maxlength="50">
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
								<td><input type="text" class="" name="customsNo" maxlength="50"/></td>
								<td>IC&nbsp;&nbsp;&nbsp;&nbsp;卡号</td>
								<td><input type="text" class="" name="icNo" maxlength="50"/></td>
							</tr>
							<tr>
								<td>手机号码1</td>
								<td><input type="text" class="" name="mobile1" maxlength="20"/></td>
								<td>手机号码2</td>
								<td><input type="text" class="" name="mobile2" maxlength="20"/></td>
							</tr>
							<tr>
								<td>手机号码3</td>
								<td><input type="text" class="" name="mobile3" maxlength="20"/></td>
								<td>传&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;真</td>
								<td><input type="text" class="" name="fax" maxlength="20"/></td>
							</tr>
							<tr>
								<td>qq&nbsp;&nbsp;&nbsp;&nbsp;卡号</td>
								<td><input type="text" class="" name="qq" maxlength="20"/></td>
								<td>E-Mail</td>
								<td><input type="text" class="" name="email" maxlength="50"/></td>
							</tr>
							<tr>
								<td>基本工资</td>
								<td><input type="text" class="" name="salaryBase" maxlength="20"/></td>
								<td>地&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;址</td>
								<td><input type="text" class="" name="addr" maxlength="50"/></td>
							</tr>
							<tr>
								<td>备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注</td>
								<td><input type="text" name="remark" maxlength="200"/></td>
								<td>当前状态</td>
								<td>
									<select name="currentStatus">
										<option value="">请选择</option>
										<option value="在职">在职</option>
										<option value="离职">离职</option>
									</select>
								</td>
							</tr>
							<tr id="driverTypeTr">
								<td colspan="2">
									<!-- 司机类型 -->
									<input id="tuoche" type="hidden" name="tuoche" value="0"/>
									<input id="diaoche" type="hidden" name="diaoche" value="0"/>
									<input id="weixiu" type="hidden" name="weixiu" value="0"/>
									<input id="tuocheCheckBox" type="checkbox" value="" name="tuocheCheckBox" onclick="clickCheckBox('tuoche')"/><span>拖车司机</span>
									<input id="diaocheCheckBox" type="checkbox" value="" name="diaocheCheckBox" onclick="clickCheckBox('diaoche')" style="margin-left: 35px;"/><span>吊车司机</span>
									<input id="weixiuCheckBox" type="checkbox" value="" name="weixiuCheckBox" onclick="clickCheckBox('weixiu')" style="margin-left: 35px;"/><span>维修工作</span>
								</td>
								<td colspan="2">
									<input id="waixie" type="hidden" name="waixie" value="0"/>
									<input id="guakao" type="hidden" name="guakao" value="0"/>
									<input id="waixieCheckBox" type="checkbox" value="" name="waixieCheckBox" onclick="clickCheckBox('waixie')"/><span>外协</span>
									<input id="guakaoCheckBox" type="checkbox" value="" name="guakaoCheckBox" onclick="clickCheckBox('guakao')" style="margin-left: 35px;"/><span>挂靠</span>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<!-- ============第一个面板END============= -->
				<!-- ============第二个面板START===附件========== -->
				<div id="add_driver_pic_panel" style="">
					<div class="pageFormContent" >
						<!-- 上传图片组件 -->
						<table id="driverImgTable">
							<tr>
								<td style="padding: 0px">相关证件：
									<button type="button" style="float: right;" onclick="addDriverPic()">新增</button>
								</td>
							</tr>
							<tr>
								<td>
									<table id="show_driver_table" border="1">
										<thead>
											<tr>
												<th style="min-width: 100px" align="center">证件类型</th>
												<th style="min-width: 800px" align="center">图片<span style="color: red">提示：每一类只允许添加三张图片！</span></th>
												<th width="100px" align="center">操作</th>
											</tr>
										</thead>
										<tbody>
											<input id="driver_maxImgNum" name="driver_maxImgNum" type="hidden"
												value="0" />
											<input name="defualt_prefix" type="hidden" value="driver"/>
										</tbody>
									</table>
								</td>
							</tr>
						</table>
	
						<!-- 身份证 -->
						<!-- <div style="border: 1px solid #666;">
							<div style="text-align: center;line-height: 30px"><span>身份证</span></div>
							<div style="border-top: 1px solid #666;height: 200px;">
								<table style="width: 100%">
									<tr style="width: 100%">
										<td style="text-align: center;"><a><img id="idCardImg1" src="" style="width: 150px;height:150px;"/></a></td>
										<td style="text-align: center;"><a><img id="idCardImg2" src="" style="width: 150px;height:150px;"/></a></td>
										<td style="text-align: center;"><a><img id="idCardImg3" src="" style="width: 150px;height:150px;"/></a></td>
									</tr>
									<tr>
										<td style="text-align: center;"><button type="button" onclick="">选择文件</button></td>
										<td style="text-align: center;"><button type="button" onclick="">选择文件</button></td>
										<td style="text-align: center;"><button type="button" onclick="">选择文件</button></td>
									</tr>
								</table>
							</div>
						</div> -->
						<!-- 驾驶证 -->
						<!-- <div style="border: 1px solid #666;margin-top: 20px;">
							<div style="text-align: center;line-height: 30px"><span>驾驶证</span></div>
							<div style="border-top: 1px solid #666;height: 200px;">
								<table style="width: 100%">
									<tr style="width: 100%">
										<td style="text-align: center;"><a><img id="idCardImg1" src="" style="width: 150px;height:150px;"/></a></td>
										<td style="text-align: center;"><a><img id="idCardImg2" src="" style="width: 150px;height:150px;"/></a></td>
										<td style="text-align: center;"><a><img id="idCardImg3" src="" style="width: 150px;height:150px;"/></a></td>
									</tr>
									<tr>
										<td style="text-align: center;"><button type="button" onclick="">选择文件</button></td>
										<td style="text-align: center;"><button type="button" onclick="">选择文件</button></td>
										<td style="text-align: center;"><button type="button" onclick="">选择文件</button></td>
									</tr>
								</table>
							</div>
						</div> -->
						<!-- 从业资格证 -->
						<!-- <div style="border: 1px solid #666;margin-top: 20px;">
							<div style="text-align: center;line-height: 30px"><span>从业资格证</span></div>
							<div style="border-top: 1px solid #666;height: 200px;">
								<table style="width: 100%">
									<tr style="width: 100%">
										<td style="text-align: center;"><a><img id="idCardImg1" src="" style="width: 150px;height:150px;"/></a></td>
										<td style="text-align: center;"><a><img id="idCardImg2" src="" style="width: 150px;height:150px;"/></a></td>
										<td style="text-align: center;"><a><img id="idCardImg3" src="" style="width: 150px;height:150px;"/></a></td>
									</tr>
									<tr>
										<td style="text-align: center;"><button type="button" onclick="">选择文件</button></td>
										<td style="text-align: center;"><button type="button" onclick="">选择文件</button></td>
										<td style="text-align: center;"><button type="button" onclick="">选择文件</button></td>
									</tr>
								</table>
							</div>
						</div>-->
				<!-- ============第二个面板END============= -->
					</div> 
				</div>
			</div>
		</div>
	</form>
	<div class="formBar">
		<ul style="float:left">
			<li><div class="buttonActive"><div class="buttonContent"><button type="button" onclick="submitAddDriverForm()" >保存</button></div></div></li>
			<li><div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div></li>
		</ul>
	</div>
</div>
<script  type="text/javascript">
	function submitAddDriverForm(){
		
		/* var areaCheckedTypeSize =$("input[name='type']:checked", navTab.getCurrentPanel()).size();
		if(areaCheckedTypeSize==0){
			alertMsg.warn("请选择地点类型！");
			return;
		} */
		var canSubmit = true;
		$.each($sysdict.DRIVER_CARD,function(index,e){
			var imgNum = 0;
			$.each($("tr#driver"+e.ID+" img", navTab.getCurrentPanel()),function(obj){
				imgNum++;
			});
			if(imgNum>3){
				alert("每一类最多上传三张图片");
				canSubmit = false;
			}
		});
		if(canSubmit){
			$("#driverId", navTab.getCurrentPanel()).val(UUID.prototype.createUUID());
			$("#driverAddForm", navTab.getCurrentPanel()).submit();
		}
	}
	
	function initScheduleCenter(){
		getSource('${ctxPath}/topic/ajax/getScheduleCenter',function(json){
	          json=json.resultObj;
	        //  console.info(json);
	          $.each(json, function(index,item){
	               var st = "";
	               if('${param.CENTER_ID}' == item.CENTER_ID){
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
	
	//公用获取数据方法
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

	function clickCheckBox(id){
		var val = $("#"+id+"CheckBox",navTab.getCurrentPanel()).attr("checked");
		val = val=="checked"?'1':'0';
		$("#"+id,navTab.getCurrentPanel()).val(val);
	}
	
	
	//点击新增弹出添加图片框
	function addDriverPic(){
		$.pdialog.open(_contextPath +"/topic/addDriverPic", 
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
</script>
<script type="text/javascript">
	$(function(){
		//初始化所属调度中心下拉框
		initScheduleCenter();
		//初始化车架下拉框
		initTruckFrame();
	});
</script>