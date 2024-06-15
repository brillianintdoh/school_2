export function main() {
    const login_button = document.getElementById("login_button") as HTMLElement;

    if(login_button) {
        login_button.addEventListener("click", function() {
            if (!window.Notification) {
                Notification.requestPermission();
            }
        });
    }
}

export async function main_htmx(evt_documet:HTMLElement) {
    // 로그인 폼
    const login_form = document.getElementById("login_form") as HTMLElement;
    const login_btn = document.getElementById("login") as HTMLElement;

    // 회원 가입폼
    const sing_form = document.getElementById("sing_form") as HTMLElement;
    const sing_btn = document.getElementById("sing_btn") as HTMLElement;
    const sing_ok = document.getElementById("sing_ok") as HTMLElement;

    const context = document.getElementById("context") as HTMLElement;
    if(evt_documet == login_form) {
        setTimeout(() => login_btn.innerHTML = "<button class='w-100 mb-2 btn btn-lg rounded-3 btn-primary'>Login</button>", 2000);
    }else if(evt_documet == sing_form) {
        if(!sing_ok) {
            setTimeout(() => sing_btn.innerHTML = "<button class='w-100 mb-2 btn btn-lg rounded-3 btn-primary'>보내기</button>", 2000);
        }else {
            await fetch("/node/send_all", {
                method:"POST",
                headers: {
                    "Content-Type":"application/json"
                },
                body: JSON.stringify({})
            });
            location.reload();
        }
    }else if(context) {
        location.href  = '/page/context';
    }
}