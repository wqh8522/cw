<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp" %>
<%--<jsp:forward page="${ctx}/dzjg/jkgl/spjkfoeward" />--%>
<html>
<head>
    <meta charset="UTF-8">
    <%--<meta name="decorator" content="default"/>--%>
    <script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content">
    <div class="ibox" id="ts">
        <div class="ibox-title">
            <h1>温馨提示</h1>
        </div>
        <div class="ibox-content">
            1、视频监控功能需要将IE浏览器升级至IE 11，<a href="${ctxRoot }/asset/IE11_for_Win7_x64.exe">点击下载安装。</a> &nbsp;&nbsp;
            <font id="llqRight" color="black" style="display: none">√</font> <font color="red" id="llqErroe"
                                                                                  style="display: none">×</font><br>
            2、如果使用360极速浏览器，首先将IE浏览器升级至IE 11，然后选择使用兼容模式打开。<br>
           <%-- 3、视频监控还需要安装OCX插件，<a href="${ctxRoot }/asset/OCX.zip">点击下载安装。</a>
            <font id="cjRight" color="black" style="display: none">√</font> <font color="red" id="cjErroe"
                                                                                 style="display: none">×</font><br>--%>
            3、视频监控功能使用文档，<a href="${ctxRoot }/asset/OperatingDocuments.docx">点击下载。</a><br>
        </div>
    </div>
</div>
<script type="application/javascript">
    var browserType = '${browserType}';
    var Sys = {};
    var ua = navigator.userAgent.toLowerCase();
    var s;
    (s = ua.match(/(msie\s|trident.*rv:)([\d.]+)/)) ? Sys.ie = s[2] :
        (s = ua.match(/firefox\/([\d.]+)/)) ? Sys.firefox = s[1] :
            (s = ua.match(/chrome\/([\d.]+)/)) ? Sys.chrome = s[1] :
                (s = ua.match(/opera.([\d.]+)/)) ? Sys.opera = s[1] :
                    (s = ua.match(/version\/([\d.]+).*safari/)) ? Sys.safari = s[1] : 0;

    //判断是否安装插件
    // function checkOcx() {
    //
    //     try {
    //         var obj = new ActiveXObject("DPSDK_OCX.DPSDK_OCXCtrl.1");
    //         $("#cjRight").show();
    //         return true;
    //     } catch (e) {
    //         $("#cjErroe").show();
    //         return false;
    //     }
    // }

    function checkBrowser() {
        if (!Sys.ie || browserType == 'IE8' || browserType == 'IE9') {
            //浏览器提示
            $("#llqErroe").show();
            return false;
        } else {
            $("#llqRight").show();
            return true;
        }
    }
    var b = checkBrowser();
    // var ocx = checkOcx();
    if (b) {
        window.open("${ctx}/dzjg/jkgl/spjk/detail", "_blank", "");
    }
</script>

</body>
</html>
