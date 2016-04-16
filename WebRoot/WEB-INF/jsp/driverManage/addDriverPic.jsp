<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
$(function() {	
		$.each($sysdict.DRIVER_CARD,function(index,e){
			var st="";
			var option="<option " +st+" value=\""+e.ID+ "\" >"+e.TEXT+ "</option>" ;
			$("#driver_imgtype0").append(option);
		});
});	
	//提交后执行的方法,将添加的认证图片加载到表格
	function uploadImgDone(data) {
		if (data.result == "1") {
				//先循环添加的内容
				data =  data.resultObj;
	 		for(var i=0;i<=maxRow;i++){
				var type = $("#driver_imgtype"+i).val();//下拉框值
				var text = $("#driver_imgtype"+i).find("option:selected").text();//下拉框值
				var driver_maxImgNum = parseInt($("#driver_maxImgNum").val());
				driver_maxImgNum = $("#driver_maxImgNum").val();
				if(text=="" || type =="undefined"){
					continue;
				}
				//每个tr有id对应着某一类型(比如身份证)
				var html="";
				if($("tr[id='driver"+type+"']").length >= 1){
					var tr_img_num = $("tr[id='"+type+"'] .imgTd img").length;
					var tr_index = $(".imgTr").index($("#"+type));
					html +="<div class='imgDiv'><div class='closeImg' onclick='delThisImg(this)'></div><img id='"+""+"' src=\"${ctxPath }/pic/"+data["pic"+i].path+"\" ></img>";
					html +="<input type=\"hidden\" name='remote_img_"+driver_maxImgNum+"' value=\""+data["pic"+i].qiniuPath+"\"></input>";
					html +="<input type=\"hidden\" name='img_"+driver_maxImgNum+"' value=\""+type+"~"+data["pic"+i].path+"\"></input></div>";
					$("#show_driver_table tbody tr[id='driver"+type+"'] td.imgTd").append(html);
				}else{
					var tr_index = $("#show_driver_table tbody tr").length;
					html+="<tr id=\"driver"+type+"\" class='imgTr'>";
					html+="<td align=\"center\"><span>"+text+"</span></td>";
					html+="<td class=\"imgTd\">";
					html+="<div class='imgDiv'><div class='closeImg' onclick='delThisImg(this)'></div><img id='"+""+"' src=\"${ctxPath }/pic/"+data["pic"+i].path+"\"></img>";
					html +="<input type=\"hidden\" name='remote_img_"+driver_maxImgNum+"' value=\""+data["pic"+i].qiniuPath+"\"></input>";
					html +="<input type=\"hidden\" name='img_"+driver_maxImgNum+"' value=\""+type+"~"+data["pic"+i].path+"\"></input></div>";
					html+="</td>";
					html+="<td align=\"center\"><button type=\"button\" onclick='delThisRow(this)'>删除</button></td>";
					html+="</tr>";
					$("#show_driver_table tbody").append(html);
				}
				//$("#show_driver_table tbody tr#"+type)
				$("#driver_maxImgNum").val(parseInt(driver_maxImgNum)+1);
			}
			$.pdialog.closeCurrent();
			$("td img",navTab.getCurrentPanel()).each(function(i){
				var objEvt = $._data($(this)[0], "events"); 
				//判断是否存在click事件
				if (objEvt && objEvt["click"]){
				}else{
					$(this).on("click",function(){
						openPhoto($("td img",navTab.getCurrentPanel()),i);
					});
				}
			});
		}else{
			alert(data.resultInfo);
		}
		
	}
	var maxRow=0;
	function addRow(){
		if($("#inputFileNum",$.pdialog.getCurrent()).val()>5){
			return;
		}else{
			var inputFileNum= parseInt($("#inputFileNum",$.pdialog.getCurrent()).val());
			$("#inputFileNum",$.pdialog.getCurrent()).val(inputFileNum+1);
		}
		maxRow++;
		var html = "";
		html += "<tr>";
		html += "<td><select id='driver_imgtype"+maxRow+"' name='driver_imgtype"+maxRow+"'></select></td>";
		html += "<td><input type='file' id='driver_imgtype_img"+maxRow+"' name='driver_imgtype_img"+maxRow+"'></input></td>";
		html += "<td><input type='button' value='-' onclick='delRow(this)'></input></td>";
		html +="</tr>";
		
		$("#driver_maxFileNum").val(maxRow);
		$("#driver_fjfile").append(html);
		var option="";
		option = $("#driver_imgtype0").html();
		$("#driver_imgtype"+maxRow).append(option);
	}
	
	function delRow(obj){
		var inputFileNum= parseInt($("#inputFileNum",$.pdialog.getCurrent()).val());
		$("#inputFileNum",$.pdialog.getCurrent()).val(inputFileNum-1);
		var id = $(obj).attr("id");
		$(obj).parent().parent().remove();
	}

</script>
<div class="page" style="height: 250px">
	<form id="driverPicForm" method="post" 
		action="${ctxPath}/topic/ajax/savePic"
		enctype="multipart/form-data" onsubmit="return iframeCallback(this,uploadImgDone);"
		style="height: 100%">
		<div style="height: 220px;overflow-y:scroll;"> 
		<table id="driver_fjfile">
			<tr>
				<td>
				  <select id="driver_imgtype0" name="driver_imgtype0">
				  </select>
				</td>
				<td><input id="driver_imgtype_img0" type="file" name="driver_imgtype_img0"></input></td>
				<td><input type="button" value="+" onclick="addRow()"></input></td>
			</tr>
		</table>
		</div>
		<input id="driver_maxFileNum" name="driver_maxFileNum" type="hidden" value="1"/>
		<input name="defualt_prefix" type="hidden" value="driver"/>
		<input id="inputFileNum" name="" type="hidden" value="1"/>
		<div style="width: 67px;margin: 0 auto;"><button type="submit">确&nbsp;&nbsp;&nbsp;&nbsp;定</button></div>
	</form>
</div>
