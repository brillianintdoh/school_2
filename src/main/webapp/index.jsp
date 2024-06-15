<%@ page contentType="text/html; charset=UTF-8"
import="kr.co.ourgram.school_2.Data"
import="kr.co.ourgram.school_2.Check"
import="jakarta.servlet.http.*" %>
<%!
String seed = null;
public boolean login_check(HttpSession sessions) {
    System.out.println(sessions);
    if(sessions != null && sessions.getAttribute("seed") != null) {
        seed = (String) sessions.getAttribute("seed");
        String check = Data.getUsername(seed);
        if(!Check.checkParam(check)) {
            return true;
        }
    }
    return false;
}
%>
<%
HttpSession sessions = request.getSession(false);
boolean login = login_check(sessions);
%>
<jsp:forward page="page/index/index.jsp">
    <jsp:param name="login" value="<%= login %>" />
    <jsp:param name="seed" value="<%= seed %>" />
</jsp:forward>