<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <%--<meta name="renderer" content="ie-stand">--%>
    <title>实时视频监控</title>
    <script src="${ctxStatic}/jquery/jquery-2.1.1.min.js" type="text/javascript"></script>

    <!--[if lte IE 10]>
    <script src="${ctxStatic}/jquery/jquery-1.9.1.js"></script>
    <![endif]-->
    <!-- 引入layer插件 -->
    <script src="${ctxStatic}/layer-v2.3/layer/layer.js"></script>
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
            padding: 10px 0 0 3px;
        }

        body, html {
            height: 100%;
            padding: 0;
            margin: 0;
        }

        .videos {
            width: 100%;
            height: auto;
            overflow-y: auto;
            margin-left: 230px;
        }

        .video {
            width: 95%;
            height: 90%;
            border: 1px solid #ffffff;
            margin: 5px 0 0 10px;
            /*background: #e7eaec ;*/
            float: left;
        }
    </style>
    <script type="text/javascript">
        var g_ocx;
        var gWndId;
        var loginFlag;
        function refresh() {//刷新
            window.location = "${ctx}/dzjg/jkgl/spjk/detail";
        }
    </script>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content">
    <div class="ibox">
        <div class="ibox-title">
            <h3 id="titleH3">实时视频监控</h3>
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
                    <div class="video">
                        <object id="ocx" classid="CLSID:D3E383B6-765D-448D-9476-DFD8B499926D"
                                style="width: 100%; height: 100%"
                                codebase="${ctxRoot }/webpage/modules/dzjg/jkgl/DpsdkOcx.CAB#version=1.0.0.0">
                        </object>
                        <div style="float: right;">
                              <button class="btn btn-white btn-sm" style="display: none;"
                                      onclick="Capture()" id="capture">
                                  <i class="fa fa-scissors"></i>抓图
                              </button>
                              <button class="btn btn-white btn-sm" id="startRecord" style="display:none;"
                                      onclick="StartRecord()">
                                  <i class="fa fa-video-camera"></i>开始录像
                              </button>
                              <button class="btn btn-white btn-sm" style="display: none;" id="stopRecord"
                                      onclick="StopRecord()">
                                  <i class="fa fa-stop"></i>停止录像
                              </button>
                            <button class="btn btn-white btn-sm" id="openSound" style="display: none"
                                    onclick="OpenAudio()">
                                <i class="fa  fa-volume-up"></i>开启声音
                            </button>
                            <button class="btn btn-white btn-sm" style="display: none" id="closeSound"
                                    onclick="CloseAudio()">
                                <i class="fa  fa-volume-off"></i>关闭声音
                            </button>
                            <button class="btn btn-white btn-sm" style="display: none" id="FullScreen"
                                    onclick="reqFullScreen()">
                                <i class="fa fa-arrows-alt"></i>全屏
                            </button>
                        </div>
                    </div>
                    <script type="application/javascript">
                        $(document).ready(function () {
                            // top.layer.alert("连接服务器失败！！",{icon: 0});
                            g_ocx = document.getElementById('ocx');
                            var bRet = g_ocx.DPSDK_Login('${dss.ip}','${dss.dkh}', '${dss.yhm}', '${dss.mm}');
                            gWndId = g_ocx.DPSDK_CreateSmartWnd(0, 0, 100, 100);
                            var n = g_ocx.DPSDK_SetWndCount(gWndId,1);
                            // layer.msg("连接成功！！",{icon:1});
                            if(bRet != 0){
                                alert("服务器连接失败！！");
                            }
                            loginFlag = 1;
                        });
                    </script>
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
                var channelId = treeNode.channelId == null ? '' : treeNode.channelId;
                playVideo(channelId,treeNode.name);
                <%--window.location.href = "${ctx}/dzjg/jkgl/spjkDetail?officeId.id=" + id;--%>
                <%--$('#spjkContent').attr("src","${ctx}/sys/user/list?office.id="+id+"&office.name="+treeNode.name);--%>
            }
        }
    };
    function refreshTree() {
        $.getJSON("${ctx}/dzjg/dzjgSxtTree/treeData", function (data) {
            $.fn.zTree.init($("#ztree"), setting, data).expandAll(false);
        });
    }
    refreshTree();

    var leftWidth = 225; // 左侧窗口大小
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
    var Sys = {};
    var ua = navigator.userAgent.toLowerCase();
    var s;
    (s = ua.match(/(msie\s|trident.*rv:)([\d.]+)/)) ? Sys.ie = s[2] :
        (s = ua.match(/firefox\/([\d.]+)/)) ? Sys.firefox = s[1] :
            (s = ua.match(/chrome\/([\d.]+)/)) ? Sys.chrome = s[1] :
                (s = ua.match(/opera.([\d.]+)/)) ? Sys.opera = s[1] :
                    (s = ua.match(/version\/([\d.]+).*safari/)) ? Sys.safari = s[1] : 0;
    // var PLUGINS_NAME = 'WebActiveEXE.Plugin.1';
    // var hasPlugin = checkPlugins();
