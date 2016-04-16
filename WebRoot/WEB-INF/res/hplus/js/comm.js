$(function(){
	//选择框 
	$(".i-checks").iCheck({checkboxClass:"icheckbox_square-green",radioClass:"iradio_square-green"});
	//日期控件初始化  BOOTSTRAP-DATETIMEPICKER
	/*$(".form_date").each(function(){
		// yyyy-mm-dd hh:ii:ss
		var vDataFormat = 'yyyy-mm-dd hh:ii:ss';
		if(!isEmpty($(this).attr("data-date-format"))){
			vDataFormat = $(this).attr("data-date-format");
		}
		var vMinView = '0';//  0 显示时分秒
		if(vDataFormat.length <= 10){ // yyyy-mm-dd
			vMinView = '2';// 2 不显示时分秒
		}else if(vDataFormat.length > 10 && vDataFormat.length < 17){ //yyyy-mm-dd hh:ii
			vMinView = '1';// 1不显示分钟
		}
		$(this).datetimepicker({
			format: vDataFormat,
			language: 'zh-CN',
	  		autoclose: 1,
	  		todayBtn: 1,
			minView: vMinView, // 2 不显示时分秒 1不显示分钟 0 显示时分秒
	  	  	todayHighlight: 1
		});
	});	*/
});

/**  控件初始化加载 **********************************************************************************************************************/
/**
 * 初始化表格  dataTables  【旧版本】
 * 注： 调用该控件加载列表页，最好新建一个url来专门加载列表数据
 * @param id divid
 * @param urlAjax请求地址
 * @param paramAjax请求时发送额外的数据(条件)格式： { "name": "more_data", "value": "my_value" }
 * @param colsParam设置列属性条件（eg:标题栏上的升序/降序条件） 列表信息
 * @param aoColumnParam设置哪些列不进行排序
 * @param aaSortParam设置列排序
 * @param idName设置选中行时回填值的字段名
 * @returns
 */
function oldinitTable(id,url,param,colsParam,aoColumnParam,aaSortParam,idName){
	$.ajaxSetup({cache:false});//ajax调用不使用缓存 
	var table=$("#"+id).dataTable({
		"bFilter": true, //搜索
		"bDestory" : false, //销毁 boolean
        "bProcessing": true, //加载数据时显示正在加载信息  
		"bServerSide": true, //是否使用服务器端处理 默认为false
		"sServerMethod": "POST",//以post的方式提交数据
		"sAjaxSource":url,//Ajax请求地址
		"fnServerParams": function (aoData) {  //Ajax请求时发送额外的数据(条件)，格式： { "name": "more_data", "value": "my_value" }
			if(param){
				aoData.push(param);
			}
		},
		"aoColumns":colsParam, //设置列属性条件（eg:标题栏上的升序/降序条件） 【列表信息】
		"aoColumnDefs": aoColumnParam,  //设置哪些列不进行排序
		"aaSorting": aaSortParam, // 设置列排序
		"order": aaSortParam, // 设置列排序
		"createdRow": function ( row, data, index ) {  //创建行信息
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
				}
			}
		},
		"bJQueryUI": true, //是否允许终端用户从一个选择列表中选择分页的页数，页数为10，25，50和100
		"bPaginate": true, //翻页功能
		"bLengthChange": true, //改变每页显示数据数量
		"lengthMenu": [20, 30, 50, 100],//[10, 25, 50, 100],  //自定义每页显示条数
		"sPaginationType": "full_numbers", //默认为two_button 两种交互式分页策略，两个按钮和全页数，展现给终端用户不同的控制方式
		"sDom": 't<"F"<<"p_i"i><"p_fl"l><"fr"p>>',//该初始化属性用来指定你想把各种控制组件注入到dom节点的位置（比如你想把分页组件放到表格的顶部）
		"bLengthChange": true,//是否开启分页功能,即使设置为false,仍然会有一个默认的<前进,后退>分页组件
		"oLanguage": {  //自定义语言设置
            "sProcessing": "正在加载中......",
            "sLengthMenu": "每页显示 _MENU_ 条记录",
            "sZeroRecords": "对不起，查询不到相关数据！",
            "sEmptyTable": "无数据存在！",
            "sInfo": "当前显示 _START_ 到 _END_ 条，共 _TOTAL_ 条记录",
            "sInfoFiltered": "",
            "sSearch": "搜索",
            "oPaginate": {
                "sFirst": "首页",
                "sPrevious": "上一页",
                "sNext": "下一页",
                "sLast": "末页"
            }
		},
		"fnFooterCallback":(other && other.fnFooterCallback)?other.fnFooterCallback:null //与fnHeaderCallback()完全相同，只是该函数允许你在每一个draw时间发生时修改页脚
	});
	return table;
}

