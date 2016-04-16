<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>新增费用类型</title>
    <jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
    <script type="text/javascript">
	    $(function(){
			$("#addFeeForm").validate({
				submitHandler : function(form) {
					addFeeInfo();
				}
			});
		});

		function addFeeInfo(){
			$.ajax({
	 			type : "POST",
	 			url : "${ctxPath}/topic/ajax/addOrderFee",
	 			data : $("#addFeeForm").serialize(),
	 			dataType : "json",
	 			async : false,
	 			success : function(json) {
	 				if (json.result == '1') {
	 					swal({
							title : "新增费用类型成功",
							type : "success",
							showCancelButton : false,
							confirmButtonColor : "#A7D5EA",
							confirmButtonText : "确定",
							closeOnConfirm : false
						}, function() {
							parent.refreshFeeType();
							//刷新表格，关闭弹窗
		 					parent.layer.close(parent.layer.getFrameIndex(window.name));
						});
	 				} else {
	 					swal("", json.resultInfo, "error");
	 					return;
	 				}
	 			},error : function(json) {
	 					swal("", json.responseText, "error");
	 				}
	 			});
		}
	</script>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">            
    <form id="addFeeForm" method="post" action="#" class="form-horizontal">
        <br />
        <div class="row">
             <div class="ibox-content">
                 <div class="form-group" style="padding: 10px;margin: 10px;">
                 	<label class="col-sm-1 control-label">费用类型: </label>
                 	<div class="col-sm-3">
                     	<input id="FEE_TYPE" name="FEE_TYPE" type="text" class="required" maxlength="25" />
                     </div>
                 	<label class="col-sm-1 control-label">编码: </label>
                 	<div class="col-sm-3">
                     	<input id="FEE_CODE" name="FEE_CODE" type="text" class="required" maxlength="15" />
                     </div>
                 </div>
             </div>
        </div>
        <div style="text-align: center;margin: 5px;">
        	<button class="btn btn-primary" type="submit">&nbsp;提&nbsp;&nbsp;交&nbsp;</button>
        </div>
    </form>
	</div>
</body>
</html>