<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp" %>
<html>
<head>
    <title>节后公示管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        var validateForm;

        function doSubmit() {//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
            if (validateForm.form()) {
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
<form:form id="inputForm" modelAttribute="jhgs" action="${ctx}/dzjg/jhgs/save" method="post" class="form-horizontal">
    <form:hidden path="id"/>
    <sys:message content="${message}"/>

    <table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
        <thead>
        <tr align="center">
            <div align="center">
                <h1>南昌市节日廉情监督情况公示表</h1>
            </div>
            <br/>
            <div >
                    <span style="font-size: 15px">填报单位：${jhgs.tbdw.name}</span>

                   <%-- <span>节日：</span>--%>
                    <span style="float: right">填报时间：${fns:formatDateTime1(jhgs.tbsj,"yyyy年MM月dd日")}</span>
            </div>
        </tr>
        </thead>
        <tbody>
        <tr align="center">
            <td colspan="4"><h3>节前教育提醒情况</h3></td>
            <td colspan="3"><h3>节日明察暗访情况</h3></td>
        </tr>
        <tr align="center">
            <td colspan="4" height="100px">
                ${jhgs.jqjyqk}
            </td>
            <td colspan="3" height="100px">
                    ${jhgs.jrmcqk}
            </td>
        </tr>
        <tr align="center">
            <td colspan="2">项目</td>
            <td width="100px">合计</td>
            <td colspan="2">公共接待方面</td>
            <td>公车使用管理方面</td>
            <td>遵守廉洁规定方面</td>
        </tr>
        <tr align="center">
            <td colspan="2">发现违纪违规问题数</td>
            <td>
                    ${jhgs.wgwjCount}
            </td>
            <td colspan="2">
                    ${jhgs.wgwjGgjd}
            </td>
            <td>
                    ${jhgs.wgwjGggl}
            </td>
            <td>
                    ${jhgs.wgwjZsljgd}
            </td>
        </tr>
        <tr align="center">
            <td rowspan="2" width="60px">查处违纪违规干部人数</td>
            <td width="150px">党纪政纪处分人数</td>
            <td>
                    ${jhgs.djzjCount}
            </td>
            <td colspan="2">
                    ${jhgs.djzGgjd}
            </td>
            <td>
                    ${jhgs.djzjGggl}
            </td>
            <td>
                    ${jhgs.djzjZsljgd}
            </td>
        </tr>
        <tr align="center">
            <td>其他问责人数</td>
            <td>
                    ${jhgs.qtwzCount}
            </td>
            <td colspan="2">
                    ${jhgs.qtwzGgjd}
            </td>
            <td>
                    ${jhgs.qtwzGggl}
            </td>
            <td>
                    ${jhgs.qtwzZsljgd}
            </td>
        </tr>
        <tr>
            <td colspan="7">
                说明：此表每逢节后一周内填写，在本单位张贴公示，并报派驻纪检组备案。
            </td>
        </tr>
        </tbody>
    </table>
    <div style="float: right">
        附件：<a href="${ctx}/sys/attach/download?id=${jhgs.attachs.id}" title="下载附件">${jhgs.attachs.fileName}</a></td>
    </div>

</form:form>
<script type="text/javascript">
    $(document).ready(function () {
        $("input[type='text']").bind("keyup", function () {
            if (!/^\d+$/.test(this.value)) {
                this.value = this.value.replace(/[^\d]+/g, '');
            }
        })
    });
</script>
</body>
</html>