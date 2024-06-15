package kr.co.ourgram.school_2.Web.context;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import org.json.JSONObject;
import jakarta.websocket.OnClose;
import jakarta.websocket.OnError;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;
import kr.co.ourgram.school_2.Data;

@ServerEndpoint("/chat")
public class Chat {
    private static Set<Session> clients = Collections.synchronizedSet(new HashSet<>());

    @OnOpen
    public void open(Session sess) {
        clients.add(sess);
    }

    @OnClose
    public void close(Session sess) {
        clients.remove(sess);
    }

    @OnError
    public void error(Session sess, Throwable err) {
        System.out.println("!@! error: "+err.getMessage());
    }

    @OnMessage
    public void message(String mess, Session sess) throws IOException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        JSONObject json = new JSONObject(mess);
        String room_id = json.getString("room_id");
        String seed = json.getString("seed");
        String content = json.getString("content");
        String author = json.getString("author");
        String title = json.getString("title");
        try (Connection conn = DriverManager.getConnection(Data.getUrl(), Data.getUser(), Data.getPass())) {
            String query = "INSERT INTO chat(room_id, sender_id, content) VALUES (?,?,?)";
            PreparedStatement sql = conn.prepareStatement(query);
            sql.setString(1, room_id);
            sql.setString(2, Data.getID(seed));
            sql.setString(3, content);
            sql.executeUpdate();

            for(Session client : clients) {
                String send = "{ \"seed\" : \""+seed+"\" , \"room_id\": \""+room_id+"\", \"author\":\""+Data.getIDUsername(author)+"\", \"title\":\""+title+"\", \"content\":\""+content+"\" }";
                client.getBasicRemote().sendText(send);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}