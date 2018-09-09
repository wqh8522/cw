<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>报销单管理</title>
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
		<h5>报销单列表 </h5>
		<div class="ibox-tools">
		</div>
	</div>
    
    <div class="ibox-content">
	<sys:message content="${message}"/>
	
	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12">
	<form:form id="searchForm" modelAttribute="TCwBxd" action="${ctx}/cw/CwBxd/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<span>姓名：</span>
				<form:input path="name" htmlEscape="false" maxlength="100"  class=" form-control input-sm"/>
			<span>报销时间：</span>
			<form:input path="bxStartDate" autocomplete="off"
						value="${fns:formatDateTime1(TCwBxd.bxStartDate,'yyyy-MM-dd')}"
						onclick="laydate({ format: 'YYYY-MM-DD'}); $('#laydate_box').css('-webkit-box-sizing', null);"
						class="form-control required  laydate-icon" />-
			<form:input path="bxEndDate" autocomplete="off"
						value="${fns:formatDateTime1(TCwBxd.bxEndDate,'yyyy-MM-dd')}"
						onclick="laydate({ format: 'YYYY-MM-DD'}); $('#laydate_box').css('-webkit-box-sizing', null);"
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
			<shiro:hasPermission name="cw:CwBxd:add">
				<table:addRow url="${ctx}/cw/CwBxd/form" title="报销单"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="cw:CwBxd:edit">
			    <table:editRow url="${ctx}/cw/CwBxd/form" title="报销单" id="contentTable"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="cw:CwBxd:del">
				<table:delRow url="${ctx}/cw/CwBxd/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="cw:CwBxd:import">
				<table:importExcel url="${ctx}/cw/CwBxd/import"></table:importExcel><!-- 导入按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="cw:CwBxd:export">
	       		<table:exportExcel url="${ctx}/cw/CwBxd/export"></table:exportExcel><!-- 导出按钮 -->
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
				<th width="1"> <input type="checkbox" class="i-checks"></th>
				<th  class="sort-column name">姓名</th>
				<th  class="sort-column money">金额</th>
				<th  class="sort-column detail">明细</th>
				<th  class="sort-column bxTime">报销时间</th>
				<th width="25%">备注信息</th>
				<th width="18%">操作</th>
			</tr>
		</thead>
		<tbody>

		<c:set var="sum" value="0"/>
		<c:forEach items="${page.list}" var="CwBxd">
			<c:set var="sum" value="${sum+CwBxd.money}"/>
			<tr>
				<td> <input type="checkbox" id="${CwBxd.id}" class="i-checks"></td>
				<td><a  href="#" onclick="openDialogView('查看报销单', '${ctx}/cw/CwBxd/form?id=${CwBxd.id}','800px', '500px')">
						${CwBxd.name}
				</a></td>
				<td>
					￥${CwBxd.money}
				</td>
				<td>
					${CwBxd.detail}
				</td>
				<td>
					<fmt:formatDate value="${CwBxd.bxTime}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					${fns:abbr(CwBxd.remarks, 50)}
				</td>
				<td>
					<shiro:hasPermission name="cw:CwBxd:view">
						<a href="#" onclick="openDialogView('查看报销单', '${ctx}/cw/CwBxd/form?id=${CwBxd.id}','800px', '500px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="cw:CwBxd:edit">
    					<a href="#" onclick="openDialog('修改报销单', '${ctx}/cw/CwBxd/form?id=${CwBxd.id}','800px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="cw:CwBxd:del">
						<a href="${ctx}/cw/CwBxd/delete?id=${CwBxd.id}" onclick="return confirmx('确认要删除该报销单吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
					</shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		<c:if test="${sum > 0}">
			<tr>
				<td colspan="7" align="right">合计：${fns:parseDouble(sum, 2)}&nbsp;元</td>
			</tr>
		</c:if>

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