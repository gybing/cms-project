<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false"%>
<script type="text/javascript">
$().ready(function() {			
	//循环页面所有的校验表单
	$("form").each(function(){
		var url = $(this).attr("action");  //Ajax提交url
		var data_id = $(this).attr("data-id");   //需要重新加载的页面data_id
		var callBack = $(this).attr("callback");   //回调函数
	 	$(this).validate({
			submitHandler : function(form) {
				/**
				 * From表单提交（主要用于添加、修改）
				 * @param form表单  fullUrlAjax提交url  pdataId 需要重新加载的页面data_id  callBack回调js
				 */
				toSubmit(form, url,data_id,callBack);
			}
		});			 	
	});
});
</script>    