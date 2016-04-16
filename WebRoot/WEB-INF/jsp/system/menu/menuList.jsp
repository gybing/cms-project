<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
</head>
<body class="gray-bg">
	<input type="hidden" id="MENU_ID" />
	<input type="hidden" id="PARENT_MENU_ID" />
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-4">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5 style="margin-left:5px;">系统菜单管理 </h5>
                    </div>
                    <div class="btn-menu" style="padding:5px 5px;">
                    	<a class="btn btn-outline btn-default" href="#" onclick="addpMenu();"><i class="glyphicon glyphicon-plus"></i> 菜单目录</a>
	                    <a class="btn btn-outline btn-default" href="#" onclick="addMenu();"><i class="glyphicon glyphicon-plus"></i> 添加菜单</a>
	                    <a class="btn btn-outline btn-default" href="#" onclick="delMenu();"><i class="glyphicon glyphicon-remove"></i> 删除菜单</a>
                    </div>
                    <div class="ibox-content">
						<div id="sysMenuJstree"></div>
					</div>
                </div>
            </div>
            <div class="col-sm-8">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>菜单信息</h5>
                    </div>
                    <div class="ibox-content" id="menu-content"></div>
                </div>
            </div>            
        </div>
    </div>
    <script>
    	$(document).ready(function(){
    		//加载菜单树
    		initJsTree("sysMenuJstree","${ctxPath}/topic/ajax/menuTree",toEditMenuPage);
    		var obj=$("iframe[data-id='toMenuListPage']",parent.document);
        	$(obj).attr("scrolling","");
    	});

    	//重新加载刷新树
    	function refreshMenuTree(){
    		initJsTree("sysMenuJstree","${ctxPath}/topic/ajax/menuTree",toEditMenuPage,$("#PARENT_MENU_ID").val() == ''?'0':$("#PARENT_MENU_ID").val());
    	}
    	
    	// 跳转至右边修改页面 MENU_ID菜单id  PARENT_MENU_ID 父菜单id
    	function toEditMenuPage(obj){
    		if(!isEmpty(obj.id)){
    			$("#MENU_ID").val(obj.id);  //菜单id
        		$("#PARENT_MENU_ID").val(obj.parent=='#'?'0':obj.parent);  //父菜单id
        		toDiv("${ctxPath}/topic/editMenuPage","menu-content",{MENU_ID : obj.id});
    		}
    	}
    	
    	//新增主菜单
    	function addpMenu(){
    		toDiv("${ctxPath}/topic/addPmenuPage","menu-content",null);
    	}
    	//新增子菜单
    	function addMenu(){
    		var _pid = $("#MENU_ID").val();
			if (_pid == '') {
				swal({
					type : "warning",
					title : "",
					text : "请选择上级菜单！"
				});
				return;
			}
    		toDiv("${ctxPath}/topic/addMenuPage","menu-content",{MENU_ID : _pid});
    	}
    	//删除菜单
    	function delMenu(){
			delForm("${ctxPath}/topic/ajax/delMenu","菜单",[{MENU_ID : $("#MENU_ID").val()}],refreshMenuTree);
			$("#menu-content").empty();
    	}
	</script>
</body>
</html>