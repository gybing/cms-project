<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
</head>
<body class="gray-bg">
	<input type="hidden" id="PRIV_ID" />
	<input type="hidden" id="PARENT_PRIV_ID" />
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-3">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5 style="margin-left:10px">权限管理 </h5>
                    </div>
                    <div class="btn-menu" style="padding:5px 5px">
                    	<a class="btn btn-outline btn-default" href="#" onclick="addPriv();"><i class="glyphicon glyphicon-plus"></i> 新增权限</a>
	                    <a class="btn btn-outline btn-default" href="#" onclick="editPirv();"><i class="glyphicon glyphicon-edit"></i> 修改权限</a>
	                    <a class="btn btn-outline btn-default" href="#" onclick="delMenu();"><i class="glyphicon glyphicon-remove"></i> 删除权限</a>
                    </div>
                    <div class="ibox-content">
						<div id="sysMenuJstree"></div>
					</div>
                </div>
            </div>
            <div class="col-sm-9">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>URL信息</h5>
                    </div>
                    <div class="ibox-content" id="priv-content"></div>
                </div>
            </div>            
        </div>
    </div>
    <script>
    	$(document).ready(function(){
    		//加载菜单树
    		initJsTree("sysMenuJstree","${ctxPath}/topic/ajax/privTree",toEditMenuPage);
    		var obj=$("iframe[data-id='privManage']",parent.document);
        	$(obj).attr("scrolling","");
    	});

    	//重新加载刷新树
    	function refreshMenuTree(){
    		initJsTree("sysMenuJstree","${ctxPath}/topic/ajax/privTree",toEditMenuPage,$("#PARENT_PRIV_ID").val() == ''?'0':$("#PARENT_PRIV_ID").val());
    	}
    	
    	// 跳转至右边修改页面 PRIV_ID菜单id  PARENT_PRIV_ID 父菜单id
    	function toEditMenuPage(obj){
    		if(!isEmpty(obj.id)){
    			$("#PRIV_ID").val(obj.id);  //菜单id
        		$("#PARENT_PRIV_ID").val(obj.parent=='#'?'0':obj.parent);  //父菜单id
        		toDiv("${ctxPath}/topic/queryPrivUrl","priv-content",{Q_PRIV_ID : obj.id});
    		}
    	}
    	
    	// 编辑权限
    	function editPirv(){
    		var _pid = $("#PRIV_ID").val();
			if (_pid == '') {
				swal({
					type : "warning",
					title : "",
					text : "请选择对应权限！"
				});
				return;
			}
    		toDiv("${ctxPath}/topic/editPrivPage","priv-content",{id : _pid});
    	}
    	
    	
    	
    	//新增权限
    	function addPriv(){
    		var _pid = $("#PRIV_ID").val();
    		toDiv("${ctxPath}/topic/addPrivPage","priv-content",{id : _pid});
    	}
    	//删除菜单
    	function delMenu(){
			delForm("${ctxPath}/topic/ajax/privDel","权限",[{id : $("#PRIV_ID").val()}],refreshMenuTree);
			$("#priv-content").empty();
    	}
	</script>
</body>
</html>