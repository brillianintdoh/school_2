<%@ page contentType="text/html; charset=UTF-8"
import="kr.co.ourgram.school_2.*"
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
boolean manager = Check.manager(seed);
String username = Data.getUsername(seed);
if(username == null) { %>
    <jsp:forward page="/error.html"/>
<% } %>
<!doctype html>
<html lang="ko">
    <head>
        <title> 내 계정 </title>
        <meta charset="UTF-8">
        <link href="/img/icon.ico" rel="icon">
        <link href="/css/accounts.css" rel="stylesheet">
        <script src="/js/boot.js"></script>
        <meta name='viewport' content='width=device-width, initial-scale=1'>
    </head>
    <body>
        <jsp:include page="/page/menu.jsp">
            <jsp:param name="seed" value="<%= seed %>"/>
        </jsp:include>

        <div class="main" id="accounts_page">
            <div class="col-md-10 mx-auto col-lg-5">
                <form class="p-4 p-md-5 border rounded-3 bg-body-tertiary" hx-post="/password" hx-target="#pass_btn">
                    <input type="hidden" name="seed" value="<%= seed %>">
                    <small class="text-body-secondary h3">비밀번호 변경</small>
                    <hr class="my-4">
                    <div class="form-floating mb-3">
                        <input type="password" class="form-control" name="password_1" id="password_1">
                        <label for="password_1">현재 비밀번호</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="password" class="form-control" name="password_2" id="password_2">
                        <label for="password_2">현재 비밀번호 재입력</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="password" class="form-control" name="new_password" id="new_password">
                        <label for="new_password">새로운 비밀번호</label>
                    </div>
                    <div class="checkbox mb-3">
                    </div>
                    <button class="w-100 btn btn-lg btn-primary" type="submit" id="pass_btn">변경</button>
                    
                    <hr class="my-4">
                    <small class="text-body-secondary">비번을 잃어버리면 2128최도휘 찾아오셈</small>
                </form>
            </div>
            
            <hr class="my-4">

            <% if(manager) { %>
                <div class="col-md-10 mx-auto col-lg-5">
                    <div class="p-4 p-md-5 border rounded-3 bg-body-tertiary">
                        <small class="text-body-secondary h3">관리자 패널 가기</small>
                        <hr class="my-4">
                        <button class="w-100 btn btn-lg btn-primary" onclick="location.href = 'manager'">가기</button>
                        <hr class="my-4">
                    </div>
                </div>
            <% } %>
        </div>
        <script src='/js/index.js'></script>
    </body>
</html>