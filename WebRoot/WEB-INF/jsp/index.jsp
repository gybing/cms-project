<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.cms.common.bean.UserSessionBean" %> 
<%@ page import="com.cms.common.form.ResponseDataForm" %>
<%@ page import="com.cms.common.utils.MapUtils" %>
<%@ page import="com.cms.common.cache.GlobalCache"%>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <title>智慧小区物业管理系统</title>

	<jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>

    <!--[if lt IE 8]>
    <meta http-equiv="refresh" content="0;ie.html" />
    <![endif]-->

    <link rel="shortcut icon" href="${resRoot}/icon.jpg">
  	<script type="text/javascript">	
		var _contextPath = "${ctxPath}";
	    var _resRoot = "${resRoot}";
	    
	    //处理ie下面get缓存
	     $.ajaxSetup({ cache: false });
		//用户注销退出
	    function logout() {	    	
			swal({
				title : "您确定要退出吗",
				text : "退出后需重新登录！",
				type : "warning",
				showCancelButton : true,
				confirmButtonColor : "#DD6B55",
				confirmButtonText : "退出",
				cancelButtonText: "取消",
				closeOnConfirm : false
			}, function() {
				window.location.href = "${ctxPath}/topic/bsm$logout";
				swal("退出成功！", null, "success");
			});
	    }
	    //打开新tab页 iUrl ajax执行url,iTitle tab标签名,dataId 标签data_id（用于关闭刷新标签页）
	    function newTab(iUrl,iTitle,dataId){
			var t = $.trim(iUrl),i = $.trim(iTitle),a=new Date().getTime(),n=!0;
			if(isEmpty(dataId)){ //根据url截取data_id
				var start = t.lastIndexOf("/"),end = t.indexOf("?")==-1 ? t.length : t.indexOf("?");
				dataId = t.substring(start+1, end);
			}
			if(void 0==t || 0==$.trim(t).length){
				return !1;
			}
			if($(".J_menuTab").each(function(){
				return $(this).data("id")==dataId?(
						$(this).hasClass("active") || 
						($(this).addClass("active").siblings(".J_menuTab").removeClass("active"),
								e(this),
								$(".J_mainContent .J_iframe").each(function(){
									return $(this).data("id")==dataId?($(this).show().siblings(".J_iframe").hide(),!1):void 0;
								})
						),
						n=!1,
						!1
					):void 0;
				}),n){
				var s='<a href="javascript:;" class="active J_menuTab" data-id="'+dataId+'">'+i+' <i class="fa fa-times-circle"></i></a>';
				$(".J_menuTab").removeClass("active");
				var r='<iframe class="J_iframe" name="iframe'+a+'" width="100%" height="100%" src="'+t+'" frameborder="0" data-id="'+dataId+'" seamless></iframe>';
				$(".J_mainContent").find("iframe.J_iframe").hide().parents(".J_mainContent").append(r);
				var o=layer.load();
				$(".J_mainContent iframe:visible").load(function(){layer.close(o);}),
				$(".J_menuTabs .page-tabs-content").append(s),e($(".J_menuTab.active"));
			}else{//同个活动页的话则关闭活动页 然后重新打开一个新的活动页，以【刷新活动页里的内容】
				$(".J_mainContent .J_iframe").each(function(){
					if($(this).data("id")==dataId){
						$(this).remove();$(".J_menuTab.active").remove();
						newTab(iUrl,iTitle,dataId);
					}
				});
			}
			return!1;
		}
	    
	  	//关闭当前活动tab页面  pdataId 需要重新加载的页面data_id callBack 回调函数（父页调iframe页方法）
	    function closeTab(pdataId,callBack){
	    	var e = $(".J_menuTab.active");//当前活动页
			$(".J_mainContent .J_iframe").each(function(){
				if($(this).data("id")==e.data("id")){
					$(this).remove(),e.remove();
				}
			});
			if(!isEmpty(pdataId)){
				//加载指定data_id的tab页面，并根据回调函数刷新页面 或 重新加载页面（刷新）
				$(".J_mainContent .J_iframe").each(function(){
					if($(this).data("id")==pdataId){
						var t=$('.J_iframe[data-id="'+$(this).data("id")+'"]');
						t.show(),$('.J_menuTab[data-id="'+$(this).data("id")+'"]').addClass("active");
						if (callBack!=null && callBack != ""){
							var n=t.attr("name"),cb=n+".window."+callBack;
							eval('(' + cb + ')');
						}else{ //重新加载页面（刷新） 
							var e=t.attr("src"),a=layer.load();
							t.attr("src",e).load(function(){
								layer.close(a);
							});
						}
					}
				});
	    	}
	  	}
	  	//获取当前活动标签 data_id（用于刷新页面）
	  	function getDataId(){
	  		return $(".J_menuTab.active").data("id");
	  	}
	</script>
