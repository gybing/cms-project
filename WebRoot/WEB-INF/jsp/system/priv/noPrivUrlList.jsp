<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>URL列表页</title>
<jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
<jsp:include page="/WEB-INF/jsp/formSubmit.jsp"></jsp:include>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<form class="form-horizontal" id="add_priv_url_form" method="post" action="#" callback="">
		<input type="hidden" id="add_dict_tag" name="tag" value="${sessionScope.SESSION_USER_LOGIN_INFO.userInfo.TAG }" />
		<input type="hidden" id="clickId" name="urlids"/>
		<input type="hidden" id="privId" name="privId" value="${param.priv_id }"/>
		</form>
		<div class="row">
			<div class="col-sm-12" >
				<div class="ibox float-e-margins">
					<div class="ibox-content widget-content nopadding float-e-margins">
						<div class="panel panel-default">
		                    <div class="panel-heading" style="padding: 5px;background-color: #fff;border-color: #fff">
		                    	<div class="col-sm-9 m-b-xs">
									<div class="">
										<a href="javascript:void(0);" class="btn btn-primary " onclick="savePrivUrl()">保存</a> 
										<a href="javascript:void(0);" class="btn btn-primary " onclick="closeLayer()">取消</a>
									</div>
								</div>
								<div class="col-sm-3">
									<form class="form-inline" id="areaManageForm">
										<div class="input-group">
											<input id="key_search" type="text" placeholder="请输入关键词"class="input-sm form-control"> 
											<span class="input-group-btn">
												<button type="button" class="btn btn-sm btn-primary" onclick="searchForm()">搜索</button>
											</span>
										</div>
									</form>
								</div>
		                    </div>
		                    <div class="panel-body">
								<table id="no_priv_url_list"
									class="table table-striped table-bordered table-hover data-table with-check">
									<thead>
										<tr>
											<!--   <th><input type="checkbox" data-type="urlCheckAll"></th> -->
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
	</div>
	<script>
	var table, cols = [
   		{
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
   		// 设置哪些列不进行排序  哪些列需排序（需要改sql xml条件）[3,""],[4,""]
   		var aoColumnParam = [ 0, 1, 2, 3 ], aaSortParam = [];
   		$(function() {
   			// 加载列表信息 initTable(id,url,param,colsParam,aoColumnParam,aaSortParam,other); 
   			// param Ajax请求时发送额外的数据(条件),colsParam 设置列属性条件,aoColumnParam 设置哪些列不排序  aaSortParam设置哪些列排序
   			table = initTable("no_priv_url_list","${ctxPath }/topic/page/getNoPrivUrlList", null, cols,aoColumnParam, aaSortParam, "URL_ID");

   		});
		function savePrivUrl(){
			$.ajax({
				url : "${ctxPath}/topic/ajax/saveUrlPriv",
				dataType : "json",
				data : $("#add_priv_url_form").serialize(),
				type : "post",
				success : function(json) {
					if (json.result == '1') {
						layer.alert(json.resultInfo, function(index){
							//刷新表格，关闭弹窗
							searchForm();
							layer.close(index);
							parent.layer.close(window.parent.index);
						});  
					} else {
						layer.alert(json.resultInfo,{icon: 2}, function(index){
							//刷新表格，关闭弹窗
							layer.close(index);
						});  
						return;
					}
			}});
			
		}
		function closeLayer(){
			parent.layer.close(window.parent.index); 
		};
		/* 搜索 查询 */
		function searchForm() {
			$("#clickId").val(""); //清除之前选中的id
			table.column(0).search($('#key_search').val());
			table.column(1).search($('#key_search').val());
			table.column(2).search($('#key_search').val());
			table.column(3).search($('#key_search').val());
			table.column(4).search($('#key_search').val());
			table.column(5).search($('#key_search').val());
			table.column(6).search($('#key_search').val());
			table.column(7).search($('#key_search').val());
			table.draw();
		}
	</script>
</body>
</html>