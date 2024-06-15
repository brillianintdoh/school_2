export function manager() {
    const send_btn = document.getElementById("send_btn") as HTMLElement;
    send_btn.addEventListener("click", async function() {
        const user = document.getElementById("user") as HTMLInputElement;
        const tit = document.getElementById("title") as HTMLInputElement;
        const description = document.getElementById("description") as HTMLInputElement;
        const send_p = document.getElementById("send_p") as HTMLElement;
        
        const username = user.value;
        const title = tit.value;
        const body = description.value;

        const send = await fetch("/node/send", {
            method:"POST",
            headers: {
                "Content-Type":"application/json"
            },
            body: JSON.stringify({username, title, body})
        });
        const text = (await send.text()).toString();
        send_p.innerHTML = "상태: " + text;
        setTimeout(() => send_p.innerHTML = "상태:", 5000);
    });
}