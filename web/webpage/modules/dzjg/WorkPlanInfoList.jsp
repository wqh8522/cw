<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>计划管理管理</title>
	<meta name="decorator" content="default"/>
    <script src="/static/layui/lay/modules/layedit.js" charset="UTF-8" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function() {
		    $("#planType").bind("change",function () {
				var planType = this.value;
				window.location = "${ctx}/dzjg/workplan/info?planType="+planType;
            });
		});
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
		<h5>工作计划列表 </h5>
		<div class="ibox-tools">
		</div>
	</div>
    
    <div class="ibox-content">
	<sys:message content="${message}"/>
	
	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12">
	<form:form id="searchForm" modelAttribute="TDzjgWorkplan" action="${ctx}/dzjg/workplan/info" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<span>计划类型：</span>
				<form:select path="planType" htmlEscape="false" class=" form-control m-b" id="planType">
					<form:option value="">全部</form:option>
					<form:options items="${fns:getDictList('plan_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			<span>计划标题：</span>
				<form:input path="planTitle" htmlEscape="false" maxlength="50"  class=" form-control input-sm"/>
		 </div>
	</form:form>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<shiro:hasPermission name="dzjg:workplan:add">
				<table:addRow url="${ctx}/dzjg/workplan/form" title="计划"  height="600px"  width="850px"  label="新增工作计划"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			<%--<shiro:hasPermission name="dzjg:workplan:edit">
			    <table:editRow url="${ctx}/dzjg/workplan/form" title="计划管理" id="contentTable"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission>--%>
			<shiro:hasPermission name="dzjg:workplan:del">
				<table:delRowInfo url="${ctx}/dzjg/workplan/deleteAll" id="contentTable"></table:delRowInfo><!-- 删除按钮 -->
			</shiro:hasPermission>
			<%--<shiro:hasPermission name="dzjg:workplan:import">
				<table:importExcel url="${ctx}/dzjg/workplan/import"></table:importExcel><!-- 导入按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="dzjg:workplan:export">
	       		<table:exportExcel url="${ctx}/dzjg/workplan/export"></table:exportExcel><!-- 导出按钮 -->
	       	</shiro:hasPermission>--%>
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
				<th width="20px"> <input type="checkbox" class="i-checks"></th>
				<th  class="sort-column plan_Title">计划标题</th>
				<th  class="sort-column plan_Type">计划类型</th>
				<th  class="sort-column a.create_by">创建人</th>
				<th  class="sort-column a.create_Date">创建时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="workplan" varStatus="vs">
			<tr>
				<td width="20px"> <input type="checkbox" id="${workplan.id}" class="i-checks"></td>
			<%--	<td width="35px"> ${vs.count}</td>--%>
				<td><a  href="#" onclick="openDialogView('查看工作计划', '${ctx}/dzjg/workplan/findPlanById?id=${workplan.id}','800px', '500px')">
						${workplan.planTitle}

				</a></td>
				<td>
						${fns:getDictLabel(workplan.planType, "plan_type","周计划" )}
				</td>
				<td>
					${workplan.createBy.name}
				</td>
				<td>
                    ${fns:formatDateTime(workplan.createDate)}
				</td>
				<td>
					<shiro:hasPermission name="dzjg:workplan:view">
						<a href="#" onclick="openDialogView('查看计划管理', '${ctx}/dzjg/workplan/findPlanById?id=${workplan.id}','800px', '500px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="dzjg:workplan:edit">
    					<a href="#" onclick="openDialog('修改计划管理', '${ctx}/dzjg/workplan/form?id=${workplan.id}&type=info','800px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="dzjg:workplan:del">
						<a href="${ctx}/dzjg/workplan/delete?id=${workplan.id}&type=info" onclick="return confirmx('确认要删除该计划管理吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
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