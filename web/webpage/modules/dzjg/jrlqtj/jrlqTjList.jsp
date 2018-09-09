<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>节日廉情提交统计</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}/laydate5.0.9/laydate.js"></script>

	<script src="${ctxStatic}/echarts3/echarts.min.js"></script>


	<script type="text/javascript">
		$(document).ready(function() {

		});
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
		<h5>节日廉情统计列表 </h5>
		<div class="ibox-tools">
		</div>
	</div>
    
    <div class="ibox-content">
	<sys:message content="${message}"/>

	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<div id="jrlqtj" style="width: 500px;height:250px;float: left;"></div>
			<div id="jrlqtj_j" style="width: 500px;height:280px;float: right;"></div>
		</div>
	<form:form id="searchForm" modelAttribute="jrlqTj" action="${ctx}/dzjg/jqjytx/jrlqtj" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group" style="">
			<span>节日：</span>
				<%--<form:input path="jr" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>--%>
				<select name="jrId" id="jrId" htmlEscape="false" class="form-control required">
					<c:forEach items="${jrs}" var="jr">
						<option value="${jr.id}" ${jrlqTj.jrId == jr.id?'selected = "selected"':'' }>${jr.name}</option>
					</c:forEach>
			</select>
			<span >年份：</span>
			<input name="jrYear" id="jrYear"
				   value="${jrlqTj.jrYear}" size="10px" style="width: 100px;"
				   class="laydate-icon form-control layer-date required" />
			<span>单位：</span>
				<sys:treeselect id="office" name="officeId" value="${jrlqTj.officeId}" labelName="officeName" labelValue="${jrlqTj.officeName}"
								cssStyle="width: 150px" title="部门" url="/sys/office/treeData?type=2" cssClass="form-control required" notAllowSelectParent="false"/>
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
			<%--<shiro:hasPermission name="dzjg:jqjytx:add">
				<table:addRow url="${ctx}/dzjg/jqjytx/form" title="节前提醒"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="dzjg:jqjytx:edit">
			    <table:editRow url="${ctx}/dzjg/jqjytx/form" title="节前提醒" id="contentTable"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="dzjg:jqjytx:del">
				<table:delRow url="${ctx}/dzjg/jqjytx/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>--%>
			<%--<shiro:hasPermission name="dzjg:jqjytx:import">
				<table:importExcel url="${ctx}/dzjg/jqjytx/import"></table:importExcel><!-- 导入按钮 -->
			</shiro:hasPermission>--%>
			<shiro:hasPermission name="dzjg:jrlq:tj">
	       		<table:exportExcel url="${ctx}/dzjg/jqjytx/export/tj"></table:exportExcel><!-- 导出按钮 -->
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
				<th width="10px" align="center"></th>
				<th  class="sort-column o.type">单位</th>
				<th class="sort-column jr_year" >年份</th>
				<th  class="sort-column jr_id">节日</th>
				<th  class="sort-column jq_num">节前提醒提交数量</th>
				<th class="sort-column jz_num" >节日暗访提交数量</th>
				<th  class="sort-column jh_num">节后公示提交数量</th>
				<th>状态</th>
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
						${tj.jrYear=='-'?jrlqTj.jrYear:tj.jrYear}
				</td>
				<td>
						${tj.jrName=='-'?jrlqTj.jrName:tj.jrName}
				</td>
				<td>

					<a href="${ctx}/dzjg/jqjytx/list?tjdw.id=${tj.officeId}&jr.id=${jrlqTj.jrId}&jrYear=${jrlqTj.jrYear}&type=back">	${tj.jqNum}</a>
				</td>
				<td>
					<a href="${ctx}/dzjg/jmcaf/list?bjcdw.id=${tj.officeId}&jr.id=${jrlqTj.jrId}&jrYear=${jrlqTj.jrYear}&type=back">${tj.jzNum}</a>
				</td>
				<td>
					<a href="${ctx}/dzjg/jhgs/list?tbdw.id=${tj.officeId}&jr.id=${jrlqTj.jrId}&jrYear=${jrlqTj.jrYear}&type=back">	${tj.jhNum}</a>
				</td>
				<td>
					<c:if test="${tj.jrYear=='-' || tj.jrName=='-' || tj.jqNum == 0 || tj.jzNum == 0 || tj.jhNum == 0}">
						<span class="btn-mini btn-danger">未完成</span>
					</c:if>
					<c:if test="${tj.jrYear!='-' && tj.jrName!='-' && tj.jqNum != 0 && tj.jzNum != 0 && tj.jhNum != 0}">
						<span class="btn-mini btn-primary">已完成</span>
					</c:if>
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
        elem: '#jrYear',
        theme: 'molv',
        type: 'year'
    });
    var myChart = echarts.init(document.getElementById('jrlqtj'));
    // 指定图表的配置项和数据
    option = {
        title : {
            text: '${jrlqTj.jrYear}年${jrlqTj.jrName}节日廉情提交情况',
            x:'right'
        },
        tooltip : {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
            orient: 'vertical',
            left: 'left',
            data: ['已完成','未完成']
        },
        series : [
            {
                name: '节日廉情提交情况',
                type: 'pie',
                radius : '55%',
                center: ['50%', '60%'],
                data:[
                    {value:${ywc}, name:'已完成'},
                    {value:${wwc}, name:'未完成'}
                ],
                itemStyle: {
                    emphasis: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    },
                    normal:{
                        label:{
                            show: true,
                            formatter: '{b} : {c} ({d}%)'
                        },
                        labelLine :{show:true}
                    }
            	}
            }
        ]
    };

    var myChart1 = echarts.init(document.getElementById('jrlqtj_j'));
    var app = {};
    option1 = null;
    var posList = [
        'left', 'right', 'top', 'bottom',
        'inside',
        'insideTop', 'insideLeft', 'insideRight', 'insideBottom',
        'insideTopLeft', 'insideTopRight', 'insideBottomLeft', 'insideBottomRight'
    ];

    app.configParameters = {
        rotate: {
            min: -90,
            max: 90
        },
        align: {
            options: {
                left: 'left',
                center: 'center',
                right: 'right'
            }
        },
        verticalAlign: {
            options: {
                top: 'top',
                middle: 'middle',
                bottom: 'bottom'
            }
        },
        position: {
            options: echarts.util.reduce(posList, function (map, pos) {
                map[pos] = pos;
                return map;
            }, {})
        },
        distance: {
            min: 0,
            max: 100
        }
    };

    app.config = {
        rotate: 90,
        align: 'left',
        verticalAlign: 'middle',
        position: 'insideBottom',
        distance: 15,
        onChange: function () {
            var labelOption = {
                normal: {
                    rotate: app.config.rotate,
                    align: app.config.align,
                    verticalAlign: app.config.verticalAlign,
                    position: app.config.position,
                    distance: app.config.distance
                }
            };
            myChart1.setOption({
                series: [{
                    label: labelOption
                }, {
                    label: labelOption
                }, {
                    label: labelOption
                }, {
                    label: labelOption
                }]
            });
        }
    };


    var labelOption = {
        normal: {
            show: false,
            position: app.config.position,
            distance: app.config.distance,
            align: app.config.align,
            verticalAlign: app.config.verticalAlign,
            rotate: app.config.rotate,
            formatter: '{c}  {name|{a}}',
            fontSize: 16,
            rich: {
                name: {
                    textBorderColor: '#fff'
                }
            }
        }
    };

    option1 = {
        color: ['#003366', '#e5323e'],
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'shadow'
            }
        },
        legend: {
            left: 'right',
            data: ['已提交','未提交']
        },
        calculable: true,
        xAxis: [
            {
                type: 'category',
                axisTick: {show: false},
                data: ['节前提醒', '节日暗访', '节后公示']
            }
        ],
        yAxis: [
            {
                type: 'value'
            }
        ],
        series: [
            {
                name: '已提交',
                type: 'bar',
                barGap: 0,
                label: labelOption,
                data: [${jqNumYtj}, ${jzNumYtj}, ${jhNumYtj}]
            },
            {
                name: '未提交',
                type: 'bar',
                label: labelOption,
                data: [${jqNumWtj}, ${jzNumWtj}, ${jhNumWtj}]
            }
        ]
    };


    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
    myChart1.setOption(option1);

</script>
</body>
</html>