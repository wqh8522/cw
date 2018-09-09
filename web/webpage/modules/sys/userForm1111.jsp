<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
	<link href="/static/dzjg/css/admin.css" rel="stylesheet">
	<link href="/static/dzjg/css/pintuer.css" rel="stylesheet">

	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		var validateForm;
		function doSubmit(){//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
		  if(validateForm.form()){
			  if($("#mobile").val() != "" && !(/^1[3|4|5|7|8][0-9]{9}$/.test($("#mobile").val()))) {
				  top.layer.msg('手机号码有误，请重填', {icon: 5});
				  return false;
			  }
			  if($("#newPassword").val() != "" && !(/^[0-9a-zA-Z_]{1,}$/.test($("#newPassword").val()))) {
				  top.layer.msg('密码只能由数字、26个英文字母或者下划线组成', {icon: 5});
				  return false;
			  }
			  if($("#no").val() != "" && !(/^[0-9]*$/.test($("#no").val()))) {
				  top.layer.msg('工号/学号只能是数字', {icon: 5});
				  return false;
			  }
			  $("#inputForm").submit();
			  return true;
		  }
	
		  return false;
		}
		$(document).ready(function() {
			$("#no").focus();
			validateForm = $("#inputForm").validate({
				rules: {
					loginName: {remote: "${ctx}/sys/user/checkLoginName?oldLoginName=" + encodeURIComponent('${user.loginName}')}//设置了远程验证，在初始化时必须预先调用一次。
				},
				messages: {
					loginName: {remote: "用户登录名已存在"},
					confirmNewPassword: {equalTo: "输入与上面相同的密码"}
				},
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

			$("#inputForm").validate().element($("#loginName"));
		});

	
	</script>
</head>
<body >
<div class="panel admin-panel" style="margin-right: 20px">

	<form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/save" method="post">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>

		<div>
			<table class="tableUser" width="700" border="1" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100">姓名</td>
					<td width="165"><input class="inputDefault" id="userName" name="userName" placeholder="请输入姓名"/></td>
					<td width="60">性别</td>
					<td width="150" colspan="2">
						<select class="input inputDefault" id="userSex" name="userSex" title="请选择">
							<option value="1">男</option>
							<option value="0">女</option>
						</select>
					</td>
					<td width="60">民族</td>
					<td width="165">
						<input class="inputDefault" id="nationality" name="politicalStatus" placeholder="请输入民族" />
					</td>
				</tr>
				<tr>
					<td>政治面貌</td>
					<td colspan="4">
						political_status
						<select class="input inputDefault" id="politicalStatus" name="politicalStatus">
							<option value="1">中共党员</option>
							<option value="2">中共预备党员</option>
							<option value="3">共青团员</option>
							<option value="4">民革党员</option>
							<option value="5">民盟盟员</option>
							<option value="6">民建会员</option>
							<option value="7">民进会员</option>
							<option value="8">农工党党员</option>
							<option value="9">致公党党员</option>
							<option value="10">九三学社社员</option>
							<option value="11">台盟盟员</option>
							<option value="12">无党派人士</option>
							<option value="13">群众</option>
						</select>

					</td>
					<td>职务</td>
					<td><input class="inputDefault" id="duty" name="duty" placeholder="请输入职务"/></td>
				</tr>
				<tr>
					<td>出生年月</td>
					<td><input id="birth" name="birth" onclick="laydate({ istime: true, format: 'YYYY-MM-DD hh:mm:ss' }); $('#laydate_box').css('-webkit-box-sizing', null);" class="inputDefault laydate-icon" /></td>
					<td>专/兼职</td>
					<td colspan="2">
						<select class="input inputDefault" id="dutyType" name="dutyType">
							<option value="1">专职</option>
							<option value="0">兼职</option>
						</select>
					</td>
					<td>职级</td>
					<td><input class="inputDefault" id="dutyLevel" name="dutyLevel" placeholder="请输入职级" /></td>
				</tr>
				<tr>
					<td>任职时间</td>
					<td colspan="2"><input id="servingTime" name="servingTime" onclick="laydate({ istime: true, format: 'YYYY-MM-DD hh:mm:ss' }); $('#laydate_box').css('-webkit-box-sizing', null);" class="inputDefault laydate-icon" /></td>
					<td colspan="2">何时参加工作</td>
					<td colspan="2"><input id="joinWorkTime" name="joinWorkTime" onclick="laydate({ istime: true, format: 'YYYY-MM-DD hh:mm:ss' }); $('#laydate_box').css('-webkit-box-sizing', null);" class="inputDefault laydate-icon" /></td>
				</tr>
				<tr>
					<td>进入公司时间</td>
					<td colspan="2"><input id="joinCompanyTime" name="joinCompanyTime" onclick="laydate({ istime: true, format: 'YYYY-MM-DD hh:mm:ss' }); $('#laydate_box').css('-webkit-box-sizing', null);" class="inputDefault laydate-icon" /></td>
					<td colspan="2">何时从事纪检监察工作</td>
					<td colspan="2"><input id="startTime" name="startTime" onclick="laydate({ istime: true, format: 'YYYY-MM-DD hh:mm:ss' }); $('#laydate_box').css('-webkit-box-sizing', null);" class="inputDefault laydate-icon" /></td>
				</tr>
				<tr>
					<td>毕业院校</td>
					<td colspan="2"><input class="inputDefault" id="graduateInstitutions" name="graduateInstitutions" placeholder="请输入毕业院校"/></td>
					<td colspan="2">毕业专业</td>
					<td colspan="2"><input class="inputDefault" id="specialty" name="specialty" placeholder="请输入毕业专业" /></td>
				</tr>
				<tr>
					<td>学历</td>
					<td colspan="2"><input class="inputDefault" id="qualifications" name="qualifications" placeholder="请输入学历"/></td>
					<td colspan="2">技术职称</td>
					<td colspan="2"><input class="inputDefault" id="technicalTitle" name="technicalTitle" placeholder="请输入技术职称"/></td>
				</tr>
				<tr>
					<td>办公电话</td>
					<td colspan="2"><input class="inputDefault" id="oPH" name="oPH" placeholder="请输入办公电话" /></td>
					<td colspan="2">手机号</td>
					<td colspan="2"><input class="inputDefault" id="phone" name="phone" placeholder="请输入手机号"/></td>
				</tr>
				<tr>
					<td>机构</td>
					<td colspan="2">
						<select class="input inputDefault" id="group" name="group">
						</select>
					</td>
					<td colspan="4">
						<span style="color: #FE0505">以上内容均为必填项，否则无法提交！</span>
					</td>
				</tr>
				<tr>
					<td colspan="7" style="text-align: left; height: 60px;padding-top:12px">
						<div class="form-group" style="">
							<div class="label">
								<label></label>
							</div>
							<div class="field">
								<button class="button bg-main icon-check-square-o" type="submit" id="submitData"> 提交</button>
								<button class="button bg-red icon-reply" type="button" id="butCancle" style="margin-left: 10px" onclick="window.location.href = 'person-roster-list.html'"> 取消</button>
								<span id="errInfo" style="color: #FE0505"></span>
							</div>

						</div>
					</td>
				</tr>
			</table>

		</div>


	</form:form>
</div>
</body>
</html>