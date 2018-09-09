<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>模板文件配置管理</title>
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
		<form:form id="inputForm" modelAttribute="mbwj" action="${ctx}/dzjg/mbwj/save" method="post" class="form-horizontal" enctype="multipart/form-data">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		   <tbody>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>文件名：</label></td>
					<td class="width-35" colspan="2">
						<form:input path="name" htmlEscape="false"    class="form-control required"/>
					</td>
				</tr>
		   		<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>文件类型：</label></td>
					<td class="width-35" colspan="2">
						<form:select path="type" class="form-control required">
							<form:option value="" label="---请选择---"/>
							<form:options items="${fns:getDictList('dzjg_mbtype')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
				</tr>
			   <tr>
				   <td class="width-15 active"><label class="pull-right"><font color="red">*</font>文件：</label></td>
				   <td class="width-35">
					   <input type="file" name="file" htmlEscape="false"    class="form-control required"/>
				   </td>
				   <td class="width-35">
						<a href="${ctx}/dzjg/mbwj/download?id=${mbwj.id}">${mbwj.name}</a>
				   </td>
			   </tr>
		 	</tbody>
		</table>
	</form:form>
</body>
</html>