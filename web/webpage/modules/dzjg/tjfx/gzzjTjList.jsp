<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>工作总结报送统计</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}/laydate5.0.9/laydate.js"></script>

	<%--<script src="${ctxStatic}/echarts3/echarts.min.js"></script>--%>


	<script type="text/javascript">
		$(document).ready(function() {

		});
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
		<h5>工作总结报送统计列表 </h5>
		<div class="ibox-tools">
		</div>
	</div>

    <div class="ibox-content">
	<sys:message content="${message}"/>

	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12">
	<form:form id="searchForm" modelAttribute="workSummaryTj" action="${ctx}/dzjg/tjfx/gzzjtj" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group" style="">
			<span >时间：</span>
			<input name="queryDate" id="queryDate" style="width: 150px;"
				   value="${workSummaryTj.queryDate}" size="10px"
				   class="laydate-icon form-control layer-date" />
			<span>单位：</span>
				<sys:treeselect id="office" cssStyle="width: 150px" name="officeId" value="${workSummaryTj.officeId}" labelName="officeName" labelValue="${workSummaryTj.officeName}"
								title="部门" url="/sys/office/treeData?type=2" cssClass="form-control required" notAllowSelectParent="false"/>
			<span>单位类型：</span>
			<form:select path="officeType" class="form-control">
				<form:option value="" label="---请选择---" />
				<form:options items="${fns:getDictList('sys_office_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</form:select>
				<%--</div>--%>
		</div>

	</form:form>
	<br/>
	</div>
	</div>

	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<shiro:hasPermission name="dzjg:jrlq:tj">
	       		<table:exportExcel url="${ctx}/dzjg/tjfx/export/gzzjTj"></table:exportExcel><!-- 导出按钮 -->
	       	</shiro:hasPermission>
	       <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>

			</div>
			<div class="pull-right">
				<button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="search()" ><i class="fa fa-search"></i> 查询</button>
				<button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="reset()" ><i class="fa fa-refresh"></i> 重置</button>
			</div>
	</div>
	</div>

	<!-- 表格 -->
	<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
		<thead>
		<tr>

			<td colspan="${workSummaryTj.weeks.size()*2+3}" align="center"><h3>${workSummaryTj.year}年${workSummaryTj.month}月各单位工作总结报送情况</h3></td>
		</tr>
			<tr>
				<th width="10px" align="center"></th>
				<th  class="sort-column o.name">单位</th>
				<c:forEach items="${workSummaryTj.weeks}" var="week" varStatus="vs">
					<th colspan="2" style="text-align:center;">${week.weekStart}-${week.weekEnd}</th>
				</c:forEach>
                <th>总数</th>
			</tr>
		</thead>
        <tbody>
        <c:forEach items="${page.list}" var="tj" varStatus="vs">
            <tr>
                <td width="1px"> ${vs.count}</td>
                <td width="150px">
                        ${tj.officeName}
                </td>
                <td>
                        ${tj.oneWeekStatus=='√'?'<strong color="" size="4px">√</strong>':'<font color="red" size="4px">×</font>'}
                </td>
                <td>
                        ${tj.oneWeek}
                </td>
                <td>
                        ${tj.twoWeekStatus=='√'?'<strong color="" size="4px">√</strong>':'<font color="red" size="4px">×</font>'}
                </td>
                <td>
                        ${tj.twoWeek}
                </td>
                <td>
                        ${tj.threeWeekStatus=='√'?'<strong color="" size="4px">√</strong>':'<font color="red" size="4px">×</font>'}
                </td>
                <td>
                        ${tj.threeWeek}
                </td>
                <c:if test="${tj.fourWeek != null}">
                    <td>
                            ${tj.fourWeekStatus=='√'?'<strong color="" size="4px">√</strong>':'<font color="red" size="4px">×</font>'}
                    </td>
                    <td>
                            ${tj.fourWeek}
                    </td>
                </c:if>
                <c:if test="${tj.fiveWeek != null}">
                    <td>${tj.fiveWeekStatus=='√'?'<strong color="" size="4px">√</strong>':'<font color="red" size="4px">×</font>'}
                    </td>
                    <td>
                            ${tj.fiveWeek}
                    </td>
                </c:if>
                <td>
                    <c:choose>
                        <c:when test="${tj.fourWeek != null}">
                            ${tj.oneWeek + tj.twoWeek + tj.threeWeek + tj.fourWeek}
                        </c:when>
                        <c:when test="${tj.fiveWeek != null}">
                            ${tj.oneWeek + tj.twoWeek + tj.threeWeek + tj.fourWeek + tj.fiveWeek}
                        </c:when>
                        <c:otherwise>
                            ${tj.oneWeek + tj.twoWeek + tj.threeWeek}
                        </c:otherwise>
                    </c:choose>

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
<script type="text/javascript">
    laydate.render({
        elem: '#queryDate',
        theme: 'molv',
        type: 'month'
    });

</script>
</body>
</html>