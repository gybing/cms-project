<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
</head>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.cms.common.utils.UserSessionBean"%>
<body class="gray-bg">
<form id="add_dict_type_form" method="post" action="" class="form-horizontal">
	<input type="hidden" id="add_dict_type_tag" name="tag" value="${sessionScope.SESSION_USER_LOGIN_INFO.userInfo.TAG }"/>
    <div class="form-group">
        <label class="col-sm-2 control-label">数据类型：</label>
        <div class="col-sm-10">
            <input type="text" class="form-control required" minlength="2" id="type" name="type">
            <span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 必填项</span>
        </div>            
    </div>
    <div class="hr-line-dashed"></div>
    <div class="form-group">
        <label class="col-sm-2 control-label">类型名称：</label>
        <div class="col-sm-10">
            <input type="text" class="form-control required" minlength="2" id="name" name="name">
            <span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 必填项</span>
        </div>            
    </div>
    <div class="hr-line-dashed"></div>
    <div class="form-group">
        <label class="col-sm-2 control-label">编码：</label>
        <div class="col-sm-10">
            <input type="text" class="form-control required" minlength="2" id="code" name="code">
            <span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 必填项</span>
        </div>            
    </div>
    <div class="hr-line-dashed"></div>
    <div class="form-group">
        <label class="col-sm-2 control-label">编码对应文本：</label>
        <div class="col-sm-10">
            <input type="text" class="form-control required" minlength="2" id="text" name="text">
            <span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 必填项</span>
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
			$("#add_dict_type_form").validate({
				submitHandler : function(form) {
					/**
					 * From表单提交（主要用于添加、修改）
					 * @param form表单  fullUrlAjax提交url  pdataId 需要重新加载的页面data_id  callBack回调js
					 */
					toSubmit(form, "${ctxPath}/topic/ajax/addDictType",null,refreshDictTree);
				}
			});
		});
    </script>
</form>
</body>
</html>