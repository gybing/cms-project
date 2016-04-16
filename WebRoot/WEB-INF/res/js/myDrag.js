/**
 * 
 */


$.fn.myDrag = function() {
	var self = $(this);
	self.mousedown(
	
	function(event) {
		self.css("position", "absolute");
		var p = self.position();
		self.css({
			left: p.left,
			top: p.top
		});
		// debugger; 
		self.data("ifDary", "true"); //保存状态，表示是否可以拖拽 
		// debugger; 
		var selfLeft = event.pageX - parseInt(self.css("left")); //计算出鼠标到这个元素的left
		var selfTop = event.pageY - parseInt(self.css("top")); //计算出鼠标到这个元素的top 
		self.data("selfLeft", selfLeft); //保存坐标信息 
		self.data("selfTop", selfTop);
	});
	
		
	$(document).mouseup(

	function() {
		self.data("ifDary", "false");
		//防止窗体飞到外面去 
		var bWidth = $(window).width();
		var bHeight = $(window).height();
		var currentleft = parseInt(self.css("left"));
		var currenttop = parseInt(self.css("top"));
		if (currentleft <= 0) currentleft = 0;
		if (currentleft >= bWidth) currentleft = bWidth - self.width();
		if (currenttop <= 0) currenttop = 0;
		if (currenttop >= bHeight) currenttop = bHeight - self.height();
		self.css({
			left: currentleft,
			top: currenttop
		});
	});
	$(document).mousemove(function(event) {
		var state = self.data("ifDary");
		if (state && state == "true") {
			var selfLeft = event.pageX - parseInt(self.data("selfLeft")); //计算这个元素的left位置 
			var selfTop = event.pageY - parseInt(self.data("selfTop"));
			self.css({
				left: selfLeft,
				top: selfTop
			}); //设置这个元素的位置 
		}
	});
	return self;
}