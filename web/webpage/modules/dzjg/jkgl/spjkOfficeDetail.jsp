<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>视频监控</title>
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
            margin-left: 250px;
        }

        .video {
            width: 350px;
            height: 333px;
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
            <h3>${sxt.officeId.name}视频监控</h3>
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
                            <object classid="clsid:30209FBC-57EB-4F87-BF3E-740E3D8019D2" codebase=""
                                    name="playOcx" align="center" id="${sxt.id}" width="350" height="300px">
                                    <%--  <embed align="center" onclick="qp();"></embed>--%>
                            </object>
                            <div style="float: left;">
                                    ${sxt.ck}
                            </div>
                            <div style="float: right;">
                               <!--
                                <button class="btn btn-white btn-sm"
                                        onclick="Capture(document.getElementById('${sxt.id}'))">
                                    <i class="fa fa-scissors"></i>截屏
                                </button>
                                <button class="btn btn-white btn-sm"
                                        onclick="StartRecord(document.getElementById('${sxt.id}'))">
                                    <i class="fa  fa-play-circle-o"></i>录像
                                </button>
                                <button class="btn btn-white btn-sm" style="display: none"
                                        onclick="StopRecord(document.getElementById('${sxt.id}'))">
                                    <i class="fa  fa-stop"></i>停止
                                </button>
                                -->
                                <button class="btn btn-white btn-sm"
                                        onclick="OpenAudio(document.getElementById('${sxt.id}'))">
                                    <i class="fa  fa-stop"></i>开启声音
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
        // $("#right").width($("#content").width()- leftWidth - $("#openClose").width() -60);
        $(".ztree").width(leftWidth - 10).height(frameObj.height() - 46);
    }
</script>
<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>

<script type="text/javascript">
    var width = "";
    var height = "";

    //进入全屏
    function reqFullScreen(element) {
        console.log(element.width)
        var de = element;
        if (de.requestFullscreen) {
            de.requestFullscreen();
            remoceWH(de);
        } else if (de.mozRequestFullScreen) {
            de.mozRequestFullScreen();
            remoceWH(de);
        } else if (de.webkitRequestFullScreen) {
            de.webkitRequestFullScreen();
            remoceWH(de);
        } else if (de.msRequestFullscreen) {
            de.msRequestFullscreen();
            doc = de;
            remoceWH(de);
        } else {
            console.log("进入全屏失败")
        }
    }

    function remoceWH(element) {
        //保存原始的宽高
        width = element.getAttribute("width");
        height = element.getAttribute("height");
        //移除object元素的宽高
        element.removeAttribute("width");
        element.removeAttribute("height");
    }

    //退出全屏
    function exitFullscreen() {
        if (document.exitFullscreen) {
            document.exitFullscreen();
        }
        else if (document.msExitFullscreen) {
            document.msExitFullscreen();
        }
        else if (document.mozCancelFullScreen) {
            document.mozCancelFullScreen();
        }
        else if (document.webkitCancelFullScreen) {
            document.webkitCancelFullScreen();
        }
        setWH();
    }

    function setWH() {
        $("object[name='playOcx']").each(function () {
            $(this).attr("width", width);
            $(this).attr("height", height);
        });
    }
</script>
<script>
    /*截屏*/
    function Capture(element) {
        var SSOcx = element;
        // var dd = SSOcx.GetCapturePicture("d:\\1.bmp");
        window.location.reload();
    }
    /*录像*/
    function StartRecord(element) {
        var SSOcx = element;
        // SSOcx.SaveRealData("d:\\1.avi");
    }
    /*停止录像*/
    function StopRecord(element) {
        var SSOcx = element;
        // SSOcx.StopSaveRealDate();
    }
    /*开启声音*/
    function OpenAudio(element) {
        var SSOcx = element;
        console.log(SSOcx);
        // SSOcx.AboutBox();
    }


    /*监听esc事件*/
    $(document).keyup(function (event) {
        switch (event.keyCode) {
            case 27:
                exitFullscreen();
                break;
        }
    });

    $(document).ready(function () {
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
                        var SSOcx = document.getElementById(sxtList[i].id);
                        var flag = SSOcx.SetDeviceInfo(sxtList[i].ip, sxtList[i].dkh, 0, sxtList[i].yhm, sxtList[i].mm);
                        if (flag) {
                            SSOcx.StartPlay();
                        } else {
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
    });


</script>
</body>
</html>