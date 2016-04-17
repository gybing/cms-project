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
        	table = initTableAutoHeight("urlList", "${ctxPath}/topic/page/toUrlList", null,cols,aoColumnParam,aaSortParam,'URL_ID');
		});
		
		// 新增url
		function addUrl(){
			index = layer.open({
			    type: 2, 
			    title : "新增 URL 信息",
			    area: ['64%', '43%'],
			    fix: false, //不固定
			   // maxmin: true,
			    content: _contextPath+"/topic/addUrlPage"
			});
		}
		
		// 编辑url
		function editUrl(){		
			var r_id = $("#clickId").val()?$("#clickId").val():"";
			if(r_id){
				index = layer.open({
				    type: 2, 
				    title : "编辑 URL 信息",
				    area: ['65%', '43%'],
				    fix: false, //不固定
				   // maxmin: true,
				    content: _contextPath+"/topic/editUrlPage?URL_ID="+r_id
				});
			}else{
				layer.alert("请选择一条记录！", {icon: 2}, function(index){
					layer.close(index);
				});  
			}
		}
		
		// 删除url
		function delUrl(){
			var b_id = $("#clickId").val()?$("#clickId").val():"";
			if(b_id){
				layer.confirm('您确定要删除这条记录吗?', {icon: 3, title:'提示'}, function(index){
					 $.ajax({
							url : "${ctxPath }/topic/ajax/delUrl",
							dataType : "json",
							type : "post",
							data:{"URL_ID":b_id},
							success : function(json) {
								if (json.result == '1') {
									layer.alert(json.resultInfo, function(index){
										//刷新表格，关闭弹窗
										searchForm();
										layer.close(index);
									});  
								} else {
									layer.alert(json.resultInfo,{icon: 2}, function(index){
										layer.close(index);
									});  
									return;
								}
						}});
				});
			}else{
				layer.alert("请选择一条记录！", {icon: 2}, function(index){
					layer.close(index);
				});  
			}
		}
		
		/* 搜索 查询 */
		function searchForm() {
			$("#clickId").val("");  //清除之前选中的id
			table.column(0).search($('#Q_URL_ID').val());
			table.column(1).search($('#Q_SERVICE_NAME').val());
			table.column(2).search($('#Q_SQL_ID').val());
			table.draw();
		}
    </script>
</body>
</html>