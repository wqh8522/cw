<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>节日明察暗访管理</title>
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
		<h5>节日明察暗访列表 </h5>
		<div class="ibox-tools">
		</div>
	</div>
    
    <div class="ibox-content">
	<sys:message content="${message}"/>
	
	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12">
	<form:form id="searchForm" modelAttribute="TDzjgJmcaf" action="${ctx}/dzjg/jmcaf/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<span >年份：</span>
			<input name="jrYear" id="jrYear" style="width: 100px;"
				   value="${TDzjgJmcaf.jrYear}" size="10px"
				   onclick="laydate({ istime: true, format: 'YYYY'}); $('#laydate_box').css('-webkit-box-sizing', null);"
				   class="laydate-icon form-control layer-date required" />
			<span>节日：</span>
				<%--<form:input path="jr" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>--%>
			<select name="jr" id="jr" htmlEscape="false" class="form-control required">
				<option value="" >请选择</option>
				<c:forEach items="${jrs}" var="jr">
					<option value="${jr.id}" ${TDzjgJmcaf.jr.id == jr.id?'selected = "selected"':'' }>${jr.name}</option>
				</c:forEach>
			</select>
			<span>被检查单位：</span>
				<%--<form:input path="bjcdw" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>--%>
				<sys:treeselect id="bjcdw" name="bjcdw.id" value="${TDzjgJmcaf.bjcdw.id}" labelName="bjcdw.name" labelValue="${TDzjgJmcaf.bjcdw.name}"
								title="部门" url="/sys/office/treeData?type=2" cssClass="form-control required"
								cssStyle="width:150px" notAllowSelectParent="false"/></td>
			<span>上报人：</span>
				<form:input path="sbr.name" cssStyle="width: 150px" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>

			<span>检查时间：</span>
			<form:input path="jcStartDate" id="jcStartDate"
						value="${fns:formatDateTime1(TDzjgJmcaf.jcStartDate,'yyyy-MM-dd')}"
						onclick="laydate({ istime: true, format: 'YYYY-MM-DD'}); $('#laydate_box').css('-webkit-box-sizing', null);"
						class="form-control required  laydate-icon" size="13px" cssStyle="width: 150px"/>-
			<form:input path="jcStopDate" id="jcStopDate"
						value="${fns:formatDateTime1(TDzjgJmcaf.jcStopDate,'yyyy-MM-dd')}"
						onclick="laydate({ istime: true, format: 'YYYY-MM-DD'}); $('#laydate_box').css('-webkit-box-sizing', null);"
						class="form-control required  laydate-icon" size="13px" cssStyle="width: 150px"/>
			<%--<span>检查时间：</span>
			<form:input path="jcsj" id="jcsj"
						value="${fns:formatDateTime(TDzjgJmcaf.jcsj)}"
						onclick="laydate({ istime: true, format: 'YYYY-MM-DD' }); $('#laydate_box').css('-webkit-box-sizing', null);"
						class="form-control required  laydate-icon" />--%>
			<%--<span>检查组人员：</span>
				<form:input path="jczry" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>--%>
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
			<shiro:hasPermission name="dzjg:jmcaf:add">
				<table:addRow url="${ctx}/dzjg/jmcaf/form" title="节日明察暗访" width="1000px" height="600px"> </table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="dzjg:jmcaf:edit">
			    <table:editRow url="${ctx}/dzjg/jmcaf/form" title="节日明察暗访" id="contentTable"  width="1000px" height="600px"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="dzjg:jmcaf:del">
				<table:delRow url="${ctx}/dzjg/jmcaf/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
			<%--<shiro:hasPermission name="dzjg:jmcaf:import">
				<table:importExcel url="${ctx}/dzjg/jmcaf/import"></table:importExcel><!-- 导入按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="dzjg:jmcaf:export">
	       		<table:exportExcel url="${ctx}/dzjg/jmcaf/export"></table:exportExcel><!-- 导出按钮 -->
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
				<th  class="sort-column bjcdw">被检查单位</th>
				<th  class="sort-column sbr">上报人</th>
				<th  class="">检查组人员</th>
				<th  class="sort-column jcsj">检查时间</th>
				<th  class="sort-column jr_year">年份</th>
				<th  class="sort-column jr">节日</th>
				<td>证明材料</td>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="jmcaf">
			<tr>
				<td width="1px"> <input type="checkbox" id="${jmcaf.id}" class="i-checks"></td>
				<td><a  href="#" onclick="openDialogView('查看节日明察暗访', '${ctx}/dzjg/jmcaf/form?id=${jmcaf.id}','1000px', '600px')">
						${jmcaf.bjcdw}
				</a></td>
				<td>
					${jmcaf.sbr.name}
				</td>
				<td>
					${jmcaf.jcz_users.name}
				</td>
				<td width="160px">
					<fmt:formatDate value="${jmcaf.jcsj}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
						${jmcaf.jrYear}
				</td>
				<td>
						${jmcaf.jr.name}
				</td>
				<td>
					<c:forEach items="${jmcaf.zmcl}" varStatus="vs" var="zmcl">
						<a href="${ctx}/sys/attach/download?id=${zmcl.id}" title="${zmcl.fileName}">
							<c:if test="${jmcaf.zmcl.size()>1}">
								${vs.count}、
							</c:if>
								${fns:abbr(zmcl.fileName,40)}
						</a><br>
					</c:forEach>
				</td>
				<td width="170px">
					<shiro:hasPermission name="dzjg:jmcaf:view">
						<a href="#" onclick="openDialogView('查看节日明察暗访', '${ctx}/dzjg/jmcaf/form?id=${jmcaf.id}','1000px', '600px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="dzjg:jmcaf:edit">
    					<a href="#" onclick="openDialog('修改节日明察暗访', '${ctx}/dzjg/jmcaf/form?id=${jmcaf.id}','1000px', '600px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="dzjg:jmcaf:del">
						<a href="${ctx}/dzjg/jmcaf/delete?id=${jmcaf.id}" onclick="return confirmx('确认要删除该节日明察暗访吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
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