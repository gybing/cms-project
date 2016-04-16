<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>人员管理列表页</title>
    <jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
    	<input type="hidden" id="clickId" />
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <!-- <h5>人员管理</h5> -->
                        <form class="form-inline" id="userSearchForm">
                            <div class="form-group form-group-sm col-sm-3">
                                <label>姓名：</label>
                                <input type="text" id="Q_User_NAME" class="form-control" value="${param.Q_User_NAME }">
                            </div>
                            <div class="form-group form-group-sm col-sm-3">
                                <label>电话：</label>
                                <input type="text" id="Q_User_TEL" class="form-control" value="${param.Q_User_TEL }">
                            </div>
                            <div class="form-group form-group-sm col-sm-2">
                                <label>帐号状态：</label>
                                <select id="Q_User_STATUS" class="form-control">
									<option value="" >全部</option>
									<option value="0" <c:if test="${param.isDisabled eq '0'}">selected="selected"</c:if>>失效</option>
									<option value="1" <c:if test="${param.isDisabled eq '1'}">selected="selected"</c:if>>生效</option>
								</select>
                            </div>
                            <div class="form-group form-group-sm-7 ">
                                <button type="button" class="btn btn-sm btn-primary" onclick="searchForm();">查询</button>
                                <button type="button" class="btn btn-sm btn-primary " onclick="resetForm('userSearchForm');">重置</button>
                            </div>
                        </form>
                    </div>
                    <div class="ibox-content">
                        <div class="form-group" id="toolbar" style=" float:left; padding: 5px 5px;">
                            <a  href="javascript:void(0);" class="btn btn-outline btn-default" onclick="addUser();"><i class="glyphicon glyphicon-plus"></i>新增人员</a>
                            <a  href="javascript:void(0);" class="btn btn-outline btn-default" onclick="editUser();"><i class="glyphicon glyphicon-edit"></i>修改人员</a>
                            <a  href="javascript:void(0);" class="btn btn-outline btn-default" onclick="deluser();"><i class="glyphicon glyphicon-remove"></i>删除人员</a>
                            <a  href="javascript:void(0);" class="btn btn-outline btn-default" onclick="showts();"><i class="glyphicon glyphicon-edit"></i>重置密码</a>
                            <a  href="javascript:void(0);" class="btn btn-outline btn-default" onclick="beEffective();"><i class="glyphicon glyphicon-edit"></i>生效</a>
                            <a  href="javascript:void(0);" class="btn btn-outline btn-default" onclick="beInvalid();"><i class="glyphicon glyphicon-edit"></i>失效</a>
                            <a  href="javascript:void(0);" class="btn btn-outline btn-default" onclick="distributeRole();"><i class="glyphicon glyphicon-edit"></i>分配角色</a>
                        </div>
                        <table id="UserDataList" class="table table-striped table-bordered table-hover data-table ">
                            <thead>
                                <tr>
                                    <th width="100" title="用户名">用户帐号</th>
					                <th width="100" title="姓名">姓名</th>
					                <th width="110" title="电话">电话</th>
					                <th width="110" title="公司">公司</th>
					                <th width="120" title="所属部门">所属部门</th>
					                <th width="120" title="生失效">生失效</th>
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
      				{"mData" : "TEL"},
      				{"mData" : "COMPANY"},
      				{"mData" : "DEPARTMENT"},
      				{"mData" : "IS_DISABLED"}
      			];
    	// 设置哪些列不进行排序  哪些列需排序（需要改sql xml条件）[3,""],[4,""]
    	var aoColumnParam = [0] ,aaSortParam = [];
    	$(function(){
			// 加载列表信息 initTable(id,url,param,colsParam,aoColumnParam,aaSortParam,other); 
			// param Ajax请求时发送额外的数据(条件),colsParam 设置列属性条件,aoColumnParam 设置哪些列不排序  aaSortParam设置哪些列排序
        	table = initTableAutoHeight("UserDataList", "${ctxPath}/topic/page/toManagerList", null,cols,aoColumnParam,aaSortParam,"USER_ID",getScreen());
    	});
    	/* 新增人员 */
    	function addUser(){
			indexToPage("${ctxPath}/topic/addManagerPage","新增人员");
// 			layer.open({
// 			    type: 2,
// 			    title : "新增人员",
// 			    area: ['800px', '530px'],
// 			    fix: false, //不固定
// 			   maxmin: true,
// 			    content: "${ctxPath}/topic/addManagerPage"
// 			});
		}
		function editUser(){
			
			var USER_ID =$("#clickId").val();
			if (isEmpty(USER_ID) || USER_ID == '') {
				swal("", "请选择一条信息进行修改!", "warning");
				return;
			}
			
			layer.open({
			    type: 2,
			    title : "修改人员",
			    area: ['800px', '430px'],
			    fix: false, //不固定
			   // maxmin: true,
			    content: "${ctxPath}/topic/editManagePage?USER_ID="+USER_ID
			});
			
		}
		function deluser(){
			var params = [];
			if(!isEmpty($("#clickId").val())) {
				params = [{USER_ID:$("#clickId").val()}];
			} else {
				$("input[data-type='userCheck']:checked").each(function(i) {
			    	if(this.checked == true){
			    		params[i] = {USER_ID:$(this).val()};
			    	}
			    });
			}
			
			/**
			 * 删除记录，支持批量删除（参数格式必须为数组） iUrl请求url iText提示的文本信息（只需关键字）
			 * params参数 数组eg:params = [{unid:"2"},{unid:"1"}] callBack回调函数
			 */
			delForm("${ctxPath}/topic/ajax/delManage","人员管理",params,searchForm);
		}
    	
		function searchForm() {
			$("#clickId").val("");
			table.column(0).search($("#Q_User_STATUS").val());
			table.column(1).search($("#Q_User_NAME").val());
			table.column(2).search($("#Q_User_TEL").val());
			table.draw();
		}
		/* 重置密码 */
		function showts(){
			var param = [{USER_ID:$("#clickId").val()}];
			var sLength = param.length;
			if (isEmpty(param) || sLength == 0 || param[0] == '' || sLength > 1) {
				swal("", "请选择一条信息进行修改!", "warning");
				return;
			}
			
			swal({
				title : "您确定要重置该密码吗?",
				type : "warning",
				showCancelButton : true,
				confirmButtonColor : "#DD6B55",
				confirmButtonText : "确定",
				cancelButtonText : "取消",
				closeOnConfirm : false
			}, function() {
				$.ajax({
					type:"POST",
					url:"${ctxPath}/topic/ajax/resetManagePwd",
					data : param[0],
					dataType:"json",
					async:false,
					success:function(data){
						data=data.result;
						if(data=='1'){
							swal("操作成功！","密码修改成功,新密码为123456");
						}
						
					}
				});	
			});
		}
		/* 生效 */
		function beEffective(){
			var param = [{USER_ID:$("#clickId").val()}];
			var sLength = param.length,ok =false,msg="";
			if (isEmpty(param) || sLength == 0 || param[0] == '' || sLength > 1) {
				swal("", "请选择一条信息进行修改!", "warning");
				return;
			}
			
			swal({
				title : "确定要将该用户置为生效吗",
				type : "warning",
				showCancelButton : true,
				confirmButtonColor : "#DD6B55",
				confirmButtonText : "确定",
				cancelButtonText : "取消",
				closeOnConfirm : false
			}, function() {
				$.ajax({
					type : "POST", // 提交的类型 
					url : "${ctxPath }/topic/ajax/beEffective", // 提交地址 
					data : param[0], // 参数 
					dataType : "json",
					async : false,
					success : function(json) {
						if(json.result == '1'){
							ok = true;
						}else{
							msg = ""+json.resultInfo;
							ok = false;
						}
					},
					error : function(data) {
						msg = "请求异常！";
						ok = false;
					}
				});
				if(ok){
					searchForm();
					swal("操作成功！","已将该用户置为生效");
				}else{
					swal("", msg, "error");
				}
				// 执行回调函数
				if (callBack!=null && callBack != ""){
					callBack();
				}
			});
			
		}
		/* 失效 */
		function beInvalid(){
			var param = [{USER_ID:$("#clickId").val()}];
			var sLength = param.length,ok =false,msg="";
			if (isEmpty(param) || sLength == 0 || param[0] == '' || sLength > 1) {
				swal("", "请选择一条信息进行修改!", "warning");
				return;
			}
			
			swal({
				title : "确定要将该用户置为失效吗",
				type : "warning",
				showCancelButton : true,
				confirmButtonColor : "#DD6B55",
				confirmButtonText : "确定",
				cancelButtonText : "取消",
				closeOnConfirm : false
			}, function() {
				$.ajax({
					type : "POST", // 提交的类型 
					url : "${ctxPath }/topic/ajax/beInvalid", // 提交地址 
					data : param[0], // 参数 
					dataType : "json",
					async : false,
					success : function(json) {
						if(json.result == '1'){
							ok = true;
						}else{
							msg = ""+json.resultInfo;
							ok = false;
						}
					},
					error : function(data) {
						msg = "请求异常！";
						ok = false;
					}
				});
				if(ok){
					searchForm();
					swal("操作成功！","已将该用户置为失效");			
				}else{
					swal("", msg, "error");
				}
				// 执行回调函数
				if (callBack!=null && callBack != ""){
					callBack();
				}
			});
			
		}
		/* 分配角色 */
		function distributeRole(){
			var param = [{USER_ID:$("#clickId").val()}];
			//console.log(param[0].USER_ID);
			var sLength = param.length;
			if (isEmpty(param) || sLength == 0 || param[0] == '' || sLength > 1) {
				swal("", "请选择一条信息进行分配!", "warning");
				return;
			}
			
			index = layer.open({
			    type: 2,
			    title:"分配角色",
			    area: ['800px', '450px'],
			    fix: false, //不固定
			    maxmin: false,
			    content: '${ctxPath}/topic/toAssignRolePage?USER_ID='+param[0].USER_ID
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
			return height-94-ibox_title-40-toolbar;
		}
    </script>
</body>