package kr.co.ourgram.school_2;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Check {

    public static boolean manager(String seed) {
        String username = Data.getUsername(seed);
        boolean result = false;
        try (Connection conn = DriverManager.getConnection(Data.getUrl(), Data.getUser(), Data.getPass())) {
            String query = "SELECT * FROM user WHERE username=?";
            PreparedStatement sql = conn.prepareStatement(query);
            sql.setString(1, username);
            ResultSet rs = sql.executeQuery();
            if(rs.next()) {
                String right = rs.getString("manager");
                if(right.equals("1")) {
                    result = true;
                }
            }
            sql.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public static boolean checkParam(String data) {
        return (data == null || "null".equals(data) || "".equals(data));
    }

    public static String username(String id) {
        String result = null;
        try (Connection conn = DriverManager.getConnection(Data.getUrl(), Data.getUser(), Data.getPass())) {
            String query = "SELECT username FROM writing JOIN user ON writing.author = user.id WHERE writing.id = ?;";
            PreparedStatement sql = conn.prepareStatement(query);
            sql.setString(1, id);
            ResultSet rs = sql.executeQuery();
            if(rs.next()) {
                result = rs.getString("username");
            }
            sql.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
}