<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>部门管理</title>
	<script type="text/javascript">
	jQuery(function($) {
		$.ajax({
		    type: "POST",
		    url: "${ctxPath}/topic/ajax/cpwb$deptTree",
		    dataType:"json",
		    async:false,
			success: function(json){
				$("#left").html(getTree(json.resultObj,0).replaceAll("<ul></ul>",""));
			}
		});  
	});
	
	//获取部门树数据
	function getTree(data, pId){
		var tree;
		if(pId==0){
			tree = "<ul class='tree treeFolder'>";
		} else {
			tree = "<ul>";
		}
		for(var i in data){
	        if(data[i].F_DEPT_ID == pId){
	            tree += "<li><a href='javascript:void(0);' onclick='getInfo(this,\""+data[i].DEPT_ID+"\");'>"+data[i].DEPT_NAME+"</a>";
	            tree += getTree(data,data[i].DEPT_ID);
	            tree += "</li>";
	        }
	    }
	    return tree+"</ul>";
	}

	function getInfo(obj, _deptId){
		$("#SEL_DEPT_ID").val(_deptId);
		$("#SEL_F_DEPT_ID").val(_deptId);
	}
	
	</script>
</head>
<body>

<div class="pageContent">
	
	<!-- 操作按钮 -->
	<div class="panelBar" >
		<ul class="toolBar" >
			<li><a class="add" href="${ctxPath}/topic/cpwb$addDeptPage?P_DEPT_ID={SEL_F_DEPT_ID}" target="dialog" rel="addDeptPage" width="560" height="300" mask="true" title="新增部门" warn="请选择直属部门" ><span>新增部门</span></a></li>
				<li class="line">line</li>
			<li><a class="edit" href="${ctxPath}/topic/cpwb$editDeptPage?DEPT_ID={SEL_DEPT_ID}" target="dialog" rel="editDept" width="560" height="300" mask="true" title="修改部门" warn="请选择部门"><span>修改部门</span></a></li>
				<li class="line">line</li>
			<li><a class="delete" href="${ctxPath}/topic/ajax/cpwb$delDept?DEPT_ID={SEL_DEPT_ID}" target="ajaxTodo" title="确定要删除吗?" callback="customNavTabAjaxDone"><span>删除部门</span></a></li>
		</ul>
	</div>
	
	<!-- 部门树 -->
	<div class="accordionContent tree" id="left" layoutH="56">
	</div>
	<input type="hidden" id="SEL_F_DEPT_ID" value="0"/>
	<input type="hidden" id="SEL_DEPT_ID" />
	<input type="hidden" id="navTabId" value="cpwb$toDeptListPage"/>
</div>

</body>
</html>