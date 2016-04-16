<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>URL列表页</title>
    <jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
    
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <input type="hidden" id="clickId" />
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                       	<form class="form-horizontal" id="driverSearchForm">
                       		<div class="row">
		                   		<div class="form-group col-sm-12" style="margin-left: 0px">
			                      	<label class="col-sm-1 control-label" style="text-align: left;width: auto;">万能搜索</label>
			                      	<div class="col-sm-2">
			                        	<input id="key" type="text" placeholder="请输入关键词" class="form-control" style="margin-left: 5px"> 
				                   	</div>
				                 	<div class="col-sm-9">
				                    	<button type="button" class="btn btn-sm btn-primary" onclick="searchForm()">查询</button> 
				                     	<button type="button" class="btn btn-sm btn-primary " onclick="resetForm('driverSearchForm');">重置</button>
				                   	</div>
		                   		</div>
		                   	</div>
	               		</form>
	               	 </div>
                    <div class="ibox-content">
	                        <div id="toolbar" style=" float:left; padding: 5px 5px 5px 0px;">
	                        	<button type="button" class="btn btn-outline btn-default" onclick="toDriverAdd()"> <i class="glyphicon glyphicon-plus"></i> 新增</button>
	                        	<button type="button" class="btn btn-outline btn-default" onclick="toDriverEdit()"> <i class="glyphicon glyphicon-edit"></i> 修改</button>
	                        	<button type="button" class="btn btn-outline btn-default" onclick="delDriver()"> <i class="glyphicon glyphicon-remove"></i> 删除</button>
	                        </div>
                            <table id="driverManageTable" class="table table-striped table-bordered table-hover data-table with-check">
                                <thead>
                                    <tr>
                                    	<!-- <th><input type="checkbox" data-type="driverCheckAll"></th>  -->
                                        <th style="text-align: center;" width="">序号</th> 
                                        <th style="text-align: center;" width="">司机代码</th>
                                        <th style="text-align: center;" width="">司机姓名</th>
                                        <th style="text-align: center;" width="">默认车号</th>
                                        <th style="text-align: center;" width="">车架</th>
                                        <th style="text-align: center;" width="">联系电话</th>
                                        <th style="text-align: center;" width="">调度中心</th>
                                        <th style="text-align: center;" width="">备注</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        
                    </div>
                </div>
            </div>

        </div>
    </div>
    <script>
    	var table,cols = [
				/* {
					"mData":"DRIVER_ID",
					"mRender": function (data, type, full) {
						return "<input type=\"checkbox\" class=\"i-checks\" data-type=\"driverCheck\" value=\""+ data +"\">";
					}
				},  */
				{"data" : "SEQ",
					"render" : function(data) {
						return "<div align='center'>" + data + "</div>";
					},"width":20
				},
				{"data" : "CODE",
					"render" : function(data) {
						data=data==null?"":data;
						return "<div align='center'>" + data + "</div>";
					}
				},
				{"data" : "NAME",
					"render" : function(data) {
						data=data==null?"":data;
						return "<div align='center'>" + data + "</div>";
					}
				},
				{"data" : "TRUCKPLATE",
					"render" : function(data) {
						data=data==null?"":data;
						return "<div align='center'>" + data + "</div>";
					}
				},
				{"data" : "TRUCKFRAMEPLATE",
					"render" : function(data) {
						data=data==null?"":data;
						return "<div align='center'>" + data + "</div>";
					}
				},
				{"data" : "MOBILE_1",
					"render" : function(data) {
						data=data==null?"":data;
						return "<div align='center'>" + data + "</div>";
					}
				},
				{"data" : "CENTER_NAME",
					"render" : function(data) {
						data=data==null?"":data;
						return "<div align='center'>" + data + "</div>";
					}
				},
				{"data" : "REMARK",
					"render" : function(data) {
						data=data==null?"":data;
						return "<div align='center'>" + data + "</div>";
					}
				}
			];
    	// 设置哪些列不进行排序  哪些列需排序（需要改sql xml条件）[3,""],[4,""]
    	var aoColumnParam = [0,1,2,3],aaSortParam = [];
		$(function(){
			// 加载列表信息 initTable(id,url,param,colsParam,aoColumnParam,aaSortParam,other); 
			// param Ajax请求时发送额外的数据(条件),colsParam 设置列属性条件,aoColumnParam 设置哪些列不排序  aaSortParam设置哪些列排序
        	table = initTableAutoHeight("driverManageTable", "${ctxPath }/topic/page/driverList", null,cols,aoColumnParam,aaSortParam,"DRIVER_ID",getScreen());
        	// 全选 全不选  data-type
			/* checkAll("driverCheckAll"); */
			$("#driverManageTable").on( 'dblclick', 'tr', function () {
				toDriverEdit();
        	});
		});
		
		function toDriverAdd(){
			indexToPage("${ctxPath}/topic/toDriverAdd","新增司机");
		}
		
		function toDriverEdit(){
			var params = [];			
			if(!isEmpty($("#clickId").val())) {
				params = [{driverId:$("#clickId").val()}];
			} else {
				$("input[data-type='subUrlCheck']:checked").each(function(i) {
			    	if(this.checked == true){
			    		params[i] = {driverId:$(this).val()};
			    	}
			    });
			}
			
			/**
			 * 修改信息 iUrl请求url param参数 (数组)eg:params = [{unid:"2"}]  iTitletab标签名
			 */
			editForm("${ctxPath}/topic/toDriverEdit",params,"修改司机");
		}
		
		function delDriver(){
			var params = [];
			$("input[data-type='driverCheck']:checked").each(function(i) {
		    	if(this.checked == true){
		    		params[i] = {driverId:$(this).val()};
		    	}
		    });
			if(params.length==0){
				params = [{driverId:$("#clickId").val()}];
			}
			/**
			 * 删除记录，支持批量删除（参数格式必须为数组） iUrl请求url iText提示的文本信息（只需关键字）
			 * params参数 数组eg:params = [{unid:"2"},{unid:"1"}] callBack回调函数
			 */
			delForm("${ctxPath}/topic/ajax/delDriver","地点",params,searchForm);
		}
		
		/* 搜索 查询 */
		function searchForm() {
			$("#clickId").val("");  //清除之前选中的id
			table.column(0).search($('#key').val());
			table.draw();
		}
		/**
		 * 获取屏幕高度
		 * */
		function getScreen()
		{
			var height = document.body.clientHeight;
			var ibox_title = $(".ibox-title").height();
			var toolbar = $("#toolbar").height();
			return height-94-ibox_title-40-toolbar;
		}
	</script>
</body>
</html>