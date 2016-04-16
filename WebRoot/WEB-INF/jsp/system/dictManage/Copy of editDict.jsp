<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/jsp/formSubmit.jsp"></jsp:include>
</head>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.cms.common.utils.UserSessionBean"%>
<body class="gray-bg">
<form id="edit_dict_form" method="post" action="${ctxPath}/topic/ajax/editDict" class="form-horizontal" data-id="${param.pdataId}" callback="">
	<input type="hidden" id="edit_dict_type_tag" name="tag" value="${sessionScope.SESSION_USER_LOGIN_INFO.userInfo.TAG }"/>
	<input type="hidden" id="edit_dict_id" name="id" value="${responseDataForm.resultObj.dataList[0].ID}"/>
   <!-- 默认对应字典数据的类型和类型名称 -->
	<input type="hidden" id="edit_dict_type_hidden" name="type" value="${responseDataForm.resultObj.dataList[0].TYPE}"/>
	<input type="hidden" id="edit_dict_name_hidden" name="name" value="${responseDataForm.resultObj.dataList[0].NAME}"/>
	<div class="hr-line-dashed"></div>
    <div class="form-group">
        <label class="col-sm-2 control-label">编码：</label>
        <div class="col-sm-10">
            <input type="text" class="form-control required" id="code" name="code" value="${responseDataForm.resultObj.dataList[0].CODE}">
            <span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 必填项</span>
        </div>            
    </div>
    <div class="hr-line-dashed"></div>
    <div class="form-group">
        <label class="col-sm-2 control-label">编码对应文本：</label>
        <div class="col-sm-10">
            <input type="text" class="form-control required" id="text" name="text"  value="${responseDataForm.resultObj.dataList[0].TEXT}">
            <span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 必填项</span>
        </div>            
    </div>
    <div class="hr-line-dashed"></div>
    <div class="form-group">
        <label class="col-sm-2 control-label">排序：</label>
        <div class="col-sm-10">
            <input type="text" class="form-control" id="seq" name="seq"  value="${responseDataForm.resultObj.dataList[0].SEQ}">
        </div>            
    </div>
    <div class="hr-line-dashed"></div>
    <div class="form-group">
        <label class="col-sm-2 control-label">父类编码：</label>
        <div class="col-sm-10">
            <input type="text" class="form-control" id="parent_code" name="parent_code" value="${responseDataForm.resultObj.dataList[0].PARENT_CODE}">
        </div>            
    </div>
    <div class="form-group">
        <div class="col-sm-4 col-sm-offset-2">
           <button class="btn btn-primary" type="submit">提交</button>
           <button class="btn btn-white" type="button" onclick="closeeditDict()">取消</button> 
        </div>
    </div>
	<script type="text/javascript">
		/* 关闭当前页面 */
		function closeeditDict(){
			parent.layer.close(window.parent.index); 
		}
    </script>
</form>
</body>
</html>