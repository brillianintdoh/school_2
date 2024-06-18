import { config } from "dotenv";
import web from 'web-push';
import express from 'express';
import path from 'path';
const loginUser:Map<string, { webpush:web.PushSubscription, manager:boolean }> = new Map();
const app = express();

config();
const gcm = process.env.GCM as string;
const vapid = {
    public:process.env.PUBLIC as string,
    private:process.env.PRIVATE as string
};

web.setGCMAPIKey(gcm);
web.setVapidDetails("mailto:palanghwi@gmail.com", vapid.public, vapid.private);

app.use(express.static(path.join(__dirname, './web-push')), express.json());
app.post('//push', (req, res) => {
  const { username, webpush, manager } = req.body;
  if(!loginUser.get(username)) {
    loginUser.set(username, { webpush:webpush, manager:manager });
    res.send("성공");
    console.log(username+"님 로그인 하셨습니다");
  }else {
    res.send("그런 유저가 로그인되어있지 않습니다");
  }
});

app.post("//send", function(req, res) {
  const { username, title, body } = req.body;
  const user = loginUser.get(username);
  if(user) {
    const message = JSON.stringify({ title:title, body: body });
    web.sendNotification(user.webpush , message)
    .then(() => {
      res.send("성공");
    })
    .catch(err => {
      console.error('푸시 알림 전송 오류:', err);
      res.status(500).send('푸시 알림 전송 실패');
    });
  }else {
    res.send("그런 유저가 로그인되어있지 않습니다");
  }
});

app.post("//send_all", function(req, res) {
  const { title } = req.body;
  if(!title) {
    const message = JSON.stringify({ title:"새로운 유저!!", body:"새로운 유저가 인증요청을 보냈습니다" });
    loginUser.forEach((user) => {
      if(user.manager) {
        web.sendNotification(user.webpush, message)
        .catch(err => {
          console.error('푸시 알림 전송 오류:', err);
          res.status(500).send('푸시 알림 전송 실패');
        });
      }
    });
  }else {
    const message = JSON.stringify({ title:"새로운 게시글이 올라왔습니다", body:"게시글 "+title+"이 추가되었습니다" });
    loginUser.forEach((user) => {
      web.sendNotification(user.webpush, message)
      .catch(err => {
        console.error('푸시 알림 전송 오류:', err);
        res.status(500).send('푸시 알림 전송 실패');
      });
    });
  }
  res.send("성공");
});

app.post("//exit", function(req,res) {
  const { username } = req.body;
  loginUser.delete(username);
  console.log(username+"님 로그아웃 하셨습니다");
  res.send("성공");
});

app.listen(8070, () => {
  console.log("웹 푸시 서버 실행됨");
});