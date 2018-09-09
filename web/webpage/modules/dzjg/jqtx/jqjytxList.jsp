<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<%@ include file="/webpage/include/util.jsp"%>
<html>
<head>
	<title>节前提醒管理</title>
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
		<h5>节前提醒列表 </h5>

		<div class="ibox-tools">
		</div>
	</div>
    
    <div class="ibox-content">
	<sys:message content="${message}"/>
	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12">
	<form:form id="searchForm" modelAttribute="TDzjgJqjytx" action="${ctx}/dzjg/jqjytx/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group" style="padding-top: 10px">

            <span >年份：</span>
            <input name="jrYear" id="jrYear" style="width: 100px"
                   value="${TDzjgJqjytx.jrYear}" size="10px"
                   onclick="laydate({ istime: true, format: 'YYYY'}); $('#laydate_box').css('-webkit-box-sizing', null);"
                   class="laydate-icon form-control layer-date" />
            <span>节日：</span>
				<%--<form:input path="jr" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>--%>
				<select name="jr" id="jr" htmlEscape="false" class="form-control required" >
					<option value="" >请选择</option>
					<c:forEach items="${jrs}" var="jr">
						<option value="${jr.id}" ${TDzjgJqjytx.jr.id == jr.id?'selected = "selected"':'' }>${jr.name}</option>
					</c:forEach>
			    </select>
			<span>提醒方式：</span>
				<%--<form:input path="txfs" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>--%>
				<select name="txfs" id="txfs" htmlEscape="false" class="form-control required">
					<option value="" >请选择</option>
					<c:forEach items="${txfs}" var="txfs">
						<option value="${txfs.id}" ${TDzjgJqjytx.txfs.id == txfs.id?'selected = "selected"':'' }>${txfs.name}</option>
					</c:forEach>
				</select>
			<span>提交单位：</span>
				<%--<form:input path="txsj" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>--%>
				<sys:treeselect id="tjdw" name="tjdw.id" value="${TDzjgJqjytx.tjdw.id}" labelName="tjdw.name" labelValue="${TDzjgJqjytx.tjdw.name}"
								title="部门" url="/sys/office/treeData?type=2" cssClass="form-control required" notAllowSelectParent="false"
								cssStyle="width:150px"/>
			<span>提交时间：</span>
			<form:input path="createStartDate" id="createStartDate"
						value="${fns:formatDateTime1(TDzjgJqjytx.createStartDate,'yyyy-MM-dd')}"
						onclick="laydate({ istime: true, format: 'YYYY-MM-DD'}); $('#laydate_box').css('-webkit-box-sizing', null);"
						class="form-control required  laydate-icon" size="13px" cssStyle="width: 150px"/>-
			<form:input path="createStopDate" id="createStopDate"
						value="${fns:formatDateTime1(TDzjgJqjytx.createStopDate,'yyyy-MM-dd')}"
						onclick="laydate({ istime: true, format: 'YYYY-MM-DD'}); $('#laydate_box').css('-webkit-box-sizing', null);"
						class="form-control required  laydate-icon" size="13px" cssStyle="width: 150px"/>
			<br>
			<div style="margin-top: 10px">
				<span>提醒时间：</span>
				<form:input path="txStartDate" id="txStartDate"
							value="${fns:formatDateTime1(TDzjgJqjytx.txStartDate,'yyyy-MM-dd')}"
							onclick="laydate({ istime: true, format: 'YYYY-MM-DD'}); $('#laydate_box').css('-webkit-box-sizing', null);"
							class="form-control required  laydate-icon" size="13px" cssStyle="width: 150px"/>-
				<form:input path="txStopDate" id="txStopDate"
							value="${fns:formatDateTime1(TDzjgJqjytx.txStopDate,'yyyy-MM-dd')}"
							onclick="laydate({ istime: true, format: 'YYYY-MM-DD'}); $('#laydate_box').css('-webkit-box-sizing', null);"
							class="form-control required  laydate-icon" size="13px" cssStyle="width: 150px"/>
			</div>

		</div>

	</form:form>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
            <c:if test="${type == 'back'}">
                <button class="btn btn-white btn-sm" onclick="window.history.back()" data-toggle="tooltip" data-placement="left"><i class="fa fa-chevron-left"></i>返回统计列表</button>
            </c:if>

			<shiro:hasPermission name="dzjg:jqjytx:add">
				<table:addRow url="${ctx}/dzjg/jqjytx/form" title="节前提醒"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="dzjg:jqjytx:edit">
			    <table:editRow url="${ctx}/dzjg/jqjytx/form" title="节前提醒" id="contentTable"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="dzjg:jqjytx:del">
				<table:delRow url="${ctx}/dzjg/jqjytx/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
			<%--<shiro:hasPermission name="dzjg:jqjytx:import">
				<table:importExcel url="${ctx}/dzjg/jqjytx/import"></table:importExcel><!-- 导入按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="dzjg:jqjytx:export">
	       		<table:exportExcel url="${ctx}/dzjg/jqjytx/export"></table:exportExcel><!-- 导出按钮 -->
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
				<th width="10px" align="center"> <input type="checkbox" class="i-checks"></th>
				<th  class="sort-column tjdw">提交单位</th>
				<th  class="sort-column tjr">提交人</th>
				<th  class="sort-column jr_year">年份</th>
				<th  class="sort-column jr">节日</th>
				<th  class="sort-column txfs">提醒方式</th>
				<th  class="sort-column txsj">提醒时间</th>
				<th  class="sort-column create_date">提交时间</th>
				<th>证明材料</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="jqjytx">
			<tr>
				<td width="1px"> <input type="checkbox" id="${jqjytx.id}" class="i-checks"></td>
				<td><a  href="#" onclick="openDialogView('查看节前提醒', '${ctx}/dzjg/jqjytx/form?id=${jqjytx.id}','800px', '500px')">
						${jqjytx.tjdw.name}

				</a></td>
				<td>
						${jqjytx.tjr.name}

				</td>
				<td>
						${jqjytx.jrYear}
				</td>
				<td>
						${jqjytx.jr.name}
				</td>

				<td>
						${jqjytx.txfs.name}

				</td>
				<td>
					<fmt:formatDate value="${jqjytx.txsj}" pattern="yyyy-MM-dd"/>

				</td>
				<td>
					<fmt:formatDate value="${jqjytx.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>

				</td>
				<td>
					<c:forEach items="${jqjytx.zmcl}" varStatus="vs" var="zmcl">

						<a href="${ctx}/sys/attach/download?id=${zmcl.id}" title="${zmcl.fileName}">
							<c:if test="${jqjytx.zmcl.size()>1}">
								${vs.count}、
							</c:if>
								${fns:abbr(zmcl.fileName,40)}

						</a><br>
					</c:forEach>
				</td>
				<td width="170px">
					<shiro:hasPermission name="dzjg:jqjytx:view">
						<a href="#" onclick="openDialogView('查看节前提醒', '${ctx}/dzjg/jqjytx/form?id=${jqjytx.id}','800px', '500px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="dzjg:jqjytx:edit">
    					<a href="#" onclick="openDialog('修改节前提醒', '${ctx}/dzjg/jqjytx/form?id=${jqjytx.id}','800px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="dzjg:jqjytx:del">
						<a href="${ctx}/dzjg/jqjytx/delete?id=${jqjytx.id}" onclick="return confirmx('确认要删除该节前提醒吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
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
<script type="text/javascript">
</script>
</body>
</html>