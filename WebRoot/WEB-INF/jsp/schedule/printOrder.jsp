<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>打印</title>
    <jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
    <script language="javascript" src="${resRoot}/js/jquery.jqprint-0.3.js"></script>
	<script type="text/javascript">
		$(function(){
			
			$.ajax({
				url:"${ctxPath}/topic/ajax/getTemplet",
				data:{"temp_type":"order"},
				type:"post",
				dataType:"json",
				success:function(data){
					data = data.resultObj;
					if(data.TEMPLET == null){
// 						var tdLength = $("#print_table").find("td").length;
// 						for(var i = 1;i<=tdLength;i++){
// 							drag($("#td"+i),"print_div");
// 						} 
						printTemp();// 若第一次使用打印 没有模版 则默认使用页面原先样式。
					}else{
						userPrintTemp();// 存在模版，则使用上次打印时模版
					}
				}
			});
			
			
			/* 设置 table 中每一列可拖动 */ 
		/* 	var tdLength = $("#print_table").find("td").length;
			for(var i = 1;i<=tdLength;i++){
				drag($("#td"+i),"print_div");
			} */
			
			/* 查询对应箱子的订单信息 */
			/* $.ajax({
				url:"${ctxPath}/topic/ajax/printOrderInfo",
				data:{"box_id":'${param.box_id}'},
				dataType:"json",
				type:"post",
				success:function(data){
					data = data.resultObj;
					var div_ele = $("#print_div").find("label");
					div_ele.each(function(i, e) {
						var name = $(this).attr("id");
						if (data[name] == null)
							return true;
						$(this).text(data[name] || "");
					});
				}
			}); */
		});
		
		function printTemp(){
			/* 重新加载页面箱子信息，并替换到模版内 */
			$.ajax({
				url:"${ctxPath}/topic/ajax/printOrderInfo",
				data:{"box_id":'${param.box_id}'},
				dataType:"json",
				type:"post",
				async:false,
				success:function(data){
					data = data.resultObj;
					var div_ele = $("#print_div").find("label");
					div_ele.each(function(i, e) {
						var name = $(this).attr("id");
						if (data[name] == null)
							return true;
						$(this).text(data[name] || "");
					});
				}
			});
			/* 重新设置每个 td 为可拖动 */
			var tdLength = $("#print_table").find("td").length;
			for(var i = 1;i<=tdLength;i++){
				drag($("#td"+i),"print_div");
			}
		}
		
		/* 保存打印订单的模版 */
		function savePrintTemp(){
			var html ;
			var ht = $("#print_div").clone();
			var div_ele = ht.find("label");
			div_ele.each(function(i,e){
				$(this).html("");
			});
			html = ht.html();
			$.ajax({
				url:"${ctxPath}/topic/ajax/saveTemplet",
				data:{"templet":html},
				type:"post",
				dataType:"json",
				success:function(data){
					
				}
			});
		}
		/* 使用上一次打印订单的模版 */
		function userPrintTemp(){
			/* 获取模版 */
			$.ajax({
				url:"${ctxPath}/topic/ajax/getTemplet",
				data:{"temp_type":"order"},
				type:"post",
				dataType:"json",
				success:function(data){
					$("#print_div").html("");
					$("#print_div").html(data.resultObj.TEMPLET);
					/* 重新加载页面箱子信息，并替换到模版内 */
					$.ajax({
						url:"${ctxPath}/topic/ajax/printOrderInfo",
						data:{"box_id":'${param.box_id}'},
						dataType:"json",
						type:"post",
						async:false,
						success:function(data){
							data = data.resultObj;
							var div_ele = $("#print_div").find("label");
							div_ele.each(function(i, e) {
								var name = $(this).attr("id");
								if (data[name] == null)
									return true;
								$(this).text(data[name] || "");
							});
						}
					});
					/* 重新设置每个 td 为可拖动 */
					var tdLength = $("#print_table").find("td").length;
					for(var i = 1;i<=tdLength;i++){
						drag($("#td"+i),"print_div");
					}
				}
			});
		}
		
		/* 调用打印功能 */
		function printOrderInfo(){
			savePrintTemp();
			$("#print_div").jqprint();
		}
		
		/* 页面元素拖动 */
		function drag(obj,priv_div){
			var self = obj;
			self.mousedown(function(event) {
						self.css("position", "absolute");
						var p = self.position();
						self.css({
							left: p.left,
							top: p.top
						});
						// debugger; 
						self.data("ifDary", "true"); //保存状态，表示是否可以拖拽 
						// debugger; 
						var selfLeft = event.pageX - parseInt(self.css("left")); //计算出鼠标到这个元素的left
						var selfTop = event.pageY - parseInt(self.css("top")); //计算出鼠标到这个元素的top 
						self.data("selfLeft", selfLeft); //保存坐标信息 
						self.data("selfTop", selfTop);
					});
			$(document).mouseup(

					function() {
						self.data("ifDary", "false");
						var $pDiv = $("#"+priv_div);
						//防止窗体飞到外面去 
//						var bWidth = $(window).width();
//						var bHeight = $(window).height();
						var x = $pDiv.offset().top; 
						var y = $pDiv.offset().left; 
						
						var bWidth = $pDiv.width();
						var bHeight = $pDiv.height();
						
						var currentleft = parseInt(self.css("left"));
						var currenttop = parseInt(self.css("top"));
						if (currentleft <= 0 || currentleft < y) currentleft = y;
						if (currentleft >= bWidth) currentleft = bWidth - self.width();
						if (currenttop <= x) currenttop = x;
						if (currenttop >= bHeight + x ) currenttop = bHeight + x - self.height();
						self.css({
							left: currentleft,
							top: currenttop
						});
					});
			$(document).mousemove(function(event) {
						var state = self.data("ifDary");
						if (state && state == "true") {
							var selfLeft = event.pageX - parseInt(self.data("selfLeft")); //计算这个元素的left位置 
							var selfTop = event.pageY - parseInt(self.data("selfTop"));
							self.css({
								left: selfLeft,
								top: selfTop
							}); //设置这个元素的位置 
						}
					});
			return self;
		}
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox">
			<div class="ibox-content">
				<div class="panel panel-default">
					<div class="panel-heading"><h5>控制面板</h5></div>
					<div class="panel-body">
						<div class="form-group">
							<div class="row">
								<div class="col-sm-8">
									<!--  <button class="btn btn-info" type="button" onclick="savePrintTemp()">保存模版</button>
									 <button class="btn btn-primary" type="button" onclick="userPrintTemp()">使用模版</button> -->
									 <button class="btn btn-success" type="button" onclick="printOrderInfo()">打印</button>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="panel panel-default">
					<div class="panel-heading"><h5>显示面板</h5></div>
					<div class="panel-body">
						<div id="print_div" style="margin-top: 10px;width:1000px;height:370px;font-size: 16px">
							<table id="print_table">
								<tr>
									<td id="td1"><label id="SHIP_NAME"></label></td>
									<td id="td2"><label id="SHIP_VOYAGE"></label></td>
									<td id="td3"><label id="ORDER_NO"></label></td>
								</tr>
								<tr>
									<td id="td4"><label id="CARGO_OWNNER"></label></td>
									<td id="td5"><label id="OWNNER_NAME"></label></td>
									<td id="td6"><label id="OWNNER_TEL"></label></td>
								</tr>
								<tr>
									<td id="td7"><label id="TO"></label></td>
									<td id="td8"><label id="SIZE"></label></td>
									<td id="td9"><label id="SPEC"></label></td>
								</tr>
								<tr>
									<td id="td10"><label id="CARGO_REMARK"></label></td>
									<td id="td11"><label id="TO_PORT"></label></td>
									<td id="td12"><label id="NO"></label></td>
								</tr>
								<tr>
									<td id="td13"><label id="SEAL_NO"></label></td>
									<td id="td14"><label id="ADDR"></label></td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>