<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="com.cms.common.cache.GlobalCache,com.cms.cache.*"%>

<!-- bootstrap CSS0 -->
<link rel="stylesheet" href="${resRoot}/hplus/css/bootstrap.min.css?v=3.3.5">
<link rel="stylesheet" href="${resRoot}/hplus/css/font-awesome.min.css?v=4.4.0">
<link rel="stylesheet" href="${resRoot}/hplus/css/animate.min.css">
<link rel="stylesheet" href="${resRoot}/hplus/css/style.min.css?v=4.0.0">

<!-- bootstrap JS -->
<script type="text/javascript" src="${resRoot}/hplus/js/jquery.min.js?v=2.1.4"></script>
<script type="text/javascript" src="${resRoot}/hplus/js/bootstrap.min.js?v=3.3.5"></script>
<script type="text/javascript" src="${resRoot}/hplus/js/plugins/metisMenu/jquery.metisMenu.js"></script>
<script type="text/javascript" src="${resRoot}/hplus/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
<script type="text/javascript" src="${resRoot}/hplus/js/plugins/layer/layer.min.js"></script>
<script type="text/javascript" src="${resRoot}/hplus/js/plugins/layer/laydate/laydate.js"></script>
<script type="text/javascript" src="${resRoot}/hplus/js/hplus.min.js?v=4.0.0"></script>
<script type="text/javascript" src="${resRoot}/hplus/js/contabs.min.js"></script>
<script type="text/javascript" src="${resRoot}/hplus/js/plugins/pace/pace.min.js"></script>
<script type="text/javascript" src="${resRoot}/hplus/js/content.min.js?v=1.0.0"></script>
<script type="text/javascript" src="${resRoot}/hplus/js/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script type="text/javascript" src="${resRoot}/hplus/js/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<script type="text/javascript" src="${resRoot}/hplus/js/plugins/sparkline/jquery.sparkline.min.js"></script>
<script type="text/javascript" src="${resRoot}/hplus/js/plugins/easypiechart/jquery.easypiechart.js"></script>
<script type="text/javascript" src="${resRoot}/hplus/js/demo/sparkline-demo.min.js"></script>

<script type="text/javascript" src="${resRoot}/hplus/js/plugins/flot/jquery.flot.js"></script>
<script type="text/javascript" src="${resRoot}/hplus/js/plugins/flot/jquery.flot.tooltip.min.js"></script>
<script type="text/javascript" src="${resRoot}/hplus/js/plugins/flot/jquery.flot.spline.js"></script>
<%-- <script type="text/javascript" src="${resRoot}/hplus/js/plugins/flot/jquery.flot.resize.js"></script> --%>
<script type="text/javascript" src="${resRoot}/hplus/js/plugins/flot/jquery.flot.pie.js"></script>
<script type="text/javascript" src="${resRoot}/hplus/js/plugins/flot/jquery.flot.symbol.js"></script>
<script type="text/javascript" src="${resRoot}/hplus/js/plugins/peity/jquery.peity.min.js"></script>
<script type="text/javascript" src="${resRoot}/hplus/js/demo/peity-demo.min.js"></script>

<!-- =================================================================================================== -->

<!-- jsTree -->
<script type="text/javascript" src="${resRoot}/hplus/js/plugins/jsTree/jstree.min.js"></script>
<link rel="stylesheet" href="${resRoot}/hplus/css/plugins/jsTree/style.min.css">

<!-- 选择框   -->
<script type="text/javascript" src="${resRoot}/hplus/js/plugins/iCheck/icheck.min.js"></script>
<link rel="stylesheet" href="${resRoot}/hplus/css/plugins/iCheck/custom.css">
<link href="${resRoot}/hplus/css/plugins/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css" rel="stylesheet">

<!-- dataTables -->
<script type="text/javascript" src="${resRoot}/hplus/js/plugins/jeditable/jquery.jeditable.js"></script>
<script type="text/javascript" src="${resRoot}/hplus/js/plugins/dataTables/jquery.dataTables.js"></script>
<script type="text/javascript" src="${resRoot}/hplus/js/plugins/dataTables/dataTables.bootstrap.js"></script>
<link rel="stylesheet" href="${resRoot}/hplus/css/plugins/dataTables/dataTables.bootstrap.css">

<!-- Sweet Alert -->
<script type="text/javascript" src="${resRoot}/hplus/js/plugins/sweetalert/sweetalert.min.js"></script>
<link rel="stylesheet" href="${resRoot}/hplus/css/plugins/sweetalert/sweetalert.css">

<!-- BOOTSTRAP-DATETIMEPICKER 日期控件 -->
<%-- 
<link rel="stylesheet" href="${resRoot}/hplus/css/plugins/datetimepicker/bootstrap-datetimepicker.min.css">
<script type="text/javascript" src="${resRoot}/hplus/js/plugins/datetimepicker/bootstrap-datetimepicker.js" charset="utf-8"></script>
<script type="text/javascript" src="${resRoot}/hplus/js/plugins/datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js" charset="utf-8"></script>
 --%>
<!-- 自定义公用样式 -->
<link rel="stylesheet" href="${resRoot}/css/comm.css?v=555.0">

<!-- 表单验证控件 -->
<script type="text/javascript" src="${resRoot}/hplus/js/plugins/validate/jquery.validate.min.js"></script>
<script type="text/javascript" src="${resRoot}/hplus/js/plugins/validate/messages_zh.min.js"></script>

<!-- =================================================================================================== -->
<!-- 自定义  公共 JS -->
<script type="text/javascript" src="${resRoot}/hplus/js/h+comm.js" charset="utf-8"></script>
<script type="text/javascript" src="${resRoot}/js/comm.js" charset="utf-8"></script>

<!-- 自定义  From表单自定义验证方法 JS -->
<script type="text/javascript" src="${resRoot}/js/form_validate_method.js" charset="utf-8"></script>

<!-- 自定义  公共 CSS -->
<link rel="stylesheet" href="${resRoot}/hplus/css/comm.css">
<!-- =================================================================================================== -->

<!-- 下拉框控件   -->
<link type="text/css" href="${resRoot}/css/select2.min.css" rel="stylesheet"/>
<script type="text/javascript" src="${resRoot}/js/select2.min.js" charset="utf-8"></script>

<!-- 自动补全控件 -->
<script type="text/javascript" src="${resRoot}/hplus/js/plugins/suggest/bootstrap-suggest.min.js"></script>
<script type="text/javascript" src="${resRoot}/hplus/js/plugins/suggest/bootstrap-suggest.js"></script>


<script type="text/javascript">
var _contextPath = "${ctxPath}",_resRoot = "${resRoot}";
var $sysdict = <%=GlobalCache.getCache(DictCache.class,DictCacheBean.class).getDictJsonStr()%>;
var $sysdictext = <%=GlobalCache.getCache(DictCache.class,DictCacheBean.class).getDictkeyMapStr()%>;

/* 
 * 调用方式 ：  $sysdictext["INOTYPE_" + data]
 */
</script>