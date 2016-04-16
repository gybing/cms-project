<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
<%-- <jsp:include page="/WEB-INF/jsp/formSubmit.jsp"></jsp:include> --%>
<title>新增字典表数据</title>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<form id="edit_dict_info_form" method="post" action="#" data-id="" callback="" class="form-horizontal">
		<input type="hidden" name="id" value="${param.id }"/>
			<div class="ibox">
				<div class="ibox-content">
					<div class="panel panel-default" style="margin-top: 5px;">
						<div class="panel-heading" style="padding: 5px">
							<span style="font-weight: bold;">数据类型信息</span>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label class="col-sm-1 control-label">数据类型:</label>
								<div class="col-sm-3">
		                    		<input id="type" name="type" value="${responseDataForm.resultObj.TYPE }" readonly maxlength="14" type="text" class="required" aria-required="true" />
								</div>
								<label class="col-sm-1 control-label">类型名称:</label>
								<div class="col-sm-3">
		                    		<input id="name" name="name" value="${responseDataForm.resultObj.NAME }" readonly maxlength="14" type="text" class="required" aria-required="true" />
								</div>
							</div>
						</div>
					</div>
					<div class="panel panel-default" style="margin-top: 5px;">
						<div class="panel-heading" style="padding: 5px">
							<span style="font-weight: bold;">数据具体信息</span>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label class="col-sm-1 control-label">编码:</label>
								<div class="col-sm-3">
									<input id="code" name="code" value="${responseDataForm.resultObj.CODE }" maxlength="14" type="text" aria-required="true" />
									<span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 必填项</span>
								</div>
								<label class="col-sm-1 control-label">对应文本:</label>
								<div class="col-sm-3">
									<input id="text" name="text" value="${responseDataForm.resultObj.TEXT }" maxlength="14" type="text" aria-required="true" />
									<span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 必填项</span>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-1 control-label">排序编码:</label>
								<div class="col-sm-3">
									<input id="seq" name="seq" value="${responseDataForm.resultObj.SEQ }" maxlength="14" type="text" aria-required="true" />
								</div>
								<label class="col-sm-1 control-label">父类编码:</label>
								<div class="col-sm-3">
									<input id="parent_code" name="parent_code" value="${responseDataForm.resultObj.PARENT_CODE }" maxlength="14" type="text" aria-required="true" />
								</div>
							</div>
						</div>
					</div>
					<div class="form-group" style="margin-top:20px;margin-right:-7px;">
						<div class="col-sm-1" style="float:right">
                    		<button type="button" class="btn btn-default" onclick="cancelLayer()"><i class="glyphicon glyphicon-remove"></i>取消</button>
						</div>
						<div class="col-sm-1" style="float:right">
                    		<button type="submit" class="btn btn-primary"><i class="glyphicon glyphicon-ok"></i>保存</button>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
</body>
<script type="text/javascript">
$(function() {
	$("#edit_dict_info_form").validate({
		submitHandler : function(form) {
			$.ajax({
				url : "${ctxPath }/topic/ajax/editDict",
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
}); 
</script>
</html>