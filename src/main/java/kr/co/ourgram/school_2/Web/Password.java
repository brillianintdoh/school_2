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
import kr.co.ourgram.school_2.Data;

@WebServlet("/password")
public class Password extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("mysql 클래스 에러: "+e);
        }
        res.setCharacterEncoding("UTF-8");
        PrintWriter out = res.getWriter();
        String seed = req.getParameter("seed");
        String password_1 = req.getParameter("password_1");
        String password_2 = new String(req.getParameter("password_2"));
        String new_password = req.getParameter("new_password");

        if(password_1 != null && password_1.equalsIgnoreCase(password_2)) {
            try {
                Connection conn = DriverManager.getConnection(Data.getUrl(), Data.getUser(), Data.getPass());
                String query_1 = "SELECT * FROM user WHERE username=?";
                PreparedStatement sql = conn.prepareStatement(query_1);
                String user_name = Data.getUsername(seed);
                sql.setString(1, user_name);
                ResultSet rs = sql.executeQuery();
                if(rs.next()) {
                    String password = rs.getString("pass");
                    if(password.equalsIgnoreCase(password_1)) {
                        String query_2 = "UPDATE user SET pass=? WHERE username=?";
                        sql = conn.prepareStatement(query_2);
                        sql.setString(1, new_password);
                        sql.setString(2, user_name);
                        sql.executeUpdate();
                        sql.close();
                        out.println("비밀번호 변경 완료 <p class='d-none' id='pass_ok'></p>");
                    }else {
                        out.println("원래 비번과 일치하지 않습니다");
                    }
                }
                sql.close();
                conn.close();
            } catch (SQLException e) {
                System.out.println("sql 에러: "+e);
            }
        }else {
            out.println("재입력 비번이 같지 않습니다");
        }
    }
}