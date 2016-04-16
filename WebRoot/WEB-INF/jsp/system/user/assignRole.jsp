<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
	$(function(){
		var tmp="${responseDataForm.resultObj[1]}";
		var oldRole=tmp.split(",");
		$("[name='ids']",$.pdialog.getCurrent()).each(function(i){
			if($.inArray(this.value,oldRole)!=-1){
				$(this).attr("checked",true);
				checkedbox(this);
			}
		});
	});
	function addRoles(obj) {
// 		if (arr.length==0) {
// 			alertMsg.warn("请选择角色");
// 			return false;
// 		}
		$('#roleIds',$.pdialog.getCurrent()).val(arr.join(","));
		return validateCallback(obj, function(json){
			if(json.result=='1'){
				arr=[];
			}
			customDialogAjaxDone(json);
			navTab.reload("${ctxPath}/topic/cpwb$toUserListPage");
		});
	}
	
	function checkedbox(obj){
		if(obj.checked){
			arr.push(obj.value);
		}else{
			arr=$.grep(arr,function(n,i){
				return n==obj.value;
			},true);
		}
	}
	
	function checkAll(obj){
		var selectedIds=$(obj).attr("group");
		$.pdialog.getCurrent().find("input[name='"+selectedIds+"']").each(function(i){
			var v=this.value;
			if(obj.checked){
				arr.push(v);
			}else{
				arr=$.grep(arr,function(n,i){
					return n==v;
				},true);
			}
		});
	}
	
</script>
<div class="page">
	<div class="pageContent">
		<form action="${ctxPath}/topic/cpwb$toAssignRole" class="pageForm" onsubmit="return dialogSearch(this)" id="pagerForm">
			<input type="hidden" name="pageNum" value="1" /><!-- 【必须】第几页，value=1可以写死 -->
			<input type="hidden" name="numPerPage" value="${param.numPerPage}" /><!-- 【可选】每页显示多少条 -->
			<input type="hidden" name="userId" value="${param.user_id }"/>
		</form>
		<form action="${ctxPath}/topic/ajax/cpwb$assignRole" class="pageForm" onsubmit="return addRoles(this)">
			<input type="hidden" name="userId" value="${param.user_id }" id="userId"/>
			<input type="hidden" name="roleIds" value="" id="roleIds"/>
			<input type="hidden" id="navTabId" value="userListPage"/>
			<input type="hidden" id="callbackType" value="closeCurrent"/>
			<table class="table" id="roleDataList" style="width: 100%;" layoutH="88">
				<thead>
			        <tr>
			        	<th width="22"><input type="checkbox" group="ids" class="checkboxCtrl" onclick="checkAll(this)"></th>
		                <th width="200" title="角色名">角色名</th>
		                <th width="" title="权限">权限</th>
		                <th width="100" title="备注">备注</th>
			        </tr>
			 	</thead>
			 	<tbody>
			 		<c:forEach items="${responseDataForm.resultObj[0].dataList }" var="row">
			 			<tr>
			 				<td><input name="ids" value="${row.ROLE_ID }" type="checkbox" onclick="checkedbox(this)"/></td>
			 				<td>${row.ROLE_NAME }</td>
			 				<td title="${row.PNAME }">${row.PNAME }</td>
			 				<td>${row.REMARK }</td>
			 			</tr>
			 		</c:forEach>
			 	</tbody>
			</table>
			<div class="panelBar">
				<div class="pages">
					<span>每页显示</span>
					<select name="pageSize" onchange="dialogPageBreak({numPerPage:this.value})">
						<c:forEach begin="20" end="50" step="10" varStatus="s">
							<c:if test="${param.numPerPage eq s.index}">
								<option selected="selected" value="${s.index}">${s.index}</option>
							</c:if>
							<c:if test="${param.numPerPage ne s.index}">
								<option value="${s.index}">${s.index}</option>
							</c:if>
						</c:forEach>
					</select>
					<span>条, 共 ${responseDataForm.resultObj[0].totalCount } 条</span>
				</div>
				<div class="pagination" targetType="dialog" totalCount=" ${responseDataForm.resultObj[0].totalCount }" numPerPage=" ${responseDataForm.resultObj[0].numPerPage }" pageNumShown=" ${responseDataForm.resultObj[0].pageNumShown }" currentPage=" ${responseDataForm.resultObj[0].pageNum }"></div>
			</div>
			<div class="formBar">
				<ul>
						<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
<!-- 						<li><div class="buttonActive"><div class="buttonContent"><button type="button" onclick="returnUserList()">保存</button></div></div></li> -->
					<li>
						<div class="button"><div class="buttonContent"><button class="close" type="button">关闭</button></div></div>
					</li>
				</ul>
			</div>
		</form>
	</div>
</div>