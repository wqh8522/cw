<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>提醒方式配置管理</title>
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
		<h5>提醒方式配置列表 </h5>
		<div class="ibox-tools">
		</div>
	</div>
    
    <div class="ibox-content">
	<sys:message content="${message}"/>
	
	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12">
	<form:form id="searchForm" modelAttribute="TDzjgTxfs" action="${ctx}/dzjg/txfs/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<span>名称：</span>
				<form:input path="name" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>
		 </div>	
	</form:form>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<shiro:hasPermission name="dzjg:txfs:add">
				<table:addRow url="${ctx}/dzjg/txfs/form" title="提醒方式配置"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="dzjg:txfs:edit">
			    <table:editRow url="${ctx}/dzjg/txfs/form" title="提醒方式配置" id="contentTable"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="dzjg:txfs:del">
				<table:delRow url="${ctx}/dzjg/txfs/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="dzjg:txfs:import">
				<table:importExcel url="${ctx}/dzjg/txfs/import"></table:importExcel><!-- 导入按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="dzjg:txfs:export">
	       		<table:exportExcel url="${ctx}/dzjg/txfs/export"></table:exportExcel><!-- 导出按钮 -->
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
				<th width="1px"> <input type="checkbox" class="i-checks"></th>
				<th  class="sort-column name">名称</th>
				<th  class="sort-column remarks">备注信息</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="txfs">
			<tr>
				<td width="1px"> <input type="checkbox" id="${txfs.id}" class="i-checks"></td>
				<td><a  href="#" onclick="openDialogView('查看提醒方式配置', '${ctx}/dzjg/txfs/form?id=${txfs.id}','800px', '500px')">
						${txfs.name}
				</a></td>
				<td>
				${txfs.remarks}
				</td>
				<td>
					<shiro:hasPermission name="dzjg:txfs:view">
						<a href="#" onclick="openDialogView('查看提醒方式配置', '${ctx}/dzjg/txfs/form?id=${txfs.id}','800px', '500px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="dzjg:txfs:edit">
    					<a href="#" onclick="openDialog('修改提醒方式配置', '${ctx}/dzjg/txfs/form?id=${txfs.id}','800px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="dzjg:txfs:del">
						<a href="${ctx}/dzjg/txfs/delete?id=${txfs.id}" onclick="return confirmx('确认要删除该提醒方式配置吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
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