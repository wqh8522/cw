<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    

    <title>查看邮件</title>
   	<meta name="decorator" content="default"/>

</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="animated fadeInRight">
                <div class="mail-box-header">
                   <%-- <div class="pull-right tooltip-demo">
                        <a href="#" class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="打印邮件"><i class="fa fa-print"></i> </a>
                    </div>--%>
                    <div class="mail-tools tooltip-demo m-t-md">
                        <h3>
                        <span class="font-noraml">主题： </span>${mailCompose.mail.title }
                    </h3>
                    <h5>
                        <span class="pull-right font-noraml"><fmt:formatDate value="${mailCompose.sendtime}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                        <span class="font-noraml">发件人： </span>${(fns:getUserById(mailCompose.sender)).name}
                    </h5>
                    <h5>
                        <span class="font-noraml">收件人： </span>${mailCompose.receiver.name}
                    </h5>
                       <%-- <h5>
                            <span class="font-noraml">类型： </span>${mailCompose.mail}
                        </h5>--%>
                    </div>
                </div>
                <div class="mail-box">
                    <div id="content" class="mail-body">
                        ${fns:unescapeHtml(mailCompose.mail.content)}
                    </div>
                    <div class="mail-attachment">
                    </div>
                </div>
            </div>
        </div>
    </div>


   
    <script>
        $(document).ready(function () {
        });
    </script>

 

</body>

</html>