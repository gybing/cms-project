(function($){
	
	// 判断jQuery插件是否存在. 
	if (!$ || $.isFunction() || !$.ajax) {
		alert('jiyun.Dict: jQuery is unloaded!');
		throw new Exception('jiyun.Dict: jQuery is unloaded!');
	}
	
	if (!window.jiyun || !jiyun) {
		window.jiyun = {};
	}
	
	var Dict = window.jiyun.Dict = {};
	
	// 项目根路径. 
	Dict.ctxPath = '/jiyun';
	
	// 初始化方法
	// 在js文件中无法识别el表达式. 通过init方法进行设置
	Dict.init = function(ctxPath) {
		Dict.ctxPath = ctxPath;
	}
	
	// 获取本地存储的字典项
	Dict.getItem = function(itemName){
		//console.log('Dict.getItem --> ', itemName);
		var item = window.localStorage.getItem(itemName);
		if (!item) {
			//console.log('read from server');
			item = Dict.setItem(itemName);
			//console.log('from server -->', item);
		} else {
			//console.log('read from local');
		}
		return JSON.parse(window.localStorage.getItem(itemName));
	}
	
	// 设置本地存储的字典项
	Dict.setItem = function(itemName) {
		var item = null;
		try {
			item = ajaxGetDict(itemName);
			//console.log('ajax -->', item);
			window.localStorage.setItem(itemName, JSON.stringify(item));
		} catch (ex) {			
			// 数据存储到本地时有能发生异常.如: 超出本地存储限制 等.
			window.localStorage.removeItem(itemName);
		}
		return item;
	}
	
	// 删除本地存储的字典项
	Dict.removeItem = function(itemName) {
		window.localStorage.removeItem(itemName);
	}
	
	// 清空本地存储的全部字典项
	Dict.clearAll = function() {
		window.localStorage.clear();
	}
	
	var ajaxGetDict = function(dictName) {
		 var result = null;
		 $.ajax({
			async : false,  
			type : "POST",
			url : Dict.ctxPath + '/comm/dict',
			data : {"type" : dictName},
			dataType : "json",
			success : function(data, textStatus, jqXHR) {
				//console.log('data -->', data);
				if (data.result == 1) {
					result = data.resultObj;
				}
			}, 
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert('jiyun.Dict: jquery ajax request failed');
				throw new Exception('jiyun.Dict: jquery ajax request failed');
			}
		});
		return result; 
	}
	
})(jQuery);