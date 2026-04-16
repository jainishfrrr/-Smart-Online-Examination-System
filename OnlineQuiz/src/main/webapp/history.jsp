<%@ page import="java.sql.*" %>
<%@ page import="com.quiz.db.DBConnection" %>

<%
    if(session.getAttribute("user") == null){
        response.sendRedirect("index.jsp");
    }

    String user = (String) session.getAttribute("user");

    Connection con = DBConnection.getConnection();
    PreparedStatement ps = con.prepareStatement(
        "SELECT * FROM result WHERE username=? ORDER BY exam_date DESC"
    );

    ps.setString(1, user);
    ResultSet rs = ps.executeQuery();
%>

<html>
<head>
    <title>My History</title>
    <link rel="stylesheet" href="/OnlineQuiz/style.css">
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
    <h2>My Result History</h2>
</div>

<div class="container">

<h2>User: <%= user %></h2>

<table border="1" style="margin:auto; width:80%; text-align:center;">
<tr>
    <th>Attempt</th>
    <th>Score</th>
    <th>Date</th>
</tr>

<%
    int count = 1;
    while(rs.next()){
%>

<tr>
    <td><%= count %></td>
    <td><%= rs.getInt("score") %></td>
    <td><%= rs.getTimestamp("exam_date") %></td>
</tr>

<%
        count++;
    }
%>

</table>

<br>

<a href="quiz.jsp">
    <input type="button" value="Back to Quiz">
</a>

</div>

<script>
document.body.style.opacity = 0;

window.onload = function(){
    document.body.style.transition = "opacity 0.8s";
    document.body.style.opacity = 1;
};
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