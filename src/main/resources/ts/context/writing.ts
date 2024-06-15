export function writing() {
    document.addEventListener("htmx:wsBeforeMessage", async function(message:any) {
        const mess = message.detail.message;
        if(mess == "new") {
            location.reload();
        }else {
            const seed = (document.getElementById("seed") as HTMLInputElement).value;
            const json = JSON.parse(mess) as { seed:string, room_id:string, author:string, title:string, content:string };
            if(json.seed == seed) {
                const chat_content = document.getElementById("chat_content") as HTMLInputElement;
                chat_content.value = "";
            }

            if(document.getElementById("chat_"+json.room_id)) {
                const chatBtn = document.getElementById("chatBtn_"+json.room_id) as HTMLButtonElement;
                const title = json.author+"님이 "+json.title+" 게시글에 답글을 달았습니다";
                await fetch("/node/send", {
                    method:"POST",
                    headers: {
                        "Content-Type":"application/json"
                    },
                    body:JSON.stringify({ username:json.author, title, body:json.content })
                });
                chatBtn.click();
            }
        }
    });
}

export async function writing_htmx(evt_documet:HTMLElement) {
    const title = (document.getElementById("title") as HTMLInputElement).value;
    const writing_form = document.getElementById("writer_form") as HTMLElement;
    const writing_ok = document.getElementById("writing_ok") as HTMLElement;
    const writer_ws = document.getElementById("writer_ws") as HTMLButtonElement;
    if(evt_documet == writing_form) {
        if(writing_ok) {
            await fetch("/node/send_all", {
                method:"POST",
                headers: {
                    "Content-Type":"application/json"
                },
                body: JSON.stringify({title})
            });
            writer_ws.click();
            location.reload();
        }
    }
}