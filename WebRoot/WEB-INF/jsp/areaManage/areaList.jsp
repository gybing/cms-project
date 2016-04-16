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
                        <div class="row">
	                    	<form class="form-horizontal" id="dispatchSearchForm">
	                            <div class="form-group col-sm-12" style="margin-left: 0px">
	                            	<label class="col-sm-1 control-label" style="text-align: left;width: auto;">万能搜索</label>
	                                <div class="col-sm-2">
	                                	<input id="key" type="text" placeholder="请输入关键词" class="form-control" style="margin-left: 5px"> 
		                            </div>
		                            <div class="col-sm-9">
		                                <button type="button" class="btn btn-sm btn-primary" onclick="searchForm()">查询</button> 
		                            	<button type="button" class="btn btn-sm btn-primary " onclick="resetForm('dispatchSearchForm');">重置</button>
		                            </div>
	                            </div>
	                        </form>
                        </div>
                         </div>
                        <div class="ibox-content">
                   	  	<div id="toolbar" style=" float:left; padding: 5px 5px 5px 0px;">
                     		<button type="button" class="btn btn-outline btn-default" onclick="toAreaAdd()"> <i class="glyphicon glyphicon-plus"></i> 新增</button>
                     		<button type="button" class="btn btn-outline btn-default" onclick="toAreaEdit()"> <i class="glyphicon glyphicon-edit"></i> 修改</button>
                     		<button type="button" class="btn btn-outline btn-default" onclick="delArea()"> <i class="glyphicon glyphicon-remove"></i> 删除</button>
                     		<button type="button" class="btn btn-outline btn-default" onclick="setDefaultPark()"> <i class="glyphicon glyphicon-cog"></i> 设为默认停车场</button>
               		  	</div>
                        <table id="areaManageTable" class="table table-striped table-bordered table-hover data-table with-check">
                            <thead>
                                <tr>
                                    <!-- <th width=""><input type="checkbox" data-type="areaCheckAll"></th> -->
                                    <th style="text-align: center;" width="">序号</th>
                                    <th style="text-align: center;" width="">地点代码</th>
                                    <th style="text-align: center;" width="">地点名称</th>
                                    <th style="text-align: center;" width="">所在城市</th>
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
					"mData":"ID",
					"mRender": function (data, type, full) {
						return "<input type=\"checkbox\" class=\"i-checks\" data-type=\"areaCheck\" value=\""+ data +"\">";
					},
					"width":20
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
					},"width":150},
				{"data" : "NAME",
						"render" : function(data) {
							data=data==null?"":data;
							return "<div align='center'>" + data + "</div>";
						},"width":150},
				{"data" : "CITY_ADDR",
							"render" : function(data) {
								data=data==null?"":data;
								return "<div align='center'>" + data + "</div>";
							},"width":100},
				{"data" : "REMARK",
								"render" : function(data) {
									data=data==null?"":data;
									return "<div align='center'>" + data + "</div>";
								}}
			];
    	// 设置哪些列不进行排序  哪些列需排序（需要改sql xml条件）[3,""],[4,""]
    	var aoColumnParam = [0,1,2,3],aaSortParam = [];
		$(function(){
			// 加载列表信息 initTable(id,url,param,colsParam,aoColumnParam,aaSortParam,other); 
			// param Ajax请求时发送额外的数据(条件),colsParam 设置列属性条件,aoColumnParam 设置哪些列不排序  aaSortParam设置哪些列排序
        	table = initTableAutoHeight("areaManageTable", "${ctxPath }/topic/page/areaList", null,cols,aoColumnParam,aaSortParam,"ID",getScreen());
        	// 全选 全不选  data-type
			/* checkAll("areaCheckAll"); */
			
        	$("#areaManageTable").on( 'dblclick', 'tr', function () {
        		toAreaEdit();
        	});
		});
		
		function toAreaAdd(){
			/* indexToPage("${ctxPath}/topic/toAreaAdd","新增"); */
			layer.open({
			    type: 2,
			    title : "新增地点",
			    area: ['65%', '80%'],
			    fix: false, //不固定
			   // maxmin: true,
			    content: "${ctxPath}/topic/toAreaAdd"
			});
		}
		
		function toAreaEdit(){
			var params = "";			
			if(!isEmpty($("#clickId").val())) {
				params = $("#clickId").val();
				/**
				 * 修改信息 iUrl请求url param参数 (数组)eg:params = [{unid:"2"}]  iTitletab标签名
				 */
				/* editForm("${ctxPath}/topic/toAreaEdit",params,"修改地点"); */
				layer.open({
				    type: 2,
				    title : "修改地点",
				    area: ['65%', '80%'],
				    fix: false, //不固定
				   // maxmin: true,
				    content: "${ctxPath}/topic/toAreaEdit?id="+params
				});
			}
			
		}
		
		function delArea(){
			var params = [];
			/* if(!isEmpty($("#clickId").val())) {
				params = [{id:$("#clickId").val()}];
			} else {
				$("input[data-type='areaCheck']:checked").each(function(i) {
			    	if(this.checked == true){
			    		params[i] = {id:$(this).val()};
			    	}
			    });
			} */
			
			$("input[data-type='areaCheck']:checked").each(function(i) {
		    	if(this.checked == true){
		    		params[i] = {id:$(this).val()};
		    	}
		    });
			if(params.length==0){
				params = [{id:$("#clickId").val()}];
			}
			/**
			 * 删除记录，支持批量删除（参数格式必须为数组） iUrl请求url iText提示的文本信息（只需关键字）
			 * params参数 数组eg:params = [{unid:"2"},{unid:"1"}] callBack回调函数
			 */
			delForm("${ctxPath}/topic/ajax/delArea","地点",params,searchForm);
		}
		
		//设为默认停车场
		function setDefaultPark(){
			var id =$("#clickId").val();
			if(isEmpty(id)){
				swal("","请选择一条记录！","warning");
			}
			$.ajax({
				type : "POST",
				url:"${ctxPath}/topic/ajax/setDefaultPark",
				data:{"id":id},
				async:false,
  	            dataType : "json",
  	            success : function(json){
  	        	  if(json=json.result=="1"){
  	        	  	  json=json.resultObj;
  	        	  	  searchForm();
  	        	  	  swal("","恭喜您，设置成功。","success");
  	        	  }else{
  	        		  swal("","设置默认停车场出现错误！","error");
  	        	  }
 	            }
			});
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
			var areaToolbar = $("#areaToolbar").height();
			return height-94-ibox_title-50-areaToolbar;
		}
	</script>
</body>
</html>