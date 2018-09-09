<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>新闻管理管理</title>
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
		<h5>新闻管理列表 </h5>
		<div class="ibox-tools">
		</div>
	</div>
    
    <div class="ibox-content">
	<sys:message content="${message}"/>
	
	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12">
	<form:form id="searchForm" modelAttribute="TDzjgNews" action="${ctx}/dzjg/news/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<span>新闻标题：</span>
				<form:input path="title" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>
			<span>提交人单位：</span>
				<sys:treeselect id="office" name="office.id" value="${TDzjgNews.office.id}" labelName="office.name" labelValue="${TDzjgNews.office.name}"
								title="部门" url="/sys/office/treeData?type=2" cssClass="form-control required" notAllowSelectParent="false"/></td>
			<span>提交时间：</span>
			<form:input path="startDate" id="startDate"
						value="${fns:formatDateTime1(TDzjgNews.startDate,'yyyy-MM-dd')}"
						onclick="laydate({ istime: true, format: 'YYYY-MM-DD'}); $('#laydate_box').css('-webkit-box-sizing', null);"
						class="form-control required  laydate-icon" />-
			<form:input path="stopDate" id="stopDate"
						value="${fns:formatDateTime1(TDzjgNews.stopDate,'yyyy-MM-dd')}"
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
			<%--<shiro:hasPermission name="dzjg:news:add">
				<table:addRow url="${ctx}/dzjg/news/form" title="新闻管理"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>--%>
			<shiro:hasPermission name="dzjg:news:edit">
			    <table:editRow url="${ctx}/dzjg/news/form" title="新闻管理" id="contentTable"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="dzjg:news:del">
				<table:delRow url="${ctx}/dzjg/news/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
			<%--<shiro:hasPermission name="dzjg:news:import">
				<table:importExcel url="${ctx}/dzjg/news/import"></table:importExcel><!-- 导入按钮 -->
			</shiro:hasPermission>--%>
			<shiro:hasPermission name="dzjg:news:export">
	       		<table:exportExcel url="${ctx}/dzjg/news/export"></table:exportExcel><!-- 导出按钮 -->
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
				<th  class="sort-column title">新闻标题</th>
				<th  class="sort-column a.create_by">提交人</th>
				<th  class="">提交人单位</th>
				<th  class="sort-column a.create_Date">提交时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="news">
			<tr>
				<td width="20px"> <input type="checkbox" id="${news.id}" class="i-checks"></td>
				<td ><a  href="#" onclick="openDialogView('查看新闻管理', '${ctx}/dzjg/news/form?id=${news.id}','800px', '600px')">
						${news.title}
				</a></td>
				<td width="60px">
						${news.createBy.name}
				</td>
				<td width="80px">
						${news.createBy.office.name}
				</td>
				<td width="150px">
						${fns:formatDateTime(news.createDate)}
				</td>
				<td width="180px">
					<shiro:hasPermission name="dzjg:news:view">
						<a href="#" onclick="openDialogView('查看新闻管理', '${ctx}/dzjg/news/form?id=${news.id}','800px', '600px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="dzjg:news:edit">
    					<a href="#" onclick="openDialog('修改新闻管理', '${ctx}/dzjg/news/form?id=${news.id}','800px', '600px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="dzjg:news:del">
						<a href="${ctx}/dzjg/news/delete?id=${news.id}" onclick="return confirmx('确认要删除该新闻管理吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
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