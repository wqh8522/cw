<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">
    <title>财务管理系统</title>


	<%@ include file="/webpage/include/head.jsp"%>
	<script src="${ctxStatic}/common/inspinia.js?v=3.2.0"></script>
	<script src="${ctxStatic}/common/contabs.js"></script>


    <script type="text/javascript" src="${ctxStatic}/dzjg/sockjs.min.js"></script>
    <script type="text/javascript" src="${ctxStatic}/dzjg/sockjs-0.3.min.js"></script>
    <script>
        $(document).ready(function() {
            var ws;
            if ('WebSocket' in window) {
                ws = new WebSocket("ws://"+window.location.host+"/webSocketServer");
            } else if ('MozWebSocket' in window) {
                ws = new MozWebSocket("ws://localhost/webSocketServer");
            } else {
                //如果是低版本的浏览器，则用SockJS这个对象，对应了后台“sockjs/webSocketServer”这个注册器，
                //它就是用来兼容低版本浏览器的
                ws = new SockJS("http://localhost/sockjs/webSocketServer");
            }
            ws.onopen = function (evnt) {
            };
            ws.onmessage = function (evnt) {
                var mailId = evnt.data;
                if (mailId != undefined && mailId != ''){
                    $("#jjtz").show();
                    $("#jjtz").attr("href","${ctx}/iim/mailBox/detail?id="+mailId);
//                    top.layer.msg("您有一份紧急通知，请及时处理",{icon:2});
                }
            };
            ws.onerror = function (evnt) {
                console.log(evnt)
            };
            ws.onclose = function (evnt) {
            }


        });

    </script>

</head>

<body class="fixed-sidebar full-height-layout gray-bg">
    <div id="wrapper">
        <!--左侧导航开始-->
        <nav class="navbar-default navbar-static-side" role="navigation">
            <div class="nav-close"><i class="fa fa-times-circle"></i>
            </div>
            <div class="sidebar-collapse">
                <ul class="nav" id="side-menu">
                    <li class="nav-header" style="padding: 20px 20px;">
                        <div class="dropdown profile-element">
                            <span><img alt="image" class="img-circle" style="height:64px;width:64px;margin-left: 20px;" src="${ctxRoot }/asset/images/head_default.png" /></span>
                            <a data-toggle="dropdown" class="dropdown-toggle" href="#" style="float: right;margin-right: 15px;margin-top: 15px;background-color: #273a4a;">
                                <span class="clear">
                                    <span class="block m-t-xs"><strong class="font-bold">${fns:getUser().name}</strong><b class="caret"></b></span>
                                </span>
                            </a>
                            <ul class="dropdown-menu animated fadeInRight m-t-xs">
                                <li><a class="J_menuItem" href="${ctx }/sys/user/info">个人资料</a>
                                </li>
                               <%-- <li><a class="J_menuItem" href="${ctx }/iim/mailBox/list">信箱</a>
                                </li> --%>
                                <li><a href="${ctx}/logout">安全退出</a>
                                </li>
                            </ul>
                        </div>
                        <div class="logo-element">
                        </div>
                    </li>
     
                  <t:menu  menu="${fns:getTopMenu()}"></t:menu>

                </ul>
            </div>
        </nav>
        <!--左侧导航结束-->
        <!--右侧部分开始-->
        <div id="page-wrapper" class="gray-bg dashbard-1">
            <div class="row border-bottom">
                <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
                    <div class="navbar-header">
                        <a class="navbar-minimalize minimalize-styl-2 btn btn-primary " href="#"><i class="fa fa-bars"></i> </a>
                        <div style="height: 60px;">
                            <div style="padding: 15px;font-size: 20px;font-family: '微软雅黑';">财务管理系统</div>
                        </div>
                    </div>


                    <ul class="nav navbar-top-links navbar-right"><%--btn btn-danger btn-xs;--%>
                        <a href="#" id="jjtz" onclick="closeNotice(this)" style="display: none;color: red" class="J_menuItem"> <span class="fa  fa-info-circle"></span>紧急通知</a>
                        <li class="dropdown">
                            <a class="dropdown-toggle count-info" data-toggle="dropdown" href="#">
                                <i class="fa fa-envelope"></i> <span class="label label-warning">${noReadCount}</span>
                            </a>
                            <ul class="dropdown-menu dropdown-messages">
                            	 <c:forEach items="${mailPage.list}" var="mailBox">
	                                <li class="m-t-xs">
	                                    <div class="dropdown-messages-box">

	                                        <a  href="#" class="pull-left">
	                                            <img alt="image" class="img-circle" src="${ctxRoot }/asset/images/head_default.png">
	                                        </a>
	                                        <div class="media-body">
	                                            <strong>${mailBox.sender.name }:</strong>
	                                            <a class="J_menuItem" href="${ctx}/iim/mailBox/detail?id=${mailBox.id}"> ${fns:abbr(mailBox.mail.title,50)}</a>
	                                            <br>
	                                            <small class="text-muted">
	                                            <fmt:formatDate value="${mailBox.sendtime}" pattern="yyyy-MM-dd HH:mm"/></small>
	                                        </div>
	                                    </div>
	                                </li>
	                                <li class="divider"></li>
                                </c:forEach>
                                <li>
                                    <div class="text-center link-block">
                                        <a class="J_menuItem" href="${ctx}/iim/mailBox/list?orderBy=sendtime desc">
                                            <i class="fa fa-envelope"></i> <strong> 查看所有邮件</strong>
                                        </a>
                                    </div>
                                </li>
                            </ul>
                        </li>
                        <li class="dropdown" style="padding-right: 10px;">
                            <a class="dropdown-toggle count-info" data-toggle="dropdown" href="#">
                                <i class="fa fa-bell"></i> <span class="label label-primary">${msgcount }</span>
                            </a>
                            <ul class="dropdown-menu dropdown-alerts">
                                <li>
                                
                                <c:forEach items="${msgpage.list}" var="msg">
                                        <div>
                                            <a href="#" onclick="openDialogView('查看${fns:getDictLabel(msg.msgType, "sys_msg_type", "无")}', '${ctx}/sys/tMsg/deal?id=${msg.id}','800px', '600px')">
                                        	   <%--<a class="J_menuItem" href="${ctx}${msg.redirectUrl}">--%>
                                            	<i class ="fa fa-envelope fa-fw"></i> ${fns:abbr(msg.msgContent,30)}
                                               </a>
                                            <span class="pull-right text-muted small">${fns:getTime(msg.createDate)}前</span>
                                        </div>
								</c:forEach>
                                   
                                </li>
                                <li class="divider"></li>
                                <li>
                                    <div class="text-center link-block">
                                       您有${msgcount }条未读消息 <a class="J_menuItem" href="${ctx }/sys/tMsg/list">
                                            <strong>查看所有 </strong>
                                            <i class="fa fa-angle-right"></i>
                                        </a>
                                    </div>
                                </li>
                            </ul>
                        </li>
                      
                      <!-- 国际化功能预留接口 -->
                    </ul>
                </nav>
            </div>
            <div class="row content-tabs">
                <button class="roll-nav roll-left J_tabLeft"><i class="fa fa-backward"></i>
                </button>
                <nav class="page-tabs J_menuTabs">
                    <div class="page-tabs-content">
                        <a href="javascript:;" class="active J_menuTab" data-id="${ctx}/home">首页</a>
                    </div>
                </nav>
                <button class="roll-nav roll-right J_tabRight"><i class="fa fa-forward"></i>
                </button>
                <div class="btn-group roll-nav roll-right">
                    <button class="dropdown J_tabClose"  data-toggle="dropdown">关闭操作<span class="caret"></span>

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
                <a href="${ctx}/logout" onclick="closeSocket()" class="roll-nav roll-right J_tabExit"><i class="fa fa fa-sign-out"></i> 退出</a>
            </div>
            <div class="row J_mainContent" id="content-main">
                <iframe class="J_iframe" name="iframe0" id="iframe0" width="100%" height="100%" src="${ctx}/home" frameborder="0" data-id="${ctx}/home" seamless></iframe>
            </div>
            <div class="footer">
                <div class="pull-left"><a href="${ctx}">纪检监察工作电子监管系统</a> &copy; 2017</div>
            </div>
        </div>
        <!--右侧部分结束-->
       
       
    </div>
