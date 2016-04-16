<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>修改人员</title>
    <jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeIn">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">                  
                    <div class="ibox-title">
                    </div>                  
                    <div class="ibox-content widget-content nopadding">
                       <form id="userEditForm" method="post" action="#" data-id="${param.pdataId}" callback="searchForm()" class="form-horizontal">
                       		<input type="hidden" id="E_USER_ID" name="USER_ID" value="${responseDataForm.resultObj.USER_ID }" />
							<input type="hidden" id="OLD_USER_TEL" name="OLD_USER_TEL" value="${responseDataForm.resultObj.TEL }" />
                           <div class="form-group form-group-sm">                                   
                               <label class="col-sm-2 control-label" for="account">用户账号：</label>
                               <div class="col-sm-3">
                                   <input type="text" id="A_USER_CODE" name="USER_CODE" maxlength="20" value="${responseDataForm.resultObj.USER_CODE }" class="form-control required input-sm"/>
                                   <span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 必填项</span>
                               </div>
                               <label class="col-sm-2 control-label" >姓名：</label>
                               <div class="col-sm-3">
                                   <input type="text" id="A_USER_NAME" name="USER_NAME" maxlength="20" value="${responseDataForm.resultObj.USER_NAME }" class="form-control required input-sm"/>
                                   <span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 必填项</span>
                               </div>
                           </div>
                           <div class="hr-line-dashed"></div>
                           <div class="form-group form-group-sm">
                               <label class="col-sm-2 control-label" >电话：</label>
                               <div class="col-sm-3">
                                   <input type="text" id="TEL" name="TEL" maxlength="20" value="${responseDataForm.resultObj.TEL }" class="form-control required input-sm isTelOrPhone"/>
                               		<span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 必填项</span>
                               </div>
                               <label class="col-sm-2 control-label" >性别：</label>
                               <div class="col-sm-2">
                               		<select class="form-control" id="A_USER_SEX" name="SEX">
										<option value="0">男</option>
										<option value="1">女</option>
									</select>
                               </div>
                           </div>
                           <div class="hr-line-dashed"></div>
                           <div class="form-group form-group-sm">
	                           <label class="col-sm-2 control-label" >公司：</label>
	                               <div class="col-sm-3">
	                                   <input type="text" id="A_COMPANY" name="COMPANY" maxlength="45" value="${responseDataForm.resultObj.COMPANY }" class="form-control input-sm"/>
	                               </div>
	                           <label class="col-sm-2 control-label" >所属部门：</label>
                               <div class="col-sm-3">
                                   <input type="text" id="A_DEPARTMENT" name="DEPARTMENT" maxlength="40" value="${responseDataForm.resultObj.DEPARTMENT }" class="form-control input-sm"/>
                               </div>
	                       </div>
	                       <div class="hr-line-dashed"></div>
                           <div class="form-group form-group-sm">
                           		<label class="col-sm-2 control-label" >调度中心：</label>
                                <div class="col-sm-3">
                               		<select id="A_SCHEDULE_CENTER"  name="SCHEDULE_CENTER" class="form-control">
											<option value="">请选择</option>
									</select>
                                </div>
	                       </div>
                           <div class="hr-line-dashed"></div>
                           <div class="form-group form-group-sm">
                               <div class="col-sm-4 col-sm-offset-2">
                                   <button type="submit" class="btn btn-primary">提交</button>
                                   <!-- <button type="button" class="btn btn-primary">取消</button> -->
                               </div>
                           </div>
                       </form>  
                   </div>
                </div>
            </div>
        </div>
    </div>
</body>
<script>
$(function(){
		$("#A_USER_SEX option[value='${responseDataForm.resultObj.SEX}']").attr("selected", true);
		$("#userEditForm").validate({
			submitHandler : function(form) {
				$.ajax({
					url:"${ctxPath}/topic/ajax/editManage",
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
		//调度中心下拉框
		$s2.init($("#A_SCHEDULE_CENTER"), {
			tabdict : "schedule_center",
			defVal:"${responseDataForm.resultObj.SCHEDULE_CENTER }"
		});
	});
</script>