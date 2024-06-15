<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8"
import="kr.co.ourgram.school_2.*"
import="java.sql.*"
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
if(username == null || !manager) { %>
    <jsp:forward page="/error.html"/>
<% } 
Connection conn = DriverManager.getConnection(Data.getUrl(), Data.getUser(), Data.getPass());
String query = "SELECT * FROM sing";
PreparedStatement sql = conn.prepareStatement(query);
ResultSet rs = sql.executeQuery();
%>
<!doctype html>
<html lang="ko">
    <head>
        <title> 관리자 패널 </title>
        <meta charset="UTF-8">
        <meta name='viewport' content='width=device-width, initial-scale=1'>
        <link href="/img/icon.ico" rel="icon">
        <link href='/css/accounts.css' rel="stylesheet">
        <script src="/js/boot.js"></script>
    </head>
    <body>
        <jsp:include page="/page/menu.jsp">
            <jsp:param name="seed" value="<%= seed %>"/>
        </jsp:include>
        
        <div class="container" id="manager_page">
            <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
                <div class="row text-center w-100">
                    <div style="width: 30%; float:none; margin:0 auto">
                        <h3> 관리자 패널 </h3>
                    </div>
                </div>
            </div>
        </div>

        <hr class="my-4">
        
        <div class="col-md-10 mx-auto col-lg-5">
            <div class="p-4 p-md-5 border rounded-3 bg-body-tertiary">
                <small class="text-body-secondary h3">알림 보내기 (관리자)</small>
                <hr class="my-4">
                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="user">
                    <label for="password_1">보낼사람(이름)</label>
                </div>
                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="title">
                    <label for="password_2">제목</label>
                </div>
                <div class="form-floating mb-3">
                    
                    <input type="text" class="form-control" id="description">
                    <label for="new_password">내용</label>
                </div>
                <button class="w-100 btn btn-lg btn-primary" id="send_btn">보내기</button>
                <hr class="my-4">
                <small id="send_p" class="h3 text-body-secondary">상태:</small>
            </div>
        </div>
        
        <hr class="my-4">
        
        <div class="bg-body-tertiary me-md-3 pt-3 px-3 pt-md-5 px-md-5 text-center overflow-hidden">
            <div class="my-3 p-3">
                <h3 class="display-5">회원가입 요청</h3>
            </div>
            <div class="bg-body shadow-sm mx-auto sroll" style="width: 40%; height: 400px; border-radius: 21px 21px 0 0;">
                <% while(rs.next()) { %>                
                    <div class="d-flex text-body-secondary pt-3">
                        <svg class="bd-placeholder-img flex-shrink-0 me-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 32x32" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#007bff"></rect><text x="50%" y="50%" fill="#007bff" dy=".3em">32x32</text></svg>
                        <p class="pb-3 mb-0 small lh-sm border-bottom">
                            <strong class="d-block text-gray-dark">@<%= rs.getString("className") %>(<%= rs.getString("email") %>)</strong>
                            <button type="button" class="btn btn-group-lg btn-primary">
                                <i class="bi bi-check-circle"></i>
                            </button>
                            <button type="button" class="btn btn-group-lg btn-danger">
                                <i class="bi bi-x-lg"></i>
                            </button>
                        </p>
                    </div>
                <% } %>
            </div>
        </div>
        <script src="/js/index.js"></script>
    </body>
</html>
<%
sql.close();
conn.close();
%>