</head>
<body class="fixed-sidebar full-height-layout gray-bg" style="overflow:hidden">
    <div id="wrapper">
        <!--左侧导航开始-->
        <nav class="navbar-default navbar-static-side" role="navigation">
            <div class="nav-close"><i class="fa fa-times-circle"></i>
            </div>
            <div class="sidebar-collapse">
                <ul class="nav" id="side-menu">
                    <li class="nav-header">
                        <div class="dropdown profile-element">
                            <span><img alt="image" style="width:64px" class="img-circle" src="${sessionScope.SESSION_USER_LOGIN_INFO.userInfo.PIC }" /></span>
                            <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                                <span class="clear">
                                <span class="block m-t-xs"><strong class="font-bold">&nbsp;&nbsp;${SESSION_USER_LOGIN_INFO.userName }</strong></span>
                                <span class="text-muted text-xs block"><b class="caret"></b></span>
                                </span>
                            </a>
                            <ul class="dropdown-menu animated fadeInRight m-t-xs">
                                <li><a class="J_menuItem" href="${ctxPath }/topic/toEditHeader">修改头像</a>
                                <li><a class="J_menuItem" href="${ctxPath }/topic/toEditPwdPage">修改密码</a>
                               <!-- </li>
                                <li><a class="J_menuItem" href="profile.html">个人资料</a></li>
                                <li><a class="J_menuItem" href="contacts.html">联系我们</a></li>
                                <li><a class="J_menuItem" href="mailbox.html">信箱</a></li>
                                <li class="divider"></li> -->
                                <li class="divider"></li>
                                <li><a style="color:black;" href="javascript:void(0);" onClick="logout();">安全退出</a>
                                </li>
                            </ul>
                        </div>
                        <!-- <div class="logo-element">城市配送运输管理系统
                        </div> -->
                    </li>
                    <!-- 菜单列表  -->
                    ${MENU_SESSIONN_INFO }
                    <!-- 菜单列表 -->
                </ul>
            </div>
        </nav>
        <!--左侧导航结束-->
        <!--右侧部分开始-->
        <div id="page-wrapper" class="gray-bg dashbard-1" style="overflow:hidden">
            <div class="row border-bottom">
                <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
                    <div class="navbar-header"><a class="navbar-minimalize minimalize-styl-2 btn btn-primary " href="#"><i class="fa fa-bars"></i> </a>
                        <!-- 搜索框 from表单 -->
                        <!-- <form role="search" class="navbar-form-custom" method="post" action="search_results.html">
                            <div class="form-group">
                                <input type="text" placeholder="请输入您需要查找的内容 …" class="form-control" name="top-search" id="top-search">
                            </div>
                        </form> -->
                        <div>
                        	<label style="font-size:x-large;padding-left: 25px;padding-top: 12px;">智慧小区物业管理系统</label>
                    	</div>
                    </div>
                    <!-- 右上角 栏目 信箱。。。 -->
                    <ul class="nav navbar-top-links navbar-right">
                        <%-- <li class="dropdown">
                            <a class="dropdown-toggle count-info" data-toggle="dropdown" href="#">
                                <i class="fa fa-envelope"></i> <span class="label label-warning">16</span>
                            </a>
                            <!-- 信箱缩略列表信息 -->
                            <ul class="dropdown-menu dropdown-messages">
                                <li class="m-t-xs">
                                    <div class="dropdown-messages-box">
                                        <a href="profile.html" class="pull-left">
                                            <img alt="image" class="img-circle" src="${resRoot}/hplus/img/a7.jpg">
                                        </a>
                                        <div class="media-body">
                                            <small class="pull-right">46小时前</small>
                                            <strong>小四</strong> 这个在日本投降书上签字的军官，建国后一定是个不小的干部吧？
                                            <br>
                                            <small class="text-muted">3天前 2014.11.8</small>
                                        </div>
                                    </div>
                                </li>
                                <li class="divider"></li>
                                <li>
                                    <div class="dropdown-messages-box">
                                        <a href="profile.html" class="pull-left">
                                            <img alt="image" class="img-circle" src="${resRoot}/hplus/img/a4.jpg">
                                        </a>
                                        <div class="media-body ">
                                            <small class="pull-right text-navy">25小时前</small>
                                            <strong>国民岳父</strong> 如何看待“男子不满自己爱犬被称为狗，刺伤路人”？——这人比犬还凶
                                            <br>
                                            <small class="text-muted">昨天</small>
                                        </div>
                                    </div>
                                </li>
                                <li class="divider"></li>
                                <li>
                                    <div class="text-center link-block">
                                        <a class="J_menuItem" href="mailbox.html">
                                            <i class="fa fa-envelope"></i> <strong> 查看所有消息</strong>
                                        </a>
                                    </div>
                                </li>
                            </ul>
                        </li>
                        <!-- 通知栏 -->
                        <li class="dropdown">
                            <a class="dropdown-toggle count-info" data-toggle="dropdown" href="#">
                                <i class="fa fa-bell"></i> <span class="label label-primary">8</span>
                            </a>
                            <ul class="dropdown-menu dropdown-alerts">
                                <li>
                                    <a href="mailbox.html">
                                        <div>
                                            <i class="fa fa-envelope fa-fw"></i> 您有16条未读消息
                                            <span class="pull-right text-muted small">4分钟前</span>
                                        </div>
                                    </a>
                                </li>
                                <li class="divider"></li>
                                <li>
                                    <a href="profile.html">
                                        <div>
                                            <i class="fa fa-qq fa-fw"></i> 3条新回复
                                            <span class="pull-right text-muted small">12分钟钱</span>
                                        </div>
                                    </a>
                                </li>
                                <li class="divider"></li>
                                <li>
                                    <div class="text-center link-block">
                                        <a class="J_menuItem" href="notifications.html">
                                            <strong>查看所有 </strong>
                                            <i class="fa fa-angle-right"></i>
                                        </a>
                                    </div>
                                </li>
                            </ul>
                        </li>
                        <li class="hidden-xs">
                            <a href="index_v1.html" class="J_menuItem" data-index="0"><i class="fa fa-cart-arrow-down"></i> 购买</a>
                        </li> --%>
                        <!-- <li class="dropdown hidden-xs">
                            <a class="right-sidebar-toggle" aria-expanded="false">
                                <i class="fa fa-tasks"></i> 主题
                            </a>
                        </li> -->
                    </ul>
                </nav>
            </div>
            <div class="row content-tabs">
                <button class="roll-nav roll-left J_tabLeft"><i class="fa fa-backward"></i>
                </button>
                <nav class="page-tabs J_menuTabs">
                    <div class="page-tabs-content">
                        <a href="javascript:;" class="active J_menuTab" data-id="index_v1.jsp">首页</a>
                    </div>
                </nav>
                <button class="roll-nav roll-right J_tabRight"><i class="fa fa-forward"></i>
                </button>
                <div class="btn-group roll-nav roll-right">
                    <button class="dropdown J_tabClose" data-toggle="dropdown">关闭操作<span class="caret"></span>

                    </button>
                    <ul role="menu" class="dropdown-menu dropdown-menu-right">
                        <li class="J_tabShowActive"><a>定位当前选项卡</a>
                        </li>
                        <li class="divider"></li>
                        <li class="J_tabCloseAll"><a>关闭全部选项卡</a>
                        </li>
                        <li class="J_tabCloseOther"><a>关闭其他选项卡</a>
                        </li>
                    </ul>
                </div>
                <a href="javascript:void(0);" onClick="logout();" class="roll-nav roll-right J_tabExit"><i class="fa fa fa-sign-out"></i>退出</a>
            </div>
            <div class="row J_mainContent" id="content-main">
                <iframe class="J_iframe" name="iframe0" width="100%" height="100%" src="${ctxPath}/topic/index"  frameborder="0" data-id="index_v1.jsp" seamless></iframe>
            </div>
            <!-- <div class="footer">
                <div class="pull-right">承建单位： <a href="http://www.cms.com" target="_blank" title="未名集团">福建未名信息技术股份有限公司</a>
                </div>
            </div> -->
        </div>
        <!--右侧部分结束-->
        <!--右侧边栏开始-->
        <!-- <div id="right-sidebar">
            <div class="sidebar-container">
                <ul class="nav nav-tabs navs-3">
                    <li class="active">
                        <a data-toggle="tab" href="#tab-1"><i class="fa fa-gear"></i> 主题</a>
                    </li>
                    <li><a data-toggle="tab" href="#tab-2">通知</a></li>
                    <li><a data-toggle="tab" href="#tab-3">项目进度</a></li>
                </ul>

                <div class="tab-content">
                    <div id="tab-1" class="tab-pane active">
                        <div class="sidebar-title">
                            <h3> <i class="fa fa-comments-o"></i> 主题设置</h3>
                            <small><i class="fa fa-tim"></i> 你可以从这里选择和预览主题的布局和样式，这些设置会被保存在本地，下次打开的时候会直接应用这些设置。</small>
                        </div>
                        <div class="skin-setttings">
                            <div class="title">主题设置</div>
                            <div class="setings-item">
                                <span>收起左侧菜单</span>
                                <div class="switch">
                                    <div class="onoffswitch">
                                        <input type="checkbox" name="collapsemenu" class="onoffswitch-checkbox" id="collapsemenu">
                                        <label class="onoffswitch-label" for="collapsemenu">
                                            <span class="onoffswitch-inner"></span>
                                            <span class="onoffswitch-switch"></span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="setings-item">
                                <span>固定顶部</span>

                                <div class="switch">
                                    <div class="onoffswitch">
                                        <input type="checkbox" name="fixednavbar" class="onoffswitch-checkbox" id="fixednavbar">
                                        <label class="onoffswitch-label" for="fixednavbar">
                                            <span class="onoffswitch-inner"></span>
                                            <span class="onoffswitch-switch"></span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="setings-item">
                                <span>
                        固定宽度
                    </span>

                                <div class="switch">
                                    <div class="onoffswitch">
                                        <input type="checkbox" name="boxedlayout" class="onoffswitch-checkbox" id="boxedlayout">
                                        <label class="onoffswitch-label" for="boxedlayout">
                                            <span class="onoffswitch-inner"></span>
                                            <span class="onoffswitch-switch"></span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="title">皮肤选择</div>
                            <div class="setings-item default-skin nb">
                                <span class="skin-name ">
                         <a href="#" class="s-skin-0">
                             默认皮肤
                         </a>
                    </span>
                            </div>
                            <div class="setings-item blue-skin nb">
                                <span class="skin-name ">
                        <a href="#" class="s-skin-1">
                            蓝色主题
                        </a>
                    </span>
                            </div>
                            <div class="setings-item yellow-skin nb">
                                <span class="skin-name ">
                        <a href="#" class="s-skin-3">
                            黄色/紫色主题
                        </a>
                    </span>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div> -->
    </div>
    <script type="text/javascript">
    	
	    window.onload=function(){  
	    	/* 防止回退键返回上一页面 */
	        document.getElementsByTagName("body")[0].onkeydown =function(event){  
	              
	            //获取事件对象  
	            var elem = event.relatedTarget || event.srcElement || event.target ||event.currentTarget;   
	              
	            if(event.keyCode==8){//判断按键为backSpace键  
	               //alert(234);
                   //获取按键按下时光标做指向的element  
                    var elem = event.target || event.srcElement || event.currentTarget;   
                      
                    //判断是否需要阻止按下键盘的事件默认传递  
                    var name = elem.nodeName;  
                      
                    if(name!='INPUT' && name!='TEXTAREA'){  
                        return _stopIt(event);  
                    }  
                    var type_e = elem.type.toUpperCase();  
                    if(name=='INPUT' && (type_e!='TEXT' && type_e!='TEXTAREA' && type_e!='PASSWORD' && type_e!='FILE')){  
                            return _stopIt(event);  
                    }  
                    if(name=='INPUT' && (elem.readOnly==true || elem.disabled ==true)){  
                            return _stopIt(event);  
                    }  
                }  
            } ; 
        } ; 
	    function _stopIt(e){  
	            if(e.returnValue){  
	                e.returnValue = false ;  
	            }  
	            if(e.preventDefault ){  
	                e.preventDefault();  
	            }                 
	      
	            return false;  
	    }  
    </script>
</body>
</html>
