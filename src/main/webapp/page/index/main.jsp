<%@ page contentType="text/html; charset=UTF-8"
import="kr.co.ourgram.school_2.Data" %>
<%
String username = Data.getUsername(request.getParameter("seed"));
boolean login = Boolean.parseBoolean(request.getParameter("login"));
%>
<div class="main-img container-fluid ratio ratio-21x9"></div>    
<div class='border_i py-3'></div>

<div class="bg-body-tertiary me-md-3 pt-3 px-3 pt-md-5 px-md-5 text-center overflow-hidden">
    <div class="my-3 p-3">
        <h2 class="display-5">게시판</h2>
        <% if(login) { %>
            <p class="lead context_p button_click" hx-trigger="click" hx-vals='{ "type": "2" }' hx-post="/move.jsp">게시판으로 이동</p>
        <% } else { %>
            <p class="lead"> 로그인이 필요합니다 </p>
        <% } %>
    </div>
    <div class="bg-body shadow-sm mx-auto" style="width: 80%; height: 300px; border-radius: 21px 21px 0 0;">
        <% if(login) { %>
            <jsp:include page="/page/context/writing.jsp">
                <jsp:param name="type" value="2"/>
            </jsp:include>
        <% } %>
    </div>
</div>

<div class='border_end py-2'></div>
<div class='end'>
    <ul class="nav justify-content-center border-bottom pb-3 mb-3">
        <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">Home</a></li>
        <li class="nav-item"><a href="https://school.cbe.go.kr/cbnu-h" class="nav-link px-2 text-body-secondary">Homepage</a></li>
        <li class="nav-item"><a href="https://www.instagram.com/cbnu_2_1?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw" class="nav-link px-2 text-body-secondary">Instagram</a></li>
        <li class="nav-item"><a href="https://github.com/brillianintdoh" class="nav-link px-2 text-body-secondary">Developer</a></li>
    </ul>
    <p class="text-center text-body-secondary">palanghwi@gmail.com</p>
</div>