</script>
<script>
    var curChannel ;
    var img_p =  "C:\\视频监控\\images\\";
    var video_p = "C:\\视频监控\\vidos\\";
    var video_p_name;
    var video_flag = 0;
    /*打开指定通道的实时视频*/
    function playVideo(channelId,name) {
        if(video_flag == 1){
            alert("您正在录像，请先停止录像！！");
            return false;
        }
        if(channelId == null || channelId == ''){
            return false;
        }
        // 获取当前活动窗口号,其中m_nSmartWndId是由DPSDK_CreateSmartWnd创建的窗口控件id
        // var nWndNo = g_ocx.DPSDK_GetSelWnd(gWndId);
        // 开始预览
        var nResult = g_ocx.DPSDK_DirectRealplayByWndNo(gWndId, 0, channelId, 1, 3, 1);
        if(nResult != 0){
            alert("预览失败");
            return;
        }
        var title = name + "实时视频监控";
        $("#FullScreen").show();
        $("#titleH3").text(title);
        $("#capture").show();
        //隐藏关闭按钮，显示打开按钮
        $("#openSound").show();
        $("#closeSound").hide();
        //处理录像按钮
        $("#startRecord").show();
        $("#stopRecord").hide();
        //设置当前播放的通道id
        curChannel = channelId;
    }
    //监听窗口关闭事件；onbeforeunload：关闭之前的事件
    window.onbeforeunload  = function (ev) {
        if(loginFlag == 1){
            //退出平台
            var nRet = g_ocx.DPSDK_Logout();
        }
        loginFlag = 0;
    }
    /*全屏显示*/
    function reqFullScreen() {
        g_ocx.DPSDK_SetSmartWndFullScreen(gWndId);
    }
    /*开启声音*/
    function OpenAudio() {
        if(curChannel != null && curChannel != ''){
            var nRet = g_ocx.DPSDK_OpenAudioByWndNo(gWndId, 0 ,true);
            var openSound_btn = $("#openSound");
            var closeSound_btn =  $("#closeSound");
            if(nRet == 0){
                //隐藏开启按钮，显示停止按钮
                openSound_btn.hide();
                closeSound_btn.show();
            }else{
                alert("开启声音失败！")
            }
        }
        // g_ocx.DPSDK_Logout();

    }
    /*关闭声音*/
    function CloseAudio() {
        if(curChannel != null && curChannel != ''){
            var nRet = g_ocx.DPSDK_OpenAudioByWndNo(gWndId, 0 ,false);
            var openSound_btn = $("#openSound");
            var closeSound_btn =  $("#closeSound");
            if(nRet == 0){
                //隐藏关闭按钮，显示打开按钮
                openSound_btn.show();
                closeSound_btn.hide();
            }else{
                alert("开启声音失败！")
            }
        }
    }

    /*抓图*/
    function Capture() {
        var now_date = dateFtt("yyyyMMddhhmmss",new Date());
        var path = img_p + now_date +".jpg";
        var re = g_ocx.DPSDK_CapturePictureByWndNo(gWndId,0,path);
        if(re == 0){
            alert("抓图成功，图片保存路径："+path);
        }
    }

    /*录像*/
    function StartRecord() {
        if(curChannel != null && curChannel != ''){
            var now_date = dateFtt("yyyyMMddhhmmss",new Date());
            video_p_name = video_p + now_date+".mp4";
            var nRet = g_ocx.DPSDK_StartRealRecordByWndNo(gWndId, 0, video_p_name);
            if(nRet == 0){
                video_flag = 1;
                $("#startRecord").hide();
                $("#stopRecord").show();
            }
        }

    }
    /*停止录像*/
    function StopRecord() {
         var nRet = g_ocx.DPSDK_StopRealRecordByWndNo(gWndId,0);
        if(nRet == 0){

            alert("录像成功，保存路径："+video_p_name);
            video_flag = 0;
            video_p_name = '';
            $("#startRecord").show();
            $("#stopRecord").hide();
        }
    }
    //格式化时间
    function dateFtt(fmt,date)
    { //author: meizz
        var o = {
            "M+" : date.getMonth()+1,                 //月份
            "d+" : date.getDate(),                    //日
            "h+" : date.getHours(),                   //小时
            "m+" : date.getMinutes(),                 //分
            "s+" : date.getSeconds(),                 //秒
            "q+" : Math.floor((date.getMonth()+3)/3), //季度
            "S"  : date.getMilliseconds()             //毫秒
        };
        if(/(y+)/.test(fmt))
            fmt=fmt.replace(RegExp.$1, (date.getFullYear()+"").substr(4 - RegExp.$1.length));
        for(var k in o)
            if(new RegExp("("+ k +")").test(fmt))
                fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
        return fmt;
    }
</script>
</body>
</html>