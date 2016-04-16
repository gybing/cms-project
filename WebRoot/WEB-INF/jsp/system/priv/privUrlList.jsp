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
 		<input type="hidden" id="clickId"  /> 
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content widget-content nopadding float-e-margins">
						<div class="form-group">	
							 <div id="toolbar" style="padding: 5px 5px;margin-left:3px">
	                        	<button type="button" class="btn btn-outline btn-default" onclick="addPrivUrl()"> <i class="glyphicon glyphicon-plus"></i> 添加UR</button>
	                        	<button type="button" class="btn btn-outline btn-default" onclick="delUrl()"> <i class="glyphicon glyphicon-edit"></i> 删除URL</button>
                        	</div>
						</div>
						<table id="priv_url_list"
							class="table table-striped table-bordered table-hover data-table with-check">
							<thead>
								<tr>
									<th>URL标识</th>
									<th>URL路径</th>
									<th>标题</th>
									<th>服务类型名</th>
									<th>跳转页面</th>
									<th>SQL_ID</th>
									<th>VALIDATION_ID</th>
									<th>描述</th>
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
		var table, cols = [ {
			"data" : "URL_ID"
		}, {
			"data" : "FULL_URL"
		}, {
			"data" : "TITLE"
		}, {
			"data" : "SERVICE_NAME"
		}, {
			"data" : "PAGE"
		}, {
			"data" : "SQL_ID"
		}, {
			"data" : "VALIDATION_ID"
		}, {
			"data" : "REMARK"
		} ];
		// 设置哪些列不进行排序aoColumnParam   哪些列需排序（需要改sql xml条件） aaSortParam（aoColumnParam放空，aaSortParam也为空时默认全部有排序）
		var aoColumnParam = [ 0, 1, 2, 3, 4, 5, 6, 7 ], aaSortParam = [];
		var param = {"Q_PRIV_ID":${param.Q_PRIV_ID}};
		$(function() {

			// 加载列表信息 initTable(id,url,param,colsParam,aoColumnParam,aaSortParam,other); 
			// param Ajax请求时发送额外的数据(条件),colsParam 设置列属性条件,aoColumnParam 设置哪些列不排序  aaSortParam设置哪些列排序
			table = initTableAutoHeight("priv_url_list","${ctxPath}/topic/page/getPrivUrl", param, cols,aoColumnParam, aaSortParam, 'URL_ID');

		});
		/* 打开新增 URL 页 */
		function addPrivUrl() {
			index = layer.open({
				type : 2,
				title : "新增URL",
				area : [ '800px', '500px' ],
				fix : false	, //不固定
				maxmin : false,
				content : '${ctxPath}/topic/toNoPrivUrlListPage?priv_id='+${param.Q_PRIV_ID }
			});
		}
		
		/* 删除URL */
		function delUrl() {
			var params = [];
			if (!isEmpty($("#clickId").val())) {
				params = [ {
					urlid : $("#clickId").val()
				} ];
			} else {
				$("input[data-type='subUrlCheck']:checked").each(function(i) {
					if (this.checked == true) {
						params[i] = {
								urlid : $(this).val()
						};
					}
				});
			}

			/**
			 * 删除记录，支持批量删除（参数格式必须为数组） iUrl请求url iText提示的文本信息（只需关键字）
			 * params参数 数组eg:params = [{unid:"2"},{unid:"1"}] callBack回调函数
			 */
			delForm("${ctxPath}/topic/ajax/delPrivUrl", "URL", params, searchForm);
		}
	</script>
</body>
</html>