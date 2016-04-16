<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
#areaEditForm td{
	padding: 5px
}
#areaInputTable td input{
	width: 255px
}
#areaTypeTable td{
	padding-right: 65px;
}
</style>

<div>
	<form id="areaEditForm" method="post" action="${ctxPath}/topic/ajax/editArea" class="pageForm required-validate" onsubmit="return validateCallback(this,customNavTabAjaxDone)">
		<input type="hidden" id="navTabId" value="toAreaManage"/>
		<input type="hidden" id="callbackType" value="closeCurrent"/>
		<input type="hidden" id="areaId" name="areaId" value="${param.id }"/>
		<table id="areaInputTable">
			<tr>
				<td>地点名称</td>
				<td><input id="areaName" type="text" name="areaName"/></td>
			</tr>
			<tr>
				<td>地点代码</td>
				<td><input id="areaCode" type="text" name="areaCode"/></td>
			</tr>
			<tr>
				<td>所在城市</td>
				<td>
					<input type="hidden" name="province" id="province"/>
					<input type="hidden" name="area_edit_addr" id="area_edit_addr"/>
					<select id="area_edit_addr_prov" name="area_edit_addr_prov" style="width: 129px" class="combox">
						<option value="" selected="selected">请选择</option>
					</select>
					<input type="hidden" name="city" id="city"/>
					<select id="area_edit_addr_city" name="area_edit_addr_city" style="width: 129px" class="combox">
						<option value="" selected="selected">请选择</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>定位地址</td>
				<td>
					<input id="areaAddr" type="text" name="areaAddr"/>
					<input id="lng" type="hidden" name="lng" value=""/>
					<input id="lat" type="hidden" name="lat" value=""/>
				</td>
			</tr>
			<tr>
				<td>助&nbsp;&nbsp;记&nbsp;&nbsp;器</td>
				<td><input type="text"/></td>
			</tr>
			<tr>
				<td>备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注</td>
				<td><input id="remark" type="text" name="remark"/></td>
			</tr>
			<tr>
				<td>所属调度中心</td>
				<td>
					<select id="scheduleCenter" name="scheduleCenter" style="width: 261px">
						<option value="">请选择</option>
					</select>
				</td>
			</tr>
		</table>
		<!-- 地区类型 -->
		<table id="areaTypeTable">
			<tr>
				<input id="matou" type="hidden" name="matou" value=""/>
				<input id="duichang" type="hidden" name="duichang" value=""/>
				<input id="cangku" type="hidden" name="cangku" value=""/>
				<td><input id="matouCheckBox" type="checkbox" value="" name="matouCheckBox" onclick="clickCheckBox('matou')"/><span>码&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;头</span></td>
				<td><input id="duichangCheckBox" type="checkbox" value="" name="duichangCheckBox" onclick="clickCheckBox('duichang')"/><span>堆&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;场</span></td>
				<td><input id="cangkuCheckBox" type="checkbox" value="" name="cangkuCheckBox" onclick="clickCheckBox('cangku')"/><span>仓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;库</span></td>
			</tr>
			<tr>
				<input id="tixiangmatou" type="hidden" name="tixiangmatou" value=""/>
				<input id="tuochedidian" type="hidden" name="tuochedidian" value=""/>
				<input id="chengshidiqu" type="hidden" name="chengshidiqu" value=""/>
				<td><input id="tixiangmatouCheckBox" type="checkbox" value="" name="tixiangmatouCheckBox" onclick="clickCheckBox('tixiangmatou')"/><span>提箱码头</span></td>
				<td><input id="tuochedidianCheckBox" type="checkbox" value="" name="tuochedidianCheckBox" onclick="clickCheckBox('tuochedidian')"/><span>拖车地点</span></td>
				<td><input id="chengshidiquCheckBox" type="checkbox" value="" name="chengshidiquCheckBox" onclick="clickCheckBox('chengshidiqu')"/><span>城市/地区</span></td>
			</tr>
			<tr>
				<input id="fanxiangmatou" type="hidden" name="fanxiangmatou" value=""/>
				<input id="chezhan" type="hidden" name="chezhan" value=""/>
				<input id="haiguankouan" type="hidden" name="haiguankouan" value=""/>
				<td><input id="fanxiangmatouCheckBox" type="checkbox" value="" name="fanxiangmatouCheckBox" onclick="clickCheckBox('fanxiangmatou')"/><span>返箱码头</span></td>
				<td><input id="chezhanCheckBox" type="checkbox" value="" name="chezhanCheckBox" onclick="clickCheckBox('chezhan')"/><span>车&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;站</span></td>
				<td><input id="haiguankouanCheckBox" type="checkbox" value="" name="haiguankouanCheckBox" onclick="clickCheckBox('haiguankouan')"/><span>海关口岸</span></td>
			</tr>
			<tr>
				<input id="shifazhan" type="hidden" name="shifazhan" value=""/>
				<input id="mudizhan" type="hidden" name="mudizhan" value=""/>
				<input id="bianjingzhan" type="hidden" name="bianjingzhan" value=""/>
				<td><input id="shifazhanCheckBox" type="checkbox" value="" name="shifazhanCheckBox" onclick="clickCheckBox('shifazhan')"/><span>始&nbsp;&nbsp;发&nbsp;&nbsp;站</span></td>
				<td><input id="mudizhanCheckBox" type="checkbox" value="" name="mudizhanCheckBox" onclick="clickCheckBox('mudizhan')"/><span>目&nbsp;&nbsp;的&nbsp;&nbsp;站</span></td>
				<td><input id="bianjingzhanCheckBox" type="checkbox" value="" name="bianjingzhanCheckBox" onclick="clickCheckBox('bianjingzhan')"/><span>边&nbsp;&nbsp;境&nbsp;&nbsp;站</span></td>
			</tr>
		</table>
		<div>
			<button type="button" onclick="submitEditAreaForm();">保存</button>
			<button type="button" class="close">取消</button>
		</div>
	</form>
