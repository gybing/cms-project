<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
<form id="menuInfoEditForm" method="post" action="" class="form-horizontal">
    <input type="hidden" id="E_MENU_ID" name="MENU_ID" value="${param.MENU_ID }" />
	<input type="hidden" id="A_PARENT_MENU_ID" name="PARENT_MENU_ID" value="${responseDataForm.resultObj.PARENT_MENU_ID }"/>
	<input type="hidden" id="A_MENU_CODE" name="MENU_CODE" />
	<input type="hidden" id="A_MENU_TYPE" name="MENU_TYPE" value="${responseDataForm.resultObj.MENU_TYPE }"/>			
	<div class="form-group">
        <label class="col-sm-2 control-label">上级菜单</label>
        <div class="col-sm-10">
            <input type="text" class="form-control" id="A_PARENT_MENU_NAME" name="PARENT_MENU_NAME" readonly="readonly" value="${responseDataForm.resultObj.PARENT_MENU_NAME}" placeholder="上级菜单名称">
        </div>
    </div>  
    <div class="hr-line-dashed"></div>
    <div class="form-group">
        <label class="col-sm-2 control-label">菜单名称</label>
        <div class="col-sm-10">
            <input type="text" class="form-control required" minlength="2" id="A_MENU_NAME" name="MENU_NAME" value="${responseDataForm.resultObj.MENU_NAME}">
            <span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 必填项</span>
        </div>            
    </div>
    <div class="hr-line-dashed"></div>
    <div class="form-group">
        <label class="col-sm-2 control-label">菜单URL_ID</label>
        <div class="col-sm-10">
            <input type="text" class="form-control" id="A_URL_ID" name="URL_ID" value="${responseDataForm.resultObj.URL_ID}">
            <span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 例：toMenuListPage</span>
        </div>
    </div>
    <div class="hr-line-dashed"></div>
    <div class="form-group">
        <label class="col-sm-2 control-label">菜单路径</label>
        <div class="col-sm-10">
            <input type="text" class="form-control" id="A_MENU_PATH" name="MENU_PATH" value="${responseDataForm.resultObj.MENU_PATH}">
            <span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 例：/topic/toMenuListPage</span>
        </div>            
    </div>
    <div class="hr-line-dashed"></div>
    <div class="form-group">
        <label class="col-sm-2 control-label">菜单排序</label>
        <div class="col-sm-10">
            <input type="text" class="form-control digits required" id="A_MENU_SEQ" name="MENU_SEQ" value="${responseDataForm.resultObj.MENU_SEQ}">
            <span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 必填项，只能输入数字</span>
        </div>            
    </div>
    <div class="hr-line-dashed"></div>
    <div class="form-group">
        <label class="col-sm-2 control-label">备注</label>
        <div class="col-sm-10">
            <textarea id="A_REMARK" name="REMARK" class="form-control">${responseDataForm.resultObj.REMARK}</textarea>
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
			$("#menuInfoEditForm").validate({
				submitHandler : function(form) {
					/**
					 * From表单提交（主要用于添加、修改）
					 * @param form表单  fullUrlAjax提交url  pdataId 需要重新加载的页面data_id  callBack回调js
					 */
					toSubmit(form, "${ctxPath}/topic/ajax/editMenu",null,refreshMenuTree);
	    			
				}
			});
		});
    </script>
</form>