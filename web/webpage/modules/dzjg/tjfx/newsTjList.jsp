<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>新闻报道报送情况</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}/laydate5.0.9/laydate.js"></script>

	<%--<script src="${ctxStatic}/echarts3/echarts.min.js"></script>--%>


	<script type="text/javascript">
		$(document).ready(function() {

		});
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
		<h5>新闻报道报送情况 </h5>
		<div class="ibox-tools">
		</div>
	</div>
    
    <div class="ibox-content">
	<sys:message content="${message}"/>

	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12">
	<form:form id="searchForm" modelAttribute="newsTj" action="${ctx}/dzjg/tjfx/newstj" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group" style="">
			<span >年份：</span>
			<input name="year" id="year" style="width: 100px;"
				   value="${newsTj.year}" size="10px"
				   class="laydate-icon form-control layer-date" />
			<span>单位：</span>
				<sys:treeselect id="office" name="officeId" value="${newsTj.officeId}" labelName="officeName" labelValue="${newsTj.officeName}"
								title="部门" cssStyle="width: 150px" url="/sys/office/treeData?type=2" cssClass="form-control required" notAllowSelectParent="false"/>
			<span>单位类型：</span>
			<form:select path="officeType" class="form-control">
				<form:option value="" label="---请选择---" />
				<form:options items="${fns:getDictList('sys_office_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</form:select>
			<%--</div>--%>
		</div>

	</form:form>
	<br/>
	</div>
	</div>

	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<shiro:hasPermission name="dzjg:jrlq:tj">
	       		<table:exportExcel url="${ctx}/dzjg/tjfx/export/newsTj"></table:exportExcel><!-- 导出按钮 -->
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
			<td colspan="14" align="center"><h3>${newsTj.year}年新闻报道报送情况</h3></td>
		</tr>
			<tr>
				<th width="10px" align="center"></th>
				<th  class="sort-column o.type">单位</th>
				<th class="sort-column yiyue.coun" >一月份</th>
				<th  class="sort-column eryue.coun">二月份</th>
				<th  class="sort-column sanyue.coun">三月份</th>
				<th  class="sort-column siyue.coun">四月份</th>
				<th  class="sort-column wuyue.coun">五月份</th>
				<th  class="sort-column liuyue.coun">六月份</th>
				<th  class="sort-column qiyue.coun">七月份</th>
				<th  class="sort-column bayue.coun">八月份</th>
				<th  class="sort-column jiuyue.coun">九月份</th>
				<th  class="sort-column shiyue.coun">十月份</th>
				<th  class="sort-column shiyiyue.coun">十一月份</th>
				<th  class="sort-column shieryue.coun">十二月份</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="tj" varStatus="vs">
			<tr>
				<td width="1px"> ${vs.count}</td>
				<td width="150px">
						${tj.officeName}
				</td>
				<td>
					<font ${tj.yiYue eq '0'?'color="red"':''}>${tj.yiYue}</font>
				</td>
				<td>
					<font ${tj.erYue eq '0'?'color="red"':''}>${tj.erYue}</font>
				</td>
				<td>
					<font ${tj.sanYue eq '0'?'color="red"':''}>${tj.sanYue}</font>
				</td>
				<td>
					<font ${tj.siYue eq '0'?'color="red"':''}>${tj.siYue}</font>
				</td>
				<td>
					<font ${tj.wuYue eq '0'?'color="red"':''}>${tj.wuYue}</font>
				</td>
				<td>
					<font ${tj.liuYue eq '0'?'color="red"':''}>${tj.liuYue}</font>
				</td>
				<td>
					<font ${tj.qiYue eq '0'?'color="red"':''}>${tj.qiYue}</font>
				</td>
				<td>
					<font ${tj.baYue eq '0'?'color="red"':''}>${tj.baYue}</font>
				</td>
				<td>
					<font ${tj.jiuYue eq '0'?'color="red"':''}>${tj.jiuYue}</font>
				</td>
				<td>
					<font ${tj.shiYue eq '0'?'color="red"':''}>${tj.shiYue}</font>
				</td>
				<td>
					<font ${tj.shiyiYue eq '0'?'color="red"':''}>${tj.shiyiYue}</font>
				</td>
				<td>
					<font ${tj.shierYue eq '0'?'color="red"':''}>${tj.shierYue}</font>
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
    laydate.render({
        elem: '#year',
        theme: 'molv',
        type: 'year'
    });

</script>
</body>
</html>