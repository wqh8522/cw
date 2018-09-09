<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>摄像头参数管理</title>
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
		<h5>摄像头参数列表 </h5>
		<div class="ibox-tools">
		</div>
	</div>
    
    <div class="ibox-content">
	<sys:message content="${message}"/>
	
	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12">
	<form:form id="searchForm" modelAttribute="dzjgSxt" action="${ctx}/dzjg/dzjgSxt/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<%--<span>单位：</span>
				<sys:treeselect id="officeId" name="officeId" value="${dzjgSxt.officeId.id}" labelName="" labelValue="${dzjgSxt.officeId.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="form-control input-sm" allowClear="true" notAllowSelectParent="true"/>
			<span>窗口：</span>
				<form:input path="ck" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>--%>
		 </div>	
	</form:form>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<shiro:hasPermission name="dzjg:dzjgSxt:add">
				<table:addRow url="${ctx}/dzjg/dzjgSxt/form" title="摄像头参数"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="dzjg:dzjgSxt:edit">
			    <table:editRow url="${ctx}/dzjg/dzjgSxt/form" title="摄像头参数" id="contentTable"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="dzjg:dzjgSxt:del">
				<table:delRow url="${ctx}/dzjg/dzjgSxt/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="dzjg:dzjgSxt:import">
				<table:importExcel url="${ctx}/dzjg/dzjgSxt/import"></table:importExcel><!-- 导入按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="dzjg:dzjgSxt:export">
	       		<table:exportExcel url="${ctx}/dzjg/dzjgSxt/export"></table:exportExcel><!-- 导出按钮 -->
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
				<%--<th  class="sort-column office_id">单位</th>
				<th  class="sort-column ck">窗口</th>--%>
				<th  class="sort-column ip">ip地址</th>
				<th  class="sort-column dkh">端口号</th>
				<th  class="sort-column yhm">用户名</th>
				<th  class="sort-column mm">密码</th>
				<%--<th  class="sort-column mm">摄像头密码</th>--%>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="dzjgSxt">
			<tr>
				<td> <input type="checkbox" id="${dzjgSxt.id}" class="i-checks"></td>
				<%--<td><a  href="#" onclick="openDialogView('查看DSS参数', '${ctx}/dzjg/dzjgSxt/form?id=${dzjgSxt.id}','800px', '500px')">
					${dzjgSxt.officeId.name}
				</a></td>
				<td>
					${dzjgSxt.ck}
				</td>--%>
				<td>
					<a  href="#" onclick="openDialogView('查看DSS参数', '${ctx}/dzjg/dzjgSxt/form?id=${dzjgSxt.id}','800px', '500px')">
						${dzjgSxt.ip}
					</a>
				</td>
				<td>
					${dzjgSxt.dkh}
				</td>
				<td>
					${dzjgSxt.yhm}
				</td>
				<td>
					${dzjgSxt.mm}
				</td>
				<td>
					<shiro:hasPermission name="dzjg:dzjgSxt:view">
						<a href="#" onclick="openDialogView('查看摄像头参数', '${ctx}/dzjg/dzjgSxt/form?id=${dzjgSxt.id}','800px', '500px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="dzjg:dzjgSxt:edit">
    					<a href="#" onclick="openDialog('修改摄像头参数', '${ctx}/dzjg/dzjgSxt/form?id=${dzjgSxt.id}','800px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="dzjg:dzjgSxt:del">
						<a href="${ctx}/dzjg/dzjgSxt/delete?id=${dzjgSxt.id}" onclick="return confirmx('确认要删除该摄像头参数吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
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