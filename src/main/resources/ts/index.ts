import "./htmx";
import "htmx.org/dist/ext/ws";
import { main_htmx, main } from "./main";
import { writing_htmx, writing } from "./context/writing";
import { accounts_htmx } from "./user/accounts";
import { manager } from "./user/manager";
const main_page = document.getElementById("main_page") as HTMLElement;
const accounts_page = document.getElementById("accounts_page") as HTMLElement;
const manager_page = document.getElementById("manager_page") as HTMLElement;
const writing_page = document.getElementById("writing_page") as HTMLElement;
const user_name = document.getElementById("username") as HTMLInputElement;

document.addEventListener("htmx:afterOnLoad", async function(evt:any) {
    const user_out = document.getElementById("user_out") as HTMLElement;
    const login_ok = document.getElementById("login_ok") as HTMLElement;
    const accounts = document.getElementById("accounts") as HTMLElement;
    const evt_documet = evt.detail.elt as HTMLElement;
    if(login_ok) {
        if (Notification.permission !== 'granted') {
            alert('알림을 허용해주세요(사이트 설정에서 할수 있습니다)');
        }else {
            const username_login = document.getElementById("username_login") as HTMLInputElement;
            const username_mangaer = document.getElementById("username_manager") as HTMLInputElement;
            if(username_login) {
                const username = username_login.value;
                const manager = username_mangaer.value;
                (document.getElementById("login") as HTMLElement).innerHTML = "";
                const reg = await navigator.serviceWorker.register("/node/js/woker.js");
                const webpush = await reg.pushManager.subscribe({
                    applicationServerKey: "BCyzQ2r_YxmAoRn11Php0qzwvV951tG9T-pT3xB8Eloq6KGmHebDUPc9gPzE-2msxFjwZwhc3lEjvV31_MJM2xA",
                    userVisibleOnly: true,
                });
                await fetch("/node/push", {
                    method:"POST",
                    headers: {
                        "Content-Type":"application/json"
                    },
                    body: JSON.stringify({username, webpush, manager})
                });
            }else if(user_out) {
                const username = user_name.value;
                await fetch("/node/exit", {
                    method:"POST",
                    headers: {
                        "Content-Type":"application/json"
                    },
                    body: JSON.stringify({username})
                });
            }
            location.replace('https://ourgram.co.kr');
        }
    }else if(accounts) {
        location.href  = '/page/user';
    }

    if(main_page) {
        main_htmx(evt_documet);
    }else if(accounts_page) {
        accounts_htmx(evt_documet);
    }else if(writing_page) {
        writing_htmx(evt_documet);
    }
});

if(main_page) {
    main();
}else if(writing_page) {
    writing();
}else if(accounts_page) {
}else if(manager_page) {
    manager();
}