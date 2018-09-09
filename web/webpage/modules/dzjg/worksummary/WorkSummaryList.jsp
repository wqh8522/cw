<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>工作总结管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		/*$(document).ready(function() {
            $("#summaryType").bind("change",function () {
                var summaryType = this.value;
                window.location = "${ctx}/dzjg/worksummary/?summaryType="+summaryType;
            });
		});*/
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
		<h5>计划管理列表 </h5>
		<div class="ibox-tools">
		</div>
	</div>
    
    <div class="ibox-content">
	<sys:message content="${message}"/>
	
	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12">
		<form:form id="searchForm" modelAttribute="TDzjgWorkSummary" action="${ctx}/dzjg/worksummary" method="post" class="form-inline">
			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
			<div class="form-group">
				<span>总结类型：</span>
				<form:select path="summaryType" htmlEscape="false" class=" form-control m-b" id="summaryType">
					<form:option value="">全部</form:option>
					<form:options items="${fns:getDictList('summary_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span>总结标题：</span>
				<form:input path="summaryTitle" htmlEscape="false" maxlength="50"  class=" form-control input-sm"/>
				<span>单位：</span>
					<sys:treeselect id="office" name="office.id" value="${TDzjgWorkSummary.office.id}" labelName="office.name" labelValue="${TDzjgWorkSummary.office.name}"
									title="部门" url="/sys/office/treeData?type=2" cssClass="form-control required" notAllowSelectParent="false"/></td>
				<span>时间：</span>
				<form:input path="startDate" id="startDate"
							value="${fns:formatDateTime1(TDzjgWorkSummary.startDate,'yyyy-MM-dd')}"
							onclick="laydate({ istime: true, format: 'YYYY-MM-DD'}); $('#laydate_box').css('-webkit-box-sizing', null);"
							class="form-control required  laydate-icon" />-
				<form:input path="stopDate" id="stopDate"
							value="${fns:formatDateTime1(TDzjgWorkSummary.stopDate,'yyyy-MM-dd')}"
							onclick="laydate({ istime: true, format: 'YYYY-MM-DD'}); $('#laydate_box').css('-webkit-box-sizing', null);"
							class="form-control required  laydate-icon" />
			</div>
		</form:form>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<%--<shiro:hasPermission name="dzjg:worksummary:add">
				<table:addRow url="${ctx}/dzjg/worksummary/form" title="计划管理"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>--%>
			<shiro:hasPermission name="dzjg:worksummary:edit">
			    <table:editRow url="${ctx}/dzjg/worksummary/form" title="工作计划" id="contentTable"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="dzjg:worksummary:del">
				<table:delRow url="${ctx}/dzjg/worksummary/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
			<%--<shiro:hasPermission name="dzjg:worksummary:import">
				<table:importExcel url="${ctx}/dzjg/worksummary/import"></table:importExcel><!-- 导入按钮 -->
			</shiro:hasPermission>--%>
			<shiro:hasPermission name="dzjg:worksummary:export">
	       		<table:exportExcel url="${ctx}/dzjg/worksummary/export"></table:exportExcel><!-- 导出按钮 -->
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
			<th> <input type="checkbox" class="i-checks"></th>
			<th  class="sort-column summary_Title">总结标题</th>
			<th  class="sort-column summary_Type">总结类型</th>
			<th  class="sort-column a.create_By">创建人</th>
			<th  class="">创建人单位</th>
			<th  class="sort-column a.create_date">上报时间</th>
			<th>操作</th>
		</tr>
			<%--<tr>

				<th  class="sort-column summaryType">计划类型</th>
				<th  class="sort-column summaryTitle">计划标题</th>
				<th  class="sort-column summaryVontent">计划内容</th>
				<th  class="sort-column file">附件id</th>
				<th>操作</th>
			</tr>--%>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="worksummary">
			<tr>
				<td width="20px"> <input type="checkbox" id="${worksummary.id}" class="i-checks"></td>
				<%--<td width="35px"> ${vs.count}</td>--%>
				<td><a  href="#" onclick="openDialogView('查看工作计划', '${ctx}/dzjg/worksummary/findSummaryById?id=${worksummary.id}','800px', '500px')">
						${worksummary.summaryTitle}

				</a></td>
				<td width="60px">
						${fns:getDictLabel(worksummary.summaryType, "summary_type","周计划" )}
				</td>
				<td width="60px">
						${worksummary.createBy.name}
				</td>
				<td width="80px">
						${worksummary.createBy.office.name}
				</td>
				<td width="150px">
						${fns:formatDateTime(worksummary.createDate)}
				</td>
				<td width="180px">
					<shiro:hasPermission name="dzjg:worksummary:view">
						<a href="#" onclick="openDialogView('查看工作计划', '${ctx}/dzjg/worksummary/findSummaryById?id=${worksummary.id}','800px', '600px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="dzjg:worksummary:edit">
    					<a href="#" onclick="openDialog('修改工作计划', '${ctx}/dzjg/worksummary/form?id=${worksummary.id}','800px', '600px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="dzjg:worksummary:del">
						<a href="${ctx}/dzjg/worksummary/delete?id=${worksummary.id}" onclick="return confirmx('确认要删除该工作计划吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
					</shiro:hasPermission>
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