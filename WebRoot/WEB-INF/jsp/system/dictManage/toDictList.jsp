<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
<title>房间管理</title>
<style type="text/css">
#dict_detail_table {
	text-align: center;
	margin-left: 10px;
	color: #333333;
	border-width: 1px;
	border-color: #666666;
	border-collapse: collapse;
}
#dict_detail_table th {
	text-align: center;
	border: #ffffff 1px solid; 
}
#dict_detail_table td {
	border: #ffffff 1px solid; 
/* 	border-top: #ffffff 1px solid;  */
/* 	border-left: #ffffff 1px solid;  */
/* 	border-bottom: #ffffff 1px solid; */
	margin: 0 0 0 0 ;
	padding: 0 0 0 0 ;
}

._tr_focus {
	background-color: #EEEEEE;
}

._select_tr {
	background-color: #B3F7F7;
}
</style>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
			<div class="ibox">
				<div class="ibox-title">
					<div class="panel panel-default" style="margin-top: 5px;">
						<div class="panel-body">
							<form class="form-horizontal" id="dict_list_search_form">
							<input type="hidden" id="clickId" name="clickId">
								<div class="ibox">
									<div class="form-group">
										<label class="col-sm-1 control-label">数据类型:</label>
										<div class="col-sm-2">
											<input id="type" name="type" maxlength="14" type="text" class="required" aria-required="true" />
										</div>
										<label class="col-sm-1 control-label">类型名称:</label>
										<div class="col-sm-2">
											<input id="name" name="name" maxlength="14" type="text" class="required" aria-required="true" />
										</div>
										<label class="col-sm-1 control-label">对应文本:</label>
										<div class="col-sm-2">
											<input id="text" name="text" maxlength="14" type="text" class="required" aria-required="true" />
										</div>
										<div class="col-sm-3">
											<button type="button" class="btn btn-sm btn-primary " onclick="searchForm();">查    询</button>
											<button type="button" class="btn btn-sm btn-primary " onclick="resetForm('dict_list_search_form');">重    置</button>
											<button type="button" class="btn btn-sm btn-primary " onclick="refreshForm('dict_list_search_form');">刷    新</button>
										</div>
									</div>
								</div>
							</form>
							<div class="ibox-content widget-content nopadding float-e-margins">
								<div id="orderToolbar" style=" float:left; padding: 5px 5px;">
									<button type="button" class="btn btn-outline btn-default" onclick="toAddDictType();">
										<i class="glyphicon glyphicon-plus"></i> 新增数据
									</button>
									<button type="button" class="btn btn-outline btn-default" onclick="toEditType();">
										<i class="glyphicon glyphicon-edit"></i> 批量修改
									</button>
									<button type="button" class="btn btn-outline btn-default" onclick="deleteDictType();">
										<i class="glyphicon glyphicon-remove"></i> 批量删除
									</button>
								</div>
							</div>
							<table id="dict_list_table" class="table table-striped table-bordered table-hover data-table with-check">
								<thead>
									<tr align="center">
										<th width="40px"></th>
										<th>序号</th>
										<th>数据类型</th>
										<th>类型名称</th>
									</tr>
								</thead>
								<tbody></tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
	</div>
