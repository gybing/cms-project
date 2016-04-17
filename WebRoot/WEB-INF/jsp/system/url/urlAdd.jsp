<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>新增URL</title>
    <jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content widget-content nopadding">
						<form id="urlInfoAddForm" method="post" action="#" data-id="" callback="" class="form-horizontal">
							<input type="hidden" id="PRIV_ID" name="PRIV_ID" value="" />
							<div class="form-group">
						        <label class="col-sm-2 control-label">URL标识：</label>
						        <div class="col-sm-4">
						            <input type="text" class="form-control required" id="A_URL_ID" name="URL_ID" maxlength="30" value=""/>
						        	<span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 必填项</span>
						        </div>
						        <label class="col-sm-2 control-label">URL路径：</label>
						        <div class="col-sm-4">
						        	<input type="text" class="form-control required" id="A_FULL_URL" name="FULL_URL" maxlength="200" value=""/>				
						            <span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 必填项</span>
						        </div>
						    </div>
						    <div class="form-group">
						        <label class="col-sm-2 control-label">URL标题：</label>
						        <div class="col-sm-4">			
						            <input type="text" class="form-control required" id="A_TITLE" name="TITLE" maxlength="200" value=""/>
						    		<span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 必填项</span>
						        </div>
						        <label class="col-sm-2 control-label">服务类名：</label>
						        <div class="col-sm-4">			
						            <input type="text" class="form-control" id="A_SERVICE_NAME" name="SERVICE_NAME" maxlength="200" value=""/>
						        </div>
						    </div>
						    <div class="form-group">
						        <label class="col-sm-2 control-label">跳转页面：</label>
						        <div class="col-sm-4">			
						            <input type="text" class="form-control" id="A_PAGE" name="PAGE" maxlength="200" value=""/>
						        </div>
						        <label class="col-sm-2 control-label">执行SQL：</label>
						        <div class="col-sm-4">			
						            <input type="text" class="form-control" id="A_SQL_ID" name="SQL_ID" maxlength="50" value=""/>
						        </div>
						    </div>
						    <div class="form-group">
						        <label class="col-sm-2 control-label">验证SQL：</label>
						        <div class="col-sm-4">			
						            <input type="text" class="form-control" id="A_VALIDATION_ID" name="VALIDATION_ID" maxlength="50" value=""/>
						        </div>
						        <label class="col-sm-2 control-label">描述：</label>
						        <div class="col-sm-4">
						            <input type="text" class="form-control" id="A_REMARK" name="REMARK" value=""/>
						              <!-- <textarea id="A_REMARK" name="REMARK" class="form-control"></textarea> -->
						        </div>
						    </div>
						    <div class="form-group">
						        <div class="col-sm-1  col-sm-offset-5">
           							<button class="btn btn-primary" type="submit">提交</button>
						        </div>
						        <div class="col-sm-1">
           							<button class="btn btn-default" type="button" onclick="cancelLayer()">取消</button>
						        </div>
						    </div>
						</form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
    $("#urlInfoAddForm").validate({
		submitHandler : function(form) {
			$.ajax({
				url : "${ctxPath}/topic/ajax/addUrl",
				dataType : "json",
				data : $(form).serialize(),
				type : "post",
				success : function(json) {
					if (json.result == '1') {
						layer.alert(json.resultInfo, function(index){
							//刷新表格，关闭弹窗
							parent.searchForm();
							parent.layer.close(parent.layer.getFrameIndex(window.name));
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
    </script>
</body>
</html>