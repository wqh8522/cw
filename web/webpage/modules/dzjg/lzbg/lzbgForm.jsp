<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>履职报告管理</title>
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
		<form:form id="inputForm" modelAttribute="TDzjgLzbg" action="${ctx}/dzjg/lzbg/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		   <tbody>
		   		<tr>
					<td class="width-15 active" colspan="3"><label class="pull-right">单位（如市纪委）</label></td>
					<td class="width-35">
						<form:input path="dw" id="dw" htmlEscape="false"    class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active" colspan="3"><label class="pull-right">入驻单位（如市国土局纪检组）</label></td>
					<td class="width-35">
						<form:input path="rzdw"  id="rzdw"   htmlEscape="false" class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active" colspan="3"><label class="pull-right">开始时间</label></td>
					<td class="width-35">
						<form:input path="kssj" id="kssj"
									value="${fns:formatDateTime1(TDzjgLzbg.kssj,'yyyy-MM-dd')}"
									onclick="laydate({ istime: true, format: 'YYYY-MM-DD' }); $('#laydate_box').css('-webkit-box-sizing', null);"
									class="form-control required  laydate-icon" />
					</td>
				</tr>
				<tr>
					<td class="width-15 active" colspan="3"><label class="pull-right">结束时间</label></td>
					<td class="width-45">
						<form:input path="jssj" id="jssj"
									value="${fns:formatDateTime1(TDzjgLzbg.jssj,'yyy-MM-dd')}"
									onclick="laydate({ istime: true, format: 'YYYY-MM-DD' }); $('#laydate_box').css('-webkit-box-sizing', null);"
									class="form-control required  laydate-icon" />
					</td>
				</tr>
				<tr align="center">
					<%--<td class="width-15 active"><label class="pull-right">备注信息</label></td>
					<td class="width-35">
						<form:textarea path="remarks" htmlEscape="false" rows="4"    class="form-control "/>
					</td>--%>
					<td width="15px" class="width-15 active" colspan="3"><label class="pull-right">向驻在部门书面提出管党治党意见建议条数</label></td>
					<td class="width-35">
						<form:input path="xzzbmjy" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr align="center">
					<td class="width-15 active" colspan="3"><label class="pull-right">主动发现党员干部违犯“六项纪录”问题个数</label></td>
					<td class="width-35">
						<form:input path="zdfxdywt" htmlEscape="false"    class="form-control "/>
					</td>

				</tr>
				<tr align="center">

					<td class="width-15 active" colspan="3"><label class="pull-right">向市纪委报告驻在部门班子及其成员为题次数\个数</label></td>
					<td class="width-35">
						<form:input path="xsjwbgwt" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr align="center">
					<td class="width-15 active" colspan="2" rowspan="2"><label class="pull-right">征求干部廉政意见回复情况</label></td>
					<td class="width-15 active" colspan="1"><label class="pull-right">回复廉政意见人次</label></td>
					<td class="width-35">
						<form:input path="zqHflzyj" htmlEscape="false"    class="form-control "/>
					</td>

				</tr>
				<tr>
					<td class="width-15 active" colspan="1"><label class="pull-right">提出暂缓或否决性意见人次</label></td>
					<td class="width-35">
						<form:input path="zqTczh" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active" colspan="3"><label class="pull-right">接受信访件数</label></td>
					<td class="width-35">
						<form:input path="jsxfjs" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active" colspan="3"><label class="pull-right">处置问题线索件数</label></td>
					<td class="width-35">
						<form:input path="clwtxsjs" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active" colspan="3"><label class="pull-right">立案数</label></td>
					<td class="width-35">
						<form:input path="las" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>

					<td class="width-15 active" colspan="3"><label class="pull-right">科级干部立案数</label></td>
					<td class="width-35">
						<form:input path="kjgblas" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active" colspan="3"><label class="pull-right">函询谈话数</label></td>
					<td class="width-35">
						<form:input path="hxths" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active" colspan="3"><label class="pull-right">问责数</label></td>
					<td class="width-35">
						<form:input path="wzs" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active" colspan="3"><label class="pull-right">通报数</label></td>
					<td class="width-35">
						<form:input path="tbs" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td colspan="2" rowspan="3" class="width-15 active">
						获奖数
					</td>
					<td class="width-15 active"><label class="pull-right">中央</label></td>
					<td class="width-35">
						<form:input path="hjsZy" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">省级</label></td>
					<td class="width-35">
						<form:input path="hjsShengj" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">市级</label></td>
					<td class="width-35">
						<form:input path="hjsShij" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td colspan="2" rowspan="3" class="width-15 active">
						领导批示数
					</td>
					<td class="width-15 active"><label class="pull-right">中央</label></td>
					<td class="width-35">
						<form:input path="ldpssZy" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">省级</label></td>
					<td class="width-35">
						<form:input path="ldpssShengj" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">市级</label></td>
					<td class="width-35">
						<form:input path="ldpssShij" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td colspan="2" rowspan="3" class="width-15 active">
						宣传报道数
					</td>
					<td class="width-15 active"><label class="pull-right">中央</label></td>
					<td class="width-35">
						<form:input path="xcbdsZy" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">省级</label></td>
					<td class="width-35">
						<form:input path="xcbdsShengj" htmlEscape="false" class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">市级</label></td>
					<td class="width-35">
						<form:input path="xcbdsShij" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td rowspan="6" class="width-15 active">
						践行“四种形态”情况
					</td >
					<td  class="width-15 active">第一种形态</td>
					<td class="width-15 active"><label class="pull-right">批评教育类</label></td>
					<td class="width-35">
						<form:input path="dyPpjys" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active" rowspan="2">第二种形态</td>
					<td class="width-15 active"><label class="pull-right">党纪轻处分</label></td>
					<td class="width-35">
						<form:input path="deDjqcf" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">组织调整</label></td>
					<td class="width-35">
						<form:input path="deZztz" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active" rowspan="2">第三种形态</td>
					<td class="width-15 active"><label class="pull-right">党纪重处分</label></td>
					<td class="width-35">
						<form:input path="dsDjzcf" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">重大职务调整</label></td>
					<td class="width-35">
						<form:input path="dsZdzwtz" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td  class="width-15 active">第四形态</td>
					<td class="width-15 active"><label class="pull-right">严重违纪涉嫌违法犯罪</label></td>
					<td class="width-35">
						<form:input path="dsiYzsxwffz" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
		 	</tbody>
		</table>
	</form:form>
		<script type="text/javascript">
            $(document).ready(function () {
                $("input[type='text']").bind("keyup", function () {
					if (!/^\d+$/.test(this.value)) {
                        this.value = this.value.replace(/[^\d]+/g, '');
                    }
                })
                $("#dw").unbind("keyup");
                $("#rzdw").unbind("keyup");

            });
		</script>
</body>
</html>