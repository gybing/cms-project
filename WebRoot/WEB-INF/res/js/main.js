function width(){
	var min_w=1002;
	var max_w=1200;
	var win_w=$(window).width();
	var wrap_w=1100;
	if(win_w<min_w){
		wrap_w=min_w;
		$("body").width(min_w);
	}
	if(win_w>=min_w && win_w<=max_w){
		wrap_w=win_w;
		$("body").width("auto");
	}
	if(win_w>max_w){
		wrap_w=max_w;
		$("body").width("auto");
	}
	$(".top,.slide_dot_wrap,.cont2,.shadow_1,.top_log").width(wrap_w);
	$(".nav_sec").width(wrap_w-40);
	$(".shadow_1").find(".nav_sec").width(wrap_w-52);
	$(".centra_right").width(wrap_w-218);
}
	$(function(){
		width();
		alert_pos();
		$(".centra_nav div").mouseenter(function () {
		    if (!$(this).hasClass("csplit")) { $(this).toggleClass("hover");}
		}).mouseleave(function () {
		    if (!$(this).hasClass("csplit")) { $(this).toggleClass("hover"); }
		});
		$(".reg_js").focus(function(){
			if($(this).val()==$(this).attr("value")){$(this).val("");}
		}).blur(function(){
			if($(this).val().length==0){
				$(this).val($(this).attr("value"));
			}
		});
		$(".cgpassword").focus(function(){
			$(this).blur();
			$(this).hide();
			$(this).prev().show();	
			$(this).prev().focus();	
		});
		$(".cgpassword2").blur(function(){
			if($(this).val().length<=0){
				$(this).hide();
				$(this).next().show();	
			}
		});
		$(".log_wjmm").click(function(){
			$(".logwrap").hide();
			$(".zhmmwrap").fadeIn();
		});
		$(".log_zczh").click(function(){
			$(".logwrap").hide();
			$(".zhmmwrap").hide();
			$(".regwrap").fadeIn();
		});
		$(".log_dlyb").click(function(){
			$(".regwrap").hide();
			$(".zhmmwrap").hide();
			$(".logwrap").fadeIn();
		});
		$(window).resize(function(){
			width();
			alert_pos();
		});
		$(".input_log").click(function(){
			$(this).addClass("log_show");
			$(this).select();
		}).blur(function(){
			if($(this).val().length==0){
				$(this).removeClass("log_show");
			}
		});
		$(".reg").click(function(){
			$(".alert_wrap,.regwrap").show();
		});
		$(".log").click(function(){
			$(".alert_wrap,.logwrap").show();
		});
		$(".log_close").click(function(){
			$(".alert_wrap,.logwrap,.regwrap,.zhmmwrap").hide();
		});
		$(".ctrl_tr tr").mouseenter(function(){
			$(this).find(".manage_tip_wrap").show();	
		}).mouseleave(function(){
			$(this).find(".manage_tip_wrap").hide();	
		});
		$(".cont_wrap").children("div:first").show();
		$(".centra_nav").height($(".centra").height());
		$(".quick_list").find(".quick_div:even").addClass("quick_list_bg");
		$(".quick_div").mouseenter(function(){
			$(this).addClass("quick_list_bg_flash")	;
		}).mouseleave(function(){
			$(this).removeClass("quick_list_bg_flash")	;
		});
		$(".input_text").focus(function(){
			$(this).addClass("input_text_green");	
		}).blur(function(){
			$(this).removeClass("input_text_green");	
		});
		$(".btn_submit").mouseenter(function(){
			$(this).addClass("btn_submit_atv");	
		}).mouseleave(function(){
			$(this).removeClass("btn_submit_atv");	
		});
		$(".btn_log").mouseenter(function(){
			$(this).addClass("btn_log_atv");	
		}).mouseleave(function(){
			$(this).removeClass("btn_log_atv");	
		});
		$(".btn_reg").mouseenter(function(){
			$(this).addClass("btn_reg_atv");	
		}).mouseleave(function(){
			$(this).removeClass("btn_reg_atv");	
		});
		
		$(".title1_left *").mouseenter(function(){
			$(this).parent().find("*").removeClass("atv");
			$(this).addClass("atv");
			var i=0;
			$(this).prevAll("*").each(function(){i++;});
			$(".cont_wrap").children("div").hide();
			$(".cont_wrap").children("div:eq("+i+")").show();
		});
		$(".search_nav a").mouseenter(function(){
			$(this).parent().find("a").removeClass("atv");
			$(this).parent().find("a").removeClass("search_nav_border");
			$(this).addClass("atv");
			var i=0;
			$(this).prevAll("a").each(function(){i++;});
			if(i==2){$(this).prev("a").addClass("search_nav_border");}
			$(".search_wrap").children(".search_cont").hide();
			$(".search_wrap").children(".search_cont:eq("+i+")").show();
		});
			$(".bg_change_tab").find("tr:odd").addClass("bg_change");
			$(".bg_change_tab").find("tr").mouseenter(function(){
				$(this).addClass("bg_flash");
			}).mouseleave(function(){
				$(this).removeClass("bg_flash");
			});
			$(".cy_list_wrap").children("div:odd").addClass("bg_change2");
			$(".cy_list_wrap").children("div").mouseenter(function(){
				$(this).addClass("bg_flash2");
			}).mouseleave(function(){
				$(this).removeClass("bg_flash2");
			});
		$(".cy_list_show").click(function(){
			$(".alert_wrap").show();
			$(".alert_cont").show();
		});
		$(".hyxq").click(function(){
			$(".alert_wrap").show();
			$(".alert_cont").show();
		});
		$(".close").click(function(){
			$(".alert_wrap").hide();
			$(this).parent().hide();	
		});
		$(".alert_wrap").click(function(){
			$(".alert_wrap").hide();
			$(".regwrap,.logwrap,.alert_cont").hide();	
		});
		function alert_pos(){
			var win_width;
			//if($(window).width()<1002){$("body").width("1002");}else{$("body").width("auto");}
			if($(window).width()<1002){win_width=1002;}else{win_width=$(window).width();}
			$(".alert_wrap").width(win_width);
			$(".regwrap,.logwrap,.zhmmwrap").css("left",($(window).width()-374)/2);
			var alert_cont_w=$(".alert_cont").outerWidth(false);
			var alert_cont_h=$(".alert_cont").outerHeight(false);
			var window_w=$(window).width();
			var window_h=$(window).height();
			var scroll_top=0;
			if(window_w>alert_cont_w){
				$(".alert_cont").css("left",(window_w-alert_cont_w)/2);
			}else{
				$(".alert_cont").css("width",window_w);
				$(".alert_cont").css("left","0");
			}
			if(window_h>alert_cont_h){
				$(".alert_cont").css("top",(window_h-alert_cont_h)/2);
			}else{
				$(".alert_cont").css("height",window_h);
				$(".alert_cont").css("top","0");
			}
		}
		$(window).scroll(function(){
			$(".regwrap,.logwrap").css("top",$(document).scrollTop()+60);
			$(".alert_wrap").css("top",$(document).scrollTop());
			scroll_top=$(document).scrollTop();
		});
	});



