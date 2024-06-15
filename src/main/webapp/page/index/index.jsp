<%@ page contentType="text/html; charset=UTF-8"
import="kr.co.ourgram.school_2.Check"
import="kr.co.ourgram.school_2.Data" %>
<%
String check = request.getParameter("login");
String seed = request.getParameter("seed");
String username = Data.getUsername(seed);
boolean login = false;
if(!Check.checkParam(check)) {
    login = Boolean.parseBoolean(check);
}
%>
<!doctype html>
<html lang="ko">
    <head>
        <title> 2-1 </title>
        <meta charset='UTF-8'>
        <link href="/css/index.css" rel="stylesheet">
        <link href="/img/icon.ico" rel="icon">
        <script src="/js/boot.js"></script>
        <meta name='viewport' content='width=device-width, initial-scale=1'>
    </head> 
    <body>
        <header class="container d-flex flex-wrap align-items-center justify-content-center justify-content-md-between py-3 mb-4 border-bottom">
            <input type="hidden" id="username" value="<%= username %>">
            <div class="col-md-3 mb-2 mb-md-0">
                <button class="d-inline-flex link-body-emphasis text-decoration-none nav-link" onclick="location.href='https://ourgram.co.kr'">
                    <i class="bi bi-code-slash h1"></i>
                </button>
            </div>
            
            <div class="nav col-12 col-md-auto mb-2 justify-content-center mb-md-0 ">
            </div>
            
            <div class="col-md-3 text-end">
                <% if(login) { %>
                    <i class="button_click bi bi-person h2" data-bs-toggle="dropdown" aria-expanded="false"></i>
                    <ul class="dropdown-menu">
                        <input type="hidden" name="seed" value="<%= seed %>">
                        <li><p class="dropdown-item-text h5"><%= username %></p></li>
                        <li><a class="dropdown-item button_click" hx-post="/move.jsp" hx-vals='{ "type": "1" }' hx-trigger="click">내 계정</a></li>
                        <li><a class="dropdown-item button_click" hx-post="/move.jsp" hx-include="[name=seed]" hx-vals='{ "type": "1" }' hx-trigger="click">로그아웃</a></li>
                    </ul>
                <% } else { %>
                    <button class="btn btn-outline-primary me-2" id="login_button" data-bs-toggle="modal" data-bs-target="#modal_btu">Login</button>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modal_sing">Sign-up</button>
                <% } %>
            </div>
        </header>

        <div id="main_page" class="main bg-body-secondary">
            <jsp:include page="main.jsp">
                <jsp:param name="login" value="<%= login %>"/>
                <jsp:param name="seed" value="<%= seed %>"/>
            </jsp:include>
        </div>

        <jsp:include page="modal.html"/>

        <script src="/js/index.js"></script>
    </body>
</html>