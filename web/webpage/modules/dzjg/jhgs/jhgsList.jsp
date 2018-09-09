<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>节后公示管理</title>
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
		<h5>节后公示列表 </h5>
		<div class="ibox-tools">
		</div>
	</div>
    
    <div class="ibox-content">
	<sys:message content="${message}"/>
	
	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12">
	<form:form id="searchForm" modelAttribute="TDzjgJhgs" action="${ctx}/dzjg/jhgs/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">

			<span >年份：</span>
			<input name="jrYear" id="jrYear" style="width: 100px;"
				   value="${TDzjgJhgs.jrYear}" size="10px"
				   onclick="laydate({ istime: true, format: 'YYYY'}); $('#laydate_box').css('-webkit-box-sizing', null);"
				   class="laydate-icon form-control layer-date required" />
			<span>节日：</span>
				<%--<form:input path="jr" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>--%>
			<select name="jr" id="jr" htmlEscape="false" class="form-control required">
				<option value="" >请选择</option>
				<c:forEach items="${jrs}" var="jr">
					<option value="${jr.id}" ${TDzjgJhgs.jr.id == jr.id?'selected = "selected"':'' }>${jr.name}</option>
				</c:forEach>
			</select>
			<span>填报单位：</span>
			<sys:treeselect id="tbdw" name="tbdw.id" value="${TDzjgJhgs.tbdw.id}" labelName="tbdw.name" labelValue="${TDzjgJhgs.tbdw.name}"
								title="部门" cssStyle="width: 150px" url="/sys/office/treeData?type=2" cssClass="form-control required" notAllowSelectParent="false"/>
			<span>填报时间：</span>
			<form:input path="tbStartDate" id="tbStartDate"
						value="${fns:formatDateTime1(TDzjgJhgs.tbStartDate,'yyyy-MM-dd')}"
						onclick="laydate({ istime: true, format: 'YYYY-MM-DD'}); $('#laydate_box').css('-webkit-box-sizing', null);"
						class="form-control required  laydate-icon" size="15px" cssStyle="width: 150px"/>-
			<form:input path="tbStopDate" id="tbStopDate"
						value="${fns:formatDateTime1(TDzjgJhgs.tbStopDate,'yyyy-MM-dd')}"
						onclick="laydate({ istime: true, format: 'YYYY-MM-DD'}); $('#laydate_box').css('-webkit-box-sizing', null);"
						class="form-control required  laydate-icon" size="15px" cssStyle="width: 150px"/>
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
			<shiro:hasPermission name="dzjg:jhgs:add">
				<table:addRow url="${ctx}/dzjg/jhgs/form" title="节后公示" width="1000px" height="650px"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="dzjg:jhgs:edit">
			    <table:editRow url="${ctx}/dzjg/jhgs/form" title="节后公示" id="contentTable" width="1000px" height="650px"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="dzjg:jhgs:del">
				<table:delRow url="${ctx}/dzjg/jhgs/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
		<%--	<shiro:hasPermission name="dzjg:jhgs:import">
				<table:importExcel url="${ctx}/dzjg/jhgs/import"></table:importExcel><!-- 导入按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="dzjg:jhgs:export">
	       		<table:exportExcel url="${ctx}/dzjg/jhgs/export"></table:exportExcel><!-- 导出按钮 -->
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
				<th  class="sort-column tbdw">填报单位</th>
				<th  class="sort-column tbsj">填报时间</th>
				<td class="sort-column jrYear">年份</td>
				<th  class="sort-column jr">节日</th>
				<th >填报人</th>
				<th>附件</th>
				<%--<th  class="sort-column wgwj_count">违规违纪问题数合计</th>
				<th  class="sort-column wgwj_ggjd">违规违纪问题数公共接待方面</th>
				<th  class="sort-column wgwj_gggl">违规违纪问题数公共管理方面</th>
				<th  class="sort-column wgwj_zsljgd">违规违纪问题数遵守廉洁规定方面</th>
				<th  class="sort-column djzj_count">党纪政纪处分人数合计</th>
				<th  class="sort-column djzj_ggjd">党纪政纪处分人数公共接待方面</th>
				<th  class="sort-column djzj_gggl">党纪政纪处分人数公共管理方面</th>
				<th  class="sort-column djzj_zsljgd">党纪政纪处分人数遵守廉洁规定方面</th>
				<th  class="sort-column qtwz_count">其他问责人数合计</th>
				<th  class="sort-column qtwz_ggjd">其他问责人数公共接待方面</th>
				<th  class="sort-column qtwz_gggl">其他问责人数公共管理方面</th>
				<th  class="sort-column qtwz_zsljgd">其他问责人数遵守廉洁规定方面</th>--%>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="jhgs">
			<tr>
				<td> <input type="checkbox" id="${jhgs.id}" class="i-checks"></td>
				<td><a  href="#" onclick="openDialogView('查看节后公示', '${ctx}/dzjg/jhgs/form?id=${jhgs.id}&view=view','1000px', '650px')">
						${jhgs.tbdw}
				</a></td>
				<td>
					<fmt:formatDate value="${jhgs.tbsj}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${jhgs.jrYear}
				</td>
				<td>
					${jhgs.jr.name}
				</td>
				<td>
						${jhgs.createBy.name}
				</td>
				<td>
					<a href="${ctx}/sys/attach/download?id=${jhgs.attachs.id}" title="${jhgs.attachs.fileName}">${fns:abbr(jhgs.attachs.fileName, 40)}</a></td>
				</td>
				<td>
					<shiro:hasPermission name="dzjg:jhgs:view">
						<a href="#" onclick="openDialogView('查看节后公示', '${ctx}/dzjg/jhgs/form?id=${jhgs.id}&view=view','1000px', '650px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="dzjg:jhgs:edit">
    					<a href="#" onclick="openDialog('修改节后公示', '${ctx}/dzjg/jhgs/form?id=${jhgs.id}','1000px', '650px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="dzjg:jhgs:del">
						<a href="${ctx}/dzjg/jhgs/delete?id=${jhgs.id}" onclick="return confirmx('确认要删除该节后公示吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
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