</div>
<script  type="text/javascript">
	//提交表单前处理
	function submitEditAreaForm(){
		var prov = $("#area_edit_addr_prov option:selected", navTab.getCurrentPanel()).text();
		var city = $("#area_edit_addr_city option:selected", navTab.getCurrentPanel()).text();
		prov = prov=='请选择'?"":prov;
		city = city=='请选择'?"":city;
		$("#province", navTab.getCurrentPanel()).val(prov);
		$("#city", navTab.getCurrentPanel()).val(city);
		
		/* var areaCheckedTypeSize =$("input[name='type']:checked", navTab.getCurrentPanel()).size();
		if(areaCheckedTypeSize==0){
			alertMsg.warn("请选择地点类型！");
			return;
		} */
		$("#areaEditForm", navTab.getCurrentPanel()).submit();
	}
	
	//初始化所属调度中心下拉框
	function initScheduleCenter(){
		getSource('${ctxPath}/topic/ajax/getScheduleCenter',function(json){
	          json=json.resultObj;
	       //   console.info(json);
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
	          url : '${ctxPath}/topic/ajax/getAreaById',
		      data : {"id" : id},
	          async:false,
	          dataType : "json",
	          success : function(json){
	        	  json=json.resultObj;
	        	  //alert(json.ID+"|"+json.NAME);
	        	  $( "#areaName" , navTab.getCurrentPanel()).val(json.NAME);
	        	  $( "#areaCode" , navTab.getCurrentPanel()).val(json.CODE);
	        	  $( "#lng" , navTab.getCurrentPanel()).val(json.LNG);
	        	  $( "#lat" , navTab.getCurrentPanel()).val(json.LAT);
	        	  $( "#areaAddr" , navTab.getCurrentPanel()).val(json.ADDR);
	        	  $( "#remark" , navTab.getCurrentPanel()).val(json.REMARK);
	        	  
	        	  //初始复选框
	        	  $( "#matou" , navTab.getCurrentPanel()).val(json.MATOU=='1'?"1":"0");
	        	  $( "#matouCheckBox" , navTab.getCurrentPanel()).attr("checked",json.MATOU=='1'?true:false);
	        	  $( "#duichang" , navTab.getCurrentPanel()).val(json.DUICHANG=='1'?"1":"0");
	        	  $( "#duichangCheckBox" , navTab.getCurrentPanel()).attr("checked",json.DUICHANG=='1'?true:false);
	        	  $( "#cangku" , navTab.getCurrentPanel()).val(json.CANGKU=='1'?"1":"0");
	        	  $( "#cangkuCheckBox" , navTab.getCurrentPanel()).attr("checked",json.CANGKU=='1'?true:false);
	        	  $( "#tixiangmatou" , navTab.getCurrentPanel()).val(json.TIXIANGMATOU=='1'?"1":"0");
	        	  $( "#tixiangmatouCheckBox" , navTab.getCurrentPanel()).attr("checked",json.TIXIANGMATOU=='1'?true:false);
	        	  $( "#tuochedidian" , navTab.getCurrentPanel()).val(json.TUOCHEDIDIAN=='1'?"1":"0");
	        	  $( "#tuochedidianCheckBox" , navTab.getCurrentPanel()).attr("checked",json.TUOCHEDIDIAN=='1'?true:false);
	        	  $( "#chengshidiqu" , navTab.getCurrentPanel()).val(json.CHENGSHIDIQU=='1'?"1":"0");
	        	  $( "#chengshidiquCheckBox" , navTab.getCurrentPanel()).attr("checked",json.CHENGSHIDIQU=='1'?true:false);
	        	  $( "#fanxiangmatou" , navTab.getCurrentPanel()).val(json.FANXIANGMATOU=='1'?"1":"0");
	        	  $( "#fanxiangmatouCheckBox" , navTab.getCurrentPanel()).attr("checked",json.FANXIANGMATOU=='1'?true:false);
	        	  $( "#chezhan" , navTab.getCurrentPanel()).val(json.CHEZHAN=='1'?"1":"0");
	        	  $( "#chezhanCheckBox" , navTab.getCurrentPanel()).attr("checked",json.CHEZHAN=='1'?true:false);
	        	  $( "#haiguankouan" , navTab.getCurrentPanel()).val(json.HAIGUANKOUAN=='1'?"1":"0");
	        	  $( "#haiguankouanCheckBox" , navTab.getCurrentPanel()).attr("checked",json.HAIGUANKOUAN=='1'?true:false);
	        	  $( "#shifazhan" , navTab.getCurrentPanel()).val(json.SHIFAZHAN=='1'?"1":"0");
	        	  $( "#shifazhanCheckBox" , navTab.getCurrentPanel()).attr("checked",json.SHIFAZHAN=='1'?true:false);
	        	  $( "#mudizhan" , navTab.getCurrentPanel()).val(json.MUDIZHAN=='1'?"1":"0");
	        	  $( "#mudizhanCheckBox" , navTab.getCurrentPanel()).attr("checked",json.MUDIZHAN=='1'?true:false);
	        	  $( "#bianjingzhan" , navTab.getCurrentPanel()).val(json.BIANJINGZHAN=='1'?"1":"0");
	        	  $( "#bianjingzhanCheckBox" , navTab.getCurrentPanel()).attr("checked",json.BIANJINGZHAN=='1'?true:false);
	        	  /* var type = json.TYPE;
	        	  var typeArray = type.split(",");
	        	  if(typeArray.length>0){
		        	  for(var i=0;i<typeArray.length;i++){
		        		  var val = typeArray[i];
		        		  $("input[name='type'][value='"+val+"']", navTab.getCurrentPanel()).attr("checked", true);
		        	  }
	        	  } */
	        	  
	        	  //初始化省市
	        	  $( "#province" , navTab.getCurrentPanel()).val(json.PROVINCE);
	        	  $( "#city" , navTab.getCurrentPanel()).val(json.CITY);
	        	  $( "#area_edit_addr" , navTab.getCurrentPanel()).val(json.CITY_CODE);
	        	  //初始化所属调度中心
	        	  $( "#scheduleCenter" , navTab.getCurrentPanel()).val(json.SCHEDULE_CENTER);
	        	  /* $.each($( "#area_edit_addr_prov option" , navTab.getCurrentPanel()),function (index,item){
	        			  	var prov = $(item).text();
	        		  		if(prov==json.PROVINCE){
	        		  			$(item).attr("selected",true);
	        		  			alert($(item).attr("index"));
        		  			}
	        	  }); */
	        	  /* $.each($( "#area_edit_addr_city option" , navTab.getCurrentPanel()),function (index,item){
	        			  	var city = $(item).text();
	        		  		if(city==json.CITY){
	        		  			$(item).attr("selected",true);
        		  			}
	        	  }); */
	        	  
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
</script>
<script type="text/javascript">
	$(function(){
		//初始化所属调度中心下拉框
		initScheduleCenter();
		//初始化原始数据
		initEditData('${param.id}');
		//初始化所在城市下拉框
		initArea('area_edit_addr');
	});
</script>