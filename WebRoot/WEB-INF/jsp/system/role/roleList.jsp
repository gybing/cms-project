<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>角色管理列表页</title>
    <jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
    	<input type="hidden" id="clickId" />
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <!-- <h5>角色管理</h5> -->
                        <form class="form-inline" id="dispatchSearchForm">
                            <div class="form-group form-group-sm col-sm-3">
                                <label>角色名：</label>
								<input type="text" id="Q_ROLE_NAME" name="Q_ROLE_NAME" value="${param.Q_ROLE_NAME }" class="form-control">
                            </div>
                            <div class="form-group form-group-sm-7 ">
                                <button type="button" class="btn btn-sm btn-primary" onclick="searchForm();">查询</button>
                                <button type="button" class="btn btn-sm btn-primary " onclick="resetForm('dispatchSearchForm');">重置</button>
                            </div>
                        </form>
                    </div>
                    <div class="ibox-content">
                        <div class="form-group" id="toolbar" style=" float:left; padding: 5px 5px;">
                            <a  href="javascript:void(0);" class="btn btn-outline btn-default" onclick="addRole();"><i class="glyphicon glyphicon-plus"></i>新增角色</a>
                            <a  href="javascript:void(0);" class="btn btn-outline btn-default" onclick="editRole();"><i class="glyphicon glyphicon-edit"></i>修改角色</a>
                            <a  href="javascript:void(0);" class="btn btn-outline btn-default" onclick="delRole();"><i class="glyphicon glyphicon-remove"></i>删除角色</a>
                            <a  href="javascript:void(0);" class="btn btn-outline btn-default" onclick="assign_permissions();"><i class="glyphicon glyphicon-edit"></i>分配权限</a>
                        </div>
                        <table id="roleDataList" class="table table-striped table-bordered table-hover data-table ">
                            <thead>
                                <tr>
                                    <th width="200" title="角色名">角色名</th>
					                <th width="200" title="备注">备注</th>
					                <th width="" title="权限">权限</th>
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
      				{"mData" : "ROLE_NAME"},
      				{"mData" : "REMARK"},
      				{"mData" : "PNAME"}
      			];
    	// 设置哪些列不进行排序  哪些列需排序（需要改sql xml条件）[3,""],[4,""]
    	var aoColumnParam = [0] ,aaSortParam = [];
    	$(function(){
			// 加载列表信息 initTable(id,url,param,colsParam,aoColumnParam,aaSortParam,other); 
			// param Ajax请求时发送额外的数据(条件),colsParam 设置列属性条件,aoColumnParam 设置哪些列不排序  aaSortParam设置哪些列排序
        	table = initTableAutoHeight("roleDataList", "${ctxPath}/topic/page/toRoleListPage", null,cols,aoColumnParam,aaSortParam,"ROLE_ID",getScreen());
    	});
    	/* 新增角色 */
    	function addRole(){
			layer.open({
			    type: 2,
			    title : "新增角色",
			    area: ['800px', '430px'],
			    fix: false, //不固定
			   // maxmin: true,
			    content: "${ctxPath}/topic/addRolePage"
			});
		}
    	/* 修改角色信息 */
		function editRole(){
			var ROLE_ID =$("#clickId").val();
			if (isEmpty(ROLE_ID) || ROLE_ID == '') {
				swal("", "请选择一条信息进行修改!", "warning");
				return;
			}
			
			layer.open({
			    type: 2,
			    title : "修改角色",
			    area: ['800px', '430px'],
			    fix: false, //不固定
			   // maxmin: true,
			    content: "${ctxPath}/topic/editRolePage?ROLE_ID="+ROLE_ID
			});
			
		}
		function delRole(){
			var params = [];
			if(!isEmpty($("#clickId").val())) {
				params = [{ROLE_ID:$("#clickId").val()}];
			}
			
			/**
			 * 删除记录，支持批量删除（参数格式必须为数组） iUrl请求url iText提示的文本信息（只需关键字）
			 * params参数 数组eg:params = [{unid:"2"},{unid:"1"}] callBack回调函数
			 */
			delForm("${ctxPath}/topic/ajax/delRole","角色管理",params,searchForm);
		}
    	
		function searchForm() {
			//console.log($("#Q_ROLE_NAME").val());
			$("#clickId").val("");
			table.column(0).search($("#Q_ROLE_NAME").val());
			table.draw();
		}
		/* 分配权限 */
		function assign_permissions(){
			
			var ROLE_ID =$("#clickId").val();
			if (isEmpty(ROLE_ID) || ROLE_ID == '') {
				swal("", "请选择一条信息进行分配!", "warning");
				return;
			}
			
			index = layer.open({
			    type: 2,
			    title:"分配权限",
			    area: ['800px', '450px'],
			    fix: false, //不固定
			    maxmin: false,
			    content: '${ctxPath}/topic/toAssignPermissions?ROLE_ID='+$("#clickId").val()
			});
			
		}
		/**
		 * 获取屏幕高度
		 * */
		function getScreen()
		{
			var height = document.body.clientHeight;
			var ibox_title = $(".ibox-title").height();
			var toolbar = $("#toolbar").height();
			return height-94-ibox_title-50-toolbar;
		}
    </script>
</body>
