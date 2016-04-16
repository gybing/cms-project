<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.weimingfj.common.form.ResponseDataForm"%>
<%@ page import="com.weimingfj.common.cache.GlobalCache"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">

</script>


<div class="pageContent">
	<!-- 查询部分 -->
	<div class="pageHeader">
		<div class="searchBar">
			<form method="post" name="" action="${ctxPath }/topic/toDriverManage" onsubmit="return navTabSearch(this);" id="pagerForm">
				<input type="hidden" name="pageNum" value="1" /> 
				<input type="hidden" name="numPerPage" value="${param.numPerPage }" />
				<table class="searchContent"> 
					<tbody>
						<tr>
							<!-- <td>地点类型</td>
							<td colspan="2">
								<select id="" name="" >
									<option value="">全部类型</option>
								</select>
							</td> -->
							<td>
								<input type="text" name="searchKey" placeholder="请输入关键词进行搜索" value="${param.searchKey }"/>
							</td>
							<td align="right">
								<button  type="submit">搜索</button>
								<!-- <button type="button" id="" onclick="">重置</button> -->
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
	</div>
	<!-- 操作按钮 -->
	<div class="panelBar">
		<ul class="toolBar">
			<!-- <li><a class="edit" href="javascript:void(0)" onclick=""><span>导入</span></a></li> -->
			<li><a class="add" href="${ctxPath}/topic/toDriverAdd" target="navTab"><span>新增</span></a></li>
			<li><a class="edit" rel="toEditArea"  href="${ctxPath}/topic/toDriverEdit?driverId={id}" target="navTab" warn="请选择一条记录！"><span>修改</span></a></li>
			<li><a class="delete" href="${ctxPath }/topic/ajax/delDriver?driverId={id}" target="ajaxTodo" title="确定要删除吗？" callback="customNavTabAjaxDone"><span>删除</span></a></li>
			<%-- <li>
				<a class="edit" rel="" href="${ctxPath}/topic/toAreaDetail?id={id}" target="navTab" warn="请选择一条记录！">
					<span>查看详情</span>
				</a>
			</li> --%>
			<!-- <li><a class="edit" href="javascript:void(0)" onclick=""><span>打印</span></a></li> -->
		</ul>
	</div>
	<!-- 列表部分 -->
	<table class="table" id="userDataList" width="100%" layoutH="165">
		<thead>
			<tr>
				<th width="10">序号</th>
				<th width="80">司机代码</th>
				<th width="50">司机姓名</th>
				<th width="50">默认车号</th>
				<th width="">车架</th>
				<th width="">联系电话</th>
				<th width="">调度中心</th>
				<th width="130">备注</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${responseDataForm.resultObj.dataList }" var="row" varStatus="index">
				<tr target="id" rel="${row.DRIVER_ID}">
					<td>${index.index+1}</td>
					<td>${row.CODE}</td>
					<td>${row.NAME}</td>
					<td>${row.TRUCKPLATE}</td>
					<td>${row.TRUCKFRAMEPLATE}</td>
					<td>${row.MOBILE_1}</td>
					<td>${row.CENTER_NAME}</td>
					<td>${row.REMARK}</td>
				</tr> 
			</c:forEach>
		</tbody>
	</table>
	<jsp:include page="../comm/tabPagingBar.jsp"></jsp:include>
	
</div>