</body>
<script type="text/javascript">
var table;
$(function(){
	var cols = [
	            { "data":"TYPE"},
	            { "data": "NUM" },
	            { "data": "TYPE" },
	            { "data": "NAME" }
	        ];
	var aoColumnParam = [0],aaSortParam = [];
	table = initTableAutoHeight("dict_list_table", "${ctxPath}/topic/page/getAllDictType", null,cols,aoColumnParam,aaSortParam,"TYPE",true);
	// 展开按钮点击事件
	 $(".table").on("click", " tbody td .row-details", function () {
		 var tr = $(this).closest('tr');
		 var row = table.row(tr);
		 if(row.child.isShown()){
			 // 对已经打开的行进行关闭
			 row.child.hide();
			 tr.addClass("row-details-close").removeClass("row-details-open");
		 }else{
			 // 关闭其他已经打开的行
			 $("#dict_list_table tbody tr").each(function(index,item){
				 if($(this).hasClass("row-details-open")){
					 $(this).addClass("row-details-close").removeClass("row-details-open");
					 console.info($(this));
					 table.row($(this)).child.hide();
				 }
			 });
			 // 打开选中的行
			 row.child(openRow($(tr).find("span").attr("data-id"))).show();
			 tr.addClass("row-details-open").removeClass("row-details-close");
		 }
	 });
});
// 打开隐藏数据行
function openRow(pdataId){
	var html = "";
	$.ajax({
		url:"${ctxPath}/topic/ajax/getDictInfoByType",
		type:"post",
		dataType:"json",
		async:false,
		data:{"DICT_TYPE":pdataId},
		success:function(json){
			json = json.resultObj;
			html += "<table id=\"dict_detail_table\" width=\"63%\" style=\"\">";
			html += "    <thead>";
			html += "        <th width=\"5%\">序号</th>";
			html += "        <th width=\"20%\">数据类型</th>";
			html += "        <th width=\"20%\">类型名称</th>";
			html += "        <th width=\"10%\">编码</th>";
			html += "        <th width=\"20%\">对应文本</th>";
			html += "        <th width=\"10%\">排序编码</th>";
			html += "        <th width=\"20%\">父类编码</th>";
			html += "        <th width=\"10%\">操作</th>";
			html += "    </thead>";
			html += "    <tbody>";
			$.each(json,function(index,item){
				html += "	<tr>";
				html += "        <td>"+ item.NUM +"</td>";
				html += "        <td>"+ item.TYPE +"</td>";
				html += "        <td>"+ item.NAME +"</td>";
				html += "        <td>"+ item.CODE +"</td>";
				html += "        <td>"+ item.TEXT +"</td>";
				html += "        <td>"+ item.SEQ +"</td>";
				html += "        <td>"+ item.PARENT_CODE +"</td>";
				html += "        <td style=\"backgroud-color:none\">";
				html += "<button type=\"button\" style=\"margin:0px 0 2px 6px;\" class=\" btn btn-sm btn-default glyphicon glyphicon-edit \" onclick=\"toEditDictType('"+item.ID+"');\"></button>";
				html += "<button type=\"button\" style=\"margin:0px 6px 2px 6px;\" class=\" btn btn-sm btn-danger glyphicon glyphicon-trash \" onclick=\"toDeleteDictType('"+item.ID+"');\"></button>";
				html += "		</td>";
				html += "	</tr>"
			});
			html += "	</tbody>";
			html += "</table>";
		}
	});
	// 为展开的 table tr 设置鼠标覆盖样式
	 $("#dict_detail_table tbody").on("mouseover","tr",function(){
		 $("#dict_detail_table").find("._tr_focus").removeClass("_tr_focus");
		 $(this).addClass("_tr_focus");
	 });
	// 为展开的 table tr 设置点击选中样式
	 $("#dict_detail_table tbody").on("click","tr",function(){
		 $("#dict_detail_table").find("._select_tr").removeClass("_select_tr");
		 $(this).addClass("_select_tr");
	 });
	return html;
}

/* 搜索 查询 */
function searchForm() {
	$("#clickId").val(""); //清除之前选中的id
	table.column(0).search($("#type").val());
	table.column(1).search($("#name").val());
	table.column(2).search($("#text").val());
	table.draw();
}

/* 新增数据类型弹窗 */
function toAddDictType(){
	var _type = $("#clickId").val();
	if(_type){
		url = _contextPath+"/topic/toAddDict?DICT_TYPE="+_type;
	}else{
		url = _contextPath+"/topic/toAddDict?DICT_TYPE=-1";
	}
	index = layer.open({
	    type: 2, 
	    title : "新增数据类型",
	    area: ['65%', '71%'],
	    fix: false, //不固定
	   // maxmin: true,
	    content: url
	});
}

/* 编辑数据类型弹窗 */
function toEditDictType(obj){
	index = layer.open({
	    type: 2, 
	    title : "编辑数据信息",
	    area: ['65%', '71%'],
	    fix: false, //不固定
	    content: _contextPath+"/topic/toEditDict?id="+obj
	});
}

/* 批量编辑数据类型字段 */
function toEditType(){
	var _type = $("#clickId").val();
	if(_type){
		url = _contextPath+"/topic/toEditType?DICT_TYPE="+_type;
		index = layer.open({
		    type: 2, 
		    title : "编辑数据类型",
		    area: ['65%', '71%'],
		    fix: false, //不固定
		   // maxmin: true,
		    content: url
		});
	}else{
		layer.alert(json.resultInfo,{icon: 2}, function(index){
			layer.close(index);
		});  
		return ;
	}
}

/* 批量删除数据类型 */
function deleteDictType(){
	var _type = $("#clickId").val();
	if(_type){
		layer.confirm('您确定要删除 '+_type+' 这个类型的所有记录吗?', {icon: 3, title:'提示'}, function(index){
			 $.ajax({
					url : "${ctxPath }/topic/ajax/deleteDictType",
					dataType : "json",
					type : "post",
					data:{"d_type":_type},
					success : function(json) {
						if (json.result == '1') {
							layer.alert(json.resultInfo, function(index){
								//刷新表格，关闭弹窗
								searchForm();
								layer.close(index);
							});  
						} else {
							layer.alert(json.resultInfo,{icon: 2}, function(index){
								layer.close(index);
							});  
							return;
						}
				}});
		});
	}else{
		layer.alert("请选择一条记录！", {icon: 2}, function(index){
			layer.close(index);
		});  
	}
}

