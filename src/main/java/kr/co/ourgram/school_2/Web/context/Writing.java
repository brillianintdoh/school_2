package kr.co.ourgram.school_2.Web.context;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.ourgram.school_2.Check;
import kr.co.ourgram.school_2.Data;

@WebServlet("/writing")
public class Writing extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException {
        try {
            res.setCharacterEncoding("UTF-8");
            req.setCharacterEncoding("UTF-8");
            PrintWriter out = res.getWriter();
            int id = 1;
            String title = req.getParameter("title");
            String body = req.getParameter("body");
            String seed = req.getParameter("seed");
            if(!Check.checkParam(title) && !Check.checkParam(body)) {
                Connection conn = DriverManager.getConnection(Data.getUrl(), Data.getUser(), Data.getPass());
                String query = "SELECT * FROM user WHERE username=?";
                PreparedStatement sql = conn.prepareStatement(query);
                sql.setString(1, Data.getUsername(seed));
                ResultSet rs = sql.executeQuery();
                if(rs.next()) {
                    id = rs.getInt("id");
                }
                sql.close();
                
                query = "INSERT INTO writing(title, body, author) VALUE(?,?,?)";
                sql = conn.prepareStatement(query);
                sql.setString(1, title);
                sql.setString(2, body);
                sql.setInt(3, id);
                int rss = sql.executeUpdate();
                if(rss == 1) {
                    System.out.println("새로운 게시판 글이 작성되었습니다 저자: "+Data.getUsername(seed));
                    out.println("<p id='writing_ok'></p>");
                }
            }else {
                out.println("올리기");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }catch(IOException e) {
            e.printStackTrace();
        }
    }
}