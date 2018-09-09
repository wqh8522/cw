<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>实时视频监控</title>
    <%--<%@ include file="/webpage/include/head.jsp" %>--%>
    <script src="${ctxStatic}/jquery/jquery-2.1.1.min.js" type="text/javascript"></script>
    <!-- 引入bootstrap插件 -->
    <link href="${ctxStatic}/bootstrap/3.3.4/css_default/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <link href="${ctxStatic}/awesome/4.4/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="${ctxStatic}/common/css/style.css?v=3.2.0" type="text/css" rel="stylesheet"/>
    <%--ztree--%>
    <link href="${ctxStatic}/jquery-ztree/3.5.12/css/zTreeStyle/metro.css" rel="stylesheet" type="text/css"/>
    <script src="${ctxStatic}/jquery-ztree/3.5.12/js/jquery.ztree.all-3.5.min.js" type="text/javascript"></script>

    <%--<script src="${ctxStatic}/static/common/jeeplus.js"/>--%>
    <style>
        .ztree {
            overflow: auto;
            margin: 0;
            _margin-top: 10px;
            padding: 10px 0 0 10px;
        }

        body, html {
            height: 100%;
            padding: 0;
            margin: 0;
        }

        .videos {
            width: 90%;
            height: 100%;
            overflow-y: auto;
            margin-left: 230px;
        }

        .video {
            width: 400px;
            height: 280px;
            border: 1px solid #040404;
            margin: 5px 0 0 10px;
            /*background: #e7eaec ;*/
            float: left;
        }
    </style>
    <script type="text/javascript">
        function refresh() {//刷新
            window.location = "${ctx}/dzjg/jkgl/spjkDetail?officeId.id=${sxt.officeId.id}";
        }
    </script>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content">
    <div class="ibox">
        <div class="ibox-title">
            <h3>${fn:replace(sxt.officeId.name, "分局","分窗口" )}实时视频监控</h3>

        </div>
        <div class="ibox-content">
            <div id="content" class="row">
                <!-- 左侧机构树-->
                <div id="left" style="background-color:#e7eaec;margin-left: 20px" class="leftBox col-sm-1">
                    <a onclick="refresh()" class="pull-right">
                        <i class="fa fa-refresh"></i>
                    </a>
                    <div id="ztree" class="ztree leftBox-content"></div>
                </div>
                <div id="right" class="videos" align="left">
                    <%--<div style="margin-left: 250px"><h2>${sxt.officeId.name}视频监控</h2></div>--%>
                    <c:forEach items="${list}" var="sxt" varStatus="vs">
                        <div class="video">
                            <c:choose>
                                <c:when test="${browserType == 'IE11' || browserType == 'IE10' || browserType == 'IE9' || browserType == 'IE8'}">
                                    <object id="${sxt.id}" width="100%" height="87%"
                                            classid="clsid:7F9063B6-E081-49DB-9FEC-D72422F2727F"
                                            codebase="">
                                    </object>
                                </c:when>
                                <c:otherwise>
                                    <object name="playOcx" id="${sxt.id}" width="100%" height="87%"
                                            type="application/media-plugin-version-3.1.0.2"
                                            VideoWindTextColor="9c9c9c" VideoWindBarColor="414141">
                                    </object>
                                </c:otherwise>
                            </c:choose>
                            <div style="float: left;">
                                    ${sxt.ck}
                            </div>
                            <div style="float: right;">

                              <%--  <button class="btn btn-white btn-sm"
                                        onclick="Capture(document.getElementById('${sxt.id}'))">
                                    <i class="fa fa-scissors"></i>抓图
                                </button>
                                <button class="btn btn-white btn-sm" id="startRecord${sxt.id}"
                                        onclick="StartRecord(document.getElementById('${sxt.id}'))">
                                    <i class="fa fa-video-camera"></i>录像
                                </button>
                                <button class="btn btn-white btn-sm" style="display: none" id="stopRecord${sxt.id}"
                                        onclick="StopRecord(document.getElementById('${sxt.id}'))">
                                    <i class="fa fa-stop"></i>停止
                                </button>--%>
                                <button class="btn btn-white btn-sm" id="openSound${sxt.id}"
                                        onclick="OpenAudio(document.getElementById('${sxt.id}'))">
                                    <i class="fa  fa-volume-up"></i>开启声音
                                </button>
                                <button class="btn btn-white btn-sm" style="display: none" id="closeSound${sxt.id}"
                                        onclick="CloseAudio(document.getElementById('${sxt.id}'))">
                                    <i class="fa  fa-volume-off"></i>关闭声音
                                </button>
                                <button class="btn btn-white btn-sm"
                                        onclick="reqFullScreen(document.getElementById('${sxt.id}'))">
                                    <i class="fa fa-arrows-alt"></i>全屏
                                </button>
                            </div>
                        </div>

                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>
