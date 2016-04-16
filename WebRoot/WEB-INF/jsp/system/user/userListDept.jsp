<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<title>部门管理</title>
	<script type="text/javascript">
	jQuery(function($) {
		$.ajax({
		    type: "POST",
		    url: "${ctxPath}/topic/ajax/cpwb$deptTree",
		    dataType:"json",
		    async:false,
			success: function(json){
				$("#left",$.pdialog.getCurrent()).html(getTree(json.resultObj,0).replaceAll("<ul></ul>",""));
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
// 	       alert(data[i].DEPT_NAME);
	            tree +="<li><a href='javascript:void(0)' onclick='$.bringBack({id:\""+data[i].DEPT_ID+"\", name:\""+data[i].DEPT_NAME+"\"})'>"+data[i].DEPT_NAME+"</a>";
	            tree += getTree(data,data[i].DEPT_ID);
	            tree += "</li>";
	            //tree+="<a class='btnSelect' href='javascript:$.bringBack({id:data[i].DEPT_ID, name:data[i].DEPT_NAME})' title='查找带回'>选择</a>";
	            //tree +="<li><a class='btnSelect' href='javascript:$.bringBack({id:"+data[i].DEPT_ID", name:"+data[i].DEPT_NAME"})'>"+data[i].DEPT_NAME+"</a>";
	        }
	        
	    }
		
	    return tree+"</ul>";
	}

//	function getInfo(obj, _deptId){
//		$("#SEL_DEPT_ID").val(_deptId);
	//	$("#SEL_F_DEPT_ID").val(_deptId);
//	}

	</script>
</head>
<body>

<div class="pageContent">
	
	<!-- 部门树 -->
	<div class="accordionContent tree" id="left" layoutH="56">
	</div>

</div>

</body>
</html>