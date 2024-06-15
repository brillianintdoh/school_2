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
import jakarta.servlet.http.HttpSession;
import kr.co.ourgram.school_2.Check;
import kr.co.ourgram.school_2.Data;

@WebServlet("/login")
public class Login extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            req.setCharacterEncoding("UTF-8");
            res.setCharacterEncoding("UTF-8");
            PrintWriter out = res.getWriter();
            String user = req.getParameter("id");
            String pass = req.getParameter("pass");

            Connection conn = DriverManager.getConnection(Data.getUrl(), Data.getUser(), Data.getPass());
            String query = "SELECT * FROM user WHERE username=? AND pass=?";
            try(PreparedStatement sql = conn.prepareStatement(query)) {
                sql.setString(1, user);
                sql.setString(2, pass);
                ResultSet rs = sql.executeQuery();
                if(rs.next()) {
                    String seed = String.valueOf(Math.random());
                    HttpSession session = req.getSession();
                    session.setAttribute("seed", seed);

                    Data.setUsername(seed, user);
                    out.println("<button id='login_ok' class='w-100 mb-2 btn btn-lg rounded-3 btn-primary'>Login</button> <input type='hidden' id='username_login' value='"+user+"'> <input type='hidden' id='username_manager' value='"+Check.manager(seed)+"'>");
                }else {
                    out.println("<button class='w-100 mb-2 btn btn-lg rounded-3 btn-primary btn-danger'>비번 또는 아이디가 틀렸습니다</button>");
                }
            }
        }catch(ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}