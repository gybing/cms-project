<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>新增人员</title>
<jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
<script type="text/javascript" src="${resRoot }/hplus/js/plugins/cropper/cropper.min.js"></script>
<link rel="stylesheet" href="${resRoot }/hplus/css/plugins/cropper/cropper.min.css">
<script type="text/javascript" src="${resRoot }/hplus/js/cropper.mian.js"></script>
<style type="text/css">
body {
  background-color: #fcfcfc;
}

.avatar-view {
  display: block;
  margin: 0 auto;
  height: 200px;
  width: 200px;
  border: 3px solid #fff;
  border-radius: 5px;
  box-shadow: 0 0 5px rgba(0,0,0,.15);
  cursor: pointer;
  overflow: hidden;
}

.avatar-view img {
  width: 100%;
}

.avatar-body {
  padding-right: 15px;
  padding-left: 15px;
}

.avatar-upload {
  overflow: hidden;
}

.avatar-upload label {
  display: block;
  float: left;
  clear: left;
  width: 100px;
}

.avatar-upload input {
  display: block;
  margin-left: 110px;
}

.avater-alert {
  margin-top: 10px;
  margin-bottom: 10px;
}

.avatar-wrapper {
  height: 364px;
  width: 100%;
  margin-top: 15px;
  box-shadow: inset 0 0 5px rgba(0,0,0,.25);
  background-color: #fcfcfc;
  overflow: hidden;
}

.avatar-wrapper img {
  display: block;
  height: auto;
  max-width: 100%;
}

.avatar-preview {
  float: left;
  margin-top: 15px;
  margin-right: 15px;
  border: 1px solid #eee;
  border-radius: 4px;
  background-color: #fff;
  overflow: hidden;
}

.avatar-preview:hover {
  border-color: #ccf;
  box-shadow: 0 0 5px rgba(0,0,0,.15);
}

.avatar-preview img {
  width: 100%;
}

.preview-lg {
  height: 184px;
  width: 184px;
  margin-top: 15px;
}

.preview-md {
  height: 100px;
  width: 100px;
}

.preview-sm {
  height: 50px;
  width: 50px;
}

@media (min-width: 992px) {
  .avatar-preview {
    float: none;
  }
}

.avatar-btns {
  margin-top: 30px;
  margin-bottom: 15px;
}

.avatar-btns .btn-group {
  margin-right: 5px;
}

.loading {
  display: none;
  position: absolute;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  background: #fff url("../img/loading.gif") no-repeat center center;
  opacity: .75;
  filter: alpha(opacity=75);
  z-index: 20140628;
}

</style>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content">

        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>编辑头像</h5>
                    </div>
                    <div class="ibox-content">
                        <div class="m-t m-b">
                            <div id="flash1">
                                <form id="editPicForm" method="post" action="#" data-id="${param.pdataId}" callback="searchForm()" class="form-horizontal">
		                            <div class="panel panel-default">
		                                <div class="tab-content">
		                                    <div class="tab-pane active">
		                                        <div class="panel-body">
		                                             <div class="form-group form-group-sm">
		                                                <div class="col-sm-1">
		                                                    <div id="crop-avatar">
		                                                        <div class="avatar-view" title="选择图片">
		                                                             <img <c:if test="${reponseDataForm.resultObj.PIC ne '' }">src="${responseDataForm.resultObj.PIC }"</c:if> <c:if test="${reponseDataForm.resultObj.PIC eq '' }"> src="${resRoot }/hplus/img/default_header.png"</c:if> alt="Avatar" name="pic"/>
		                                                             <input type="hidden" id="hidden-pic-url" name="pic"/>
		                                                        </div>
		                                                    </div>
		                                                </div>
		                                           </div>
		                                           <div class="form-group form-group-sm">
		                                               <div class="col-sm-4">
		                                                   <button type="submit" class="btn btn-primary">提交</button>
		                                                   <button type="button" class="btn btn-primary"  onclick="show()">取消</button>
		                                               </div>
		                                           </div>
		                                        </div>
		                                    </div>
		                                </div>
		                            </div>
		                        </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
         <!-- Cropping modal -->
    <div class="modal fade" id="avatar-modal" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1">
        <div class="modal-dialog modal-lg" style="width: 500px;">
            <div class="modal-content">
                <form class="avatar-form" action="${ctxPath }/topic/ajax/savePic" enctype="multipart/form-data" method="post">
                   <div class="modal-header">
                       <button class="close" data-dismiss="modal" type="button">&times;</button>
                       <h4 class="modal-title" id="avatar-modal-label">更换头像</h4>
                   </div>
                   <div class="modal-body">
                        <div class="avatar-body">
                           <!-- Upload image and data -->
                          <div class="avatar-upload">
                               <input class="avatar-src" name="defualt_prefix" value="header" type="hidden"/>
                               <input class="avatar-data" name="header_maxFileNum" value="0" type="hidden"/>
                               <input type="hidden" name="header_imgtype0" value="0"/>
                               <label for="avatarInput">头像上传</label>
                               <input class="avatar-input" id="avatarInput" name="header_imgtype_img0" type="file"/>
                           </div>

                           <!-- Crop and preview -->
                           <div class="row">
                               <div class="col-md-10">
                                   <div class="avatar-wrapper" style="height:233px"></div>
                               </div>
                           </div>

                           <div class="row avatar-btns">
                               <div class="col-md-3">
                                   <button class="btn btn-primary btn-block avatar-save" type="submit">确定</button>
                               </div>
                           </div>
                       </div>
                   </div>
                </form>
            </div>
        </div>
    </div>
    <!-- Cropping modal end-->
    </div>
     <script type="text/javascript">
    	 $(function(){
    		 
    		 console.info('${responseDataForm.resultObj}')
    		 
    		$("#editPicForm").validate({
				submitHandler : function(form) {
					$.ajax({
						url:"${ctxPath}/topic/ajax/editUserHeader",
						dataType:"json",
						data : $(form).serialize(),
						type:"post",
						success:function(json){
							if (json.result == '1') {
			 					swal({
									title : json.resultInfo,
									type : "success",
									showCancelButton : false,
									confirmButtonColor : "#A7D5EA",
									confirmButtonText : "确定",
									closeOnConfirm : false
								}, function() {
									//刷新表格，关闭弹窗
									window.parent.closeTab('${param.pdataId}');
								});
			 				} else {
			 					swal("", json.resultInfo, "error");
			 					return;
			 				}
						}
					});
				}
			});
    	}); 
    </script>
</body>

