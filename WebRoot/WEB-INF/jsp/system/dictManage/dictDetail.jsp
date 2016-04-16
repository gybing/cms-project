<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
<title>数据字典详情</title>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox">
			<div class="ibox-content">
				<div class="panel panel-default" style="margin-top: 5px;">
					<div class="panel-body">
						<div class="widget-content nopadding float-e-margins">
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
							<tbody></tbody>
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