<%--单位树--%>
<script type="text/javascript">
    var setting = {
        data: {simpleData: {enable: true, idKey: "id", pIdKey: "pId", rootPId: '0'}},
        callback: {
            onClick: function (event, treeId, treeNode) {
                var id = treeNode.id == '0' ? '' : treeNode.id;
                window.location.href = "${ctx}/dzjg/jkgl/spjkDetail?officeId.id=" + id;
                <%--$('#spjkContent').attr("src","${ctx}/sys/user/list?office.id="+id+"&office.name="+treeNode.name);--%>
            }
        }
    };

    function refreshTree() {
        $.getJSON("${ctx}/dzjg/jkgl/treeData", function (data) {
            $.fn.zTree.init($("#ztree"), setting, data).expandAll(true);
        });
    }

    refreshTree();

    var leftWidth = 180; // 左侧窗口大小
    var htmlObj = $("html"), mainObj = $("#main");
    var frameObj = $("#left, #openClose, #right, #right iframe");

    function wSize() {
        var strs = getWindowSize().toString().split(",");
        htmlObj.css({"overflow-x": "hidden", "overflow-y": "hidden"});
        mainObj.css("width", "auto");
        frameObj.height(strs[0] - 120);
        var leftWidth = ($("#left").width() < 0 ? 0 : $("#left").width());
        $("#right").width($("#content").width() - leftWidth - $("#openClose").width() - 60);
        $(".ztree").width(leftWidth - 10).height(frameObj.height() - 46);
    }
</script>
<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>

<%--视频监控信息--%>
<script type="text/javascript">
    // var PLUGINS_CLASSID = '7F9063B6-E081-49DB-9FEC-D72422F2727F';
    // var VERSION_GUI = 'version=3,1,0,4'; //注意：本地GUI上版本信息显示需要的字符串，修改版本的时候这个字符串也要修改
    var Sys = {};
    // var isMac = navigator.userAgent.toLowerCase().indexOf("mac") != -1;
    var ua = navigator.userAgent.toLowerCase();
    var s;
    (s = ua.match(/(msie\s|trident.*rv:)([\d.]+)/)) ? Sys.ie = s[2] :
        (s = ua.match(/firefox\/([\d.]+)/)) ? Sys.firefox = s[1] :
            (s = ua.match(/chrome\/([\d.]+)/)) ? Sys.chrome = s[1] :
                (s = ua.match(/opera.([\d.]+)/)) ? Sys.opera = s[1] :
                    (s = ua.match(/version\/([\d.]+).*safari/)) ? Sys.safari = s[1] : 0;
    var PLUGINS_NAME = 'WebActiveEXE.Plugin.1';
    var hasPlugin = checkPlugins();

    /**
     * 检测浏览器是否存在视频插件
     * @return {Boolean}
     */
    function checkPlugins() {
        var result;
        if (Sys.ie) {
            try {
                result = new ActiveXObject(PLUGINS_NAME);
                delete result;
            } catch (e) {
                return false;
            }
            return true;
        } else {
            navigator.plugins.refresh(false);
            result = navigator.mimeTypes["application/media-plugin-version-3.1.0.2"];
            return !!(result && result.enabledPlugin);
        }
    }

    /**/
