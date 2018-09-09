<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>文件管理</title>
	<meta name="decorator" content="default"/>
    <script src="/static/layui/lay/modules/layedit.js" charset="UTF-8" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function() {
		});
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
		<h5>发件箱列表 </h5>
		<div class="ibox-tools">
			<%--<a class="collapse-link">
				<i class="fa fa-chevron-up"></i>
			</a>
			<a class="dropdown-toggle" data-toggle="dropdown" href="#">
				<i class="fa fa-wrench"></i>
			</a>
			<ul class="dropdown-menu dropdown-user">
				<li><a href="#">选项1</a>
				</li>
				<li><a href="#">选项2</a>
				</li>
			</ul>
			<a class="close-link">
				<i class="fa fa-times"></i>
			</a>--%>
		</div>
	</div>
    
    <div class="ibox-content">
	<sys:message content="${message}"/>
	
	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12">
	<form:form id="searchForm" modelAttribute="TDzjgAttachment" action="${ctx}/dzjg/file" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<span>文件标题：</span>
				<form:input path="fileTitle" htmlEscape="false" maxlength="50"  class=" form-control input-sm"/>
			<span>发件人单位：</span>
				<sys:treeselect id="office" name="office.id" value="${TDzjgAttachment.office.id}" labelName="office.name" labelValue="${TDzjgAttachment.office.name}"
								title="部门" url="/sys/office/treeData?type=2" cssClass="form-control required" notAllowSelectParent="false"/></td>
			<span>时间：</span>
			<form:input path="startDate" id="startDate"
						value="${fns:formatDateTime1(TDzjgAttachment.startDate,'yyyy-MM-dd')}"
						onclick="laydate({ istime: true, format: 'YYYY-MM-DD'}); $('#laydate_box').css('-webkit-box-sizing', null);"
						class="form-control required  laydate-icon" />-
			<form:input path="stopDate" id="stopDate"
						value="${fns:formatDateTime1(TDzjgAttachment.stopDate,'yyyy-MM-dd')}"
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
			<%--<shiro:hasPermission name="dzjg:attachment:add">
				<table:addRow url="${ctx}/dzjg/file/form" height="600px"  width="850px" title="文件" label="发送文件"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>--%>
			<shiro:hasPermission name="dzjg:attachment:edit">
			    <table:editRow url="${ctx}/dzjg/file/form" title="计划管理" id="contentTable"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="dzjg:attachment:del">
				<table:delRow url="${ctx}/dzjg/file/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
			<%--<shiro:hasPermission name="dzjg:attachment:import">
				<table:importExcel url="${ctx}/dzjg/attachment/import"></table:importExcel><!-- 导入按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="dzjg:attachment:export">
	       		<table:exportExcel url="${ctx}/dzjg/attachment/export"></table:exportExcel><!-- 导出按钮 -->
	       	</shiro:hasPermission>--%>
	     <%--  <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
		--%>
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
				<th  class="sort-column a.file_title">文件标题</th>
				<%--<th  class="sort-column a.file_name">文件名</th>--%>
				<th >发件人</th>
				<th  class="">发件人单位</th>
				<th  class="">收件人</th>
				<th  class="sort-column a.create_date">发送时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="file" varStatus="vs">
			<tr>
				<td width="20px" align="center"> <input type="checkbox" id="${file.id}" class="i-checks"></td>
				<td ><a  href="#" onclick="openDialogView('查看文件', '${ctx}/dzjg/file/seeFile/2?id=${file.id}','600px', '500px')">
						${file.fileTitle}

				</a></td>
				<td width="50px">
					${file.createBy.name}
				</td>
				<td width="70px">
						${file.createBy.office.name}
				</td>
				<td >
					<a href="#" onclick="openDialogView('查看收件人', '${ctx}/dzjg/file/findReceiverUser?id=${file.id}','500px', '400px')" class="btn btn-success btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					<%--<c:forEach items="${file.fileReceivedUsers}" var="received" varStatus="vs">
						${received.receivedUser.name}
							<c:if test="${!vs.last}" >,</c:if>
					</c:forEach>--%>
				</td>

				<td width="130px">
                   ${fns:formatDateTime(file.createDate)}
				</td>
				<td width="170px">
					<shiro:hasPermission name="dzjg:attachment:view">
						<a href="#" onclick="openDialogView('查看文件', '${ctx}/dzjg/file/seeFile/2?id=${file.id}','600px', '500px')" class="btn btn-info btn-xs"><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="dzjg:attachment:edit">
    					<a href="#" onclick="openDialog('修改文件信息', '${ctx}/dzjg/file/form?id=${file.id}','800px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="dzjg:attachment:del">
						<a href="${ctx}/dzjg/file/delete?id=${file.id}" onclick="return confirmx('确认要删除该文件吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
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