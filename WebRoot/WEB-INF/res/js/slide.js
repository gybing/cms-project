var st;
var slide_start=0;
var dot_atv=1;
var sldStr="[{color:'#8f0c03',href:'zt1.asp',img:'images/banner1.jpg'},{color:'#4677af',href:'about.asp',img:'images/banner2.jpg'},{color:'#ffffff',href:'zt2.asp',img:'images/banner3.jpg'}]";
var sld=eval(sldStr);
var slide_count=sld.length;
function slide(slide_show){//幻灯片切换显示函数
	$(".slide_dot span").removeClass("atv");
	$(".slide_dot span:eq("+slide_show+")").addClass("atv");//重置圆点状态,并醒目显示目标圆点
	$(".slide_cont div").fadeOut();
	//$(".slide_cont").find("div:eq("+slide_show+")").css("background",sld[slide_show].color);//隐藏所有图片,显示目标图片
	$(".slide_cont").find("div:eq("+slide_show+")").fadeIn();//隐藏所有图片,显示目标图片
	if(slide_show+1>=slide_count){
		slide_start=0;	
	}else{
		slide_start++;	
	}//下一张显示图片的参数计算
	st=setTimeout('slide(slide_start)',3000);//计时器自动循环调用本函数
}
$(function(){
	for(var i=0; i<slide_count; i++){//根据slide_count参数，插入切换的圆点
		if(i==0){
			$(".slide_dot").append("<span class='atv'></span>");
		}else{
			$(".slide_dot").append("<span></span>");
		}
		$(".slide_cont").append("<div style='background:"+sld[i].color+"'><a href='"+sld[i].href+"'><img src='"+sld[i].img+"' /></a></div>")
	}
	$(".slide_prev,.slide_next").css({opacity:0.5});
	$(".slide_prev,.slide_next").mouseenter(function(){
		$(this).css({opacity:1});
	}).mouseleave(function(){
		$(this).css({opacity:0.5});
	}).click(function(){
		clearTimeout(st);//清除计时
		if($(this).hasClass("slide_prev")){//向上翻时，计算目标显示内容。SLIDE_START总是比当前位置往前一帧，需要特殊处理
			if(slide_start==1){
				slide_start=slide_count-1;
			}else if(slide_start==0){
				slide_start=slide_count-2;
			}else{
				slide_start=slide_start-2;	
			}
		}
		slide(slide_start);
	});
	$(".slide_dot span").mouseenter(function(){//鼠标移上时,变成醒目圆点
		$(this).addClass("atv");	
	}).click(function(){//鼠标点击事件
		clearTimeout(st);//清除计时
		slide_start=0;//重置显示的起始参数
		$(this).prevAll("span").each(function(){//计算应显示的参数
			slide_start++;
		});
		slide(slide_start);
	}).mouseleave(function(){//鼠标移出时的函数
		dot_atv=1;
		$(this).prevAll("span").each(function(){
			dot_atv++;
		});//显示指针计算
		if(dot_atv>=slide_count){dot_atv=0;}//显示指针校对
		if(dot_atv!=slide_start){//鼠标移出时,根据指针移除不必要的醒目显示圆点样式
			$(this).removeClass("atv");	
		}
	});
	slide(slide_start);
});
