package kr.co.ourgram.school_2.Web.context;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import jakarta.websocket.OnClose;
import jakarta.websocket.OnError;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;

@ServerEndpoint("/writer")
public class Writer {
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
        System.out.println("!@! 에러: "+err.getMessage());
    }

    @OnMessage
    public void message(String mess, Session sess) throws IOException {
        for(Session client : clients) {
            if(sess != client) {
                client.getBasicRemote().sendText("new");
            }
        }
    }
}