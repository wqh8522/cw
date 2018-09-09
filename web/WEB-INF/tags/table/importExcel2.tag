<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<%@ attribute name="url" type="java.lang.String" required="true"%>
<%-- 使用方法： 1.将本tag写在查询的form之前；2.传入controller的url --%>
<button id="btnImport2" class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" title="导入"><i class="fa fa-folder-open-o"></i> 兼职导入</button>
<div id="importBox2" class="hide">
		<form id="importForm2" action="${url}" method="post" enctype="multipart/form-data"
			 style="padding-left:20px;text-align:center;" onsubmit=""><br/>
			<input id="uploadFile" name="file" type="file" style="width:330px"/>导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！<br/>　　
			
			
		</form>
</div>
<script type="text/javascript">
$(document).ready(function() {
	$("#btnImport2").click(function(){
		top.layer.open({
		    type: 1, 
		    area: [500, 300],
		    title:"兼职导入",
		    content:$("#importBox2").html() ,
		    btn: ['下载模板','确定', '关闭'],
			btn1: function(index, layero){
				  window.location.href='${url}/template';
			},
		    btn2: function(index, layero){
			        var inputForm =top.$("#importForm2");
			        var top_iframe = top.getActiveTab().attr("name");//获取当前active的tab的iframe 
			        inputForm.attr("target",top_iframe);//表单提交成功后，从服务器返回的url在当前tab中展示
    	       		top.$("#importForm2").submit();
				    top.layer.close(index);
			  },
			 
			  btn3: function(index){ 
				  top.layer.close(index);
    	       }
		}); 
	});
    
});

</script>