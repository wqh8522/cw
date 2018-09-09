<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<%@ include file="/webpage/include/util.jsp"%>
<html>
<head>
	<title>节日明察暗访管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		var validateForm;
		function doSubmit(){//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
		  if(validateForm.form()){
			  $("#inputForm").submit();
			  return true;
		  }
	
		  return false;
		}
		$(document).ready(function() {
			validateForm = $("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
			
		});
	</script>
</head>
<body class="hideScroll">
		<form:form id="inputForm" modelAttribute="jmcaf" action="${ctx}/dzjg/jmcaf/save" method="post" class="form-horizontal" enctype="multipart/form-data">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		   <tbody>

		   <tr>
			   <td class="width-15 active"><label class="pull-right"><font color="red">*</font>年份：</label></td>
			   <td class="width-35">
				   <form:input path="jrYear" id="jrYear"
							   value="${jmcaf.jrYear == null ?year:jmcaf.jrYear}"
							   onclick="laydate({ format: 'YYYY'}); $('#laydate_box').css('-webkit-box-sizing', null);"
							   class="form-control required  laydate-icon" />
			   </td>
			   <td class="width-15 active"><label class="pull-right"><font color="red">*</font>节日：</label></td>
			   <td class="width-35">
					   <%--<form:input path="jr" htmlEscape="false"    class="form-control required"/>--%>
				   <select name="jr" id="jr" htmlEscape="false" class="form-control required">
					   <c:forEach items="${jrs}" var="jr">
						   <option value="${jr.id}" ${jmcaf.jr.id == jr.id?'selected = "selected"':'' }>${jr.name}</option>
					   </c:forEach>
				   </select>

			   </td>
		   </tr>
				<tr>
					<%--<td class="width-15 active"><label class="pull-right">备注信息：</label></td>
					<td class="width-35">
						<form:textarea path="remarks" htmlEscape="false" rows="4"    class="form-control "/>
					</td>--%>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>被检查单位：</label></td>
					<td class="width-35">
						<c:choose>
							<c:when test="${not empty jmcaf.id}">
								<sys:treeselect id="tjdw" name="bjcdw.id" value="${jmcaf.bjcdw.id}" labelName="bjcdw.name" labelValue="${jmcaf.bjcdw.name}"
												title="被检查单位" url="/sys/office/treeData?type=2" cssClass="form-control required" notAllowSelectParent="false"/>
							</c:when>
							<c:otherwise>
								<sys:treeselect id="tjdw" name="bjcdw.id" value="${fns:getUser().office.id}"  labelName="tjdw.name" labelValue="${fns:getUser().office.name}"
												title="部门" url="/sys/office/treeData?type=2" disabled="disabled" cssClass="form-control required" notAllowSelectParent="false"/></td>
							</c:otherwise>
						</c:choose>
						<%--<form:input path="bjcdw" htmlEscape="false"    class="form-control required"/>--%>

						</td>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>检查组人员：</label></td>
					<td class="width-35">
						<%--<form:input path="jczry" htmlEscape="false"    class="form-control required"/>--%>
							<sys:treeselect id="jczry" name="jczry" value="${jmcaf.jcz_users.id}" labelName="" labelValue="${jmcaf.jcz_users.name}"
											title="用户" url="/sys/office/treeData?type=3" cssClass="form-control required" notAllowSelectParent="true" checked="true"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>上报人：</label></td>
					<td class="width-35">
						<%--<form:input path="sbr" htmlEscape="false"    class="form-control required"/>--%>

							<c:choose>
							<c:when test="${not empty jmcaf.id}">
								<input type="hidden" name="sbr" value="${jmcaf.sbr.id}">
								<input name="sbrName1"  value="${jmcaf.sbr.name}" htmlEscape="false" class="form-control required" readonly/>
							</c:when>
							<c:otherwise>
								<input type="hidden" name="sbr" value="${fns:getUser().id}">
								<input name="sbrName2" value="${fns:getUser().name}" htmlEscape="false" class="form-control required" readonly/>
							</c:otherwise>
						</c:choose>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>检查时间：</label></td>
					<td class="width-35">
						<%--<form:input path="jcsj" htmlEscape="false"    class="form-control required"/>--%>
							<form:input path="jcsj" id="jcsj"
										value="${fns:formatDateTime1(jmcaf.jcsj,'yyyy-MM-dd')}"
										onclick="laydate({ istime: true, format: 'YYYY-MM-DD' }); $('#laydate_box').css('-webkit-box-sizing', null);"
										class="form-control required  laydate-icon" />
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>证明材料：<br>	<span style="color: red;font-size: 3px" class="pull-right">可同时上传多文件</span></label></td>
					<td class="width-35">
							<%--<form:input path="zmcl" htmlEscape="false"    class="form-control required"/>--%>

						<input name="zmcl_file" type="file" htmlEscape="false"  class="form-control ${empty jmcaf.id?'required':''}" multiple="multiple">

					</td>
		   			<td class="width-35" colspan="2">
						<c:forEach items="${jmcaf.zmcl}" varStatus="vs" var="zmcl">

							<a href="${ctx}/sys/attach/download?id=${zmcl.id}" title="下载证明材料">
								<c:if test="${jmcaf.zmcl.size()>1}">
									${vs.count}、
								</c:if>
									${zmcl.fileName}
							</a><br>
						</c:forEach>
					</td>
		  		</tr>

		 	</tbody>
		</table>
			<!-- 选项表格 -->
			<table id="contentTable1"
				   class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
				<thead>
				<tr>
						<%-- <th style="width:40px;">编号</th>--%>
					<th><span style="color: red">*</span>问题类型</th>
					<th><span style="color: red">*</span>问题描述</th>
					<th><span style="color: red">*</span>反映渠道</th>
					<th>反映人</th>
					<th>联系方式</th>
					<th>备注</th>
					<th>操作</th>
				</tr>
				</thead>
				<tbody id="options">
				<c:if test="${jmcaf.id == null }">
					<tr>
							<%-- <td>
                                 <input name="bhs" htmlEscape="false"  class="form-control bhs" value="A" readonly="true"/>
                             </td>--%>
						<%--<input type="hidden" name="zlids" value="1"/>--%>
						<td>
							<input name="wtlx" htmlEscape="false" class="form-control required"/>
						</td>
						<td>
							<input name="wtms" htmlEscape="false" class="form-control required"/>
						</td>
						<td>
							<input name="fyqd" htmlEscape="false" class="form-control required"/>
						</td>
						<td>
							<input name="fyr" htmlEscape="false" class="form-control"/>

								<%--     <input type="checkbox" name="sfbt"  htmlEscape="false"  class="i-checks">--%>
						</td>
						<td>
							<input name="lxfs" htmlEscape="false" class="form-control "/>
						</td>
						<td>
							<input name="wt_remakr" htmlEscape="false" class="form-control "/>
						</td>
						<td>
							<button type="button" class="btn btn-danger" onclick="del(this);">删除</button>
						</td>
					</tr>
				</c:if>
				<c:if test="${jmcaf.id != null }">
					<c:forEach items="${jmcaf.wtmsList }" var="wtms">
						<tr>
								<%-- <td>
                                     <input name="bhs" htmlEscape="false"  class="form-control bhs" value="A" readonly="true"/>
                                 </td>--%>
								<%--<input type="hidden" name="zlids" value="1"/>--%>
							<td>
								<input name="wtlx" htmlEscape="false" class="form-control required" value="${wtms.wtlx}"/>
							</td>
							<td>
								<input name="wtms" htmlEscape="false" class="form-control required" value="${wtms.wtms}"/>
							</td>
							<td>
								<input name="fyqd" htmlEscape="false" class="form-control required" value="${wtms.fyqd}"/>
							</td>
							<td>
								<input name="fyr" htmlEscape="false" class="form-control" value="${wtms.fyr}"/>

									<%--     <input type="checkbox" name="sfbt"  htmlEscape="false"  class="i-checks">--%>
							</td>
							<td>
								<input name="lxfs" htmlEscape="false" class="form-control " value="${wtms.lxfs}"/>
							</td>
							<td>
								<input name="wt_remakr" htmlEscape="false" class="form-control " value="${wtms.remarks}"/>
							</td>
							<td>
								<button type="button" class="btn btn-danger" onclick="del(this);">删除</button>
							</td>
						</tr>
					</c:forEach>
				</c:if>
				</tbody>
			</table>
			<button type="button" class="btn btn-primary" onclick="add();">新增选项</button>

	</form:form>

		<script type="text/javascript">
            function add() {
				var html = '<tr>' +
					'<td><input name="wtlx" htmlEscape="false" class="form-control required"/></td>' +
					'<td><input name="wtms" htmlEscape="false" class="form-control required"/></td>' +
					'<td><input name="fyqd" htmlEscape="false" class="form-control required"/></td>' +
					'<td><input name="fyr" htmlEscape="false" class="form-control"/></td>' +
                    '<td><input name="lxfs" htmlEscape="false" class="form-control "/></td>'+
					'<td><input name="wt_remakr" htmlEscape="false" class="form-control "/></td>' +
					'<td><button type="button" class="btn btn-danger" onclick="del(this);">删除</button></td></tr>';
				$("#options").append(html);
				reorder();
            }
            function del(el) {
                $(el).parent().parent().remove();
                reorder();
            }


		</script>
</body>
</html>