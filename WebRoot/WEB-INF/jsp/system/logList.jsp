<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.weimingfj.common.form.ResponseDataForm"%>
<%@ page import="com.weimingfj.common.cache.GlobalCache"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>日志列表页</title>
    <jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <!-- <h5>日志管理</h5> -->
                        <form class="form-horizontal" id="logSearchForm">
                        	<div class="form-group form-group-sm">
                        		<label class="col-sm-1 control-label">用户账号</label>
                                <div class="col-sm-1">
                                	<input type="text" placeholder="请输入关键词" id="USER_CODE" class="form-control">
                            	</div>
                            	<label class="col-sm-1 control-label">姓名</label>
                                <div class="col-sm-1">
                                	<input type="text" placeholder="请输入关键词" id="USER_NAME" class="form-control">
                                </div>
                            	<label class="col-sm-1 control-label">登录时间</label>
                                <div class="col-sm-6 form-horizontal" >
                                	<div class="col-sm-3">
                                	<input type="text" class="form-control layer-date laydate-icon" id="Q_BEGIN_TIME" placeholder="YYYY-MM-DD hh:mm:ss" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})">
                                	</div>
                                	<div class="col-sm-1" style="line-height: 30px;">
                                		至
                               		</div>
                                	<div class="col-sm-3">
                                		<input type="text" class="form-control layer-date laydate-icon" id="Q_END_TIME" placeholder="YYYY-MM-DD hh:mm:ss" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})">
                                	</div>
                                </div>
                               <div class="col-sm-1">
	                                <button type="button" class="btn btn-sm btn-primary" onclick="searchForm();">查询</button>
	                                <button type="button" class="btn btn-sm btn-primary" onclick="resetForm('logSearchForm');">重置</button>
                               </div>
                            </div>
                        </form>
                    </div>
                    <div class="ibox-content">
                        
                        <div class="form-group"></div>
                        <table id="logList" class="table table-striped table-bordered table-hover dataTables-example">
                            <thead>
                                <tr>
                                    <th width="">用户账号</th>
									<th width="">姓名</th>
									<th width="">登录IP</th>
									<th width="">登录时间</th>
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
    <script type="text/javascript">
    	var table,cols = [
      				{"mData" : "USER_CODE"},
      				{"mData" : "USER_NAME"},
      				{"mData" : "LOGIN_IP"},
      				{"mData" : "ADD_TIME"}
      			];
    	// 设置哪些列不进行排序  哪些列需排序（需要改sql xml条件）[3,""],[4,""]
    	var aoColumnParam = [] ,aaSortParam = [];
    	$(function(){
			// 加载列表信息 initTable(id,url,param,colsParam,aoColumnParam,aaSortParam,other); 
			// param Ajax请求时发送额外的数据(条件),colsParam 设置列属性条件,aoColumnParam 设置哪些列不排序  aaSortParam设置哪些列排序
        	table = initTableAutoHeight("logList", "${ctxPath }/topic/page/toLogManage", null,cols,aoColumnParam,aaSortParam,"USER_ID",getScreen());
        	// 全选 全不选  data-type
			//checkAll("dispatchCheckAll");
    	});
    	
		function searchForm() {
			
			table.column(0).search($("#USER_CODE").val());
			table.column(1).search($("#USER_NAME").val());
			table.column(2).search($("#Q_BEGIN_TIME").val());
			table.column(3).search($("#Q_END_TIME").val());
			table.draw();
		}
		/**
		 * 获取屏幕高度
		 * */
		function getScreen()
		{
			var height = document.body.clientHeight;
			var ibox_title = $(".ibox-title").height();
			/* var toolbar = $("#toolbar").height(); */
			return height-94-ibox_title-40;
		}
    </script>
</body>
</html>
