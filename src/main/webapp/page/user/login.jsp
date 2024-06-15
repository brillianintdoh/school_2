<%@ page contentType="text/html; charset=UTF-8" %>
<%
String seed = request.getParameter("seed");
%>
<% if(seed != null || "null".equals(seed)) { %>
    <jsp:forward page="sign_out.jsp">
        <jsp:param name="seed" value="<%= seed %>" />
    </jsp:forward>
<% } else {
    out.println("<p id='accounts'></p>");
} %>