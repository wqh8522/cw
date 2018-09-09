<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp" %>


<html>
<head>
    <title>发送文件</title>

    <meta name="decorator" content="default"/>

    <%--<script src="/static/layui/lay/modules/layedit.js" charset="UTF-8" type="text/javascript"></script>--%>
    <script src="/static/layui/layui.js"></script>

    <link href="/static/layui/css/layui.css" rel="stylesheet">
    <script type="text/javascript">
        var validateForm;
        function doSubmit() {//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
            if (validateForm.form()) {
               /* if(exit_fileContent == ""){
                    layer.msg("请输入计划正文！",{icon:2,time:2000});
                    return false;
                }
                $("#fileInfo").val(exit_fileContent);*/
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
<form:form id="inputForm" modelAttribute="tDzjgAttachment" action="${ctx}/dzjg/file/send" method="post"
           class="form-horizontal"  enctype="multipart/form-data">
    <form:hidden path="id"/>
    <sys:message content="${message}"/>
    <table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
        <tbody>
        <tr>
            <td class="width_15 active"><label class="pull-right"><font color="red">*</font>文件标题：</label></td>

            <td colspan="2">
          <form:input path="fileTitle" htmlEscape="false" class="form-control required"/>
                    <%--<input type="text" class="input" style="width: 600px" placeholder="请输入计划标题" name="planTitle" id="planTitle"/>--%>
            </td>
        </tr>
        <tr>

            <td  class="width-15 active"><label class="pull-right"><font color="red">*</font>收件人：</label></td>
            <td colspan="2" class="col-sm-8">

                <div class="form-group">
                    <div class="col-sm-12">
                        <c:choose>
                            <c:when test="${empty tDzjgAttachment.sender.id}">
                             <sys:treeselect id="receiver" name="receiverIds" value="${tDzjgAttachment.sender.id}" labelName="receiverNames" labelValue="${tDzjgAttachment.sender.name}"
                                              title="用户" url="/sys/office/treeData?type=3" cssClass="form-control required" notAllowSelectParent="true" checked="true" />
                            </c:when>
                            <c:otherwise>
                                <input type="text" value="${tDzjgAttachment.sender.name}" class="form-control" readonly/>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            <%--   --%>
            </td>
        </tr>
        <tr>
            <td  width="10" class="width-15 active" ><label class="pull-right"><font color="red">*</font>文件说明：</label></td>
            <td class="width-35" colspan="3">
                <form:textarea path="fileInfo" htmlEscape="false"  rows="10" class="form-control required"/>
             <%-- <input type="hidden" id="fileInfo" value="" name="fileInfo">

                   <textarea name="edit_fileContent" id="edit_fileContent" >${tDzjgAttachment.fileInfo}</textarea>--%>
            </td>

        </tr>
        <tr>
            <td  width="10" class="width-15 active"><label class="pull-right"><font color="red">*</font>添加文件：</label></td>
            <td class="width-35">
                <input type="file" name="file" id="file" <c:if test="${empty tDzjgAttachment.id}">class="form-control required"</c:if> />

            </td>
            <td>
                <c:if test="${not empty tDzjgAttachment.id}">

                    <a href="${ctx}/dzjg/file/download?id=${tDzjgAttachment.id}" class="glyphicon glyphicon-paperclip"
                       title="${tDzjgAttachment.fileName}">${tDzjgAttachment.fileName}</a>
                </c:if>
              <%--  <a href="${ctx}/dzjg/dzjgFile/download?id=${tDzjgWorkSummary.file_file.id}">${tDzjgWorkSummary.file_file.fileName}</a>--%>
            </td>
        </tr>
        </tbody>
    </table>
</form:form>
</body>
</html>