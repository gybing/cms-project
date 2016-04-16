<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<script type="text/javascript">
$(function(){
	/**
	*文本框内容设置
	*/
	$("#msgContTextarea").val($("#MsgConText").val());
});

</script>
<div class="pageContent">
	<textarea id="msgContTextarea" name="msgContTextarea" style="width:95%;height:200px"></textarea>
</div>