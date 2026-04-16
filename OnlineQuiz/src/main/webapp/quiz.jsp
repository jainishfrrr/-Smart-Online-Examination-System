<%@ page import="java.sql.*" %>
<%@ page import="com.quiz.db.DBConnection" %>

<%
    if(session.getAttribute("user") == null){
        response.sendRedirect("index.jsp");
    }

    String userFromCookie = "";

    Cookie[] cookies = request.getCookies();
    if(cookies != null){
        for(Cookie c : cookies){
            if(c.getName().equals("username")){
                userFromCookie = c.getValue();
            }
        }
    }

    Connection con = DBConnection.getConnection();
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM questions");
%>

<html>
<head>
<link rel="stylesheet" href="/OnlineQuiz/style.css">

<head>
<link rel="stylesheet" href="/OnlineQuiz/style.css">

<script>

// ALERT ONCE
if (!sessionStorage.getItem("shown")) {
    alert("Your time starts now ");
    sessionStorage.setItem("shown", "true");
}

// TIMER + PROGRESS BAR
let totalTime = 60;
let time = totalTime;

window.onload = function() {
    let x = setInterval(function(){

        document.getElementById("timer").innerHTML = "Time: " + time + " sec";

        // progress bar update
        let percent = (time / totalTime) * 100;
        document.getElementById("progress").style.width = percent + "%";

        time--;

        if(time < 0){
            clearInterval(x);
            alert("Time Over! Submitting...");
            document.forms[0].submit();
        }

    }, 1000);
};

// DISABLE RIGHT CLICK
document.addEventListener("contextmenu", e => e.preventDefault());

// TAB SWITCH ALERT
document.addEventListener("visibilitychange", function() {
    if (document.hidden) {
        alert("Don't switch tabs! ");
    }
});

</script>

</head>

</head>

<body>

<div id="loader">Loading...</div>

<script>
window.onload = function(){
    document.getElementById("loader").style.display = "none";
};
</script>

<script>
document.querySelectorAll("input[type='submit'], input[type='button']").forEach(btn => {
    btn.addEventListener("click", () => {
        btn.style.transform = "scale(0.95)";
    });
});
</script>

<div class="header">
    <h1>Government Engineering College, Modasa</h1>
    <h2>AJP Quiz</h2>
</div>

<div class="container">

<div id="progressBar">
    <div id="progress"></div>
</div>

<p id="timer" style="color:red; font-weight:bold;">Time: 60 sec</p>

<h3>Welcome <%= userFromCookie %>, your time starts now</h3>

<form action="result" method="post">

<%
    int i = 1;
    while(rs.next()){
%>

<div class="question">
    <p><%= i %>. <%= rs.getString("question") %></p>

    <label class="option">
        <input type="radio" name="q<%=i%>" value="<%= rs.getString("option1") %>">
        <%= rs.getString("option1") %>
    </label>

    <label class="option">
        <input type="radio" name="q<%=i%>" value="<%= rs.getString("option2") %>">
        <%= rs.getString("option2") %>
    </label>

    <label class="option">
        <input type="radio" name="q<%=i%>" value="<%= rs.getString("option3") %>">
        <%= rs.getString("option3") %>
    </label>

    <label class="option">
        <input type="radio" name="q<%=i%>" value="<%= rs.getString("option4") %>">
        <%= rs.getString("option4") %>
    </label>
</div>

<%
        i++;
    }
%>

<br>
<input type="submit" value="Submit Quiz">

</form>

</div>

<div class="footer">
    <b>Created by</b><br>
    Patel Jainishkumar<br>
    Patel Henilkumar<br>
    Patel Ayushaben<br>
    Patel Aryan<br>
    Patel Pratham
</div>
<script>
document.body.style.opacity = 0;

window.onload = function(){
    document.body.style.transition = "opacity 0.8s";
    document.body.style.opacity = 1;
};
</script>

<script>
document.querySelectorAll(".option").forEach(opt => {
    opt.addEventListener("click", function(){
        document.querySelectorAll(".option").forEach(o => o.style.background = "");
        this.style.background = "#cce5ff";
    });
});
</script>
<script>
document.querySelectorAll("input[type='submit']").forEach(btn => {
    btn.addEventListener("click", function(e){
        let ripple = document.createElement("span");
        ripple.style.position = "absolute";
        ripple.style.background = "rgba(255,255,255,0.5)";
        ripple.style.borderRadius = "50%";
        ripple.style.width = ripple.style.height = "100px";
        ripple.style.left = e.offsetX + "px";
        ripple.style.top = e.offsetY + "px";
        ripple.style.transform = "translate(-50%, -50%)";
        ripple.style.animation = "ripple 0.6s linear";

        this.appendChild(ripple);

        setTimeout(() => ripple.remove(), 600);
    });
});
</script>

</body>
</html>