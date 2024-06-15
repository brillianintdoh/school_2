<%@ page contentType="text/html; charset=UTF-8"
import="jakarta.servlet.http.*"
import="kr.co.ourgram.school_2.Data" %>
<%
String target = request.getParameter("seed");

Cookie[] cookies = request.getCookies();
HttpSession sessions = request.getSession(false);

if (sessions != null) {
    sessions.invalidate();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("seed".equals(cookie.getName())) {
                Data.dropUsername(target); 
                cookie.setMaxAge(0);
                response.addCookie(cookie);
                break;
            }
        }
    }
}
out.println("<p id='login_ok'> 로그아웃 </p> <p id='user_out'></p>");
%>