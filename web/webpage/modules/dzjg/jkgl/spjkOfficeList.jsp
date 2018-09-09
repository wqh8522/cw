<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>实时视频监控</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//判断用户是否安装weplugin插件
            var Sys = {};
            var ua = navigator.userAgent.toLowerCase();
            var s;
            (s = ua.match(/(msie\s|trident.*rv:)([\d.]+)/)) ? Sys.ie = s[2] :
                (s = ua.match(/firefox\/([\d.]+)/)) ? Sys.firefox = s[1] :
                    (s = ua.match(/chrome\/([\d.]+)/)) ? Sys.chrome = s[1] :
                        (s = ua.match(/opera.([\d.]+)/)) ? Sys.opera = s[1] :
                            (s = ua.match(/version\/([\d.]+).*safari/)) ? Sys.safari = s[1] : 0;
            var PLUGINS_NAME = 'WebActiveEXE.Plugin.1';
            /**
             * 检测浏览器是否存在视频插件
             * @return {Boolean}
             */
            function checkPlugins() {
                var result;
                if (Sys.ie) {
                    try {
                        result = new ActiveXObject(PLUGINS_NAME);
                        delete result;
                    } catch (e) {
                        return false;
                    }
                    return true;
                } else {
                    navigator.plugins.refresh(false);
                    result = navigator.mimeTypes["application/media-plugin-version-3.1.0.2"];
                    return !!(result && result.enabledPlugin);
                }
            }
			if(!checkPlugins()){
                //没有安装插件，提示安装
                $("a[name='ckA']").attr("href","#");
                $("a[name='ckA']").attr("target","");
				$("#error").show();
			}

        });
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
		<h5>实时视频监控单位列表 </h5>
		<div class="ibox-tools">
		</div>
	</div>
    
    <div class="ibox-content">
	<sys:message content="${message}"/>
	
	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12">
	<form:form id="searchForm" modelAttribute="dzjgSxt" action="${ctx}/dzjg/jkgl/spjk" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<span>单位：</span>
				<sys:treeselect id="officeId" name="officeId" value="${dzjgSxt.officeId.id}" labelName="" labelValue="${dzjgSxt.officeId.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="form-control input-sm" allowClear="true" notAllowSelectParent="true"/>
		 </div>
	</form:form>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<div>
				<button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
				&nbsp;&nbsp;<span style="display: none;color: red;" id="error">视频监控功能需要安装webplugin插件，<a href="${ctxRoot }/asset/webplugin.exe">点击下载安装！</a></span>
			</div>
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
				<th  class="sort-column office_id">单位</th>
				<th  class="">窗口数量</th>
				<%--<th  class="sort-column mm">摄像头密码</th>--%>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="dzjgSxt">
			<tr>
				<td> <input type="checkbox" id="${dzjgSxt.id}" class="i-checks"></td>
				<td>
						${fn:replace(dzjgSxt.officeId.name, "分局","分窗口" )}
				</td>
				<td>
					${dzjgSxt.cksl}
				</td>
				<td>
					<shiro:hasPermission name="dzjg:jkgl:spjk">
						<a href="${ctx}/dzjg/jkgl/spjkDetail?officeId.id=${dzjgSxt.officeId.id}" target="_blank" class="btn btn-info btn-xs" name="ckA"><i class="fa fa-search-plus"></i> 查看</a>
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