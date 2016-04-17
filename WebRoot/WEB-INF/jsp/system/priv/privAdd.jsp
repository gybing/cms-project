<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
</head>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<body class="gray-bg">
<form id="menuInfoAddForm" method="post" action="" class="form-horizontal">
    <input type="hidden" id="PID" name="PID" <c:if test="${param.id eq '' }">value="0"</c:if><c:if test="${param.id ne '' }">value="${param.id }"</c:if>  />
	<div class="form-group">
       <label class="col-sm-2 control-label">所属目录</label>
       <div class="col-sm-10">
           <input type="text" class="form-control" id="PNAME" name="PNAME" <c:if test="${param.id ne '' }"> readonly="readonly"</c:if>  <c:if test="${responseDataForm.resultObj.PNAME eq '' }">value="${responseDataForm.resultObj.NAME}"</c:if><c:if test="${responseDataForm.resultObj.PNAME ne '' }">value="${responseDataForm.resultObj.PNAME}"</c:if>  placeholder="上级菜单名称">
       </div>
    </div>
    <div class="hr-line-dashed"></div>
    <div class="form-group">
        <label class="col-sm-2 control-label">权限名称</label>
        <div class="col-sm-10">
            <input type="text" class="form-control required" minlength="2" id="PRIV_NAME" name="PRIV_NAME">
            <span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 必填项</span>
        </div>            
    </div>
    <div class="hr-line-dashed"></div>
    <div class="form-group">
        <label class="col-sm-2 control-label">权限类型</label>
        <div class="col-sm-10">
            <div class="radio i-checks">
		        <label><input type="radio" checked value="Y" name="IS_FOLDER"> <i></i> 子节点</label>
		        <label><input type="radio" value="N" name="IS_FOLDER"> <i></i> 目录</label>
		    </div>
        </div>
    </div>
    <div class="hr-line-dashed"></div>
    <div class="form-group">
        <label class="col-sm-2 control-label">备注</label>
        <div class="col-sm-10">
            <textarea id="A_REMARK" name="REMARK" class="form-control"></textarea>
        </div>
    </div>    
    <div class="form-group">
        <div class="col-sm-4 col-sm-offset-2">
           <button class="btn btn-primary" type="submit">提交</button>
           <!-- <button class="btn btn-white" type="submit">取消</button> -->
        </div>
    </div>
	<script type="text/javascript">
		$().ready(function() {
			$("#menuInfoAddForm").validate({
				submitHandler : function(form) {
					$.ajax({
						url : "${ctxPath }/topic/ajax/privAdd",
						dataType : "json",
						data : $(form).serialize(),
						type : "post",
						success : function(json) {
							if (json.result == '1') {
								layer.alert(json.resultInfo, function(index){
									//刷新表格，关闭弹窗
									refreshMenuTree();
// 									parent.layer.close(parent.layer.getFrameIndex(window.name));
									layer.close(index);
								});  
							} else {
								layer.alert(json.resultInfo,{icon: 2}, function(index){
									//刷新表格，关闭弹窗
									layer.close(index);
								});  
								return;
							}
					}});
					
				}
			});
		});
    </script>
</form>
</body>
</html>