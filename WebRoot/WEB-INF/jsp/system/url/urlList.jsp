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
                        <!-- <h5>URL管理</h5> -->
                        <form class="form-inline" id="urlSearchForm">
                            <div class="form-group">
                                <label>URL标识：&nbsp;&nbsp;</label>
                                <input type="text" placeholder="请输入URL标识" id="Q_URL_ID" class="form-control">
                            </div>
                            <div class="form-group">
                                <label>&nbsp;&nbsp;&nbsp;&nbsp;SQL&nbsp;&nbsp;</label>
                                <input type="text" placeholder="请输入SQL" id="Q_SQL_ID" class="form-control">
                            </div>&nbsp;&nbsp;&nbsp;&nbsp;
                            <div class="form-group">
                                <label>&nbsp;&nbsp;&nbsp;&nbsp;服务类型名：&nbsp;&nbsp;</label>
                                <input type="text" placeholder="请输入服务类型名" id="Q_SERVICE_NAME" class="form-control">
                            </div>&nbsp;&nbsp;&nbsp;&nbsp;
		 					<button type="button" class="btn btn-sm btn-primary" onclick="searchForm();">查询</button>
		 					<button type="button" class="btn btn-sm btn-primary " onclick="resetForm('urlSearchForm');">重置</button>
                        </form>
                    </div>
                    <div class="ibox-content widget-content nopadding float-e-margins">                    	
                        <div class="form-group" id="toolbar" style="padding:5px 5px;">
                        	<button type="button" class="btn btn-outline btn-default" onclick="addUrl()"> <i class="glyphicon glyphicon-plus"></i> 添加URL</button>
                        	<button type="button" class="btn btn-outline btn-default" onclick="editUrl()"> <i class="glyphicon glyphicon-edit"></i> 修改URL</button>
                        	<button type="button" class="btn btn-outline btn-default" onclick="delUrl()"> <i class="glyphicon glyphicon-remove"></i> 删除URL</button>
                    	</div>
						<table id="urlList" class="table table-striped table-bordered table-hover data-table with-check">
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
    <script>
    	var table,cols = [
				{"data" : "URL_ID"},
				{"data" : "FULL_URL"},
				{"data" : "TITLE"},
				{"data" : "SERVICE_NAME"},
				{"data" : "PAGE"},
				{"data" : "SQL_ID"},
				{"data" : "VALIDATION_ID"},
				{"data" : "REMARK"}
			];
    	// 设置哪些列不进行排序aoColumnParam   哪些列需排序（需要改sql xml条件） aaSortParam（aoColumnParam放空，aaSortParam也为空时默认全部有排序）
    	var aoColumnParam = [0,1,2,3,4,5,6,7],aaSortParam = [];
    	
		$(function(){
			// 加载列表信息 initTable(id,url,param,colsParam,aoColumnParam,aaSortParam,other); 
			// param Ajax请求时发送额外的数据(条件),colsParam 设置列属性条件,aoColumnParam 设置哪些列不排序  aaSortParam设置哪些列排序
        	table = initTableAutoHeight("urlList", "${ctxPath}/topic/page/toUrlList", null,cols,aoColumnParam,aaSortParam,'URL_ID',getScreen());
		});
		
		function addUrl(){
			/**
			 * 跳转页面  iUrl请求url  iTitletab标签名
			 */
			indexToPage("${ctxPath}/topic/addUrlPage","新增URL");
		}
		function editUrl(){			
			var params = [];			
			if(!isEmpty($("#clickId").val())) {
				params = [{URL_ID:$("#clickId").val()}];
			} else {
				$("input[data-type='subUrlCheck']:checked").each(function(i) {
			    	if(this.checked == true){
			    		params[i] = {URL_ID:$(this).val()};
			    	}
			    });
			}
			
			/**
			 * 修改信息 iUrl请求url param参数 (数组)eg:params = [{unid:"2"}]  iTitletab标签名
			 */
			editForm("${ctxPath}/topic/editUrlPage",params,"修改URL");
		}
		function delUrl(){
			var params = [];
			if(!isEmpty($("#clickId").val())) {
				params = [{URL_ID:$("#clickId").val()}];
			} else {
				$("input[data-type='subUrlCheck']:checked").each(function(i) {
			    	if(this.checked == true){
			    		params[i] = {URL_ID:$(this).val()};
			    	}
			    });
			}
			
			/**
			 * 删除记录，支持批量删除（参数格式必须为数组） iUrl请求url iText提示的文本信息（只需关键字）
			 * params参数 数组eg:params = [{unid:"2"},{unid:"1"}] callBack回调函数
			 */
			delForm("${ctxPath}/topic/ajax/delUrl","URL",params,searchForm);
		}
		
		/* 搜索 查询 */
		function searchForm() {
			$("#clickId").val("");  //清除之前选中的id
			table.column(0).search($('#Q_URL_ID').val());
			table.column(1).search($('#Q_SERVICE_NAME').val());
			table.column(2).search($('#Q_SQL_ID').val());
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