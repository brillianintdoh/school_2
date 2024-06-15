package kr.co.ourgram.school_2;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

public class Data {
    private static String url = "null";
    private static String user = "null";
    private static String pass = "null";
    private static Map<String, String> username = new HashMap<>();

    private void init() {
        Properties prop = new Properties();
        try(InputStream stream = getClass().getResourceAsStream("/application.properties")) {
            prop.load(stream);
        }catch(IOException e) {
            e.printStackTrace();
        }
        url = prop.getProperty("dbUrl");
        user = prop.getProperty("dbUser");
        pass = prop.getProperty("dbPass");
    }

    public static void setUsername(String seed, String name) {
        username.put(seed, name);
    }

    public static void dropUsername(String seed) {
        username.remove(seed);
    }

    public static String getUsername(String seed) {
        if(!seed.equals("null")) {
            return username.get(seed);
        }
        return null;
    }

    public static String getIDUsername(String id) {
        String result = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(getUrl(), getUser(), getPass());
            String query = "SELECT * FROM user WHERE id=?";
            PreparedStatement sql = conn.prepareStatement(query);
            sql.setString(1, id);
            ResultSet rs = sql.executeQuery();
            if(rs.next()) {
                result = rs.getString("username");
            }
            sql.close();
            conn.close();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public static String getID(String seed) {
        String id = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(getUrl(), getUser(), getPass());
            String query = "SELECT * FROM user WHERE username=?";
            PreparedStatement sql = conn.prepareStatement(query);
            sql.setString(1, getUsername(seed));
            ResultSet rs = sql.executeQuery();
            if(rs.next()) {
                id = rs.getString("id");
            }
            sql.close();
            conn.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return id;
    }
    
    public static String getUrl() {
        if(url.equals("null")) {
            new Data().init();
        }
        return url;
    }

    public static String getUser() {
        if(user.equals("null")) {
            new Data().init();
        }
        return user;
    }

    public static String getPass() {
        if(pass.equals("null")) {
            new Data().init();
        }
        return pass;
    }
}