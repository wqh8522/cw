<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp" %>
<%@ include file="/webpage/include/util.jsp" %>
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
<form:form id="inputForm" modelAttribute="jhgs" action="${ctx}/dzjg/jhgs/save" method="post" class="form-horizontal"
           enctype="multipart/form-data">
    <form:hidden path="id"/>
    <sys:message content="${message}"/>

    <table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
        <thead>
        <tr align="center">
            <div align="center">
                <h1>南昌市节日廉情监督情况公示表</h1>
            </div>
        </tr>
            <%--<tr class="form-group">
                    <div class="form-group">
                                <td>
                                    <span>填报单位：</span>
                                <sys:treeselect id="tbdw" name="tbdw.id" value="${jhgs.tbdw.id}" labelName="tbdw.name" labelValue="${jhgs.tbdw.name}"
                                            title="部门" url="/sys/office/treeData?type=2" cssClass="form-control required" notAllowSelectParent="false"/>
                                </td>
                        <td>
                        <span>节日：</span>
                        <select name="jr" id="jr" htmlEscape="false" class="form-control required">
                            <option value="" >请选择</option>
                            <c:forEach items="${jrs}" var="jr">
                            <option value="${jr.id}" ${TDzjgJqjytx.jr.id == jr.id?'selected = "selected"':'' }>${jr.name}</option>
                            </c:forEach>
                        <span style="float: right">填报时间：</span>
                        </td>
                    </div>

            </tr>--%>
        </thead>
        <tbody>
        <tr>
            <td width="80px" align="center">年份</td>
            <td colspan="2">
                <form:input path="jrYear" id="jrYear"
                            value="${jhgs.jrYear == null?year:jhgs.jrYear}"
                            onclick="laydate({ format: 'YYYY'}); $('#laydate_box').css('-webkit-box-sizing', null);"
                            class="required  laydate-icon" size="26px"/>
            </td>
            <td colspan="2" align="center">
                节日
            </td>
            <td colspan="2">
                <select name="jr" id="jr" htmlEscape="false" class="form-control required">
                    <option value="">请选择</option>
                    <c:forEach items="${jr}" var="jr">
                    <option value="${jr.id}" ${jhgs.jr.id == jr.id?'selected = "selected"':'' }>${jr.name}</option>
                    </c:forEach>
                    <span style="float: right">填报时间：</span>
            </td>

        </tr>
        <tr>
            <td width="80px" align="center">填报单位</td>
            <td colspan="2">

                <c:choose>
                <c:when test="${not empty jhgs.id}">
                    <sys:treeselect id="tbdw" name="tbdw.id" value="${jhgs.tbdw.id}" labelName="tbdw.name"
                                    labelValue="${jhgs.tbdw.name}"
                                    title="部门" url="/sys/office/treeData?type=2" cssClass="form-control required"
                                    notAllowSelectParent="false"/>
                </c:when>
                <c:otherwise>
                <sys:treeselect id="tjdw" name="tbdw.id" value="${fns:getUser().office.id}" labelName="tjdw.name"
                                labelValue="${fns:getUser().office.name}"
                                title="部门" url="/sys/office/treeData?type=2" disabled="disabled"
                                cssClass="form-control required" notAllowSelectParent="false"/></td>
            </c:otherwise>
            </c:choose>


            </td>
            <td colspan="2" align="center">
                附件
            </td>
            <td colspan="2" align="left">
                <input type="file" name="jhgs_file"/>
                <a href="${ctx}/sys/attach/download?id=${jhgs.attachs.id}" title="下载附件">${jhgs.attachs.fileName}</a>
            </td>
            </td>

        </tr>
        <tr align="center">
            <td colspan="4"><h3>节前教育提醒情况</h3></td>
            <td colspan="3"><h3>节日明察暗访情况</h3></td>
        </tr>
        <tr>
            <td colspan="4">
                <form:textarea path="jqjyqk" htmlEscape="false" rows="4" class="form-control required"/>
            </td>
            <td colspan="3">
                <form:textarea path="jrmcqk" htmlEscape="false" rows="4" class="form-control required"/>
            </td>
        </tr>
        <tr align="center">
            <td colspan="2">项目</td>
            <td>合计</td>
            <td colspan="2">公共接待方面</td>
            <td>公车使用管理方面</td>
            <td>遵守廉洁规定方面</td>
        </tr>
        <tr align="center">
            <td colspan="2">发现违纪违规问题数</td>
            <td>
                <form:input path="wgwjCount" htmlEscape="false" class="form-control required"/>
            </td>
            <td colspan="2">
                <form:input path="wgwjGgjd" htmlEscape="false" class="form-control required"/>
            </td>
            <td>
                <form:input path="wgwjGggl" htmlEscape="false" class="form-control required"/>
            </td>
            <td>
                <form:input path="wgwjZsljgd" htmlEscape="false" class="form-control required"/>
            </td>
        </tr>
        <tr align="center">
            <td rowspan="2" width="60px">查处违纪违规干部人数</td>
            <td width="150">党纪政纪处分人数</td>
            <td>
                <form:input path="djzjCount" htmlEscape="false" class="form-control required"/>
            </td>
            <td colspan="2">
                <form:input path="djzGgjd" htmlEscape="false" class="form-control required"/>
            </td>
            <td>
                <form:input path="djzjGggl" htmlEscape="false" class="form-control required"/>
            </td>
            <td>
                <form:input path="djzjZsljgd" htmlEscape="false" class="form-control required"/>
            </td>
        </tr>
        <tr align="center">
            <td>其他问责人数</td>
            <td>
                <form:input path="qtwzCount" htmlEscape="false" class="form-control required"/>
            </td>
            <td colspan="2">
                <form:input path="qtwzGgjd" htmlEscape="false" class="form-control required"/>
            </td>
            <td>
                <form:input path="qtwzGggl" htmlEscape="false" class="form-control required"/>
            </td>
            <td>
                <form:input path="qtwzZsljgd" htmlEscape="false" class="form-control required"/>
            </td>
        </tr>
            <%--<tr>
                <td >
                    附件：
                </td>
                <td colspan="6">

                </td>
            </tr>--%>
        <tr>
            <td colspan="7">
                说明：此表每逢节后一周内填写，在本单位张贴公示，并报派驻纪检组备案。
            </td>
        </tr>
        </tbody>
    </table>
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