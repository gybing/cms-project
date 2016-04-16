<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>新增角色</title>
    <jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeIn">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">                  
                    <div class="ibox-title">
                        <h5>新增角色</h5>
                    </div>                  
                    <div class="ibox-content widget-content nopadding">
                       <form id="roleEditForm" method="post" action="#" data-id="${param.pdataId}" callback="searchForm()" class="form-horizontal">
                       	   <input type="hidden" id="E_ROLE_ID" name="ROLE_ID" value="${responseDataForm.resultObj.ROLE_ID }" />
                           <div class="form-group form-group-sm">                                   
                          
                               <label class="col-sm-2 control-label" for="account">角色名：</label>
                               <div class="col-sm-4">
                                   <input type="text" id="ROLE_NAME" name="ROLE_NAME" maxlength="30" value="${responseDataForm.resultObj.ROLE_NAME }" class="form-control required input-sm"/>
                                   <span class="help-block m-b-none"><i class="fa fa-info-circle"></i> (不超过30个字)必填项</span>
                               </div>
                        
                           </div>
                           <c:if test="${session_role_type eq '0' }">
	                           <div class="hr-line-dashed"></div>
	                           <div class="form-group form-group-sm">
	
	                               <label class="col-sm-2 control-label" >是否固化：</label>
	                               <div class="col-sm-4">
	                                   <input type="radio" name="role_type" value="0" <c:if test="${responseDataForm.resultObj.ROLE_TYPE eq '0'}">checked</c:if>/>否
									   <input type="radio" name="role_type" value="1" <c:if test="${responseDataForm.resultObj.ROLE_TYPE eq '1'}">checked</c:if>/>是
	                               </div>
	                                                                                                       
	                           </div>
                           </c:if>
                           <div class="hr-line-dashed"></div>
                           <div class="form-group form-group-sm">

                               <label class="col-sm-2 control-label" >备注：</label>
                               <div class="col-sm-4">
                                   <textarea id="REMARK" name="REMARK" cols="50" rows="6" maxlength="60" class="form-control">${responseDataForm.resultObj.REMARK }</textarea>
                               </div>
                                                                                                       
                           </div>
                           <div class="form-group form-group-sm">

                               <div class="col-sm-4 col-sm-offset-2">
                                   <button type="submit" class="btn btn-primary">保存</button>
                                   <!-- <button type="button" class="btn btn-primary">取消</button> -->
                               </div>
                           </div>
                       </form>  
                   </div>
                </div>
            </div>
        </div>
    </div>
    <script>
$(function(){
		$("#roleEditForm").validate({
			submitHandler : function(form) {
				$.ajax({
					url:"${ctxPath}/topic/ajax/editRole",
					dataType:"json",
					data : $(form).serialize(),
					type:"post",
					success:function(json){
						if (json.result == '1') {
		 					swal({
								title : json.resultInfo,
								type : "success",
								showCancelButton : false,
								confirmButtonColor : "#A7D5EA",
								confirmButtonText : "确定",
								closeOnConfirm : false
							}, function() {
								//刷新表格，关闭弹窗
								parent.searchForm();
			 					parent.layer.close(parent.layer.getFrameIndex(window.name)); 
							});
		 				} else {
		 					swal("", json.resultInfo, "error");
		 					return;
		 				}
					}
				});
			}
		});
		
	});
</script>
</body>
