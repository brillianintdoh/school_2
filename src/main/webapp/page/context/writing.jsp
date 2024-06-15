<%@ page contentType="text/html; charset=UTF-8"
import="kr.co.ourgram.school_2.Data"
import="kr.co.ourgram.school_2.Check"
import="java.sql.*" %>
<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
}catch(Exception e) {
    System.out.println("writing.jsp 에서 sql 에러: "+e);
}
String type = request.getParameter("type");
Connection conn = DriverManager.getConnection(Data.getUrl(), Data.getUser(), Data.getPass());
String query = "SELECT * FROM writing ORDER BY created_at DESC";
PreparedStatement sql = conn.prepareStatement(query);
ResultSet rs = sql.executeQuery();
if(type.equals("1")) {
    while(rs.next()) { %>
        <% String id = rs.getString("id");
        String title = rs.getString("title"); %>
        <div class="col">
            <div class="card shadow-sm">
                <svg class="bd-placeholder-img card-img-top" width="100%" height="225">
                <rect width="100%" height="100%" fill="#55595c"></rect></svg>
                <div class="card-body">
                    <p class="card-text"><%= title %> ( <%= Check.username(id) %> )</p>
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="btn-group">
                            <button style="display:none" id="chatBtn_<%= id %>" hx-get="chat/modal.jsp" hx-target="#chat_body" hx-vals='{ "room_id": "<%= id %>", "title":"<%= title %>", "author": "<%= rs.getString("author") %>"  }'>
                            <button type="button" class="btn btn-sm btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#modal_chat" hx-get="chat/modal.jsp" hx-target="#chat_body" hx-vals='{ "room_id": "<%= id %>", "title":"<%= title %>", "author": "<%= rs.getString("author") %>" }'>
                                <i class="bi bi-chat-square-text"></i>
                            </button>
                            <button class="btn btn-sm btn-outline-secondary" hx-get="read.jsp" hx-target="#writing_body" hx-vals='{ "id": "<%= id %>" }' data-bs-toggle="modal" data-bs-target="#modal_writing">
                                보기
                            </button>
                        </div>
                        <small class="text-body-secondary"><%= rs.getString("created_at") %></small>
                    </div>
                </div>
            </div>
        </div>
    <% }
} else {
    if(rs.next()) { %>
        <% String id = rs.getString("id"); %>
        <div class="col">
            <div class="card shadow-sm">
                <svg class="bd-placeholder-img card-img-top" width="100%" height="225">
                <rect width="100%" height="100%" fill="#55595c"></rect></svg>
                <div class="card-body">
                    <p class="card-text"><%= rs.getString("title") %> ( <%= Check.username(id) %> )</p>
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="btn-group"></div>
                        <small class="text-body-secondary"><%= rs.getString("created_at") %></small>
                    </div>
                </div>
            </div>
        </div>
    <% }
} %>
<%
sql.close();
conn.close();
%>