</body>

<!-- 语言切换插件，为国际化功能预留插件 -->
<script type="text/javascript">

$(document).ready(function(){

	$("a.lang-select").click(function(){
		$(".lang-selected").find(".lang-flag").attr("src",$(this).find(".lang-flag").attr("src"));
		$(".lang-selected").find(".lang-flag").attr("alt",$(this).find(".lang-flag").attr("alt"));
		$(".lang-selected").find(".lang-id").text($(this).find(".lang-id").text());
		$(".lang-selected").find(".lang-name").text($(this).find(".lang-name").text());

	});


});

function closeSocket() {
    ws.close();
}
function closeNotice() {

    $("#jjtz").hide();
}

function changeStyle(){
   $.get('${pageContext.request.contextPath}/theme/ace?url='+window.top.location.href,function(result){   window.location.reload();});
}

$("#content-main").bind('DOMNodeInserted', function(e) {
    $(this).children().each(function () {
        var iframeid = $(this).attr('id');
        var url = $(this).attr("src");
        if(url == '${ctx}/gen/genTable') {
            $("#" + iframeid).on("load",function(){
                $("#" + iframeid).contents().find(".ibox-title").each(function () {
                    if($(this).find("h5").text() == "表单列表  ") {
                        $(this).html('<h5>表单列表  </h5><div class="ibox-tools"></div>');
                    }
                });
            });
        }
    });
});

</script>



<!-- 即时聊天插件  开始-->
<link href="${ctxStatic}/layer-v2.3/layim/layui/css/layui.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript">
var currentId = '${fns:getUser().loginName}';
var currentName = '${fns:getUser().name}';
var currentFace ='${fns:getUser().photo}';
var url="${ctx}";
var static_url="${ctxStatic}";
var wsServer = 'ws://'+window.document.domain+':8668'; 

</script>
<!--webscoket接口  -->
<script src="${ctxStatic}/layer-v2.3/layim/layui/layui.js"></script>

<script src="${ctxStatic}/layer-v2.3/layim/layim.js"></script>
<!-- 即时聊天插件 结束 -->
<style>
/*签名样式*/
.layim-sign-box{
	width:95%
}
.layim-sign-hide{
  border:none;background-color:#F5F5F5;
}
</style>

</html>