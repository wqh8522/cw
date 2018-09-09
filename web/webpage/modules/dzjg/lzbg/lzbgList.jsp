<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>履职情况报告</title>
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
		<h5>履职情况报告列表</h5>
		<div class="ibox-tools">
		</div>
	</div>
    
    <div class="ibox-content">
	<sys:message content="${message}"/>
	
	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12">
	<form:form id="searchForm" modelAttribute="TDzjgLzbg" action="${ctx}/dzjg/lzbg/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<span>单位：</span>
			<form:input path="dw" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>
			<span>入驻单位：</span>
			<form:input path="rzdw" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>
		 </div>	
	</form:form>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<shiro:hasPermission name="dzjg:lzbg:add">
				<table:addRow url="${ctx}/dzjg/lzbg/form" title="履职情况报告" width="600px" height="620px"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="dzjg:lzbg:edit">
			    <table:editRow url="${ctx}/dzjg/lzbg/form" title="履职情况报告" id="contentTable" width="600px" height="620px"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="dzjg:lzbg:del">
				<table:delRow url="${ctx}/dzjg/lzbg/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
		<%--	<shiro:hasPermission name="dzjg:lzbg:import">
				<table:importExcel url="${ctx}/dzjg/lzbg/import"></table:importExcel><!-- 导入按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="dzjg:lzbg:export">
	       		<table:exportExcel url="${ctx}/dzjg/lzbg/export"></table:exportExcel><!-- 导出按钮 -->
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
				<th width="1px"> <input type="checkbox" class="i-checks"></th>
				<th  class="sort-column dw">单位</th>
				<th  class="sort-column rzdw">入驻单位</th>
				<th  class="sort-column kssj">开始时间</th>
				<th  class="sort-column jssj">结束时间</th>
				<th  >上报人</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="lzbg">
			<tr>
				<td> <input type="checkbox" id="${lzbg.id}" class="i-checks"></td>
				<td><a  href="#" onclick="openDialogView('查看履职报告', '${ctx}/dzjg/lzbg/form?id=${lzbg.id}&view=view','1300px', '650px')">
						${lzbg.dw}
				</a></td>
				<td>
						${lzbg.rzdw}
				</td>
				<td>
					<fmt:formatDate value="${lzbg.kssj}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					<fmt:formatDate value="${lzbg.jssj}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
						${lzbg.createBy.name}
				</td>
				<td>
					<shiro:hasPermission name="dzjg:lzbg:view">
						<a href="#" onclick="openDialogView('查看履职报告', '${ctx}/dzjg/lzbg/form?id=${lzbg.id}&view=view','1300px', '650px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="dzjg:lzbg:edit">
    					<a href="#" onclick="openDialog('修改履职报告', '${ctx}/dzjg/lzbg/form?id=${lzbg.id}','600px', '620px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="dzjg:lzbg:del">
						<a href="${ctx}/dzjg/lzbg/delete?id=${lzbg.id}" onclick="return confirmx('确认要删除该履职报告吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
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