/**
 * 初始化表格  dataTables 【新版本】
 * 注： 调用该控件加载列表页，最好新建一个url来专门加载列表数据
 * @param id divid
 * @param urlAjax请求地址
 * @param paramAjax请求时发送额外的数据(条件)格式： { "name": "more_data", "value": "my_value" }
 * @param colsParam设置列属性条件（eg:标题栏上的升序/降序条件） 列表信息
 * @param columnParam设置哪些列不进行排序
 * @param sortParam设置列排序
 * @param idName设置选中行时回填值的字段名
 * @param isOrdering设置是否启用表头排序功能
 * @returns
 */
function initTable(id,url,param,cols,columnParam,sortParam,idName,isOrdering){
	isOrdering = isOrdering || false;
	if(!isOrdering){
		columnParam = [];
		sortParam = [];
	}
	var pageHeight=$("#content-main",window.parent.document).height();
	height=pageHeight-$("#"+id).offset().top-50;
	
	var table=$("#"+id).DataTable({
		"searching": true, //搜索
        "processing": true, //加载数据时显示正在加载信息  
        "jQueryUI": true,//使用jqueryui样式（需要引入jqueryui的css）
		"lengthChange": true, //允许改变每页显示的数据条数
		"paging": true, //允许表格分页
		"lengthMenu": [20, 30, 50, 100],//[10, 25, 50, 100, "All"],  //改变每页显示条数列表的选项
		"serverSide": true, //是否使用服务器端处理 默认为false 开启服务器模式
		"ajax": {
		    "url": url,  //Ajax请求地址
		    "type": "POST",
		    "data":function(d){
		        //return $.extend({}, d,param, {"numPerPage": d.length }); // param  Ajax请求时发送额外的数据(条件)，格式： { "name": "more_data", "value": "my_value" }
		        return $.extend({}, d, {"numPerPage": d.length });
		    }
		  },
		"columns" : cols, //设置列属性条件   【列表信息】
		"ordering" : false, //isOrdering 是否启用Datatables排序 true false
		//"order":sortParam, // 表格初始化排序 [[ 0, 'asc' ], [ 1, 'asc' ]]
		"columnDefs": [{ //列定义配置数组    设置哪些列不进行排序
			className:"datatables_text_center","targets": [ "_all"],"contentPadding": "mmm"
		  }],
		/*"columnDefs": [{ //设置哪些列不进行排序
			"orderable": false,//禁用排序 
			"targets": columnParam   //指定的列 
		  },{
			"orderable": true,//启用排序 
			"targets": sortParam   //指定的列 
		}],*/
		"createdRow": function (row, data, dataIndex ) {  //tr被创建回调函数
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
		//"scrollY": height+'px',  //设置垂直高度 滚动条
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
	});
	return table;
}
/**
 * 初始化table
 * 引入高度
 * 
 * */
/**
 * 初始化表格  dataTables 【新版本】
 * 注： 调用该控件加载列表页，最好新建一个url来专门加载列表数据
 * @param id divid
 * @param urlAjax请求地址
 * @param paramAjax请求时发送额外的数据(条件)格式： { "name": "more_data", "value": "my_value" }
 * @param colsParam设置列属性条件（eg:标题栏上的升序/降序条件） 列表信息
 * @param aoColumnParam设置哪些列不进行排序
 * @param aaSortParam设置列排序
 * @param idName设置选中行时回填值的字段名
 * @returns
 */
function initTableAutoHeight(id,url,param,colsParam,aoColumnParam,aaSortParam,idName){
	var pageHeight=$("#content-main",window.parent.document).height();
	height=pageHeight-$("#"+id).offset().top-50;
	var table=$("#"+id).DataTable({
		"searching": true, //搜索
        "processing": true, //加载数据时显示正在加载信息  
        "jQueryUI": true, //是否允许终端用户从一个选择列表中选择分页的页数，页数为10，25，50和100
		"lengthChange": true, //改变每页显示数据数量
		"paging": true, //翻页功能
		//"scrollY":300,  // 设置表格高度，超出则出现滚动条
		"lengthMenu": [20, 30, 50, 100],//[10, 25, 50, 100],  //自定义每页显示条数
		"serverSide": true, //是否使用服务器端处理 默认为false
		"ajax": {
		    "url": url,  //Ajax请求地址
		    "data":function(d){
		    	var data =  $.extend({}, d,param, {"numPerPage": d.length });
		        return data;
		        }, //Ajax请求时发送额外的数据(条件)，格式： { "name": "more_data", "value": "my_value" }
		    "type": "POST"
		  },
		"columns":colsParam, //设置列属性条件   【列表信息】
		"ordering":false, //禁用表头排序功能
		"columnDefs": [
		  { //设置哪些列不进行排序
//			"orderable": false,//禁用排序 
//			"targets": aoColumnParam,   //指定的列 
			className:"datatables_text_center","targets": [ "_all"],"contentPadding": "mmm"
		  }],
		"createdRow": function ( row, data, index ) {  //创建行信息 行被创建时回调函数
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
		"scrollX": true,  //开启水平滚动条
		"scrollY": height+'px',
		"pagingType": "full_numbers", //默认为two_button 两种交互式分页策略，两个按钮和全页数，展现给终端用户不同的控制方式
		"dom": 't<"F"<<"p_i"i><"p_fl"l><"fr"p>>',//该初始化属性用来指定你想把各种控制组件注入到dom节点的位置（比如你想把分页组件放到表格的顶部）
		"language": {  //自定义语言设置
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
	});
	return table;
}

/**  jsTree初始化 **********************************************************************************************************************/
/**
 * jsTree加载
 * =============================================================================================================================================
 * ***注：
 * ***	加载树格式：{\"id\":\""+ data[i].UNID +"\",\"parent\":\""+ data[i].PARENT_ID +"\",\"text\":\""+ data[i].TEXT +"\"}
 * ***  因此xml里相对应的sql语句查询需使用别名 UNID id，PARENT_ID 父id，TEXT 显示的名称（文本）
 * ***  其中无上级的节点，它的PARENT_ID 父id需为“ # ”号
 * *** 例：
 * ***   SELECT M.MENU_ID UNID, (CASE M.PARENT_MENU_ID WHEN '0' THEN '#' ELSE M.PARENT_MENU_ID END) PARENT_ID, M.MENU_NAME TEXT FROM sys_menu_tab M
 * ==============================================================================================================================================
 * @param id divid
 * @param urlAjax请求地址
 * @param callBack回调函数
 * @param parentId父节点id（用于刷新树）
 * @returns
 */
function initJsTree(id,url,callBack,parentId) {
	$.ajaxSetup({cache:false});//ajax调用不使用缓存 
	var jsTree="";
	$.ajax({
		type : "POST",
		url : url+"?t="+ new Date().getTime(),
		dataType : "json",
		async : false,
		success : function(json) {
			if(json.result == '1'){
				jsTree = $('#'+id).jstree({
					core : {
				    	animation:0,
					    check_callback:true,
					    themes : {"stripes":true },
				    	data : getTreeInfo(json.resultObj)
					},
	             	lang : { loading : "菜单目录加载中……" },
					plugins : ["types","dnd"],
					types : {"default":{"icon":"fa fa-folder"},"jsp":{"icon":"fa fa-file-text-o"}}					
				}).bind("select_node.jstree", function (e, data) {
					// 执行回调函数  回传 节点对象
					if (!isEmpty(callBack)){
						callBack(data.node);
					}
				}).bind("loaded.jstree", function (e, data) {
					if(!isEmpty(parentId)){  //刷新打开操作的节点
						$('#'+id).jstree("toggle_node", "#"+parentId);
					}
                });
			}
		},error : function() {
			swal("", "请求异常！", "error");
		}
	});
	return jsTree;
}

/**
 * 获取树数据 
 * @param data
 * @returns {Array}
 */
function getTreeInfo(data) {
	var treeInfo = "",bullets = [];
	for (var i in data) {
		treeInfo = "{\"id\":\""+ data[i].UNID +"\",\"parent\":\""+ data[i].PARENT_ID +"\",\"text\":\""+ data[i].TEXT +"\"}";
		bullets[i] = eval('(' + treeInfo + ')');
	}
	return bullets;
}
/**
 * 跳转至右边修改页面
 * @param idName需回填字段名
 * @param id节点id值
 * @param toPageUrl跳转页面地址
 * @param contentId需刷新的div的id
 */
function toDivPage(idName,id,toPageUrl,contentId){
	$("#"+idName).val(id);  //选中向页面回填值
	var _params={},key = idName;  //动态定义json的key
	_params[key] = id;//赋值	
	toDiv(toPageUrl,contentId,_params);
}

/**  表单处理 **********************************************************************************************************************/
/**
 * 跳转页面 新增tab
 * @param iUrl请求url 有条件直接拼接到url后
 * @param iTitletab标签名
 */
function indexToPage(iUrl,iTitle){
	var e = iUrl.indexOf("?");
	var p = "?pdataId="+ window.parent.getDataId();
	if(e != -1){
		p = "&pdataId="+ window.parent.getDataId();
	}
	//打开新tab页 iUrl ajax执行url,iTitle tab标签名,pdataId 标签data_id（用于关闭刷新标签页)
	window.parent.newTab(iUrl+p,iTitle);
}

/**
 * 跳转页面 把页面内容加载到指定div
 * @param iUrl请求url
 * @param contentId需刷新的div的id
 * @param params参数 (json)eg:params = {UNID:"2",pid:"1"}
 */
function toDiv(iUrl,contentId,params){
	$.ajax({
		type : "POST", // 提交的类型 
		url : iUrl+"?t="+ new Date().getTime(), // 提交地址 
		data : params,
		success : function(data) { //回调方法 
			$("#"+contentId).html(data);
		},
		error : function(data) {
			swal("", "请求异常！", "error");
		}
	});
}

//暂时没用
function openLayer(iUrl,iTitle,iType){
	 index = layer.open({
	    type : iType==null?2:iType, //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
	    title : iTitle,  //标题  String/Array/Boolean，默认：'信息'  title: ['文本', 'font-size:18px;'] 带样式
	    area: ['1000px', '530px'], //String/Array，默认：'auto' 默认状态下，layer是宽高都自适应的
	    fix : false, //是否固定Boolean true，false
	    maxmin : false, //最大最小化 Boolean，默认：false
	    content : iUrl,  //String/DOM/Array，默认：'' 如果是url，你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
	    btn3: function(index, layero){
	    	console.log(index, layero);
	    }
	});
}

/**
 * 修改信息 
 * @param iUrl请求url
 * @param param参数(数组) eg:params = [{unid:"2"}]
 * @param iTitletab标签名
 */
function editForm(iUrl,params,iTitle){
	var sLength = params.length,param="",key = "";
	if (isEmpty(params) || sLength == 0 || params[0] == '') {
		swal("", "请选择一条信息进行修改!", "warning");
		return;
	}else if(sLength > 1){
		swal("", "只能选择一条信息进行修改!", "warning");
		return;
	}
	$.each(params[0], function(i) {
	    param = params[0][i],key = i;
	});
	//打开新tab页 iUrl ajax执行url,iTitle tab标签名,dataId 标签data_id（用于关闭刷新标签页）
	window.parent.newTab(iUrl+"?pdataId="+ window.parent.getDataId() +"&"+ key +"="+ param,iTitle);	
}

/**
 * 删除记录，支持批量删除（参数格式必须为数组）
 * @param iUrl请求url
 * @param iText提示的文本信息（只需关键字）
 * @param params参数 数组eg:params = [{UNID:"2"},{UNID:"1"}]
 * @param callBack回调函数
 */
function delForm(iUrl,iText,params,callBack){
	var ok = false,msg="";
	if (isEmpty(params) || params.length == 0 || isEmpty(params[0])) {
		swal("", "请选择需要删除的"+iText, "warning");
		return;
	}
	var p = params[0];
	$.each(p, function(i) {
	    p = p[i];
	});
	if (isEmpty(p)) {
		swal("", "请选择需要删除的"+iText, "warning");
		return;
	}
	swal({
		title : "您确定要删除这"+ params.length +"条信息吗？",
		text : "删除后将无法恢复，请谨慎操作！",
		type : "warning",
		showCancelButton : true,
		confirmButtonColor : "#DD6B55",
		confirmButtonText : "删除",
		cancelButtonText : "取消",
		closeOnConfirm : false
	}, function() {
		var sLength = params.length;
		for(var i = 0; i < sLength; i++){
			$.ajax({
				type : "POST", // 提交的类型 
				url : iUrl, // 提交地址 
				data : params[i], // 参数 
				dataType : "json",
				async : false,
				success : function(json) {
					if(json.result == '1'){
						msg = json.resultInfo;
						ok = true;
					}else{
						msg = json.resultInfo;
						ok = false;
					}
				},
				error : function(data) {
					msg = "["+ i +"] 请求异常！";
					ok = false;
				}
			});
			if(!ok){
				break;
			}
		}
		if(ok){
			if(msg != "" && msg != null){
				swal("", msg,"success");
			}else{
				swal("删除成功！", "您已经删除了"+ sLength +"条"+ iText +"信息。","success");			
			}
		}else{
			swal("", msg, "error");
		}
		// 执行回调函数
		if (callBack!=null && callBack != ""){
			callBack();
		}
	}); //alert end 
}

/**
 * 操作记录，支持批量操作（参数格式必须为数组） 用于改变状态等常规操作
 * @param iUrl请求url
 * @param iText提示的文本信息（只需关键字）
 * @param params参数 数组eg:params = [{UNID:"2"},{UNID:"1"}]
 * @param callBack回调函数
 */
function operForm(iUrl,iText,params,callBack){
	var ok = false,msg="";
	if (isEmpty(params) || params.length == 0 || isEmpty(params[0])) {
		swal("", "请选择需要"+ iText +"的项目！", "warning");
		return;
	}
	var p = params[0];
	$.each(p, function(i) {
	    p = p[i];
	});
	if (isEmpty(p)) {
		swal("", "请选择需要"+ iText +"的项目！", "warning");
		return;
	}
	swal({
		title : iText +"操作",
		text : "您确定要"+ iText +"这"+ params.length +"条项目吗？",
		type : "warning",
		showCancelButton : true,
		confirmButtonColor : "#DD6B55",
		confirmButtonText : "确定",
		cancelButtonText : "取消",
		closeOnConfirm : false
	}, function() {
		var sLength = params.length;
		for(var i = 0; i < sLength; i++){
			$.ajax({
				type : "POST", // 提交的类型 
				url : iUrl, // 提交地址 
				data : params[i], // 参数 
				dataType : "json",
				async : false,
				success : function(json) {
					if(json.result == '1'){
						ok = true;
					}else{
						msg = json.resultInfo;
						ok = false;
					}
				},
				error : function(data) {
					msg = "["+ i +"] 请求异常！";
					ok = false;
				}
			});
			if(!ok){
				break;
			}
		}
		if(ok){
			swal("",iText+"成功！", "success");
		}else{
			swal("", msg, "error");
		}
		// 执行回调函数
		if (callBack!=null && callBack != ""){
			callBack();
		}
	}); //alert end 
}

/**
 * From表单提交（主要用于添加、修改）
 * @param form表单
 * @param fullUrlAjax提交url
 * @param pdataId 需要重新加载的页面data_id
 * @param callBack回调js
 * @returns {Boolean}
 */
function toSubmit(form, fullUrl,pdataId,callBack) {
	$.ajax({
		type : "POST",
		url : fullUrl,
		data : $(form).serialize(),
		dataType : "json",
		async : false,
		success : function(json) {
			debugger;
			console.info("======================")
			if (json.result == '1') {
				if (!isEmpty(pdataId)){
					swal({
						title : "",
						text : json.resultInfo,
						type : "success",
						showCancelButton : false,
						confirmButtonColor : "#A7D5EA",
						confirmButtonText : "确定",
						closeOnConfirm : false
					}, function() {
						//关闭当前活动tab页面  pdataId 需要重新加载的页面data_id callBack  回调函数（父页调iframe页方法）
						window.parent.closeTab(pdataId,callBack);
					});
				} else if(!isEmpty(callBack)){
					swal({
						title : "",
						text : json.resultInfo,
						type : "success",
						showCancelButton : false,
						confirmButtonColor : "#A7D5EA",
						confirmButtonText : "确定",
						closeOnConfirm : true
					}, function() {
						callBack();
					});
				}else{
					swal({
						title : "",
						text : json.resultInfo,
						type : "success",
						showCancelButton : false,
						confirmButtonColor : "#A7D5EA",
						confirmButtonText : "确定",
						closeOnConfirm : true
					}, function() {
						//关闭当前活动tab页面  pdataId 需要重新加载的页面data_id callBack  回调函数（父页调iframe页方法）
						cancelLayer();
					});
				}
			} else {
				swal("", json.resultInfo, "error");
				return;
			}
		},
		error : function(json) {
			swal("", json.responseText, "error");
		}
	});
	return false;
}

/* 
关闭tab
*/
function cancel(tab){
	var pdataId = $(tab).find("#pdataId");
	if(pdataId){
		window.parent.closeTab(pdataId.val());
	}else{
		console.log("关闭失败，请设置tab的id");
	}
}

/* 
关闭layer
*/
function cancelLayer(){
	parent.layer.close(window.parent.index); 
}

/**  常用方法 **********************************************************************************************************************/

/**
 * 全选/全不选
 * @param pdataTypecheckAll的data-type
 */
function checkAll(pdataType){
	$('[data-type="'+ pdataType +'"]').click(function(){
		if($(this).prop("checked")) {
			$('[type="checkbox"]').prop('checked', true);
		} else {
			$('[type="checkbox"]').prop('checked', false);
		}
	});
}

/* 搜索 查询 */
function searchForm(formId) {
	var oSettings = table.fnSettings();
	var form;
	if(!formId){
		form = $('form.form-search');
	}else{
		form = $("#"+formId);
	}
	if(!form){
		console.log("id不存在");
		return;
	}
	//文本框类型的条件
	var index = 0;
	form.find("input").each(function(){
		$.extend( oSettings.aoPreSearchCols[index++], {
		"sSearch": $(this).val(),
		"bRegex": null,
		"bSmart": null,
		"bCaseInsensitive": null
		} );
		
	});
	table.fnDraw();
}
/**
 * jsTree加载
 * =============================================================================================================================================
 * ***注：
 * ***	加载树格式：{\"id\":\""+ data[i].UNID +"\",\"parent\":\""+ data[i].PARENT_ID +"\",\"text\":\""+ data[i].TEXT +"\"}
 * ***  因此xml里相对应的sql语句查询需使用别名 UNID id，PARENT_ID 父id，TEXT 显示的名称（文本）
 * ***  其中无上级的节点，它的PARENT_ID 父id需为“ # ”号
 * *** 例：
 * ***   SELECT M.MENU_ID UNID, (CASE M.PARENT_MENU_ID WHEN '0' THEN '#' ELSE M.PARENT_MENU_ID END) PARENT_ID, M.MENU_NAME TEXT FROM sys_menu_tab M
 * ==============================================================================================================================================
 * @param id divid
 * @param urlAjax请求地址
 * @param callBack回调函数
 * @param parentId父节点id（用于刷新树）
 * @returns
 */
function initJsTreeCheckBox(id,url,initDataUrl) {
	$.ajaxSetup({cache:false});//ajax调用不使用缓存 
	var jsTree="";
	$.ajax({
		type : "POST",
		url : url+"?t="+ new Date().getTime(),
		dataType : "json",
		async : false,
		success : function(json) {
			if(json.result == '1'){
				jsTree = $('#'+id).jstree({
					core : {
				    	animation:0,
					    check_callback:true,
					    themes : {"stripes":true },
				    	data : getTreeInfo(json.resultObj)
					},
	             	lang : { loading : "菜单目录加载中……" },
					plugins : ["types","dnd","checkbox"],
					types : {"default":{"icon":"fa fa-folder"},"jsp":{"icon":"fa fa-file-text-o"}},
				}).bind("loaded.jstree", function (e, data) {
					$.ajax({
						type : "POST", // 提交的类型 
						url : initDataUrl, // 提交地址 
						dataType:"json",
						success : function(data) {
							if(data.result=="1"){
								$.each(data.resultObj,function(i,item){
									$('#'+id).jstree("select_node","#"+item.PRIV_ID);
								});
							}
						}
					});
					/*if(!isEmpty(parentId)){  //刷新打开操作的节点
						$('#'+id).jstree("toggle_node", "#"+parentId);
					}*/
                });
			}
		},error : function() {
			swal("", "请求异常！", "error");
		}
	});
	return jsTree;
}

//=======================================================================================================
var $sel = {};
$sel.init = function (id, param) {
	var sel = "";
	
	param = param || {};
	var s2param = param;
	//s2param.width = param.width||"150px";
	s2param.vType = param.vType;
	
	if(param.tabdict) {
		sel = $("#"+id).bsSuggest({
	        allowNoKeyword: true,   //是否允许无关键字时请求数据。为 false 则无输入时不执行过滤请求
	        //multiWord: false,         //以分隔符号分割的多关键字支持
	        //separator: ",",          //多关键字支持时的分隔符，默认为空格
	        getDataMethod: "url",    //获取数据的方式，总是从 URL 获取
	        //aeffectiveFieldsAlias:{Id: "序号", keyWord: "关键字", keyValue: "值"},
	        //url: 'http://unionsug.baidu.com/su?p=3&t='+ (new Date()).getTime() +'&wd=', /*优先从url ajax 请求 json 帮助数据，注意最后一个参数为关键字请求参数*/
	        url:"${ctxPath}/topic/ajax/getTabSel?TYPE="+ param.tabdict +"&t="+ (new Date()).getTime(),// +"&sSearch_0=",
	        //jsonp: 'cb',    //如果从 url 获取数据，并且需要跨域，则该参数必须设置
	        processData: function (json) {    // url 获取数据时，对数据的处理，作为 getData 的回调函数
	            var i, data = {value: []};
	            if (!json || !json.resultObj || json.resultObj.length === 0) {
	                return false;
	            }
	            for(i = 0; i < json.resultObj.length; i++) {
	                data.value.push({
	                    "id": json.resultObj[i].ID,
	                    "word": json.resultObj[i].TEXT
	                });
	            }
	            //字符串转化为 js 对象
	            return data;
	        }
	    }).on('onSetSelectValue', function (e, keyword, data) {//选中
	        //console.log('onSetSelectValue: ', keyword, data);
	    	$("#"+id).val(data.id);
	    });
	}
	return sel;
};

/**
 * 判断对象是否为空
 * @param str对象、字符串
 * @returns {Boolean}
 */
function isEmpty(str){
	if(str == '' || str == null || str.length == 0 || typeof(str) == "undefined"){
		return true;
	}
	return false;
}
/**
 * 字符串替换
 * @param s1需要替换掉的字符串
 * @param s2替换字符串
 * @returns替换后的字符串
 */
String.prototype.replaceAll = function(s1,s2){return this.replace(new RegExp(s1,"gm"),s2);};

function showFormFootTool(formId){
	var pageHeight=$("#content-main",window.parent.document).height();
	var $form=$("#"+formId);
	var $footTool=$("#form_foot_tool");
	$form.css("overflow-y","auto");
	$form.css("overflow-x","hidden");
	var formHeight=pageHeight-$form.position().top;
	$form.height(formHeight);
	$form.css("padding-bottom",$footTool.height());
	$footTool.css("position","absolute");
	$footTool.offset({top: pageHeight-$footTool.height()});
	$(window).scroll( function() {
		$footTool.offset({top: pageHeight-$footTool.height()});
	});
}