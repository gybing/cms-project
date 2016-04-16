<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户列表页</title>
    <jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight" >
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<input type="hidden" id="pdataId" value="${param.pdataId}" />
						<form class="form-horizontal" id="allotPrivForm">
		                    <input type="hidden" id="P_ROLE_ID" name="P_ROLE_ID" value="${param.ROLE_ID}" />
		                    <input type="hidden" id="P_PRIV_ID" name="P_PRIV_ID" />
							<div id="sysMenuTree"></div>
							<div class="form-group"></div>
							<div class="form-group">
	                           <div class="col-sm-offset-6 col-sm-8">
	                              <button class="btn  btn-primary" type="submit">保存</button>
	                              <button class="btn" onclick="cancelLayer();">取消</button>
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
	$(document).ready(function(){
		initJsTreeCheckBox("sysMenuTree", "${ctxPath}/topic/ajax/privTree","${ctxPath}/topic/ajax/queryRolePriv?ROLE_ID=${param.ROLE_ID}");
		$.jstree.reference("sysMenuTree").close_all();
		$("#allotPrivForm").validate({
			submitHandler : function(form) {
				var priv=$.jstree.reference("sysMenuTree").get_selected();
				if(isEmpty(priv)){
					swal("","权限选择不能为空", "warning");
					return;
				}
				$("#P_PRIV_ID").val(priv);
				/**
				 * From表单提交（主要用于添加、修改）
				 * @param form表单  fullUrlAjax提交url  pdataId 需要重新加载的页面data_id  callBack回调js
				 */
				toSubmit(form, "${ctxPath}/topic/ajax/assignPermissions",$("#pdataId").val());
			}
		});
	});
</script>
</html>