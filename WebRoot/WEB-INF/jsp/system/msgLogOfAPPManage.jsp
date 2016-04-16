<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.weimingfj.common.form.ResponseDataForm"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<script type="text/javascript">
$(function(){
	/**
	*信息类型下拉框内容设置
	*/
	$("#APP_MSG_TYPE option").each(function(){
		if($(this).val() == '${param.MSG_TYPE}'){
			$(this).attr("selected","selected");
		}
	});
});
//点击记录给隐藏域赋值
function setMsgCon(obj){
//	alert($(obj).attr("tID"));
	$("#MsgConText").val($(obj).attr("tMsgCon"));
}

</script>
<div class="pageContent">
	<!-- 查询部分 -->
	<div class="pageHeader">
		<form method="post" action="${ctxPath}/topic/bsm$toMsgLogOfAppManage" onsubmit="return navTabSearch(this);" id="pagerForm" >
			<div class="searchBar"> 
				<input type="hidden" name="pageNum" value="1" /><!-- 【必须】第几页，value=1可以写死 -->
				<input type="hidden" name="numPerPage" value="${param.numPerPage}" /><!-- 【可选】每页显示多少条 -->
				<input type="hidden" id="MsgConText" name="MsgConText" value="" /><!--信息内容 -->
				<table class="searchContent">
					<tbody><tr>
						<td>
							手机号码：
							<input type="text" id="to_mobile" name="to_mobile" value="${param.to_mobile }" class="textInput">
						</td>
						<td>
							收信人：
							<input type="text" id="to_user_name" name="to_user_name" value="${param.to_user_name }" class="textInput">
						</td>
						<td>
							发件人：
							<input type="text" id="from_user_name" name="from_user_name" value="${param.from_user_name }" class="textInput">
						</td>
						<td>信息类型：</td>
						<td>
							<select id="APP_MSG_TYPE" name="MSG_TYPE" class="combox">
								<option selected="selected" value="">全部</option>
								<option value="1">通知</option>
								<option value="2">自定义消息</option>
							</select>
						</td>
					</tr>
				</tbody></table>
				<div class="subBar">
					<ul>
						<li>
							<div class="buttonActive">
								<div class="buttonContent">
									<button type="submit">查询</button>
								</div>
							</div>
							<div class="buttonActive">
								<div class="buttonContent">
									<button type="button" id="reset_msg_log_App_manage" onclick="resetCurrentPagerForm()">重置</button>
								</div>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</form>
	</div>
	
	<!-- 操作按钮 -->
	<div class="panelBar">
		<ul class="toolBar">
			<li><a class="icon" id="alertAppMsg" name="alertAppMsg" title="信息内容" href="${ctxPath}/topic/bsm$toMsgOfAppDialog?send_no={msgLogOfAppId}" target="dialog" warn="请选择一条记录"><span>查看信息内容</span></a></li>
		</ul>
	</div>
	
	<!-- 列表部分 -->
	<table class="table" id="msgLogOfAppList" width="100%" layoutH="136">
		<thead>
	        <tr>
	        	 <th width="90" title="手机号码">手机号码</th>
	        	 <th width="50" title="信息类型">信息类型</th>
                 <th width="200" title="信息内容">信息内容</th>
                 <th width="100" title="收信人">收信人</th>
                 <th width="100" title="发件人">发件人</th>
                 <th width="70" title="发送状态">发送状态</th>
                 <th width="110" title="发送时间">发送时间</th>
                 <th width="150" title="备注">备注</th>
	        </tr>
	 	</thead>
	 	<tbody>
	 		<c:forEach items="${responseDataForm.resultObj.dataList }" var="row">
	 			<tr  target="msgLogOfAppId" rel="${row.SENDNO }" tMsgCon='${row.MSG_CONTENT}' onclick="setMsgCon(this)">
	 			    <td>${row.TO_MOBILE}</td>
	 			    <td>
	 					<c:if test="${row.MSG_TYPE=='1'||row.MSG_TYPE eq ('1')}">通知</c:if>
	 					<c:if test="${row.MSG_TYPE=='2'||row.MSG_TYPE eq ('2')}">自定义消息</c:if>
	 					<c:if test="${row.MSG_TYPE!='2'&&row.MSG_TYPE!='1'}">未知</c:if>
	 			    </td>  
	 			    <td>
	 					<c:if test="${fn:length(row.MSG_CONTENT)>60}">${fn:substring(row.MSG_CONTENT, 0, 60)}......</c:if>
	 					<c:if test="${fn:length(row.MSG_CONTENT)<=60}">${row.MSG_CONTENT}</c:if>
	 			    </td>
 				    <td>${row.TO_USER_NAME}</td>
 				    <td>${row.FROM_USER_NAME}</td>
 				    <td>
 				    	<c:if test="${row.IS_SEND eq 'Y'}">发送成功</c:if>
	 					<c:if test="${row.IS_SEND eq 'N'}">发送未成功</c:if>
					</td>
	 				<td>
	 					<%-- <c:if test="${fn:length(row.SEND_DATE_FMT)<=0}">发送未成功</c:if>
	 					<c:if test="${fn:length(row.SEND_DATE_FMT)>0}">${row.SEND_DATE_FMT}</c:if> --%>
	 					${row.SEND_DATE_FMT}
	 			    </td>
	 				<td>${row.APP_NAME}-${row.PLATFORM}</td>
	 			</tr>
	 		</c:forEach>
	 	</tbody>
	</table>
	<jsp:include page="../comm/tabPagingBar.jsp"></jsp:include>
</div>