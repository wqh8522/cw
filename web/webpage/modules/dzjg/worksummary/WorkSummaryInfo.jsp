<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp" %>


<html>
<head>
    <title>工作总结</title>

    <meta name="decorator" content="default"/>

    <%--<script src="/static/layui/lay/modules/layedit.js" charset="UTF-8" type="text/javascript"></script>--%>
    <script src="/static/layui/layui.js"></script>

    <link href="/static/layui/css/layui.css" rel="stylesheet">
    <script type="text/javascript">
    </script>
</head>
<body class="hideScroll">
<div >
    <div class="body-content" style="margin-left: 20px;margin-right: 20px;margin-top: 30px" id="pageMain">
        <div>
            <span style="font-size: 16px; font-weight: bold;color:#000000" id="spanPlanTitle">${ws.summaryTitle}</span>&nbsp;&nbsp;
                <span style="font-size: 10px;font-weight: bold" id="spanSmallTitle">(${fns:getDictLabels(ws.summaryType,"summary_type" ,"")})</span>
        </div>
        <div id="divSentUser">
            创建人：<span style="font-size: 12px" id="spanCreateUser">${ws.createBy.name}</span>
        </div>
        <div>
            部&nbsp;&nbsp;&nbsp;门：<span style="font-size: 12px" id="spanGroupName">${ws.createBy.office.name}</span>
        </div>
        <div>
            时&nbsp;&nbsp;&nbsp;间：<span style="font-size: 12px" id="spanCreateTime"> ${fns:formatDateTime(ws.createDate)}</span>
        </div>
        <div id="divAttachment">
            附&nbsp;&nbsp;&nbsp;件：<span style="font-size: 12px" id="spanAttachment">

                                    <c:if test="${not empty ws.file}">
                                        <a href="${ctx}/dzjg/dzjgFile/download?id=${ws.file.id}">${ws.file.fileName}</a>
                                    </c:if>
                                    <c:forEach items="${ws.attachs}" varStatus="vs" var="att">
                                        <a href="${ctx}/sys/attach/download?id=${att.id}" title="下载附件">
                                            <c:if test="${ws.attachs.size()>1}">
                                                <c:if test="${!vs.first}">
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                </c:if>
                                                ${vs.count}、
                                            </c:if>
                                                ${att.fileName}
                                        </a><br>
                                    </c:forEach>
                                    <%--<a href="${ctx}/dzjg/dzjgFile/download?id=${ws.summary_file.id}">${ws.summary_file.fileName}</a>--%>
                                </span>
        </div>
        <%--<c:if test="${empty ws.plan_file }" >

        </c:if>--%>

        <hr />
        <div id="divPlanContent">
            ${fns:unescapeHtml(ws.summaryContent)}
        </div>
    </div>
</div>

</body>
</html>