$(function() {
	if($("#source").val()==2 || $("#source").val()==3){
		selectedDiv($("#source").val());
	}else{
		selectedDiv(1);
	}
	$("#u1").on("click", function() {
		selectedDiv(1);
		$("#line1").show();
		$("#line2").hide();
		$("#line3").hide();
		
	});
	$("#u2").on("click", function() {
		selectedDiv(2);
		$("#line2").show();
		$("#line3").show();
		$("#line1").hide();
	});
	$("#u3").on("click", function() {
		selectedDiv(3);
		$("#line2").show();
		$("#line3").show();
		$("#line1").hide();
	});
});

function selectedDiv(index) {
	$("#source").val(index);
	var arrowHeight = $(".arrow").height();
	for ( var i = 1; i < 4; i++) {
		var $div = $("#u" + i);
		var height = $div.height();
		var top = $div.offset().top + height;
		if (index == i) {
			$div.addClass("activity");
			$div.find("img").attr("src", _resRoot+"/img/u1.png");
			$(".arrow").offset({
				top : (top - (height + arrowHeight) / 2)
			});
		} else {
			$div.removeClass("activity");
			$div.find("img").attr("src", _resRoot+"/img/u3.png");
		}
	}
}

function submitForm() {
	if ($('#name').val() == "") {
		alert("用户名不能为空！");
		return false;
	}
	if ($('#pw').val() == "") {
		alert("密码不能为空！");
		return false;
	}
	$('#zyy_form').submit();
}