/* 删除数据类型 */
function toDeleteDictType(obj){
	var b_id = obj;
	if(b_id){
		layer.confirm('您确定要删除这条记录吗?', {icon: 3, title:'提示'}, function(index){
			 $.ajax({
					url : "${ctxPath }/topic/ajax/deleteDict",
					dataType : "json",
					type : "post",
					data:{"id":b_id},
					success : function(json) {
						if (json.result == '1') {
							layer.alert(json.resultInfo, function(index){
								//刷新表格，关闭弹窗
								searchForm();
								layer.close(index);
							});  
						} else {
							layer.alert(json.resultInfo,{icon: 2}, function(index){
								layer.close(index);
							});  
							return;
						}
				}});
		});
	}else{
		layer.alert("请选择一条记录！", {icon: 2}, function(index){
			layer.close(index);
		});  
	}
}

function initCustomTable(tableId,url,cols,idName){
	var pageHeight=$("#content-main",window.parent.document).height();
	height=pageHeight-$("#"+tableId).offset().top-50;
	t = $("#"+tableId).dataTable( {
		"searching": true, //搜索
        "processing": true, //加载数据时显示正在加载信息  
        "jQueryUI": true, //是否允许终端用户从一个选择列表中选择分页的页数，页数为10，25，50和100
		"lengthChange": true, //改变每页显示数据数量
		"paging": true, //翻页功能
		//"scrollY":300,  // 设置表格高度，超出则出现滚动条
		"lengthMenu": [20, 30, 50, 100],//[10, 25, 50, 100],  //自定义每页显示条数
		"serverSide": true, //是否使用服务器端处理 默认为false 开启服务器模式
        "ajax": {
		    "url": url,  //Ajax请求地址
		    "type": "POST",
		    "data":function(d){
		        //return $.extend({}, d,param, {"numPerPage": d.length }); // param  Ajax请求时发送额外的数据(条件)，格式： { "name": "more_data", "value": "my_value" }
		        return $.extend({}, d, {"numPerPage": d.length });
		    }
		  },
        "columns": cols,
		"ordering" : false, //isOrdering 是否启用Datatables排序 true false
		//"order":sortParam, // 表格初始化排序 [[ 0, 'asc' ], [ 1, 'asc' ]]
		"columnDefs": [{ //列定义配置数组    设置哪些列不进行排序
			className:"datatables_text_center","targets": [ "_all"],"contentPadding": "mmm"
		  }],
        "createdRow": function (row, data, dataIndex ) {  //tr被创建回调函数
        	$('td:eq(0)',row).html("<span class='row-details row-details-close' data-id='"+data[idName]+"'><i class=\"fa fa-plus-square\"></i></a></span> ");
			if(!isEmpty(idName)){
				var clickId="";
				for(var key in data){
					if(idName == key){  //idName 表示Json串中的属性，如'UNID'
						clickId = data[key];  //key所对应的value
			            break;
					}
				}
				row.setAttribute('data-id',clickId);//向tr中添加属性data-id并赋值
				row.onclick=function(){
					$('table tr').removeClass('onClick');//选择行时删除其他被选中的背景色
					$(this).addClass('onClick');//选择行时添加样式，加背景色
					$("#clickId").val($(this).data('id'));//选择行时回填该值，用于单条修改删除用  注：在列表页需添加id为clickId的文本框
				};
			}
		},
		"scrollX": false,  //开启  水平滚动条
		"scrollY": height+'px',  //设置垂直高度 滚动条
		"pagingType": "full_numbers", //分页按钮种类显示选项       默认为two_button 两种交互式分页策略，两个按钮和全页数，展现给终端用户不同的控制方式
		"dom": 't<"F"<<"p_i"i><"p_fl"l><"fr"p>>',//该初始化属性用来指定你想把各种控制组件注入到dom节点的位置（比如你想把分页组件放到表格的顶部）
		"language": {  //按什么顺序定义表的控制元素在页面上出现   自定义语言设置
            "processing": "正在加载中......",
            "lengthMenu": "每页显示 _MENU_ 条记录",
            "zeroRecords": "对不起，查询不到相关数据！",
            "infoEmpty": "无数据存在！",
            "info": "当前显示 _START_ 到 _END_ 条，共 _TOTAL_ 条记录",
            "infoFiltered": "",
            "search": "搜索",
            "paginate": {
                "first": "首页",
                "previous": "上一页",
                "next": "下一页",
                "last": "末页"
            }
		}
    } );
	return t;
}
</script>
</html>