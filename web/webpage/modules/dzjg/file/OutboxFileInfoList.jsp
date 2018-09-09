<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>发件箱</title>
	<meta name="decorator" content="default"/>
    <script src="/static/layui/lay/modules/layedit.js" charset="UTF-8" type="text/javascript"></script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
		<h5>发件箱列表 </h5>
		<div class="ibox-tools">
		</div>
	</div>
    
    <div class="ibox-content">
	<sys:message content="${message}"/>
	
	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12">
	<form:form id="searchForm" modelAttribute="TDzjgAttachment" action="${ctx}/dzjg/file/info?boxtype=out" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<span>文件标题：</span>
				<form:input path="fileTitle" htmlEscape="false" maxlength="50"  class=" form-control input-sm"/>
			<span>收件人：</span>
			<sys:treeselect id="receiver" name="receiverIds" value="${attachment.sender.id}" labelName="receiverNames" labelValue="${attachment.sender.name}"
							title="用户" url="/sys/office/treeData?type=3" cssClass="form-control required" notAllowSelectParent="true" />
		</div>

	</form:form>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<shiro:hasPermission name="dzjg:attachment:add">
				<table:addRow url="${ctx}/dzjg/file/form" height="600px"  width="850px" title="文件" label="发送文件"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			<%--<shiro:hasPermission name="dzjg:worksummary:edit">
			    <table:editRow url="${ctx}/dzjg/worksummary/form" title="计划管理" id="contentTable"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission>--%>
			<%--<shiro:hasPermission name="dzjg:worksummary:del">
				<table:delRow url="${ctx}/dzjg/worksummary/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>--%>
			<%--<shiro:hasPermission name="dzjg:worksummary:import">
				<table:importExcel url="${ctx}/dzjg/worksummary/import"></table:importExcel><!-- 导入按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="dzjg:worksummary:export">
	       		<table:exportExcel url="${ctx}/dzjg/worksummary/export"></table:exportExcel><!-- 导出按钮 -->
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
				<th align="center" width="30px"> 序号</th>
		<th  class="sort-column a.file_title">文件标题</th>
		<th  class="sort-column a.file_name">文件名</th>
		<th  class="">收件人</th>
		<th  class="sort-column a.create_date">发送时间</th>
		<th>操作</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="file" varStatus="vs">
			<tr>
				<td width="30px" align="center"> ${vs.count}</td>
				<td ><a  href="#" onclick="openDialogView('查看文件', '${ctx}/dzjg/file/seeFile/out?id=${file.id}','600px', '500px')">
						${file.fileTitle}

				</a></td>
				<td >
						${file.fileName}
				</td>
				<td width="60px">
					<c:forEach items="${file.fileReceivedUsers}" var="received" varStatus="vs">
						<c:if test="${vs.index == 0}">
							${received.receivedUser.name}  等
						</c:if>
					</c:forEach>
				</td>
				<td width="140px">
                   ${fns:formatDateTime(file.createDate)}
				</td>
				<td >
					<shiro:hasPermission name="dzjg:worksummary:view">
						<a href="#" onclick="openDialogView('查看文件', '${ctx}/dzjg/file/seeFile/out?id=${file.id}','600px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<%--<shiro:hasPermission name="dzjg:worksummary:edit">
    					<a href="#" onclick="openDialog('修改计划管理', '${ctx}/dzjg/worksummary/form?id=${worksummary.id}','800px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="dzjg:worksummary:del">
						<a href="${ctx}/dzjg/worksummary/delete?id=${worksummary.id}" onclick="return confirmx('确认要删除该计划管理吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
					</shiro:hasPermission>--%>
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