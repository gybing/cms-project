<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>新增人员</title>
    <jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
</head>
<body class="">
    <div class="wrapper wrapper-content animated fadeIn">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">                  
                    <div class="ibox-content widget-content nopadding">
                       <form id="areaEditForm" method="post" action="#" data-id="${param.pdataId}" callback="searchForm()" class="form-horizontal">
                           	<input id="tag" name="tag" type="hidden" value="${sessionScope.SESSION_USER_LOGIN_INFO.userInfo.TAG }"/>
                            <input type="hidden" id="areaId" name="areaId" value="${param.id }"/>
                            <div>
                            <table
							style="width: 80%;line-height: 40px;height: 40px;margin-top: 5%;"
							align="center">
							<tr>
								<td><label class=" control-label" for="account">地点名称:</label></td>
								<td><input id="areaName" name="areaName" type="text"
									class="form-control required" maxlength="100"></td>
								<td><span class="help-block m-b-none"><i
										class="fa fa-info-circle"></i> 必填项</span></td>
								<td style="padding-left: 10px;"><label
									class=" control-label">地点代码:</label></td>
								<td><input id="areaCode" type="text"
									class="form-control required" name="areaCode" maxlength="20"></td>
								<td><span class="help-block m-b-none"><i
										class="fa fa-info-circle"></i> 必填项</span></td>
							</tr>
							<tr>
								<td><label class=" control-label">所在城市:</label></td>
								<td colspan="2"><input type="hidden" name="province"
									id="province" /> <input type="hidden" name="city" id="city" />
									<input type="hidden" name="area_edit_addr" id="area_edit_addr" />
									<table>
										<tr>
											<td><select id="area_edit_addr_prov"
												name="area_edit_addr_prov" style="width: 67px">
													<option value="">请选择</option>
											</select></td>
											<td style="padding-left: 15px;"><select
												id="area_edit_addr_city" name="area_edit_addr_city"
												style="width: 68px">
													<option value="">请选择</option>
											</select></td>
										</tr>
									</table></td>
								<td  style="padding-left: 10px;"><label class=" control-label">定位地址:</label></td>
								<td><input id="areaAddr" name="areaAddr" type="text"
									class="form-control required" onclick="selectAreaOnMap()"
									isFirst="1" maxlength="20" readonly="readonly"
									placeholder="点击弹出地图选择地址"> <input id="lng" type="hidden"
									name="lng" value="" /> <input id="lat" type="hidden"
									name="lat" value="" /></td>
								<td><span class="help-block m-b-none"><i
										class="fa fa-info-circle"></i> 必填项</span></td>
							</tr>
							<tr>
								<td><label class=" control-label">助记器:</label></td>
								<td colspan="1"><input id="cnaxxme" name="namxxe"
									maxlength="20" type="text" class="form-control"></td>
								<td></td>
								<td  style="padding-left: 10px;"><label class=" control-label">所属调度中心:</label></td>
								<td colspan="1">
									<select class="form-control" id="scheduleCenter" name="scheduleCenter">
	                                	<option value="">请选择</option>
	                               	</select>
									<!-- <div class="input-group" id="A_SCHEDULECENTER"></div> -->

								</td>
								<td></td>
							</tr>
							<tr>
								<td><label class="control-label">备注:</label></td>
								<td colspan="4"><input id="remark" name="remark"
									type="text" class="form-control" maxlength="200"></td>
								<td></td>
							</tr>
						</table>
						<table style="width: 80%;line-height: 40px;height: 40px;" align="center">
							<tr>
								<td></td>
								<td><input id="matou" type="hidden" name="matou" value="0" />
									<input id="matouCheckBox" name="matouCheckBox" type="checkbox"
									value="" onclick="clickCheckBox('matou')"> <i></i>码头</td>
								<td><input id="duichang" type="hidden" name="duichang"
									value="0" /> <input id="duichangCheckBox" type="checkbox"
									value="" name="duichangCheckBox"
									onclick="clickCheckBox('duichang')"> <i></i> 堆场</td>
								<td><input id="cangku" type="hidden" name="cangku"
									value="0" /> <input id="cangkuCheckBox" type="checkbox"
									value="" name="cangkuCheckBox"
									onclick="clickCheckBox('cangku')"> <i></i> 仓库</td>
							<tr>
							<tr>
								<td></td>
								<td><input id="tixiangmatou" type="hidden"
									name="tixiangmatou" value="0" /> <input
									id="tixiangmatouCheckBox" type="checkbox" value=""
									name="tixiangmatouCheckBox"
									onclick="clickCheckBox('tixiangmatou')"> <i></i>提箱码头</td>
								<td><input id="tuochedidian" type="hidden"
									name="tuochedidian" value="0" /> <input
									id="tuochedidianCheckBox" type="checkbox" value=""
									name="tuochedidianCheckBox"
									onclick="clickCheckBox('tuochedidian')"> <i></i>拖车地点</td>
								<td><input id="chengshidiqu" type="hidden"
									name="chengshidiqu" value="0" /> <input
									id="chengshidiquCheckBox" type="checkbox" value=""
									name="chengshidiquCheckBox"
									onclick="clickCheckBox('chengshidiqu')"> <i></i>城市/地区</td>
							</tr>
							<tr>
								<td></td>
								<td><input id="fanxiangmatou" type="hidden"
									name="fanxiangmatou" value="0" /> <input
									id="fanxiangmatouCheckBox" type="checkbox" value=""
									name="fanxiangmatouCheckBox"
									onclick="clickCheckBox('fanxiangmatou')"> <i></i>返箱码头</td>
								<td><input id="chezhan" type="hidden" name="chezhan"
									value="0" /> <input id="chezhanCheckBox" type="checkbox"
									value="" name="chezhanCheckBox"
									onclick="clickCheckBox('chezhan')"> <i></i>车站</td>
								<td><input id="haiguankouan" type="hidden"
									name="haiguankouan" value="0" /> <input
									id="haiguankouanCheckBox" type="checkbox" value=""
									name="haiguankouanCheckBox"
									onclick="clickCheckBox('haiguankouan')"> <i></i>海关口岸</td>
							</tr>
							<tr>
								<td></td>
								<td><input id="shifazhan" type="hidden" name="shifazhan"
									value="0" /> <input id="shifazhanCheckBox" type="checkbox"
									value="" name="shifazhanCheckBox"
									onclick="clickCheckBox('shifazhan')"> <i></i>始发站</td>
								<td><input id="mudizhan" type="hidden" name="mudizhan"
									value="0" /> <input id="mudizhanCheckBox" type="checkbox"
									value="" name="mudizhanCheckBox"
									onclick="clickCheckBox('mudizhan')"> <i></i>目的站</td>
								<td><input id="bianjingzhan" type="hidden"
									name="bianjingzhan" value="0" /> <input
									id="bianjingzhanCheckBox" type="checkbox" value=""
									name="bianjingzhanCheckBox"
									onclick="clickCheckBox('bianjingzhan')"> <i></i>边境战</td>
							</tr>
						</table>
                           </div>
                           <div class="modal-footer" style="position:relative">
							<div style="float: right;padding-right: 30px; height:30px;position:relative;bottom: 0px;">
								<!-- <button type="submit" class="btn btn-primary">提交</button> -->
								<button class="btn btn-primary" type="button"
									onclick="submitEditAreaForm()">
									<i class="fa fa-check"></i>提 交
								</button>
								<!-- <button type="button" class="btn btn-primary">取消</button> -->
							</div>
						</div>
                           
                       </form>  
                   </div>
                </div>
            </div>
    </div>
    <div class="modal inmodal fade" id="mapModal" tabindex="-1" role="dialog"  aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-body">
                	<input type="hidden" id="mapSelectLng" name="mapSelectLng"/>
					<input type="hidden" id="mapSelectLat" name="mapSelectLat"/>
                	<div id="areaSelectMap" style="width: 100%;height:300px;"></div>
					手动填写地址:<input type="text" id="writeAddr" name="writeAddr" style="width: 200px"/><span style="color: red">输入完成请按回车，然后在地图上点击鼠标。</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-white" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" onclick="saveArea()">保存</button>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
    	$(function(){
    		$("#areaEditForm").validate({
				submitHandler : function(form) {
					$.ajax({
						url:"${ctxPath}/topic/ajax/editArea",
						dataType:"json",
						data : $(form).serialize(),
						type:"post",
						success:function(json){
							if (json.result == '1') {
			 					swal({
									title : json.resultInfo,
									type : "success",
									showCancelButton : false,
									confirmButtonColor : "#A7D5EA",
									confirmButtonText : "确定",
									closeOnConfirm : false
								}, function() {
									//刷新表格，关闭弹窗
									parent.searchForm();
				 					parent.layer.close(parent.layer.getFrameIndex(window.name)); 
								});
			 				} else {
			 					swal("", json.resultInfo, "error");
			 					return;
			 				}
						}
					});
				}
			});
    		
    		//初始化所属调度中心下拉框
    		//initScheduleCenter();
    		//初始化所在城市下拉框
    		initArea('area_edit_addr');
    		//初始化原始数据
    		initEditData('${param.id}');
    		
    		/* //初始化所在城市下拉框
    		initArea('area_edit_addr');
    		//初始化所属调度中心下拉框
    		initScheduleCenter();
    		$("#writeAddr").bind('keypress',function(event){
                if(event.keyCode == "13")    
                {
                    searchAreaOnMap();
                }
            }); */
    	});
    	
    	var oldAreaCode='';
    	function submitEditAreaForm(){
    		var prov = $("#area_edit_addr_prov option:selected").text();
    		var city = $("#area_edit_addr_city option:selected").text();
    		prov = prov=='请选择'?"":prov;
    		city = city=='请选择'?"":city;
    		$("#province").val(prov);
    		$("#city").val(city);
    		
    		/* var areaCheckedTypeSize =$("input[name='type']:checked", navTab.getCurrentPanel()).size();
    		if(areaCheckedTypeSize==0){
    			alertMsg.warn("请选择地点类型！");
    			return;
    		} */
    		
    		/* if($("#areaCode").val()!=oldAreaCode){
	    		$.ajax({
	    			url:"${ctxPath}/topic/ajax/getAreaByCode",
	    			dataType:"json",
					data : {"code":$("#areaCode").val()},
					type:"post",
					success:function(json){
						if(json.resultObj!='0'){
							swal("", "该地点代码已存在，请重新输入！", "error");
							return;
						}
					}
	    		});
    		} */
    		
    		if($("#lng").val()=='' || $("#lat").val()==''){
    			swal("", "无经纬度，请选择地图位置！", "error");
    			return;
    		}
    		$("#areaEditForm").submit();
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
    	               $( "#scheduleCenter").append(option);
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
//    	        data : {"type" : type},
    	          async:$async,
    	          dataType : "json",
    	          success : $callback,
    	          error : function(XMLHttpRequest, textStatus, errorThrown) {
    	              alertMsg.warn( "请求异常:" + textStatus);
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
    	        	  oldAreaCode=json.CODE;
    	        	  $( "#areaName" ).val(json.NAME);
    	        	  $( "#areaCode" ).val(json.CODE);
    	        	  $( "#lng" ).val(json.LNG);
    	        	  $( "#lat" ).val(json.LAT);
    	        	  $( "#areaAddr" ).val(json.ADDR);
    	        	  $( "#cnaxxme" ).val(json.SHORTCUT);
    	        	  $( "#remark" ).val(json.REMARK);
    	        	  
    	        	  //初始复选框
    	        	  $( "#matou" ).val(json.MATOU=='1'?"1":"0");
    	        	  $( "#matouCheckBox" ).attr("checked",json.MATOU=='1'?true:false);
    	        	  $( "#duichang" ).val(json.DUICHANG=='1'?"1":"0");
    	        	  $( "#duichangCheckBox" ).attr("checked",json.DUICHANG=='1'?true:false);
    	        	  $( "#cangku" ).val(json.CANGKU=='1'?"1":"0");
    	        	  $( "#cangkuCheckBox" ).attr("checked",json.CANGKU=='1'?true:false);
    	        	  $( "#tixiangmatou" ).val(json.TIXIANGMATOU=='1'?"1":"0");
    	        	  $( "#tixiangmatouCheckBox" ).attr("checked",json.TIXIANGMATOU=='1'?true:false);
    	        	  $( "#tuochedidian" ).val(json.TUOCHEDIDIAN=='1'?"1":"0");
    	        	  $( "#tuochedidianCheckBox" ).attr("checked",json.TUOCHEDIDIAN=='1'?true:false);
    	        	  $( "#chengshidiqu" ).val(json.CHENGSHIDIQU=='1'?"1":"0");
    	        	  $( "#chengshidiquCheckBox" ).attr("checked",json.CHENGSHIDIQU=='1'?true:false);
    	        	  $( "#fanxiangmatou" ).val(json.FANXIANGMATOU=='1'?"1":"0");
    	        	  $( "#fanxiangmatouCheckBox" ).attr("checked",json.FANXIANGMATOU=='1'?true:false);
    	        	  $( "#chezhan" ).val(json.CHEZHAN=='1'?"1":"0");
    	        	  $( "#chezhanCheckBox" ).attr("checked",json.CHEZHAN=='1'?true:false);
    	        	  $( "#haiguankouan" ).val(json.HAIGUANKOUAN=='1'?"1":"0");
    	        	  $( "#haiguankouanCheckBox" ).attr("checked",json.HAIGUANKOUAN=='1'?true:false);
    	        	  $( "#shifazhan" ).val(json.SHIFAZHAN=='1'?"1":"0");
    	        	  $( "#shifazhanCheckBox" ).attr("checked",json.SHIFAZHAN=='1'?true:false);
    	        	  $( "#mudizhan" ).val(json.MUDIZHAN=='1'?"1":"0");
    	        	  $( "#mudizhanCheckBox" ).attr("checked",json.MUDIZHAN=='1'?true:false);
    	        	  $( "#bianjingzhan" ).val(json.BIANJINGZHAN=='1'?"1":"0");
    	        	  $( "#bianjingzhanCheckBox" ).attr("checked",json.BIANJINGZHAN=='1'?true:false);
    	        	  /* var type = json.TYPE;
    	        	  var typeArray = type.split(",");
    	        	  if(typeArray.length>0){
    		        	  for(var i=0;i<typeArray.length;i++){
    		        		  var val = typeArray[i];
    		        		  $("input[name='type'][value='"+val+"']").attr("checked", true);
    		        	  }
    	        	  } */
    	        	  
    	        	  //初始化省市
    	        	  $( "#province" ).val(json.PROVINCE);
    	        	  $( "#city" ).val(json.CITY);
    	        	  $( "#area_edit_addr" ).val(json.CITY_CODE);
    	        	  //初始化所属调度中心
    	        	 /*  $( "#scheduleCenter" ).val(json.SCHEDULE_CENTER); */
    	        	  /* $("#scheduleCenter").find("option[value='"+json.SCHEDULE_CENTER+"']").attr("selected",true); */
    	        	  /* $s.init($("#A_SCHEDULECENTER"), {
    	      			tabdict : "schedule_center",
    	      			defVal:json.SCHEDULE_CENTER,
    	    			VdefVal:json.CENTER_NAME,
    	      			vID:"schedulecenter",
    	      			listStyle: {
    	      		        "overflow": "scroll",
    	      		        "height":"200px"
    	      		    }
    	      		  }); */
    	      		$s2.init($("#scheduleCenter"), {
	        			tabdict : "schedule_center",
	        			defVal:json.SCHEDULE_CENTER,
	        			isSear:1
	        		});
    	        	 $.each($( "#area_edit_addr_prov option" ),function (index,item){
    	        			  	var prov = $(item).text();
    	        		  		if(prov==json.PROVINCE){
    	        		  			$(item).attr("selected",true);
    	        		  			$(item).change();
            		  			}
    	        	  }); 
    	        	  $.each($( "#area_edit_addr_city option" ),function (index,item){
    	        			  	var city = $(item).text();
    	        		  		if(city==json.CITY){
    	        		  			$(item).attr("selected",true);
            		  			}
    	        	  }); 
    	        	  
    	          },
    	          error : function(XMLHttpRequest, textStatus, errorThrown) {
    	              alertMsg.warn( "请求异常:" + textStatus);
    	          }
    	     });
    	}
    	
    	function clickCheckBox(id){
    		//var val = $("#"+id+"CheckBox").attr("checked");
    		//val = val=="checked"?'1':'0';
    		var val = $("#"+id).val();
    		val = val=="0"?'1':'0';
    		$("#"+id).val(val);
    	}
    	/**
    	 * 初始化地区选择控件， 
    	 */
    	function initArea(id,tag){
    		/* var obj=navTab.getCurrentPanel();
    		if(tag && tag=="dialog"){
    			obj = $.pdialog.getCurrent();
    		} */
    		var value=$("#"+id).val();
    		var suffix_prov="_prov";
    		var suffix_city="_city";
    		var suffix_county="_county";

    		$("#"+id+suffix_prov).attr("ref",id+suffix_city);
    		$("#"+id+suffix_prov).attr("refUrl","${ctxPath }/topic/ajax/queryArea?PARENT_CODE={value}");
    		$("#"+id+suffix_city).attr("ref",id+suffix_county);
    		$("#"+id+suffix_city).attr("refUrl","${ctxPath }/topic/ajax/queryArea?PARENT_CODE={value}");
    		
    		$("select[id^='"+id+"_']").bind('change',function(){
    			var objId=this.id;
    			var prefix=objId.substring(0,objId.lastIndexOf("_"));//前缀
    			var suffix=objId.substring(objId.lastIndexOf("_"));//后缀
    			
    			if($(this).val()!=""){
    				$("#"+id).val($(this).val());
    				if(suffix==suffix_prov){
    					setArea(id+suffix_city,$(this).val());
    				}
    			}else{
    				if(suffix==suffix_prov){
    					$("#"+id).val($(this).val());
    				}else if(suffix==suffix_city){
    					var tmp=$("#"+prefix+suffix_prov).val();
    					if(tmp!=""){
    						$("#"+id).val(tmp);
    					}
    				}else{
    					var tmp=$("#"+prefix+suffix_city).val();
    					if(tmp==""){
    						tmp=$("#"+prefix+suffix_prov).val();
    					}
    					$("#"+id).val(tmp);
    				}
    			}
    		});
    		if(!isEmpty(value) && value.length==6){
    			var parent="0";
    			var index=value.indexOf("00");
    			switch (index) {
    			case -1:
    				parent=value.substring(0,4)+"00";
    				setArea(id+suffix_county,parent,value);
    			case 4:
    				parent=value.substring(0,2)+"0000";
    				value=value.substring(0,4)+"00";
    				setArea(id+suffix_city,parent,value);
    				if(index==4){
    					setArea(id+suffix_county,value);
    				}
    			case 2:
    				parent="0";
    				value=value.substring(0,2)+"0000";
    				setArea(id+suffix_prov,parent,value);
    				if(index==2){
    					setArea(id+suffix_city,value);
    				}
    			}
    		}else{
    			setArea(id+suffix_prov,"0");
    		}
    	}
    	/***
    	 * 地区选择控件设置地址
    	 * */
    	function setArea(id,parentCode,defValue){
    		$.ajax({
    			type:"post",
    			data:{"PARENT_CODE":parentCode},
    			url:"${ctxPath }/topic/ajax/queryArea",
    			async:false,
    			dataType:"json",
    			success:function(data){
    				data=data.resultObj;
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
    	
    	/**判断对象是否为空*/
    	function isEmpty(str){
    		if(str === '' || str == null || str.length == 0 || typeof(str) == "undefined"){
    			return true;
    		}
    		return false;
    	}
    </script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=vaOdcXMsIjnesIldud46GOtT"></script>
<script type="text/javascript">
	var marker;
	var map;
	var gc = new BMap.Geocoder();//地址解析类
	// 百度地图API功能
	//弹出地图选择地点
	function selectAreaOnMap(){
		$('#mapModal').modal({});
		if($("#areaAddr").attr("isFirst")=="0"){
			//不是第一次打开
		}else{
			map = new BMap.Map("areaSelectMap");
			//第一次打开
			$("#areaAddr").attr("isFirst","0");
			var prov = $("#area_edit_addr_prov option:selected").text();
			var city = $("#area_edit_addr_city option:selected").text();
			prov = prov == '请选择' ? "" : prov;
			city = city == '请选择' ? "" : city;
			if(city!=""){
				//map.centerAndZoom(city,11);
				gc.getPoint(city,function(point){
					if(point){
						map.centerAndZoom(point, 10);
						setMarker(point.lng, point.lat);//设置标注
						markerClick(point.lng, point.lat);//默认触发标注点击事件
						map.addOverlay(marker);
					}
				},prov);
			}else{
				var myCity = new BMap.LocalCity();
				myCity.get(function(result) {
					var cityName = result.name;
					var lng = result.center.lng;
					var lat = result.center.lat;
					map.centerAndZoom(new BMap.Point(lng, lat), 7);
					//map.setCenter(cityName);
					//alert("当前定位城市:"+result.name);
					
					setMarker(lng, lat);//设置标注
					markerClick(lng, lat);//默认触发标注点击事件
				}); 
			}

			map.addControl(new BMap.NavigationControl());// 添加平移缩放控件
			map.enableScrollWheelZoom();//启用滚轮放大缩小
			map.addEventListener("click", function(e) {
				map.clearOverlays();
				//alert(e.point.lng + "," + e.point.lat);
				setMarker(e.point.lng, e.point.lat);
				markerClick(e.point.lng, e.point.lat);
			});
		}
	}

	

	function setMarker(lng, lat) {

		marker = new BMap.Marker(new BMap.Point(lng, lat));
		map.addOverlay(marker);
		marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
		marker.enableDragging();
		//监听标注的dragend拖拽事件
		marker.addEventListener("dragend", function(e) {
			//alert("当前位置:" + e.point.lng + ", " + e.point.lat);    
			//获取地址信息
			gc.getLocation(e.point, function(rs) {
				showLocationInfo(e.point, rs);
			});
		});

		//添加标记点击监听
		marker.addEventListener("click", function(e) {
			gc.getLocation(e.point, function(rs) {
				showLocationInfo(e.point, rs);
			});
		});
	}

	//标注单击事件
	function markerClick(lng, lat) {
		gc.getLocation(new BMap.Point(lng, lat), function(rs) {
			showLocationInfo(new BMap.Point(lng, lat), rs);
		});
	}
	
	//显示地址信息窗口
	function showLocationInfo(pt, rs){
	    var opts = {
	      width : 250,     //信息窗口宽度
	      height: 100,     //信息窗口高度
	      title : ""  //信息窗口标题
	    }
	     
	    var addComp = rs.addressComponents;
	    var addr = "当前位置:" + addComp.province + "" + addComp.city + " " + addComp.district + " " + addComp.street + " " + addComp.streetNumber + "<br/>";
	    addr += "纬度: " + pt.lat + ", " + "经度:" + pt.lng;
	    //alert(addr);
	     
	    var infoWindow = new BMap.InfoWindow(addr, opts);  //创建信息窗口对象
	    marker.openInfoWindow(infoWindow);
	    
	    $("#writeAddr").val(addComp.district + addComp.street + addComp.streetNumber);
	    $("#mapSelectLng").val(pt.lng);
	    $("#mapSelectLat").val(pt.lat);
	}
	
	/** 搜索地图 */
	function searchAreaOnMap(){
		var info = $("#writeAddr").val();
		var local = new BMap.LocalSearch(map, {
			renderOptions:{map: map}
		});
		local.search(info);
	}
	
	function saveArea(){
		$("#areaAddr").val($("#writeAddr").val());
		$("#lng").val($("#mapSelectLng").val());
		$("#lat").val($("#mapSelectLat").val());
		$("#mapModal").modal('hide');
	}
</script>
</body>
</html>