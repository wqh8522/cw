<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp" %>


<html>
<head>
    <title>文件详情</title>

    <meta name="decorator" content="default"/>

    <%--<script src="/static/layui/lay/modules/layedit.js" charset="UTF-8" type="text/javascript"></script>--%>
    <script src="/static/layui/layui.js"></script>

    <link href="/static/layui/css/layui.css" rel="stylesheet">
    <script type="text/javascript">
        var validateForm;
        function doSubmit() {//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
            if (validateForm.form()) {
                var reply_content = $("textarea[name='reply_content']").val();
                if(reply_content == ""){
                    layer.msg("请输入回复的内容！",{icon:2,time:2000});
                    return false;
                }
                $("#inputForm").submit();
                return true;
            }

            return false;
        }

        $(document).ready(function () {
            validateForm = $("#inputForm").validate({
                submitHandler: function (form) {
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function (error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
        });
    </script>
</head>
<body class="hideScroll">

<form:form id="inputForm" modelAttribute="file" action="${ctx}/dzjg/file/replyFile" method="post"
           class="form-horizontal" enctype="multipart/form-data">
    <form:hidden path="id"/>
    <sys:message content="${message}"/>
    <div>
        <div class="body-content" style="margin-left: 20px;margin-right: 20px;margin-top: 30px" id="pageMain">
            <div>
                <span style="font-size: 20px; font-weight: bold;color:#000000"
                      id="spanPlanTitle">${file.fileTitle}</span>&nbsp;&nbsp;
                    <%--<span style="font-size: 10px;font-weight: bold" id="spanSmallTitle">(${fns:getDictLabels(ws.summaryType,"summary_type" ,"")})</span>--%>
            </div>
            <div id="divSentUser">
                收件人：<span style="font-size: 15px" id="spanCreateUser">
                <c:forEach items="${file.fileReceivedUsers}" var="received" varStatus="vs">
                    ${received.receivedUser.name}
                    <c:if test="${!vs.last}">,</c:if>
                </c:forEach>
            </span>
            </div>
            <div>
                时&nbsp;&nbsp;&nbsp;间：<span style="font-size: 15px"
                                           id="spanGroupName">${fns:formatDateTime(file.createDate)}</span>
            </div>
            <div>
                说&nbsp;&nbsp;&nbsp;明：<span style="font-size: 15px" id="spanCreateTime">${file.fileInfo}</span>
            </div>
            <hr/>
            <div id="divAttachment">
                    <%--  附&nbsp;&nbsp;&nbsp;件：<span style="font-size: 12px" id="spanAttachment">
                                              <a href="${ctx}/dzjg/dzjgFile/download?id=${ws.summary_file.id}">${ws.summary_file.fileName}</a>
                                          </span>--%>
                <span style="font-size: 15px"> <a href="${ctx}/dzjg/file/download?id=${file.id}" class="glyphicon glyphicon-paperclip"
                                                  title="${file.fileName}">${file.fileName}</a></span>
            </div>
            <hr/>
                <%--收件箱查看文件信息--%>
            <c:if test="${boxtype eq  'in'}">
                <c:if test="${not empty reply_status.replyContent}">
                    [已回复] &nbsp;${fns:formatDateTime(reply_status.replyDate)}<br>
                    &nbsp;&nbsp; ${reply_status.replyContent}
                    <br>
                    <br>
                </c:if>
                <textarea  rows="5" cols="70" placeholder="请输入回复的内容"
                          style="display: block" name="reply_content" id="reply_content"></textarea>
            </c:if>
                <%--发件箱查看文件信息--%>
            <c:if test="${boxtype eq  'out'}">

                <%--循环打印出回复的信息--%>
                <c:forEach items="${file.fileReceivedUsers}" var="fileUser" varStatus="vs">
                        <c:if test="${not empty fileUser.replyContent}">

                             <div class="button-group" style="margin-top: 3px">
                                 <span>[${fileUser.receivedUser.office.name}] &nbsp; ${fileUser.receivedUser.name}</span>
                                 &nbsp;&nbsp;<span style="font-size:10px">${fns:formatDateTime(fileUser.replyDate)}</span>
                                 <br><span>${fileUser.replyContent}</span><br><br>
                             </div>
                        </c:if>
                </c:forEach>
            </c:if>
                <%--<c:if test="${empty ws.plan_file }" >
   <i class="fa fa-edit"></i> 修改
           </c:if>--%>
                <%--
                        <hr />
                        <div id="divPlanContent">
                            ${fns:unescapeHtml(ws.summaryContent)}
                        </div>--%>
        </div>
    </div>
</form:form>
</body>
</html>