</script>
<script>
    var img_p =  "C:\\spjk\\image\\";
    /*全屏*/
    //进入全屏
    function reqFullScreen(element) {
        console.log(Sys);
        var ocx = element;
        if (Sys.ie) {
            ocx.SwitchToFullScreen();
        } else {
            ocx.OnFullScreenClk();
        }

    }

    /*抓图*/
    function Capture(element) {
        var path = img_p + (new Date()).valueOf()+".jpg";
        var g_ocx = element;
        g_ocx.SetConfigPath(1,path);//设置截图保存路径
        var re = g_ocx.SnapPic(0);
        if(re == 1){
            g_ocx.ShowSaveOrOpenDlg(1,path,null);
            alert("抓图成功，图片保存路径："+path);
        }
    }

    /*录像*/
    function StartRecord(element) {
        var ele_id = element.getAttribute("id");
        var startRecord_btn = $("#startRecord"+ele_id)
        var stopRecord_btn =  $("#stopRecord"+ele_id);
        var g_ocx = element;
        // var recordStatus = g_ocx.
        if(true){
            startRecord_btn.hide();
            stopRecord_btn.show();
        }
    }

    /*停止录像*/
    function StopRecord(element) {
        var ele_id = element.getAttribute("id");
        var startRecord_btn = $("#startRecord"+ele_id)
        var stopRecord_btn =  $("#stopRecord"+ele_id);
        var g_ocx = element;
        // var recordStatus = g_ocx.
        if(true){
            startRecord_btn.show();
            stopRecord_btn.hide();
        }
    }

    /*开启声音*/
    function OpenAudio(element) {
        var ele_id = element.getAttribute("id");
        var openSound_btn = $("#openSound"+ele_id)
        var closeSound_btn =  $("#closeSound"+ele_id);
        var g_ocx = element;
        var soundStatus = g_ocx.PlayOpenSound();
        if(soundStatus){
            //隐藏开启按钮，显示停止按钮
            openSound_btn.hide();
            closeSound_btn.show();
        }

    }

    /*关闭声音*/
    function CloseAudio(element) {
        var ele_id = element.getAttribute("id");
        var openSound_btn = $("#openSound"+ele_id)
        var closeSound_btn =  $("#closeSound"+ele_id);
        var g_ocx = element;
        var soundStatus =  g_ocx.PlayStopSound();
        //隐藏开启按钮，显示停止按钮
        openSound_btn.show();
        closeSound_btn.hide();
    }

    $(document).ready(function () {
        if (checkPlugins()) {
            $.ajax({
                type: "post",
                url: "${ctx}/dzjg/jkgl/getSxt",
                data: "officeId=${sxt.officeId.id}",
                dataType: 'json',
                success: function (data, status) {
                    var jsonData = data;
                    console.log(jsonData.code + "===" + jsonData.msg)
                    if (jsonData.code == "200") {
                        var sxtList = jsonData.data;
                        console.log(jsonData)
                        for (var i = 0; i < sxtList.length; i++) {
                            var g_ocx = document.getElementById(sxtList[i].id);
                            var bRet = g_ocx.LoginDeviceEx('' + sxtList[i].ip, sxtList[i].dkh - 0, '' + sxtList[i].yhm, '' + sxtList[i].mm, 1);
                            if (bRet == 0) {
                                g_ocx.SetWinBindedChannel(1, 0, 63, 64);
                                g_ocx.SetConfigPath(1,"C:\\视频监控\\images");
                                g_ocx.SetConfigPath(2,"C:\\视频监控\\vidos");
                                // g_ocx.SetPicQuality(0);//设置画质
                                g_ocx.SetAdjustFluency(0);//设置视频实时性
                                g_ocx.SetModuleMode(1); //监视模式
                                g_ocx.ConnectRealVideo(0, 1);
                            } else {
                                alert("网络连接错误！");
                                return false;
                            }
                        }
                    } else if (jsonData.code == "400") {
                        top.layer.msg(jsonData.msg, {icon: 2});
                        location.reload();
                    }
                },
                error: function (data) {
                    top.layer.msg(jsonData.msg, {icon: 2});
                    location.reload();
                },
                complete: function () {
                }
            });
        }
    });
</script>
</body>
</html>