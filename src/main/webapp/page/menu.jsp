<%@ page contentType="text/html; charset=UTF-8"
import="kr.co.ourgram.school_2.Data" %>
<%
String seed = request.getParameter("seed");
String username = Data.getUsername(seed);
%>
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
        <i class="button_click bi bi-person h2" data-bs-toggle="dropdown" aria-expanded="false"></i>
        <ul class="dropdown-menu">
            <input type="hidden" id="seed" name="seed" value="<%= seed %>">
            <input type="hidden" name="type" value="1">
            <li><p class="dropdown-item-text h5"><%= username %></p></li>
            <li><a class="dropdown-item button_click" hx-post="/move.jsp" hx-include="[name=type]" hx-trigger="click">내 계정</a></li>
            <li><a class="dropdown-item button_click" hx-post="/move.jsp" hx-include="[name=seed],[name=type]" hx-trigger="click">로그아웃</a></li>
        </ul>
    </div>
</header>