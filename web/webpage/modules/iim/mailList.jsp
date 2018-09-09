<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
    <title>邮箱管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {
        });
    </script>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content">
    <div class="ibox">
        <div class="ibox-title">
            <h5>邮件列表 </h5>
            <div class="ibox-tools">
            </div>
        </div>



        <div class="ibox-content">
            <sys:message content="${message}"/>

            <!--查询条件-->
            <div class="row">
                <div class="col-sm-12">
                    <form:form id="searchForm" modelAttribute="mailCompose" action="${ctx}/iim/mailCompose/manage?status=1" method="post" class="form-inline">
                        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                        <table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
                        <div class="form-group">
                            <span>标题：</span>
                            <form:input path="mail.title" htmlEscape="false" maxlength="50"  class=" form-control input-sm"/>
                            <span>发件人单位：</span>
                                <sys:treeselect id="office" name="office.id" value="${mailCompose.office.id}" labelName="office.name" labelValue="${mailCompose.office.name}"
                                                title="部门" url="/sys/office/treeData?type=2" cssClass="form-control required" notAllowSelectParent="false"/></td>
                            <span>发送时间：</span>
                            <form:input path="startDate" id="startDate"
                                        value="${fns:formatDateTime1(mailCompose.startDate,'yyyy-MM-dd')}"
                                        onclick="laydate({ istime: true, format: 'YYYY-MM-DD'}); $('#laydate_box').css('-webkit-box-sizing', null);"
                                        class="form-control required  laydate-icon" />-
                            <form:input path="stopDate" id="stopDate"
                                        value="${fns:formatDateTime1(mailCompose.stopDate,'yyyy-MM-dd')}"
                                        onclick="laydate({ istime: true, format: 'YYYY-MM-DD'}); $('#laydate_box').css('-webkit-box-sizing', null);"
                                        class="form-control required  laydate-icon" />
                        </div>
                    </form:form>
                    <br/>
                </div>
            </div>
            <!--查询条件-->
            <%--<div class="row">
                <div class="col-sm-12">
                    <form:form  id="searchForm" modelAttribute="mailCompose" action="${ctx}/iim/mailCompose/manage?status=1" method="post" class="pull-right mail-search">
                        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                        <table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
                        <div class="form-group">
                            <span>文章标题：</span>
                            <form:input path="mail.title" htmlEscape="false" maxlength="50"  class=" form-control input-sm"/>
                        </div>
                    </form:form>
                    <br/>
                </div>
            </div>--%>

            <!-- 工具栏 -->
            <div class="row">
                <div class="col-sm-12">
                    <div class="pull-left">
                        <table:delRow url="${ctx}/iim/mailCompose/deleteAllCompose" id="contentTable"></table:delRow><!-- 删除按钮 -->
                        <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
                    </div>
                    <div class="pull-right">
                        <button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="search()" ><i class="fa fa-search"></i> 查询</button>
                        <button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="reset()" ><i class="fa fa-refresh"></i> 重置</button>
                    </div>
                </div>
            </div>

                <table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
                    <thead>
                    <tr>
                        <th  width="1px" class="check-mail">
                            <input type="checkbox" class="i-checks">
                        </th>
                        <th  class="">标题</th>
                        <th  class="">正文</th>
                        <th >信息类型</th>
                        <th  class="">发件人</th>
                        <th  class="">发件人单位</th>
                        <th  class="">收件人</th>
                        <th  class="sort-column sendtime">时间</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>

                    <c:forEach items="${page.list}" var="mailCompose">
                        <tr>
                            <td  width="0px" class="check-mail">
                                <input id="${mailCompose.id}" type="checkbox" class="i-checks">
                            </td>

                            <td class="mail-ontact"><a href="#" onclick="openDialogView('查看信息详情','${ctx}/iim/mailCompose/detailView?id=${mailCompose.id}','800px','500px')">
                                <c:if test="${fn:length(mailCompose.mail.title)>15 }">
                                    ${fn:substring(mailCompose.mail.title, 0, 15)}...
                                </c:if>
                                <c:if test="${fn:length(mailCompose.mail.title)<=15}">
                                    ${mailCompose.mail.title }
                                </c:if>

                            </a></td>
                            <td class="mail-subject">
                                    ${mailCompose.mail.overview}

                            </td>
                            <td>
                                    ${fns:getDictLabel(mailCompose.mail.mailType,"mail_type" ,"" )}
                            </td>
                            <td>
                                ${mailCompose.sender.name}
                            </td>
                            <td>
                                ${mailCompose.sender.office.name}
                            </td>
                            <td class="">
                                    <c:if test="${fn:length(mailCompose.receiver.name)>9 }">
                                        ${fn:substring(mailCompose.receiver.name, 0, 9)}...
                                    </c:if>
                                    <c:if test="${fn:length(mailCompose.receiver.name)<=9 }">
                                        ${mailCompose.receiver.name }
                                    </c:if>

                            </td>
                            <td class="mail-date">
                                    ${fns:formatDateTime(mailCompose.sendtime)}
                            </td>
                            <td>
                                <a href="#" onclick="openDialogView('查看信息详情','${ctx}/iim/mailCompose/detailView?id=${mailCompose.id}','800px','500px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
                                    <a href="${ctx}/iim/mailCompose/delete?id=${mailCompose.id}" onclick="return confirmx('确认要删除该站内信吗？', this.href)"   class="btn btn-info btn-xs btn-danger"><i class="fa fa-trash"></i> 删除</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            <!-- 分页代码 -->
            <table:page page="${page}"></table:page>
            <br/>
            <br/>
        </div>
    </div>
</div>
</body>
</html>