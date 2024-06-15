<%@ page contentType="text/html; charset=UTF-8"
import="kr.co.ourgram.school_2.Data"
import="jakarta.servlet.http.*" %>
<%!
public String login_check(HttpSession sessions) {
    String seed = null;
    if(sessions != null) {
        seed = (String) sessions.getAttribute("seed");
        return seed;
    }
    return null;
}
%>
<%
HttpSession sessions = request.getSession(false);
String seed = login_check(sessions);
if(seed == null) { %>
    <jsp:forward page="/error.html"/>
<% }
String username = Data.getUsername(seed);
if(username == null) { %>
    <jsp:forward page="/error.html"/>
<% } %>
<!doctype html>
<html lang="ko">
    <head>
        <title> 게시판 </title>
        <meta charset="UTF-8">
        <link href="/css/context.css" rel="stylesheet">
        <link href="/img/icon.ico" rel="icon">
        <script src="/js/boot.js"></script>
        <meta name='viewport' content='width=device-width, initial-scale=1'>
    </head>
    <body>
        <jsp:include page="/page/menu.jsp">
            <jsp:param name="seed" value="<%= seed %>"/>
        </jsp:include>

        <div class="container">
            <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
                <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
                </ul>
                
                <div class="text-end">
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modal_btu">
                        <i class="bi bi-plus-lg"></i>
                    </button>
                </div>
            </div>
        </div>

        <div class="main sroll album py-5 bg-body-tertiary" id="writing_page">
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                <jsp:include page="writing.jsp">
                    <jsp:param name="type" value="1"/>
                </jsp:include>
            </div>
        </div>

        <div class="end_wheedo">
            <div class='end'>
                <ul class="nav justify-content-center border-bottom pb-3 mb-3">
                    <li class="nav-item"><a href="#" class="nav-link px-2 text-body-secondary">Home</a></li>
                    <li class="nav-item"><a href="https://school.cbe.go.kr/cbnu-h" class="nav-link px-2 text-body-secondary">Homepage</a></li>
                    <li class="nav-item"><a href="https://www.instagram.com/cbnu_2_1?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw" class="nav-link px-2 text-body-secondary">Instagram</a></li>
                    <li class="nav-item"><a href="https://github.com/brillianintdoh" class="nav-link px-2 text-body-secondary">Developer</a></li>
                </ul>
                <p class="text-center text-body-secondary">palanghwi@gmail.com</p>
            </div>
        </div>

        <jsp:include page="modal.html"/>

        <script src="/js/index.js"></script>
<script>
 function wow() {
    const title = document.getElementById("title").value;
    const body = document.getElementById("body").value;
    if(title != '' && body != '') {
        return true;
    }
    return false;
}

function chat() {
    const chat_content = document.getElementById("chat_content").value;
    if(chat_content != '') {
        return true;
    }
    return false;
}
</script>
    </body>
</html>