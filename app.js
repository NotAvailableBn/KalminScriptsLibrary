(function(){
"use strict";
/* ---------- default config (override with /config.json or the admin page) ---------- */
var DEF={
 hcaptcha:"", /* paste your hCaptcha site key here or in /adminpg; empty = captcha gate is skipped */
 script:'loadstring(game:HttpGet("https://kalmin.kdns.fr/script.lua"))()',
 lvId:"10419982",
 verifyUrl:"", /* optional: your server endpoint that checks the Linkvertise hash with the anti-bypass token */
 discordInvite:"u5XmnW6Vkq",
 social:{discord:"https://discord.gg/u5XmnW6Vkq",support:"https://discord.gg/XAyxW74BsY",youtube:"https://www.youtube.com/channel/UCj_-Y0AkXIHnr4AiaJV8d9g"},
 games:[
  {n:"Rivals",u:"https://www.roblox.com/discover?Keyword=Rivals",s:"current"},
  {n:"Granny",u:"https://www.roblox.com/discover?Keyword=Granny",s:"current"},
  {n:"Flick",u:"https://www.roblox.com/discover?Keyword=Flick",s:"current"}],
 execs:[
  {n:"Madium (Pc)",s:"green"},{n:"Real (Pc)",s:"green"},{n:"Volt (Pc)",s:"green"},
  {n:"Velocity (Pc)",s:"yellow"},{n:"Bunni (Pc)",s:"yellow"},{n:"Yub-X (Pc)",s:"yellow"},{n:"Lynx (Pc)",s:"yellow"},{n:"Lucid (Pc)",s:"yellow"},{n:"Patassium (Pc)",s:"yellow"},{n:"Xeno (Pc)",s:"yellow"},{n:"Solara (Pc)",s:"yellow"},{n:"Nexomia (Pc)",s:"yellow"},{n:"SirHurt (Pc)",s:"yellow"},{n:"Seliware (Pc)",s:"yellow"},{n:"Delta (Mobile)",s:"yellow"},{n:"Opiumware (Mac)",s:"yellow"}],
 tutorials:[], /* {p:"YouTube",t:"How To Get Key",u:"https://youtube.com/watch?v=ID"} */
 terms:"Terms of Service\n\nEdit this text from /adminpg.",
 privacy:"Privacy Policy\n\nEdit this text from /adminpg.",
 pw:"888e68c26069c0c2476e3ec130084fd2057c2c0f95f061ed82d6bef4371a6bf6" /* SHA-256 of default password: kalmin-admin */
};
var cfg=JSON.parse(JSON.stringify(DEF));
var T={ /* tiny translation table; English is the fallback */
 es:{dash:"Panel",tut:"Tutorial",games:"Juegos",exec:"Ejecutores",copy:"© 2026 Kalmin. Todos los derechos reservados.",disc:"Kalmin no está afiliado, respaldado ni patrocinado por Roblox Corporation. Roblox es una marca registrada de Roblox Corporation.",com:"Comunidad",soc:"Social",leg:"Legal",terms:"Términos de servicio",priv:"Política de privacidad"},
 fr:{dash:"Tableau de bord",tut:"Tutoriel",games:"Jeux",exec:"Exécuteurs",copy:"© 2026 Kalmin. Tous droits réservés.",disc:"Kalmin n'est ni affilié, ni approuvé, ni parrainé par Roblox Corporation. Roblox est une marque déposée de Roblox Corporation.",com:"Communauté",soc:"Social",leg:"Légal",terms:"Conditions d'utilisation",priv:"Politique de confidentialité"},
 de:{dash:"Dashboard",tut:"Anleitung",games:"Spiele",exec:"Executors",copy:"© 2026 Kalmin. Alle Rechte vorbehalten.",disc:"Kalmin steht in keiner Verbindung zur Roblox Corporation. Roblox ist eine eingetragene Marke der Roblox Corporation.",com:"Community",soc:"Soziales",leg:"Rechtliches",terms:"Nutzungsbedingungen",priv:"Datenschutz"},
 pt:{dash:"Painel",tut:"Tutorial",games:"Jogos",exec:"Executores",copy:"© 2026 Kalmin. Todos os direitos reservados.",disc:"A Kalmin não é afiliada, endossada ou patrocinada pela Roblox Corporation. Roblox é marca registrada da Roblox Corporation.",com:"Comunidade",soc:"Social",leg:"Legal",terms:"Termos de Serviço",priv:"Política de Privacidade"}
};
var lang=localStorage.getItem("kl_lang")||"en";
function t(k,d){return (T[lang]&&T[lang][k])||d}
function esc(s){return String(s==null?"":s).replace(/[&<>"']/g,function(c){return {"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;","'":"&#39;"}[c]})}
function $(s){return document.querySelector(s)}
var app=$("#app"),savedSnap="",autoFn=null;

/* ---------- helpers ---------- */
function sha(s){return crypto.subtle.digest("SHA-256",new TextEncoder().encode(s)).then(function(b){return Array.from(new Uint8Array(b)).map(function(x){return x.toString(16).padStart(2,"0")}).join("")})}
function merge(a,b){for(var k in b){if(b[k]&&typeof b[k]==="object"&&!Array.isArray(b[k])){a[k]=merge(a[k]||{},b[k])}else a[k]=b[k]}return a}
function saveLocal(){localStorage.setItem("kl_cfg",JSON.stringify(cfg))}

/* ---------- theme ---------- */
function setTheme(m){document.documentElement.dataset.theme=m;$("#theme").textContent=m==="dark"?"☾":"☀";localStorage.setItem("kl_theme",m)}
setTheme(localStorage.getItem("kl_theme")||"dark");
$("#theme").onclick=function(){setTheme(document.documentElement.dataset.theme==="dark"?"light":"dark")};
$("#burger").onclick=function(){var o=$("#links").classList.toggle("open");this.classList.toggle("open",o);this.setAttribute("aria-expanded",o)};
$("#lang").value=lang;
$("#lang").onchange=function(){lang=this.value;localStorage.setItem("kl_lang",lang);chrome();route()};

/* ---------- nav + footer text ---------- */
function chrome(){
 document.querySelectorAll("[data-k]").forEach(function(e){if(!e.dataset.d)e.dataset.d=e.textContent;e.textContent=t(e.dataset.k,e.dataset.d)});
 var s=cfg.social;
 $("#fc").innerHTML='<div><h4>'+t("com","Community")+'</h4><a href="'+esc(s.discord)+'" target="_blank" rel="noopener">Discord</a><a href="'+esc(s.support)+'" target="_blank" rel="noopener">Support</a></div>'+
 '<div><h4>'+t("soc","Social")+'</h4><a href="'+esc(s.youtube)+'" target="_blank" rel="noopener">YouTube</a></div>'+
 '<div><h4>'+t("leg","Legal")+'</h4><a href="/terms" data-l>'+t("terms","Terms Of Service")+'</a><a href="/privacy" data-l>'+t("priv","Privacy Policy")+'</a></div>';
}

/* ---------- pages ---------- */
function dash(){
 app.innerHTML='<section class="glass hero"><h1>Kalmin <b>Hub</b></h1><h2>Go Beyond with <b>Kalmin</b>.</h2><div class="btns"><button class="btn p" id="gs">Get Script</button><a class="btn" href="/tutorials" data-l>'+t("tut","Tutorial")+'</a></div></section>'+
 '<div class="grid"><div class="glass card"><div class="n" id="vc">—</div><small>Website visitors</small></div><div class="glass card"><div class="n" id="dc">—</div><small>Discord members</small></div></div>';
 $("#gs").onclick=function(){
  var back=location.origin+"/getscript";
  var rnd=Math.floor(Math.random()*1e5);
  location.href="https://link-to.net/"+encodeURIComponent(cfg.lvId)+"/"+rnd+"/dynamic?r="+btoa(encodeURI(back));
 };
 var seen=localStorage.kl_v==="1";function vis(m){return fetch("https://abacus.jasoncameron.dev/"+m+"/kalmin.kdns.fr/visits").then(function(r){return r.json()})}
 vis(seen?"get":"hit").then(function(j){if(typeof j.value!=="number")throw 0;localStorage.kl_v="1";$("#vc").textContent=j.value.toLocaleString()}).catch(function(){if(seen)vis("hit").then(function(j){if(typeof j.value==="number")$("#vc").textContent=j.value.toLocaleString()}).catch(function(){})});
 fetch("https://discord.com/api/v9/invites/"+encodeURIComponent(cfg.discordInvite)+"?with_counts=true").then(function(r){return r.json()}).then(function(j){if(j.approximate_member_count)$("#dc").textContent=j.approximate_member_count.toLocaleString()}).catch(function(){});
}
function getscript(){
 var p=new URLSearchParams(location.search),h=p.get("hash"),ok=sessionStorage.kl_ok==="1";
 function show(){sessionStorage.kl_ok="1";app.innerHTML='<section class="glass card"><h3 class="t">Your Script</h3><pre class="code" id="sc">'+esc(cfg.script)+'</pre><button class="btn p" id="cp">Copy Script</button></section>';
  $("#cp").onclick=function(){var b=this;navigator.clipboard.writeText(cfg.script).then(function(){b.textContent="Copied ✓";setTimeout(function(){b.textContent="Copy Script"},1800)})}}
 function deny(m){app.innerHTML='<section class="glass card"><h3 class="t">Checkpoint required</h3><p class="empty">'+m+'</p><a class="btn p" href="/" data-l>Back to Dashboard</a></section>'}
 if(h){
  history.replaceState(null,"","/getscript");
  if(cfg.verifyUrl){var u=cfg.verifyUrl.indexOf("{hash}")>-1?cfg.verifyUrl.replace("{hash}",encodeURIComponent(h)):cfg.verifyUrl+(cfg.verifyUrl.indexOf("?")>-1?"&":"?")+"hash="+encodeURIComponent(h);
   fetch(u).then(function(r){return r.text()}).then(function(x){var v=x.trim(),j=null;try{j=JSON.parse(v)}catch(e){}
    var bad=/^false$/i.test(v)||(j&&(j.valid===false||j.status===false||j.success===false));bad?deny("Verification failed. Please complete the checkpoint again."):show()}).catch(function(){show()})}
  else show();
 } else if(ok)show(); else deny("Complete the Linkvertise checkpoint from the dashboard to get the script.");
}
function tuts(){
 var h='<h3 class="t">Tutorials</h3>';
 if(!cfg.tutorials.length)h+='<div class="glass card"><p class="empty">No tutorials are currently available.</p></div>';
 else h+='<div class="grid">'+cfg.tutorials.map(function(x){
  var m=String(x.u).match(/(?:v=|youtu\.be\/)([\w-]{11})/),th=m?'style="background-image:url(https://img.youtube.com/vi/'+m[1]+'/hqdefault.jpg)"':"";
  return '<div class="glass card"><div class="tag">'+esc(x.p)+'</div><h3 style="font-weight:700;margin-top:6px">'+esc(x.t)+'</h3><a class="vid" '+th+' href="'+esc(x.u)+'" target="_blank" rel="noopener" aria-label="Watch"></a></div>'}).join("")+'</div>';
 app.innerHTML=h;
}
function sec(cls,title,items,fn,empty){return '<div class="sec"><span class="dot '+cls+'"></span>'+title+'</div><div class="list">'+(items.length?items.map(fn).join(""):'<div class="glass row"><span class="empty">'+empty+'</span></div>')+'</div>'}
function games(){
 var g=cfg.games,row=function(x){return '<div class="glass row"><span>'+esc(x.n)+'</span>'+(x.u&&x.s!=="retired"?'<a href="'+esc(x.u)+'" target="_blank" rel="noopener">View Game</a>':'')+'</div>'};
 app.innerHTML='<h3 class="t">Kalmin Supported Games</h3>'+
  sec("green","Current Supported Games",g.filter(function(x){return x.s==="current"}),row,"[Not Available Yet]")+
  sec("black","To Be Supported Soon Games",g.filter(function(x){return x.s==="soon"}),row,"[Not Available Yet]")+
  sec("red","Retired Games",g.filter(function(x){return x.s==="retired"}),row,"[Not Available Yet]");
}
function execs(){
 var e=cfg.execs,row=function(x){var l=x.s==="red"?"":(x.w?'<a href="'+esc(x.w)+'" target="_blank" rel="noopener">View Website</a>':"")+(x.d?'<a href="'+esc(x.d)+'" target="_blank" rel="noopener">Discord</a>':"");return '<div class="glass row"><span>'+esc(x.n)+'</span><span class="lk">'+l+'</span></div>'};
 app.innerHTML='<h3 class="t">Kalmin Supported Executors</h3>'+
  sec("green","Supported",e.filter(function(x){return x.s==="green"}),row,"[Not Available Yet]")+
  sec("yellow","Unknown",e.filter(function(x){return x.s==="yellow"}),row,"[Not Available Yet]")+
  sec("red","Not Supported",e.filter(function(x){return x.s==="red"}),row,"[Not Available Yet]");
}
function md(s){var x=function(a){return a.replace(/`([^`]+)`/g,"<code>$1</code>").replace(/\*\*([^*]+)\*\*/g,"<b>$1</b>").replace(/__([^_]+)__/g,"<u>$1</u>").replace(/(^|[^*])\*([^*\n]+)\*/g,"$1<i>$2</i>").replace(/~~([^~]+)~~/g,"<s>$1</s>")};
 return esc(s).split(/\r?\n/).map(function(l){var m=l.match(/^(#{1,3}) (.*)$/);return m?"<h"+m[1].length+">"+x(m[2])+"</h"+m[1].length+">":l.trim()?"<p>"+x(l)+"</p>":"<br>"}).join("")}
function doc(k,title){app.innerHTML='<h3 class="t">'+title+'</h3><div class="glass doc">'+md(cfg[k])+'</div>'}

/* ---------- admin ---------- */
function admin(){
 if(sessionStorage.kl_adm!=="1"){
  app.innerHTML='<section class="glass card" style="max-width:380px;margin:40px auto"><h3 class="t">Admin</h3><input type="password" id="pw" placeholder="Password" autocomplete="current-password"><div class="btns"><button class="btn p" id="li">Login</button></div><p class="empty" id="er"></p></section>';
  var go=function(){sha($("#pw").value).then(function(x){if(x===cfg.pw){sessionStorage.kl_adm="1";admin()}else $("#er").textContent="Wrong password."})};
  $("#li").onclick=go;$("#pw").onkeydown=function(e){if(e.key==="Enter")go()};return;
 }
 var F=function(label,path,area){return '<label>'+label+'</label>'+(area?'<textarea rows="6" data-p="'+path+'">':'<input data-p="'+path+'" value="')+esc(get(path))+(area?'</textarea>':'">')};
 var PH={n:"Name",u:"Game link",w:"Website link",d:"Discord link",p:"Platform",t:"Title"};
 var L=function(title,key,fields,opts){return '<h4>'+title+'</h4><div data-list="'+key+'">'+cfg[key].map(function(x,i){return '<div class="ar">'+fields.map(function(f){if(f==="s")return '<select data-i="'+i+'" data-f="s">'+opts.map(function(o){return '<option'+(x.s===o?' selected':'')+'>'+o+'</option>'}).join("")+'</select>';var off=(key==="games"&&f==="u"&&x.s==="retired")||(key==="execs"&&(f==="w"||f==="d")&&x.s==="red");return '<input data-i="'+i+'" data-f="'+f+'" placeholder="'+(off?"Disabled for this status":(key==="tutorials"&&f==="u"?"Video link":PH[f]))+'" value="'+(off?"":esc(x[f]))+'"'+(off?" disabled":"")+'>'}).join("")+'<button data-del="'+key+':'+i+'">✕</button></div>'}).join("")+'</div><button class="btn" data-add="'+key+'">+ Add</button>'};
 app.innerHTML='<section class="glass card adm"><h3 class="t">Admin panel</h3>'+
  F("hCaptcha site key","hcaptcha")+F("Script (shown after checkpoint)","script",1)+F("Linkvertise publisher ID","lvId")+F("Verify endpoint (server that checks the anti-bypass token, optional)","verifyUrl")+F("Discord invite code (for member count)","discordInvite")+
  F("Discord link","social.discord")+F("Discord support link","social.support")+F("YouTube link","social.youtube")+
  L("Games (name · status · link; retired has no link)","games",["n","s","u"],["current","soon","retired"])+
  L("Executors (name · status · website · discord; red shows no links)","execs",["n","s","w","d"],["green","yellow","red"])+
  L("Tutorials (platform · title · video link)","tutorials",["p","t","u"])+
  F("Terms of Service","terms",1)+F("Privacy Policy","privacy",1)+
  '<label>New admin password (leave empty to keep)</label><input type="password" id="np">'+
  '<div class="btns"><button class="btn p" id="sv">Save in this browser</button><button class="btn" id="cc">Copy config.json</button><button class="btn" id="dl">Download config.json</button><button class="btn" id="rs">Reset local copy</button><button class="btn" id="lo">Logout</button></div>'+
  '<p class="empty" id="ms">Visitors only see changes after you upload the downloaded config.json next to index.html.</p></section>';
 var root=app;
 function sync(){root.querySelectorAll("[data-p]").forEach(function(e){set(e.dataset.p,e.value)});root.querySelectorAll("[data-i]").forEach(function(e){var l=e.closest("[data-list]").dataset.list;cfg[l][e.dataset.i][e.dataset.f]=e.value})}
 root.onclick=function(e){var b=e.target;
  if(b.dataset.add){sync();cfg[b.dataset.add].push(b.dataset.add==="games"?{n:"",u:"",s:"current"}:b.dataset.add==="execs"?{n:"",s:"yellow",w:"",d:""}:{p:"YouTube",t:"",u:""});admin()}
  if(b.dataset.del){sync();var d=b.dataset.del.split(":");cfg[d[0]].splice(+d[1],1);admin()}};
 root.onchange=function(e){if(e.target.dataset.f==="s"){sync();cfg.games.forEach(function(x){if(x.s==="retired")x.u=""});cfg.execs.forEach(function(x){if(x.s==="red"){x.w="";x.d=""}});auto(true);admin()}};
 var msg=$("#ms"),hint=msg.textContent,tm,at;
 function flash(x,ms){msg.textContent=x;clearTimeout(tm);tm=setTimeout(function(){msg.textContent=hint},ms)}
 function auto(quiet){sync();var j=JSON.stringify(cfg);if(j!==savedSnap){saveLocal();savedSnap=j;if(!quiet)flash("Auto-saved",1000)}}
 autoFn=auto;
 root.oninput=function(e){if(e.target.id==="np")return;clearTimeout(at);at=setTimeout(function(){auto()},800)};
 function prep(cb){sync();var np=$("#np").value;(np?sha(np).then(function(h){cfg.pw=h;$("#np").value=""}):Promise.resolve()).then(cb)}
 $("#sv").onclick=function(){prep(function(){var j=JSON.stringify(cfg);if(j===savedSnap){flash("Already saved",1000);return}saveLocal();savedSnap=j;chrome();flash("Saved ✓",1500)})};
 $("#cc").onclick=function(){var b=this;prep(function(){var q=JSON.stringify(cfg,null,1),ok=function(){b.textContent="Copied ✓";setTimeout(function(){b.textContent="Copy config.json"},1800)};navigator.clipboard?navigator.clipboard.writeText(q).then(ok,function(){prompt("Copy:",q)}):prompt("Copy:",q)})};
 $("#dl").onclick=function(){prep(function(){var a=document.createElement("a");a.href=URL.createObjectURL(new Blob([JSON.stringify(cfg,null,1)],{type:"application/json"}));a.download="config.json";a.click()})};
 $("#rs").onclick=function(){localStorage.removeItem("kl_cfg");location.reload()};
 $("#lo").onclick=function(){sessionStorage.kl_adm="0";admin()};
}
function get(p){return p.split(".").reduce(function(o,k){return o[k]},cfg)}
function set(p,v){var a=p.split("."),o=cfg;while(a.length>1)o=o[a.shift()];o[a[0]]=v}

/* ---------- router ---------- */
var R={"/":dash,"/tutorials":tuts,"/games":games,"/executers":execs,"/getscript":getscript,"/terms":function(){doc("terms","Terms Of Service")},"/privacy":function(){doc("privacy","Privacy Policy")},"/adminpg":admin};
var rt,first=true;
function route(){
 var p=location.pathname.replace(/\/index\.html$/,"/").replace(/(.)\/$/,"$1");
 var f=R[p]||dash;
 autoFn=null;
 document.querySelectorAll(".links a").forEach(function(a){a.classList.toggle("on",a.getAttribute("href")===p)});
 $("#links").classList.remove("open");$("#burger").classList.remove("open");$("#burger").setAttribute("aria-expanded","false");
 clearTimeout(rt);
 var go=function(){window.scrollTo(0,0);app.className="";void app.offsetWidth;app.className="page";f()};
 if(first||!app.firstChild){first=false;go()}
 else{app.className="out";rt=setTimeout(go,200)}
}
document.addEventListener("click",function(e){var a=e.target.closest("a[data-l]");if(a){e.preventDefault();history.pushState(null,"",a.getAttribute("href"));chrome();route()}});
window.addEventListener("popstate",route);
window.addEventListener("beforeunload",function(){autoFn&&autoFn(true)});
window.addEventListener("pagehide",function(){autoFn&&autoFn(true)});
document.addEventListener("visibilitychange",function(){if(document.hidden&&autoFn)autoFn(true)});

/* ---------- hCaptcha gate ---------- */
function gate(){
 if(sessionStorage.kl_h==="1"||!cfg.hcaptcha){$("#gate").remove();return}
 var n=0,iv=setInterval(function(){
  if(window.hcaptcha){clearInterval(iv);hcaptcha.render("hc",{sitekey:cfg.hcaptcha,theme:document.documentElement.dataset.theme,callback:function(){sessionStorage.kl_h="1";var g=$("#gate");g.style.transition="opacity .6s";g.style.opacity=0;setTimeout(function(){g.remove()},600)}})}
  else if(++n>100){clearInterval(iv);$("#hc").textContent="Could not load hCaptcha. Disable blockers and refresh."}
 },100);
}

/* ---------- boot ---------- */
fetch("/config.json",{cache:"no-store"}).then(function(r){return r.ok?r.json():{}}).catch(function(){return {}}).then(function(j){
 merge(cfg,j);
 try{var l=JSON.parse(localStorage.getItem("kl_cfg")||"null");if(l)merge(cfg,l)}catch(e){}
 savedSnap=JSON.stringify(cfg);chrome();route();gate();
});
})();
