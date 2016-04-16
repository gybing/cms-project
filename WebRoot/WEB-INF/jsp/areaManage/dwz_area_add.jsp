<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.weimingfj.common.utils.UserSessionBean" %> 
<style>
#areaAddForm td{
	padding: 5px
}
#areaInputTable td input{
	width: 255px
}
#areaTypeTable td{
	padding-right: 65px;
}
</style>

<div class="pageContent">
		<div class="pageFormContent" layoutH="56">
	<form id="areaAddForm" method="post" action="${ctxPath}/topic/ajax/addArea" class="pageForm required-validate" onsubmit="return validateCallback(this,customNavTabAjaxDone)">
		<input type="hidden" id="navTabId" value="toAreaManage"/>
		<input type="hidden" id="callbackType" value="closeCurrent"/>
		<input id="tag" name="tag" type="hidden" value="${sessionScope.SESSION_USER_LOGIN_INFO.userInfo.TAG }"/>
		<table id="areaInputTable">
			<tr>
				<td>地点名称</td>
				<td><input type="text" name="areaName" maxlength="100"/></td>
			</tr>
			<tr>
				<td>地点代码</td>
				<td><input type="text" name="areaCode" maxlength="20"/></td>
			</tr>
			<tr>
				<td>所在城市</td>
				<td>
					<input type="hidden" name="province" id="province"/>
					<input type="hidden" name="area_add_addr" id="area_add_addr"/>
					<select id="area_add_addr_prov" name="area_add_addr_prov" style="width: 129px" class="combox">
						<option value="" selected="selected">请选择</option>
					</select>
					
					<select id="area_add_addr_city" name="area_add_addr_city" style="width: 129px" class="combox">
						<option value="" selected="selected">请选择</option>
					</select>
					<input type="hidden" name="city" id="city"/>
				</td>
			</tr>
			<tr>
				<td>定位地址</td>
				<td>
					<input id="areaAddr" type="text" name="areaAddr" onclick="selectAreaOnMap()"  maxlength="20"/>
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
				<td><input type="text" name="remark"  maxlength="200"/></td>
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
				<input id="matou" type="hidden" name="matou" value="0"/>
				<input id="duichang" type="hidden" name="duichang" value="0"/>
				<input id="cangku" type="hidden" name="cangku" value="0"/>
				<td><input id="matouCheckBox" type="checkbox" value="" name="matouCheckBox" onclick="clickCheckBox('matou')"/><span>码&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;头</span></td>
				<td><input id="duichangCheckBox" type="checkbox" value="" name="duichangCheckBox" onclick="clickCheckBox('duichang')"/><span>堆&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;场</span></td>
				<td><input id="cangkuCheckBox" type="checkbox" value="" name="cangkuCheckBox" onclick="clickCheckBox('cangku')"/><span>仓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;库</span></td>
			</tr>
			<tr>
				<input id="tixiangmatou" type="hidden" name="tixiangmatou" value="0"/>
				<input id="tuochedidian" type="hidden" name="tuochedidian" value="0"/>
				<input id="chengshidiqu" type="hidden" name="chengshidiqu" value="0"/>
				<td><input id="tixiangmatouCheckBox" type="checkbox" value="" name="tixiangmatouCheckBox" onclick="clickCheckBox('tixiangmatou')"/><span>提箱码头</span></td>
				<td><input id="tuochedidianCheckBox" type="checkbox" value="" name="tuochedidianCheckBox" onclick="clickCheckBox('tuochedidian')"/><span>拖车地点</span></td>
				<td><input id="chengshidiquCheckBox" type="checkbox" value="" name="chengshidiquCheckBox" onclick="clickCheckBox('chengshidiqu')"/><span>城市/地区</span></td>
			</tr>
			<tr>
				<input id="fanxiangmatou" type="hidden" name="fanxiangmatou" value="0"/>
				<input id="chezhan" type="hidden" name="chezhan" value="0"/>
				<input id="haiguankouan" type="hidden" name="haiguankouan" value="0"/>
				<td><input id="fanxiangmatouCheckBox" type="checkbox" value="" name="fanxiangmatouCheckBox" onclick="clickCheckBox('fanxiangmatou')"/><span>返箱码头</span></td>
				<td><input id="chezhanCheckBox" type="checkbox" value="" name="chezhanCheckBox" onclick="clickCheckBox('chezhan')"/><span>车&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;站</span></td>
				<td><input id="haiguankouanCheckBox" type="checkbox" value="" name="haiguankouanCheckBox" onclick="clickCheckBox('haiguankouan')"/><span>海关口岸</span></td>
			</tr>
			<tr>
				<input id="shifazhan" type="hidden" name="shifazhan" value="0"/>
				<input id="mudizhan" type="hidden" name="mudizhan" value="0"/>
				<input id="bianjingzhan" type="hidden" name="bianjingzhan" value="0"/>
				<td><input id="shifazhanCheckBox" type="checkbox" value="" name="shifazhanCheckBox" onclick="clickCheckBox('shifazhan')"/><span>始&nbsp;&nbsp;发&nbsp;&nbsp;站</span></td>
				<td><input id="mudizhanCheckBox" type="checkbox" value="" name="mudizhanCheckBox" onclick="clickCheckBox('mudizhan')"/><span>目&nbsp;&nbsp;的&nbsp;&nbsp;站</span></td>
				<td><input id="bianjingzhanCheckBox" type="checkbox" value="" name="bianjingzhanCheckBox" onclick="clickCheckBox('bianjingzhan')"/><span>边&nbsp;&nbsp;境&nbsp;&nbsp;站</span></td>
			</tr>
		</table>
	</form>
		</div>
	<div class="formBar">
		<ul style="float:left">
			<li><div class="buttonActive"><div class="buttonContent"><button type="button" onclick="submitAddAreaForm()" >保存</button></div></div></li>
			<li><div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div></li>
		</ul>
	</div>
</div>
<script  type="text/javascript">
	function submitAddAreaForm(){
		var prov = $("#area_add_addr_prov option:selected", navTab.getCurrentPanel()).text();
		var city = $("#area_add_addr_city option:selected", navTab.getCurrentPanel()).text();
		prov = prov=='请选择'?"":prov;
		city = city=='请选择'?"":city;
		$("#province", navTab.getCurrentPanel()).val(prov);
		$("#city", navTab.getCurrentPanel()).val(city);
		
		/* var areaCheckedTypeSize =$("input[name='type']:checked", navTab.getCurrentPanel()).size();
		if(areaCheckedTypeSize==0){
			alertMsg.warn("请选择地点类型！");
			return;
		} */
		$("#areaAddForm", navTab.getCurrentPanel()).submit();
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
	
	//弹出地图选择地点
	function selectAreaOnMap(){
		//navTab.openTab("areaSelectMap", "${ctxPath}/topic/areaSelectMap", {title:'定位地址选择'});
		$.pdialog.open("${ctxPath}/topic/areaSelectMap", 
				"view", '定位地址选择', {mask:true, width: 700, height:500});
	}
</script>
<script type="text/javascript">
	$(function(){
		/* $s2.init($C("#area_add_addr_prov"));
		$s2.init($C("#area_add_addr_city"));  */
		//初始化所在城市下拉框
		initArea('area_add_addr');
		//初始化所属调度中心下拉框
		initScheduleCenter();
	});
</script>