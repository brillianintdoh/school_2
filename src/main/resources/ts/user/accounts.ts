export function accounts_htmx(evt_documet:HTMLElement) {
    const pass_ok = document.getElementById("pass_ok") as HTMLElement;
    const pass_1 = document.getElementById("password_1") as HTMLInputElement;
    const pass_2 = document.getElementById("password_2") as HTMLInputElement;
    const pass_new = document.getElementById("new_password") as HTMLInputElement;
    if(pass_ok) {
        pass_1.value = "";
        pass_2.value = "";
        pass_new.value = "";
    }else {
        const pass_btn = document.getElementById("pass_btn") as HTMLElement;
        setTimeout(() => pass_btn.innerHTML = "변경", 2000);
    }
}