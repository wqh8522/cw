<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp" %>


<html>
<head>
    <title>文件传阅状态</title>

    <meta name="decorator" content="default"/>

    <%--<script src="/static/layui/lay/modules/layedit.js" charset="UTF-8" type="text/javascript"></script>--%>
    <script src="/static/layui/layui.js"></script>

    <link href="/static/layui/css/layui.css" rel="stylesheet">
    <link href="/static/dzjg/css/admin.css" rel="stylesheet">
    <link href="/static/dzjg/css/pintuer.css" rel="stylesheet">

    <style>
        #divShowData div {
            padding: 2px;
        }
        .divR {
            padding-left: 5px;
        }
        .divR li {
            margin-left: 6px;
            margin-right: 6px;
            margin-top: 3px;
            margin-bottom: 3px;
        }
        .divR a {
            font-size: 10px
        }
    </style>


    <script type="text/javascript">
    </script>
</head>
<body class="hideScroll">
<sys:message content="${message}"/>


<div>

    <div class="body-content" style="margin-left: 20px;margin-right: 20px;margin-top: 10px" id="pageMain">
        <c:forEach items="${result}" var="map">
        <div class="divR" id="showR"><span style="font-size: 15px"> ${map.key}</span><br>
            <hr>
            <ul class="ulR">
                <c:forEach items="${map.value}" var="value">
                    <li class="button-group"><a href="javascript:void(0)"
                                                class="button border-main">${value.receivedUser.name}</a>
                        <a href="javascript:void(0)" class="button bg-dot"
                           title="${fns:formatDateTime(value.consultDate)}">${fns:getDictLabel(value.isConsult, "is_consult","" )}</a>
                        <a href="javascript:void(0)" class="button bg-blue"<c:if test="${not empty value.receivedDate}"> title="${fns:formatDateTime(value.receivedDate)}"</c:if>>${fns:getDictLabel(value.isReceived, "is_received","" )}</a>
                    </li>
                </c:forEach>
            </ul>
            <br>
            </c:forEach>
        </div>
    </div>
</div>
</body>
</html>