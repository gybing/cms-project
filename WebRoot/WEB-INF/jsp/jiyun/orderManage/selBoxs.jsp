<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>新增集装箱</title>
    <jsp:include page="/WEB-INF/jsp/top.jsp"></jsp:include>
    <script type="text/javascript">
		$(function(){
			$s2.init($("#D_SPEC0"), {
				sysdict : $sysdict.BOX_TYPE
			});
			$s2.init($("#D_SPEC1"), {
				sysdict : $sysdict.BOX_TYPE
			});
			$s2.init($("#D_SPEC2"), {
				sysdict : $sysdict.BOX_TYPE
			});
			$("#orderBoxSelForm").validate({
				submitHandler : function(form) {
					getBoxInfo();
				}
			});
		});
		
		function getBoxInfo(){
			var SIZES = toArray('SIZE');
			var NUMSS = toArray('NUMS');
			var SPECS = new Array();
			for(var i=1;i<=SIZES.length;i++ ){
				SPECS[i-1] = $("#D_SPEC"+(i-1)).val();
			}
			for(var m=1; m <= SIZES.length; m++){
				var i = m-1;
				var size = SIZES[i];
				var spec = SPECS[i];
				var nums = NUMSS[i]==""?0:NUMSS[i];
				//console.log("size="+size+" spec="+spec+"nums="+nums);
				if(nums > 0){
					if(spec = null || spec == ''){
						swal("", "尺寸为"+ size +"的集装箱请选择箱规！", "error");
						return;
					}
				}
			}
			
			//刷新表格，关闭弹窗
			parent.boxAddRow(SIZES,SPECS,NUMSS);
			parent.layer.close(parent.layer.getFrameIndex(window.name));
		}
		
		function toArray(name,type){
			var names = new Array();
			var i = 0;
			var type = type || "input";
			var s = "";
			if(type == "select"){
				s = "selected";
			}
			$(type+"[name='"+ name +"' "+ s +"]").each(function(){
				names[i] = $(this).val();
				i++;
			});
			return names;
		}
	</script>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">            
    <form id="orderBoxSelForm" method="post" action="#" class="form-horizontal">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <!-- <div class="ibox-title"><h5>业务接单信息</h5></div> -->
                    <div class="ibox-content">
                        <div class="form-group" style="margin-top: 15px;">
                        	<label class="col-sm-2 control-label">尺寸: 20<input name="SIZE" id="SIZE0" type="hidden" value="20"/></label>
                            <label class="col-sm-1 control-label">箱规:</label>
                            <div class="col-sm-3">
		                    	<select class="combox" id="D_SPEC0" name="SPEC"></select>
                            </div>
                            <label class="col-sm-1 control-label">个数:</label>
                            <div class="col-sm-2">
                            	<input id="NUMS0" name="NUMS" type="text" class="isNum" maxlength="2" />
                            </div>
                        </div>
                        <div class="form-group" style="margin-top: 15px;">
                        	<label class="col-sm-2 control-label">尺寸: 40<input name="SIZE" id="SIZE1" type="hidden" value="40"/></label>
                            <label class="col-sm-1 control-label">箱规:</label>
                            <div class="col-sm-3">
		                    	<select class="combox" id="D_SPEC1" name="SPEC"></select>
                            </div>
                            <label class="col-sm-1 control-label">个数:</label>
                            <div class="col-sm-2">
                            	<input id="NUMS1" name="NUMS" type="text" class="isNum" maxlength="2" />
                            </div>
                        </div>
                        <div class="form-group" style="margin-top: 15px;">
                        	<label class="col-sm-2 control-label">尺寸: 45<input name="SIZE" id="SIZE2" type="hidden" value="45"/></label>
                            <label class="col-sm-1 control-label">箱规:</label>
                            <div class="col-sm-3">
		                    	<select class="combox" id="D_SPEC2" name="SPEC"></select>
                            </div>
                            <label class="col-sm-1 control-label">个数:</label>
                            <div class="col-sm-2">
                            	<input id="NUMS2" name="NUMS" type="text" class="isNum" maxlength="2" />
                            </div>
                        </div>
							<div id="form_foot_tool"
								style="float: right ;padding-right: 20px;margin-top: 18px">
								<button class="btn btn-primary" type="submit">
									<i class="glyphicon glyphicon-ok"></i>确定
								</button>
							</div>
						</div>
        			</div>
        		</div>
        	</div>
    	</form>
	</div>
</body>
</html>