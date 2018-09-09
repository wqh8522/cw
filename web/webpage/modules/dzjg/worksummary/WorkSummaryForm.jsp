<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp" %>


<html>
<head>
    <title>新增总结</title>

    <meta name="decorator" content="default"/>

    <%--<script src="/static/layui/lay/modules/layedit.js" charset="UTF-8" type="text/javascript"></script>--%>
    <script src="/static/layui/layui.js"></script>

    <link href="/static/layui/css/layui.css" rel="stylesheet">
    <script type="text/javascript">
        var validateForm;
        var layedit;
        function doSubmit() {//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
            if (validateForm.form()) {
                var exit_summaryContent = layedit.getContent(edit);
                if(exit_summaryContent == ""){
                    layer.msg("请输入计划正文！",{icon:2,time:2000});
                    return false;
                }
                loading('正在提交，请稍等...');
                $("#summaryContent").val(exit_summaryContent);
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
            //初始化文本编辑器
            layui.use('layedit', function () {
                layedit = layui.layedit;
                edit = layedit.build('edit_summaryContent', {
                    height: 250 //设置编辑器高度
                    ,
                    tool: [
                        'strong' //加粗
                        , 'italic' //斜体
                        , 'underline' //下划线
                        , 'del' //删除线
                        , '|' //分割线
                        , 'left' //左对齐
                        , 'center' //居中对齐
                        , 'right' //右对齐
                        , '|' //分割线
                        , 'link' //超链接
                        , 'unlink' //清除链接
                        //, 'face' //表情
                        //, 'image' //插入图片
                        //, 'help' //帮助
                    ]
                }); //建立编辑器

                //layedit.set({
                //    uploadImage: {
                //        url: responseUrl.uploadImage //接口url
                //        ,
                //        type: 'post' //默认post
                //    }
                //});
            });
        });
    </script>
</head>
<body class="hideScroll">
<form:form id="inputForm" modelAttribute="worksummary" action="${ctx}/dzjg/worksummary/save" method="post"
           class="form-horizontal"  enctype="multipart/form-data">
    <form:hidden path="id"/>
    <input type="hidden" name="type" value="${type}"/>
    <sys:message content="${message}"/>
    <table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
        <tbody>
        <tr>
            <td class="width_15 active"><label class="pull-right"><font color="red">*</font>总结标题：</label></td>

            <td colspan="2">
                <form:input path="summaryTitle" htmlEscape="false" class="form-control required"/>
                    <%--<input type="text" class="input" style="width: 600px" placeholder="请输入计划标题" name="planTitle" id="planTitle"/>--%>
            </td>
        </tr>
        <tr>

            <td  class="width-15 active"><label class="pull-right"><font color="red">*</font>总结类型：</label></td>
            <td class="width-35" >
                <form:select path="summaryType" htmlEscape="false" class=" form-control m-b" id="planType">
                   <%-- <form:option value="">全部</form:option>--%>
                    <form:options items="${fns:getDictList('summary_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                </form:select>
            </td>
        </tr>
        <tr>
            <td  width="10" class="width-15 active" ><label class="pull-right"><font color="red">*</font>总结正文：</label></td>
            <td class="width-35" colspan="2">
                <input type="hidden" id="summaryContent" value="" name="summaryContent">
                    <%--<form:input path="tDzjgWorkplan" htmlEscape="false"    class="form-control required"/>--%>
              <%--  <form:textarea path="planContent" htmlEscape="false" class="form-control required" id="edit_planContent" />--%>
                   <textarea name="edit_summaryContent" id="edit_summaryContent" >${worksummary.summaryContent}</textarea>
            </td>

        </tr>
        <tr>
            <td  width="10" class="width-15 active"><label class="pull-right">添加附件：<br>	<span style="color: red;font-size: 3px" class="pull-right">可同时上传多文件</span></label></td>
            <td class="width-35">
               <input type="file" name="workSummary_File"  multiple="multiple"/>

            </td>
            <td>
                <c:if test="${not empty worksummary.file}">
                    <a href="${ctx}/dzjg/dzjgFile/download?id=${worksummary.file.id}">${worksummary.file.fileName}</a>
                </c:if>
                <c:forEach items="${worksummary.attachs}" varStatus="vs" var="att">
                    <a href="${ctx}/sys/attach/download?id=${att.id}" title="下载附件">
                        <c:if test="${worksummary.attachs.size()>1}">
                            ${vs.count}、
                        </c:if>
                            ${att.fileName}
                    </a><br>
                </c:forEach>
            </td>
        </tr>
        </tbody>
    </table>
</form:form>
</body>
</html>