<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>修改密码</title>
    <jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>修改密码</h5>
                    </div>
                    <div class="ibox-content widget-content nopadding">
						<form id="editUserPwdForm" method="post" action="${ctxPath}/topic/ajax/toEditPwd" class="form-horizontal">
							<input type="hidden" name="USER_ID" value="${SESSION_USER_LOGIN_INFO.userId }" />
							<div class="form-group">
						        <label class="col-sm-2 control-label">用户名：</label>
						        <div class="col-sm-10" style="padding-top: 7px;">${SESSION_USER_LOGIN_INFO.userCode }</div>
						    </div>
						    <div class="hr-line-dashed"></div>
						    <div class="form-group">
						        <label class="col-sm-2 control-label">姓名：</label>
						        <div class="col-sm-10" style="padding-top: 7px;">${SESSION_USER_LOGIN_INFO.userName }</div>
						    </div>
						    <div class="hr-line-dashed"></div>
						    <div class="form-group">
						        <label class="col-sm-2 control-label">旧密码：</label>
						        <div class="col-sm-10">
						        	<input type="password" class="required" id="OLD_PWD" name="OLD_PWD" minlength="6" maxlength="20" value=""/>				
						            <span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 必填项,字母、数字、下划线 6-20位</span>
						        </div>
						    </div>
						    <div class="hr-line-dashed"></div>
						    <div class="form-group">
						        <label class="col-sm-2 control-label">新密码：</label>
						        <div class="col-sm-10">
						        	<input type="password" class="required" id="USER_PWD" name="USER_PWD" minlength="6" maxlength="20" value=""/>				
						            <span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 必填项,字母、数字、下划线 6-20位</span>
						        </div>
						    </div>
						    <div class="hr-line-dashed"></div>
						    <div class="form-group">
						        <label class="col-sm-2 control-label">确认密码：</label>
						        <div class="col-sm-10">
						        	<input type="password" class="required" id="RE_PWD" name="RE_PWD" minlength="6" maxlength="20" value="" equalTo="#USER_PWD" field="ssss"/>				
						            <span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 必填项,字母、数字、下划线 6-20位</span>
						        </div>
						    </div>
						    <div class="form-group">
						        <div class="col-sm-4 col-sm-offset-2" style="margin-top: 10px;">
           							<button class="btn btn-primary" type="submit">提交</button>
						        </div>
						    </div>
						</form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
<script type="text/javascript">
$().ready(function() {
	//循环页面所有的校验表单
	$("#editUserPwdForm").validate({
		submitHandler : function(form) {
			console.log($(form).attr("action"));
			console.log($(form).serialize());
			$.ajax({
				type : "POST",
				url : $(form).attr("action"),
				data : $(form).serialize(),
				dataType : "json",
				async : false,
				success : function(json) {
					console.log(json);
					if (json.result == '1') {
						swal({
							title : "",
							text : json.resultInfo,
							type : "success",
							showCancelButton : false,
							confirmButtonColor : "#A7D5EA",
							confirmButtonText : "确定",
							closeOnConfirm : false
						}, function() {
							window.location.href = "${ctxPath}/topic/bsm$logout";
						});
					}
				},
				error : function(json) {
					swal("", json.responseText, "error");
				}
			});
			return false;
		}
	});
});
</script>
</html>