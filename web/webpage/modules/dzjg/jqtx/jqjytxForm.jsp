<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<%@ include file="/webpage/include/util.jsp"%>
<html>
<head>
	<title>节前提醒管理</title>
	<meta name="decorator" content="default"/>
	<%--<script src="${ctxStatic}/laydate5.0.9/laydate.js"></script>--%>
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
            /*laydate.render({
                elem: '#jr_year',
                theme: 'molv',
                type: 'year'
            });*/
            /*laydate.render({
                elem: '#txsj',
                theme: 'molv',
            });*/
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
		<form:form id="inputForm" modelAttribute="jqjytx" action="${ctx}/dzjg/jqjytx/save" method="post" class="form-horizontal" enctype="multipart/form-data">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		   <tbody>
			   <tr>
				   <td class="width-15 active"><label class="pull-right"><font color="red">*</font>年份：</label></td>
				   <td class="width-35">
					   <form:input path="jrYear" id="jrYear"
								   value="${jqjytx.jrYear == null? year:jqjytx.jrYear}"
								   onclick="laydate({ format: 'YYYY'}); $('#laydate_box').css('-webkit-box-sizing', null);"
								   class="form-control required  laydate-icon" />
				   </td>
				   <td class="width-15 active"><label class="pull-right"><font color="red">*</font>节日：</label></td>
				   <td class="width-35">
						   <%--<form:input path="jr" htmlEscape="false"    class="form-control required"/>--%>
					   <select name="jr" id="jr" htmlEscape="false" class="form-control required">
						   <c:forEach items="${jrs}" var="jr">
							   <option value="${jr.id}" ${jqjytx.jr.id == jr.id?'selected = "selected"':'' }>${jr.name}</option>
						   </c:forEach>
					   </select>

				   </td>
			   </tr>
				<tr>


					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>提醒方式：</label></td>
					<td class="width-35">
						<%--<form:input path="txfs" htmlEscape="false"    class="form-control required"/>--%>
							<select name="txfs" id="txfs" htmlEscape="false" class="form-control required">
								<c:forEach items="${txfs}" var="txfs">
									<option value="${txfs.id}" ${jqjytx.txfs.id == txfs.id?'selected = "selected"':'' }>${txfs.name}</option>
								</c:forEach>
							</select>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>提醒时间：</label></td>
					<td class="width-35">
							<%--<form:input path="txsj" htmlEscape="false"    class="form-control required"/>--%>
						<form:input path="txsj" id="txsj"
									value="${fns:formatDateTime1(jqjytx.txsj,'yyyy-MM-dd')}"
									onclick="laydate({ format: 'YYYY-MM-DD'}); $('#laydate_box').css('-webkit-box-sizing', null);"
									class="form-control required  laydate-icon" />
					</td>
				</tr>
				<tr>

					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>提交单位：</label></td>
					<td class="width-35">
						<%--<form:input path="tjdw" htmlEscape="false"    class="form-control required"/>--%>
							<c:choose>
								<c:when test="${not empty jqjytx.id}">
									<sys:treeselect id="tjdw" name="tjdw.id" value="${jqjytx.tjdw.id}" labelName="tjdw.name" labelValue="${jqjytx.tjdw.name}"
												title="部门" url="/sys/office/treeData?type=2" cssClass="form-control required" notAllowSelectParent="false"/></td>
								</c:when>
								<c:otherwise>
									<sys:treeselect id="tjdw" name="tjdw.id" value="${fns:getUser().office.id}"  labelName="tjdw.name" labelValue="${fns:getUser().office.name}"
													title="部门" url="/sys/office/treeData?type=2" disabled="disabled" cssClass="form-control required" notAllowSelectParent="false"/></td>
								</c:otherwise>
							</c:choose>

					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>提交人：</label></td>
					<td class="width-35">
						<c:choose>
							<c:when test="${not empty jqjytx.id}">
								<input type="hidden" name="tje" value="${jqjytx.tjr.id}">
								<input name="tjrName1"  value="${jqjytx.tjr.name}" htmlEscape="false" class="form-control required" readonly/>
							</c:when>
							<c:otherwise>
								<input type="hidden" name="tjr" value="${fns:getUser().id}">
								<input name="tjrName2" value="${fns:getUser().name}" htmlEscape="false" class="form-control required" readonly/>
							</c:otherwise>
						</c:choose>
							<%--${fns:getU}--%>
					</td>
				</tr>
				<tr>

					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>证明材料：<br>	<span style="color: red;font-size: 3px" class="pull-right">可同时上传多文件</span></label>	</td>
					<td class="width-35">
						<%--<form:input path="zmcl" htmlEscape="false"    class="form-control required"/>--%>

						<input name="zmcl_file" type="file" htmlEscape="false"  class="form-control ${empty jqjytx.id?'required':''}"  multiple="multiple">


							<c:forEach items="${jqjytx.zmcl}" varStatus="vs" var="zmcl">
								<a href="${ctx}/sys/attach/download?id=${zmcl.id}" title="下载证明材料">
									<c:if test="${jqjytx.zmcl.size()>1}">
										${vs.count}、
									</c:if>
										${zmcl.fileName}

								</a><br>
							</c:forEach>
					</td>
					<c:if test="${not empty jqjytx.createDate}">
					   <td class="width-15 active"><label class="pull-right">提交时间：</label></td>
					   <td class="width-35">
							   ${fns:formatDateTime(jqjytx.createDate)}
					   </td>
			   		</c:if>
				</tr>

				
		    	<tr>
					<td class="width-15 active"><label class="pull-right">备注信息：</label></td>
					<td class="width-35" colspan="3">

						<form:textarea path="remarks" htmlEscape="false" rows="4"    class="form-control "/>
					</td>
				</tr>
		 	</tbody>
		</table>
	</form:form>
</body>
</html>