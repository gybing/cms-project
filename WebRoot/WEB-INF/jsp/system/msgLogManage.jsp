<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<script type="text/javascript">
$(function(){
	/**
	*状态下拉框内容设置
	*/
	$("#sms_info option").each(function(){
		if($(this).val() == '${param.sms_info}'){
			$(this).attr("selected","selected");
		}
	});
});

</script>
<div class="pageContent">
	<!-- 查询部分 -->
	<div class="pageHeader">
		<form method="post" action="${ctxPath}/topic/bsm$toMsgLogManage" onsubmit="return navTabSearch(this);" id="pagerForm" >
			<div class="searchBar"> 
				<input type="hidden" name="pageNum" value="1" /><!-- 【必须】第几页，value=1可以写死 -->
				<input type="hidden" name="numPerPage" value="${param.numPerPage}" /><!-- 【可选】每页显示多少条 -->
				<table class="searchContent">
					<tbody>
						<tr>
							<td>收件人： <input value="${param.sms_user_name}" name="sms_user_name" id="sms_user_name" type="text" style="width: 100px" maxlength="20"/></td>
							<td>收件人电话： <input value="${param.sms_mobile}" name="sms_mobile" id="sms_mobile" type="text" style="width: 100px" maxlength="20"/></td>
							<td>发件人： <input value="${param.userName}" name="userName" id="userName" type="text" style="width: 100px" maxlength="20"/></td>
							<td>发件结果： </td>
							<td>
								<select class="combox" name="sms_info" id="sms_info">
									<option selected="selected"  value="">全部</option>
									<option  value="00">发送成功</option>
									<option  value="11">发送失败</option>
								</select>
							</td>
							<td style="margin-left: 50px;">
								<button type="submit">查询</button>
								<button type="button" id="reset_msg_log_manage" onclick="resetCurrentPagerForm()">重置</button>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</form>
	</div>
	
	<!-- 列表部分 -->
	<table class="table" id="TruckAuditDataList" width="100%" layoutH="85">
		<thead>
	        <tr>
                 <th width="110" title="手机号码">手机号码</th>
                 <th width="200" title="短信内容">短信内容</th>
                 <th width="90" title="收信人">收信人</th>
                 <th width="90" title="发件人">发件人</th>
                 <th width="70" title="发送时间">发送时间</th>
                 <th width="90" title="备注">备注</th>
	        </tr>
	 	</thead>
	 	<tbody>
	 		<c:forEach items="${responseDataForm.resultObj.dataList }" var="row">
	 			<tr target="SMSid" rel="${row.SMS_ID}">
	 			    <td>${row.SMS_MOBILE}</td> 
 				    <td>${row.SMS_MESSAGE}</td>
 				   	<td>${row.SMS_USER_NAME}</td>
	 				<td>${row.USER_NAME}</td> 
	 				<td>${row.SMS_TIME_TEXT}</td>
	 				<td>${row.REMARK}</td>
	 			</tr>
	 		</c:forEach>
	 	</tbody>
	</table>
	
	<jsp:include page="../comm/tabPagingBar.jsp"></jsp:include>
</div>