<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>信息管理管理</title>
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
		<h5>我的信息列表 </h5>
		<div class="ibox-tools">
		</div>
	</div>
    
    <div class="ibox-content">
	<sys:message content="${message}"/>
	
	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12">
	<form:form id="searchForm" modelAttribute="TDzjgMessage" action="${ctx}/dzjg/message/info" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<span>信息标题：</span>
				<form:input path="title" htmlEscape="false" maxlength="200"  class=" form-control input-sm"/>
				<%--<span>类型：</span>
				<form:select path="type"  class="form-control m-b">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('t_dzjg_message_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>--%>

		 </div>	
	</form:form>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<shiro:hasPermission name="dzjg:message:add">
				<table:addRow url="${ctx}/dzjg/message/form" title="信息" height="600px" label="新增信息"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="dzjg:message:del">
				<table:delRowInfo url="${ctx}/dzjg/message/deleteAll" id="contentTable"></table:delRowInfo><!-- 删除按钮 -->
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
				<th width="20px"> <input type="checkbox" class="i-checks"></th>
				<th  class="sort-column title">信息标题</th>
				<th  class="sort-column a.create_by">提交人</th>
				<th  class="sort-column a.create_Date">提交时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="message" varStatus="vs">
			<tr>
				<td width="20px"> <input type="checkbox" id="${message.id}" class="i-checks"></td>
				<%--<td width="30px" align="center"> ${vs.count}</td>--%>
				<td><a  href="#" onclick="openDialogView('查看信息管理', '${ctx}/dzjg/message/form?id=${message.id}','800px', '600px')">
					${message.title}
				</a></td>
				<td width="60px">
						${message.createBy.name}
				</td>
				<%--<td width="80px">--%>
						<%--${message.createBy.office.name}--%>
				<%--</td>--%>
				<td width="150px">
						${fns:formatDateTime(message.createDate)}
				</td>
				<td width="180px">
					<shiro:hasPermission name="dzjg:message:view">
						<a href="#" onclick="openDialogView('查看信息管理', '${ctx}/dzjg/message/form?id=${message.id}&type=info','800px', '600px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="dzjg:message:edit">
    					<a href="#" onclick="openDialog('修改信息管理', '${ctx}/dzjg/message/form?id=${message.id}&type=info','800px', '600px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="dzjg:message:del">
						<a href="${ctx}/dzjg/message/delete?id=${message.id}&type=info" onclick="return confirmx('确认要删除该信息管理吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
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