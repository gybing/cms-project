<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>字典数据详情</title>
<jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
 		<input type="hidden" id="clickId"  /> 
 		<input type="TEXT" id="dict_type" value="${param.DICT_TYPE }"/>
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content widget-content nopadding float-e-margins">
						<div class="form-group" style="padding:5px 5px">
							<button type="button" class="btn btn-outline btn-default" onclick="toAddDict()"> <i class="glyphicon glyphicon-plus"></i> 新增类型</button>
							<button type="button" class="btn btn-outline btn-default" onclick="toEditDict()"> <i class="glyphicon glyphicon-edit"></i> 修改类型</button>
							<button type="button" class="btn btn-outline btn-default" onclick="toDelDict()"> <i class="glyphicon glyphicon-remove"></i> 删除类型</button>
						</div>
						<table id="dict_detail_table" class="table table-striped table-bordered table-hover data-table with-check">
							<thead>
								<tr>
									<th>序号</th>
									<th>数据类型</th>
									<th>类型名称</th>
									<th>编码</th>
									<th>父类编码</th>
									<th>编码对应的文本</th>
									<th>排序编码</th>
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
	var table;
	var cols = [
	    		{"data" : "NUM"}, // 
	    		{"data" : "TYPE"}, // 
	    		{"data" : "NAME"}, // 
	    		{"data" : "CODE"}, // 
	    		{"data" : "PARENT_CODE"}, // 
	    		{"data" : "TEXT"}, // 
	    		{"data" : "SEQ"} // 
	    		];
	// 设置哪些列不进行排序aoColumnParam   哪些列需排序（需要改sql xml条件） aaSortParam（aoColumnParam放空，aaSortParam也为空时默认全部有排序）
	var aoColumnParam = [0],aaSortParam = [];
	var param = {"DICT_TYPE":'${param.DICT_TYPE}'};
	$(function() {
		// 加载列表信息 initTable(id,url,param,colsParam,aoColumnParam,aaSortParam,other); 
		// param Ajax请求时发送额外的数据(条件),colsParam 设置列属性条件,aoColumnParam 设置哪些列不排序  aaSortParam设置哪些列排序
		table = initTableAutoHeight("dict_detail_table","${ctxPath}/topic/page/getDictDetail", param,cols,aoColumnParam,aaSortParam,"ID",getScreen());

	});
	/* 打开添加字典数据页面 */
	function toAddDict(){
		indexToPage("${ctxPath}/topic/toAddDict?DICT_TYPE="+'${param.DICT_TYPE}',"新增");
	}
	/* 打开修改字典数据页面 */
	function toEditDict(){
		indexToPage("${ctxPath}/topic/toEditDict?id="+$("#clickId").val(),"修改");
	}
	/* 删除字典数据 */
	function toDelDict(){
		var params = [{id:$("#clickId").val()}];
		/**
		 * 删除记录，支持批量删除（参数格式必须为数组） iUrl请求url iText提示的文本信息（只需关键字）
		 * params参数 数组eg:params = [{unid:"2"},{unid:"1"}] callBack回调函数
		 */
		delForm("${ctxPath}/topic/ajax/deleteDict","字典",params,resetForm);
		
	}
	function resetForm(){
		refreshDictTree();
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