<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
</head>
<body class="gray-bg">
	<input type="hidden" id="DICT_ID" />
	<input type="hidden" id="PARENT_DICT_ID" />
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-3">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5 style="margin-left:5px">字典表类型管理 </h5>
                    </div>
                    <div class="btn-menu" style="padding:5px 5px">
                    	<button type="button" class="btn btn-outline btn-default" onclick="addDictType()"> <i class="glyphicon glyphicon-edit"></i> 新增类型</button>
                    </div>
                    <div class="ibox-content">
						<div id="sysDictJstree"></div>
					</div>
                </div>
            </div>
            <div class="col-sm-9">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>字典数据</h5>
                    </div>
                    <div class="ibox-content" id="dict-content"></div>
                </div>
            </div>            
        </div>
    </div>
    <script>
    	$(document).ready(function(){
    		//加载菜单树
    		initJsTree("sysDictJstree","${ctxPath}/topic/ajax/getDictType",toDictDetailPage);
    	});

    	//重新加载刷新树
    	function refreshDictTree(){
    		initJsTree("sysDictJstree","${ctxPath}/topic/ajax/getDictType",toDictDetailPage,$("#PARENT_DICT_ID").val() == ''?'0':$("#PARENT_DICT_ID").val());
    	}
    	 
    	// 跳转至右边修改页面 DICT_ID菜单id  PARENT_DICT_ID 父菜单id
    	function toDictDetailPage(obj){
    		if($("#DICT_ID").val()==obj.id){
    			return;
    		}
    		if(!isEmpty(obj.id)){
    			$("#DICT_ID").val(obj.id);  //菜单id
        		$("#PARENT_DICT_ID").val(obj.parent=='#'?'0':obj.parent);  //父菜单id
        		toDiv("${ctxPath}/topic/toDictDetail","dict-content",{DICT_TYPE : obj.id});
    		}
    	}
    	/* 新增字典类型 */
    	function addDictType(){
      		var _dict_type = $("#DICT_ID").val();
      		toDiv("${ctxPath}/topic/toAddDictType","dict-content",{DICT_TYPE : _dict_type});
    	}
	</script>
</body>
</html>