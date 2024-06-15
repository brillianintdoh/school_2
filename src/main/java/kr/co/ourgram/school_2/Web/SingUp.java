package kr.co.ourgram.school_2.Web;

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

@WebServlet("/sing")
public class SingUp extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        req.setCharacterEncoding("UTF-8");
        res.setCharacterEncoding("UTF-8");
        String className = req.getParameter("class_name");
        String email = req.getParameter("email");
        PrintWriter out = res.getWriter();

        if(!Check.checkParam(className) && !Check.checkParam(email)) {
            try (Connection conn = DriverManager.getConnection(Data.getUrl(), Data.getUser(), Data.getPass())) {
                String query = "SELECT * FROM sing WHERE className=?";
                PreparedStatement sql = conn.prepareStatement(query);
                sql.setString(1, className);
                ResultSet rs = sql.executeQuery();
                if(!rs.next()) {
                    sql.close();
                    query = "INSERT INTO sing (email, className) VALUES (?,?)";
                    sql = conn.prepareStatement(query);
                    sql.setString(1, email);
                    sql.setString(2, className);
                    sql.executeUpdate();
                    out.println("<button id='sing_ok' class='w-100 mb-2 btn btn-lg rounded-3 btn-primary'>가입 요청 성공!</button>");
                }else {
                    out.println("<button class='w-100 mb-2 btn btn-lg rounded-3 btn-primary'>이미 가입 요청이 있습니다</button>");
                }
                sql.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }else {
            out.println("<button class='w-100 mb-2 btn btn-lg rounded-3 btn-primary btn-danger'>값이 없습니다</button>");
        }
    }
}