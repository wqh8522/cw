<%@ page import="org.apache.commons.lang3.time.DateFormatUtils" %>
<%@ page import="java.util.Date" %>
<% Date nowDate = new Date();
    String year = DateFormatUtils.format(nowDate, "yyyy");
    request.setAttribute("year", year);
%>
