<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>列表页</title>
    <jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
</head>

<body class="">
    <div class="wrapper wrapper-content animated fadeInRight">
    	<input type="hidden" id="clickId" />
    	<input type="hidden" name="USER_ID" value="${param.USER_ID }"/>
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>分配角色</h5>
                    </div>
                    <div class="ibox-content">
                        <table id="roleDataList" class="table table-striped table-bordered table-hover data-table ">
                            <thead>
                                <tr>
                                    <th width="20"><input type="checkbox" group="ids" data-type="assignRoleCheckAll"></th>
					                <th width="200" title="角色名">角色名</th>
					                <th width="" title="权限">权限</th>
					                <th width="100" title="备注">备注</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
				        <div  id = "form_foot_tool" style="float: right ;padding-right: 20px;padding-bottom: 10px">
				             	<button onclick="saveRole();" class="btn btn-primary" >保存</button>&nbsp;&nbsp;
				             	<button onclick="cancel();" class="btn btn-default" >取消</button>&nbsp;&nbsp;
				     	</div>
                        
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
    	var table,cols = [
					{
						"mData":"ROLE_ID",
						"mRender": function (data, type, full) {
						
							var html = "<input type=\"checkbox\" class=\"i-checks\" data-type=\"assignRoleCheck\" value=\""+ data +"\"";
							if(full.BE_ASSIGN == 'Y'){
								html += " checked=\"checked\" ";
							}
							
							html += ">";
							return html;
						}
					},
      				{"mData" : "ROLE_NAME"},
      				{"mData" : "PNAME"},
      				{"mData" : "REMARK"}
      			];
    	// 设置哪些列不进行排序  哪些列需排序（需要改sql xml条件）[3,""],[4,""]
    	var aoColumnParam = [0] ,aaSortParam = [];
    	$(function(){
    		//console.log("dddddddddddddd");
			// 加载列表信息 initTable(id,url,param,colsParam,aoColumnParam,aaSortParam,other); 
			// param Ajax请求时发送额外的数据(条件),colsParam 设置列属性条件,aoColumnParam 设置哪些列不排序  aaSortParam设置哪些列排序
        	table = initTable("roleDataList", "${ctxPath}/topic/page/toAssignRole?USER_ID=${param.USER_ID}", null,cols,aoColumnParam,aaSortParam,"ROLE_ID");
        	
			// 全选 全不选  data-type
			checkAll("assignRoleCheckAll");
		});
    	
		function searchForm() {
			//console.log($("#SEARCH_TYPE").val());
			$("#clickId").val("");
			/* table.column(0).search($("#SEARCH_TYPE").val());
			table.column(1).search($("#SEARCH_KEY").val()); */
			table.draw();
		}
		/* 分配角色 */
		function saveRole(){
			var roleIds = "";
			$("input[data-type='assignRoleCheck']:checked").each(function(i) {
		    	if(this.checked == true){
		    		roleIds += $(this).val() + ",";
		    	}
		    });
			
			if(roleIds == ""){
				swal("","请选择要分配的角色！！", "warning");
				return;
			}
			
			$.ajax({
				type : "POST", // 提交的类型 
				url : "${ctxPath}/topic/ajax/assignRole", // 提交地址 
				data : {"userId":'${param.USER_ID}',"roleIds":roleIds}, // 参数 
				success : function(data) { //回调方法 
					swal({
						title : "操作成功！",
						type : "success",
						showCancelButton : false,
						confirmButtonColor : "#A7D5EA",
						confirmButtonText : "确定",
						closeOnConfirm : false
					}, function() {
						parent.layer.close(window.parent.index); 
					});
				},
				error : function(data) {
					swal("", "请求异常！", "error");
				}
			});
		}
		/* 关闭layer */
		function cancel(){
			parent.layer.close(window.parent.index); 
		}
		
    </script>
</body>
