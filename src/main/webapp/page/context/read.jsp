<%@ page contentType="text/html; charset=UTF-8"
import="kr.co.ourgram.school_2.Data"
import="java.sql.*" %>
<%
String id = request.getParameter("id");
String query = "SELECT title, body, author FROM writing JOIN user ON writing.author = user.id WHERE writing.id = ?";
Connection conn = DriverManager.getConnection(Data.getUrl(), Data.getUser(), Data.getPass());
PreparedStatement sql = conn.prepareStatement(query);
sql.setString(1, id);

ResultSet rs = sql.executeQuery();
if(rs.next()) { %>
    <% String title = rs.getString("title"); %>
    <div class="modal-header">
        <h1 class="modal-title fs-5"><%= title %></h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
    </div>

    <div class="modal-body">
        <div class="mb-3">
            <%= rs.getString("body") %>
        </div>
    </div>

    <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-group-lg" hx-get="chat/modal.jsp" hx-target="#chat_body" hx-vals='{ "room_id": "<%= id %>", "author": "<%= rs.getString("author") %>", "title":"<%= title %>" }' data-bs-toggle="modal" data-bs-target="#modal_chat">
            <i class="bi bi-chat-square-text"></i>
        </button>
    </div>
<% } %>
<%
sql.close();
conn.close();
%>