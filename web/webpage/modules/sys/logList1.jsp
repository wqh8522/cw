<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp" %>
<html>
<head>
    <title>日志管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        function page(n, s) {
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }

        $(document).ready(function () {
            //外部js调用
            laydate({
                elem: '#beginDate', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
                event: 'focus' //响应事件。如果没有传入event，则按照默认的click
            });
            laydate({
                elem: '#endDate', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
                event: 'focus' //响应事件。如果没有传入event，则按照默认的click
            });


        })
    </script>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content">
    <div class="ibox">
        <div class="ibox-title">
            <h5>登入日志列表 </h5>
            <div class="ibox-tools">
                <a class="collapse-link">
                    <i class="fa fa-chevron-up"></i>
                </a>
                <a class="dropdown-toggle" data-toggle="dropdown" href="form_basic.html#">
                    <i class="fa fa-wrench"></i>
                </a>
                <ul class="dropdown-menu dropdown-user">
                    <li><a href="#">选项1</a>
                    </li>
                    <li><a href="#">选项2</a>
                    </li>
                </ul>
                <a class="close-link">
                    <i class="fa fa-times"></i>
                </a>
            </div>
        </div>

        <div class="ibox-content">
            <sys:message content="${message}"/>

            <!-- 查询条件 -->
            <div class="row">
                <div class="col-sm-12">
                    <form:form id="searchForm" action="${ctx}/sys/log1/" method="post" class="form-inline">
                        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                        <table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}"
                                          callback="sortOrRefresh();"/><!-- 支持排序 -->
                        <div class="form-group">
                            <span>操作菜单：</span>
                            <input id="title" name="title" type="text" maxlength="50" class="form-control input-sm"
                                   value="${log.title}"/>
                            <span>用户名称：</span>
                            <input id="createBy.name" name="createBy.name" type="text" maxlength="50"
                                   class="form-control input-sm" value="${log.createBy.name}"/>

                            <span>日期范围：&nbsp;</span>
                            <input id="beginDate" name="beginDate" type="text" maxlength="20"
                                   class="laydate-icon form-control layer-date input-sm"
                                   value="<fmt:formatDate value="${log.beginDate}" pattern="yyyy-MM-dd"/>"/>
                            <label>&nbsp;--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input id="endDate" name="endDate"
                                                                                        type="text" maxlength="20"
                                                                                        class=" laydate-icon form-control layer-date input-sm"
                                                                                        value="<fmt:formatDate value="${log.endDate}" pattern="yyyy-MM-dd"/>"/>&nbsp;&nbsp;

                        </div>
                    </form:form>
                    <br/>
                </div>
            </div>


            <!-- 工具栏 -->
            <div class="row">
                <div class="col-sm-12">
                    <div class="pull-left">
                        <shiro:hasPermission name="sys:log1:del">
                            <table:delRow url="${ctx}/sys/log1/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
                            <button class="btn btn-white btn-sm "
                                    onclick="confirmx('确认要清空日志吗？','${ctx}/sys/log1/empty')" title="清空"><i
                                    class="fa fa-trash"></i> 清空
                            </button>
                        </shiro:hasPermission>
                        <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left"
                                onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新
                        </button>

                    </div>
                    <div class="pull-right">
                        <button class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="search()"><i
                                class="fa fa-search"></i> 查询
                        </button>
                        <button class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="reset()"><i
                                class="fa fa-refresh"></i> 重置
                        </button>
                    </div>
                </div>
            </div>

            <table id="contentTable"
                   class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
                <thead>
                <tr>
                    <th><input type="checkbox" class="i-checks"></th>
                    <th>操作菜单</th>
                    <th>操作用户</th>
                    <th>所在部门</th>
                    <th>操作者IP</th>
                    <th>操作时间</th>
                </thead>
                <tbody><%
                    request.setAttribute("strEnter", "\n");
                    request.setAttribute("strTab", "\t");
                %>
                <c:forEach items="${page.list}" var="log">
                    <tr>
                        <td><input type="checkbox" id="${log.id}" class="i-checks"></td>
                        <td>${log.title}</td>
                        <td>${log.createBy.name}</td>
                        <td>${log.createBy.office.name}</td>
                        <td>${log.remoteAddr}</td>
                        <td><fmt:formatDate value="${log.createDate}" type="both"/></td>
                    </tr>
                    <c:if test="${not empty log.exception}">
                        <tr>
                            <td colspan="8" style="word-wrap:break-word;word-break:break-all;">
                                    <%-- 					用户代理: ${log.userAgent}<br/> --%>
                                    <%-- 					提交参数: ${fns:escapeHtml(log.params)} <br/> --%>
                                异常信息: <br/>
                                    ${fn:replace(fn:replace(fns:escapeHtml(log.exception), strEnter, '<br/>'), strTab, '&nbsp; &nbsp; ')}
                            </td>
                        </tr>
                    </c:if>
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