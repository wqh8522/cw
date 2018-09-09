<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>摄像头参数管理</title>
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
		<form:form id="inputForm" modelAttribute="dzjgSxt" action="${ctx}/dzjg/dzjgSxt/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		   <tbody>
				<%--<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>单位：</label></td>
					<td class="width-35">
						<sys:treeselect id="officeId" name="officeId" value="${dzjgSxt.officeId.id}" labelName="" labelValue="${dzjgSxt.officeId.name}"
							title="部门" url="/sys/office/treeData?type=2" cssClass="form-control required" allowClear="true" notAllowSelectParent="true"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>窗口：</label></td>
					<td class="width-35">
						<form:input path="ck" htmlEscape="false"    class="form-control required"/>
					</td>
				</tr>--%>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>ip地址：</label></td>
					<td class="width-35">
						<form:input path="ip" htmlEscape="false"    class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>端口号：</label></td>
					<td class="width-35">
						<form:input path="dkh" htmlEscape="false"    class="form-control required digits"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>用户名：</label></td>
					<td class="width-35">
						<form:input path="yhm" htmlEscape="false"    class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>密码：</label></td>
					<td class="width-35">
						<form:password  path="mm" htmlEscape="false"     class="form-control required"/>
					</td>
				</tr>
		 	</tbody>
		</table>
	</form:form>
</body>
</html>