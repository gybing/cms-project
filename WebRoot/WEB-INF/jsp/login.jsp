<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">

    <title>小区物业管理系统</title>
 	<jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
 	<link rel="stylesheet" href="${resRoot}/hplus/css/login.min.css">	
    <!--[if lt IE 8]>
    <meta http-equiv="refresh" content="0;ie.html" />
    <![endif]-->
    <script>
        if(window.top!==window.self){window.top.location=window.location};
    </script>

</head>

<body class="signin">
    <div class="signinpanel">
        <div class="row">
            <div class="col-sm-7">
                <div class="signin-info">
                    <div class="logopanel m-b">
                        <h1>小区物业管理系统</h1>
                    </div>
                    <div class="m-b"></div>
                    <h4><strong>欢迎使用 </strong></h4>
                    <ul class="m-b">
                        <li><i class="fa fa-arrow-circle-o-right m-r-xs"></i> 优势一</li>
                        <li><i class="fa fa-arrow-circle-o-right m-r-xs"></i> 优势二</li>
                        <li><i class="fa fa-arrow-circle-o-right m-r-xs"></i> 优势三</li>
                        <li><i class="fa fa-arrow-circle-o-right m-r-xs"></i> 优势四</li>
                        <li><i class="fa fa-arrow-circle-o-right m-r-xs"></i> 优势五</li>
                    </ul>
                   <!--  <strong>还没有账号？ <a href="#">立即注册&raquo;</a></strong> -->
                </div>
            </div>
            <div class="col-sm-5">
                <form method="post" action="${ctxPath }/topic/bsm$login">
                    <h4 class="no-margins">登录：</h4>
                   	<input type="text" name="usercode"  style="width: 257px;" class="form-control uname" placeholder="用户名" required="">
                    <input type="password" name="passwd" class="form-control" placeholder="密码" required="">
                    <p class="m-t-md"></p>
					<a href="">忘记密码，请联系管理员！</a> 
                    <button class="btn btn-success btn-block">登录</button>
                </form>
            </div>
        </div>
        <div class="signup-footer">
            <div class="pull-left">
                &copy; 2015 All Rights Reserved.
            </div>
        </div>
    </div>
</body>

</html>