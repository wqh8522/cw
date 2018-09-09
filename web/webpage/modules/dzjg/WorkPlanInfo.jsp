<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp" %>


<html>
<head>
    <title>工作计划</title>

    <meta name="decorator" content="default"/>

    <%--<script src="/static/layui/lay/modules/layedit.js" charset="UTF-8" type="text/javascript"></script>--%>
    <script src="/static/layui/layui.js"></script>

    <link href="/static/layui/css/layui.css" rel="stylesheet">
    <script type="text/javascript">
        var validateForm;
        var layedit;
        function doSubmit() {//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
            if (validateForm.form()) {
                var planContent = layedit.getContent(edit);
                if(planContent == ""){
                    layer.msg("请输入计划正文！",{icon:2,time:2000});
                    return false;
                }
                alertx(planContent);
                $("#planContent").val(planContent);
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
                edit = layedit.build('edit_planContent', {
                    height: 180 //设置编辑器高度
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
<div >
    <div class="body-content" style="margin-left: 20px;margin-right: 20px;margin-top: 30px" id="pageMain">
        <div>
            <span style="font-size: 16px; font-weight: bold;color:#000000" id="spanPlanTitle">${wp.planTitle}</span>&nbsp;&nbsp;
                <span style="font-size: 10px;font-weight: bold" id="spanSmallTitle">(${fns:getDictLabels(wp.planType,"plan_type" ,"")})</span>
        </div>
        <div id="divSentUser">
            创建人：<span style="font-size: 12px" id="spanCreateUser">${wp.createBy.name}</span>
        </div>
        <div>
            部&nbsp;&nbsp;&nbsp;门：<span style="font-size: 12px" id="spanGroupName">${wp.createBy.office.name}</span>
        </div>
        <div>
            时&nbsp;&nbsp;&nbsp;间：<span style="font-size: 12px" id="spanCreateTime"> ${fns:formatDateTime(wp.createDate)}</span>
        </div>
        <div id="divAttachment">
            附&nbsp;&nbsp;&nbsp;件：<span style="font-size: 12px" id="spanAttachment">
                                    <a href="${ctx}/dzjg/dzjgFile/download?id=${wp.plan_file.id}">${wp.plan_file.fileName}</a>
                                </span>
        </div>
        <%--<c:if test="${empty wp.plan_file }" >

        </c:if>--%>

        <hr />
        <div id="divPlanContent">
            ${fns:unescapeHtml(wp.planContent)}
        </div>
    </div>
</div>

</body>
</html>