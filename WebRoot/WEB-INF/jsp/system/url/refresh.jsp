<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>"/>
    <jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/jsp/formSubmit.jsp"></jsp:include>
	<script type="text/javascript">
		function refreshCache(name){
			$.ajax({
				type : "POST",
				url : '${ctxPath}/topic/ajax/refreshCache',
				data : {"cacheName" : name},
				dataType : "json",
				success : function(data, textStatus, jqXHR) {
					if(data.result==1){
						parent.layer.alert('操作成功', {
					        skin: 'layui-layer-lan',
					        /* shift: 4 //动画类型 */
					    });
					}else{
						parent.layer.alert(data.resultInfo+'', {
					        skin: 'layui-layer-lan',
					        /* shift: 4 //动画类型 */
					    });
					}
				}, error : function(XMLHttpRequest, textStatus, errorThrown) {
					parent.layer.alert("请求异常：" + textStatus, {
				        skin: 'layui-layer-lan',
				        /* shift: 4 //动画类型 */
				    });
				}
			});
		}
	</script>
</head>
  <body>
    <div class="pageContent" style="margin-top: 10px;margin-left: 10px;">
    	<input type="button" class="btn btn-primary" value="刷新xml缓存" onclick="refreshCache('com.cms.common.cache.impl.UrlExecSqlCache')"/>
    	<input type="button" class="btn btn-primary" value="刷新validation缓存" onclick="refreshCache('com.cms.common.cache.impl.UrlValidationCache')"/>
    	<input type="button" class="btn btn-primary" value="刷新URL映射缓存" onclick="refreshCache('com.cms.common.cache.impl.UrlMappingCache')"/>
        <input type="button" class="btn btn-primary" value="刷新字典缓存" onclick="refreshCache('com.cms.cache.DictCache')"/>
    </div>
    
    
    <div>
    	<p>
<select class="js-example-basic-multiple-limit js-states form-control select2-hidden-accessible" multiple="" tabindex="-1" aria-hidden="true">
<span class="select2 select2-container select2-container--default select2-container--above" dir="ltr" style="width: 360px;">
<span class="selection">
<span class="select2-selection select2-selection--multiple" aria-expanded="false" aria-haspopup="true" aria-autocomplete="list" role="combobox" tabindex="0">
</span>
<span class="dropdown-wrapper" aria-hidden="true"></span>
</span>
</p>
    </div>
  </body>
</html>
