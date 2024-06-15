<%@ page contentType="text/html; charset=UTF-8" %>
<%
String seed = request.getParameter("seed");
String type = request.getParameter("type");
if(type.equals("1")) {
    if(seed != null || "null".equals(seed)) { %>
        <jsp:forward page="page/user/sign_out.jsp">
            <jsp:param name="seed" value="<%= seed %>" />
        </jsp:forward>
<% } else {
    out.println("<p id='accounts'></p>");
    }
}else if(type.equals("2")) {
    out.println("<p id='context'></p>");
} %>