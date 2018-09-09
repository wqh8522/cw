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
			<thead>
			     <tr align="center">
					 <div align="center">

						 <h1>${date}${TDzjgLzbg.dw}驻${TDzjgLzbg.rzdw}履职情况报告表</h1>
						 <br>
					 </div>
				 </tr>
				 <tr>
					<%--	 <span>开始时间:</span>
						 &lt;%&ndash;<form:input path="kssj" id="kssj"
									 value="${fns:formatDateTime(TDzjgLzbg.kssj)}"
									 onclick="laydate({ istime: true, format: 'YYYY-MM-DD' }); $('#laydate_box').css('-webkit-box-sizing', null);"
									 class="form-control required  laydate-icon" />&ndash;%&gt;
					 <span>结束时间:</span>
					 <span>单位时间:</span>
					 <span>入驻时间:</span>--%>
				 </tr>

			</thead>
		   <tbody>
		    	<tr align="center">
					<td rowspan="4" width="50px">向驻在部门书面提出管党治党意见建议条数</td>
					<td rowspan="4" width="50px">主动发现党员干部违犯“六项纪录”问题个数</td>
					<td rowspan="4" width="50px">向市纪委报告驻在部门班子及其成员为题次数\个数</td>
					<td rowspan="1" colspan="2">征求干部廉政意见回复情况</td>

					<td rowspan="4" width="20px">接受信访件数</td>
					<td rowspan="4"  width="20px">处置问题线索件数</td>
					<td rowspan="4"  width="20px">立案数</td>
					<td rowspan="4" width="20px">科级干部立案数</td>
					<td rowspan="4" width="20px">函询谈话数</td>
					<td rowspan="4" width="20px">问责数</td>
					<td rowspan="4" width="20px">通报数</td>
					<td rowspan="2" colspan="3">获奖数</td>
					<td rowspan="2" colspan="3">领导批示数</td>
					<td rowspan="2" colspan="3">宣传报道数</td>
					<td rowspan="2" colspan="6">践行“四种形态”情况</td>
				</tr>
				<tr>
					<td rowspan="3" width="40px">回复廉政意见人次</td>
					<td rowspan="3"  width="40px">提出暂缓或否决性意见人次</td>


				</tr>
				<tr align="center">
					<td rowspan="2" width="20px">中央</td>
					<td rowspan="2" width="20px">省级</td>
					<td rowspan="2" width="20px">市级</td>
					<td rowspan="2" width="20px">中央</td>
					<td rowspan="2" width="20px">省级</td>
					<td rowspan="2" width="20px">市级</td>
					<td rowspan="2" width="20px">中央</td>
					<td rowspan="2" width="20px">省级</td>
					<td rowspan="2" width="20px">市级</td>
					<td width="30px">第一种形态</td>
					<td colspan="2" width="100px">第二种形态</td>
					<td colspan="2"width="30px">第三种形态</td>
					<td>第四种形态</td>
					<%--<td>批评教育数</td>
					<td>党纪轻处分</td>
					<td>组织调整</td>
					<td>党纪重处分</td>
					<td>重大职务调整</td>
					<td>严重违纪涉嫌违法犯罪</td>--%>
				</tr>
				<tr align="center">
					<td width="50px">批评教育数</td>
					<td width="20px">党纪轻处分</td>
					<td width="20px">组织调整</td>
					<td width="20px">党纪重处分</td>
					<td width="40px">重大职务调整</td>
					<td width="50px">严重违纪涉嫌违法犯罪</td>
				</tr>
				<tr align="center">
					<td>${TDzjgLzbg.xzzbmjy}</td>
					<td>${TDzjgLzbg.zdfxdywt}</td>
					<td>${TDzjgLzbg.xsjwbgwt}</td>
					<td>${TDzjgLzbg.zqHflzyj}</td>
					<td>${TDzjgLzbg.zqTczh}</td>
					<td>${TDzjgLzbg.jsxfjs}</td>
					<td>${TDzjgLzbg.clwtxsjs}</td>
					<td>${TDzjgLzbg.las}</td>
					<td>${TDzjgLzbg.kjgblas}</td>
					<td>${TDzjgLzbg.hxths}</td>
					<td>${TDzjgLzbg.wzs}</td>
					<td>${TDzjgLzbg.tbs}</td>
					<td>${TDzjgLzbg.hjsZy}</td>
					<td>${TDzjgLzbg.hjsShengj}</td>
					<td>${TDzjgLzbg.hjsShij}</td>
					<td>${TDzjgLzbg.ldpssZy}</td>
					<td>${TDzjgLzbg.ldpssShengj}</td>
					<td>${TDzjgLzbg.ldpssShij}</td>
					<td>${TDzjgLzbg.xcbdsZy}</td>
					<td>${TDzjgLzbg.xcbdsShengj}</td>
					<td>${TDzjgLzbg.xcbdsShij}</td>
					<td>${TDzjgLzbg.dyPpjys}</td>
					<td>${TDzjgLzbg.deDjqcf}</td>
					<td>${TDzjgLzbg.deZztz}</td>
					<td>${TDzjgLzbg.dsDjzcf}</td>
					<td>${TDzjgLzbg.dsZdzwtz}</td>
					<td>${TDzjgLzbg.dsiYzsxwffz}</td>
				</tr>
				<%--<tr>
					<td class="width-15 active"><label class="pull-right">备注信息：</label></td>
					<td class="width-35">
						<form:textarea path="remarks" htmlEscape="false" rows="4"    class="form-control "/>
					</td>
					<td class="width-15 active"><label class="pull-right">向驻在部门书面提出管党治党意见建议条数：</label></td>
					<td class="width-35">
						<form:input path="xzzbmjy" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">：</label></td>
					<td class="width-35">
						<form:input path="zdfxdywt" htmlEscape="false"    class="form-control "/>
					</td>
					<td class="width-15 active"><label class="pull-right">：</label></td>
					<td class="width-35">
						<form:input path="xsjwbgwt" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">：</label></td>
					<td class="width-35">
						<form:input path="zqHflzyj" htmlEscape="false"    class="form-control "/>
					</td>
					<td class="width-15 active"><label class="pull-right">：</label></td>
					<td class="width-35">
						<form:input path="zqTczh" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">：</label></td>
					<td class="width-35">
						<form:input path="jsxfjs" htmlEscape="false"    class="form-control "/>
					</td>
					<td class="width-15 active"><label class="pull-right">：</label></td>
					<td class="width-35">
						<form:input path="clwtxsjs" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">：</label></td>
					<td class="width-35">
						<form:input path="las" htmlEscape="false"    class="form-control "/>
					</td>
					<td class="width-15 active"><label class="pull-right">：</label></td>
					<td class="width-35">
						<form:input path="kjgblas" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">函询谈话数：</label></td>
					<td class="width-35">
						<form:input path="hxths" htmlEscape="false"    class="form-control "/>
					</td>
					<td class="width-15 active"><label class="pull-right">问责数：</label></td>
					<td class="width-35">
						<form:input path="wzs" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">通报数：</label></td>
					<td class="width-35">
						<form:input path="tbs" htmlEscape="false"    class="form-control "/>
					</td>
					<td class="width-15 active"><label class="pull-right">获奖数—中央：</label></td>
					<td class="width-35">
						<form:input path="hjsZy" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">获奖数—省级：</label></td>
					<td class="width-35">
						<form:input path="hjsShengj" htmlEscape="false"    class="form-control "/>
					</td>
					<td class="width-15 active"><label class="pull-right">获奖数—市级：</label></td>
					<td class="width-35">
						<form:input path="hjsShij" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">领导批示数—中央：</label></td>
					<td class="width-35">
						<form:input path="ldpssZy" htmlEscape="false"    class="form-control "/>
					</td>
					<td class="width-15 active"><label class="pull-right">领导批示数—省级：</label></td>
					<td class="width-35">
						<form:input path="ldpssShengj" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">领导批示数—市级：</label></td>
					<td class="width-35">
						<form:input path="ldpssShij" htmlEscape="false"    class="form-control "/>
					</td>
					<td class="width-15 active"><label class="pull-right">宣传报道数—中央：</label></td>
					<td class="width-35">
						<form:input path="xcbdsZy" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">宣传报道数—省级：</label></td>
					<td class="width-35">
						<form:input path="xcbdsShengj" htmlEscape="false"    class="form-control "/>
					</td>
					<td class="width-15 active"><label class="pull-right">宣传报道数—市级：</label></td>
					<td class="width-35">
						<form:input path="xcbdsShij" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">第一形态批评教育数：</label></td>
					<td class="width-35">
						<form:input path="dyPpjys" htmlEscape="false"    class="form-control "/>
					</td>
					<td class="width-15 active"><label class="pull-right">第二形态党纪轻处分：</label></td>
					<td class="width-35">
						<form:input path="deDjqcf" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">第二形态组织调整：</label></td>
					<td class="width-35">
						<form:input path="deZztz" htmlEscape="false"    class="form-control "/>
					</td>
					<td class="width-15 active"><label class="pull-right">第三形态党纪重处分：</label></td>
					<td class="width-35">
						<form:input path="dsDjzcf" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">第三形态重大职务调整：</label></td>
					<td class="width-35">
						<form:input path="dsZdzwtz" htmlEscape="false"    class="form-control "/>
					</td>
					<td class="width-15 active"><label class="pull-right">第四形态严重涉嫌违法犯罪：</label></td>
					<td class="width-35">
						<form:input path="dsiYzsxwffz" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">单位（如市纪委）：</label></td>
					<td class="width-35">
						<form:input path="dw" htmlEscape="false"    class="form-control "/>
					</td>
					<td class="width-15 active"><label class="pull-right">入驻单位（如市国土纪检组）：</label></td>
					<td class="width-35">
						<form:input path="rzdw" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">开始时间：</label></td>
					<td class="width-35">
						<form:input path="kssj" htmlEscape="false"    class="form-control "/>
					</td>
					<td class="width-15 active"><label class="pull-right">结束时间：</label></td>
					<td class="width-35">
						<form:input path="jssj" htmlEscape="false"    class="form-control "/>
					</td>
				</tr>--%>
		 	</tbody>
		</table>
	</form:form>
</body>
</html>