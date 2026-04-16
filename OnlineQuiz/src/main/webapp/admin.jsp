<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Admin Panel</title>
    <link rel="stylesheet" href="style.css">
</head>
<script>
function confirmReset() {
    return confirm("Are you sure?\nThis will delete ALL results, leaderboard and history!");
}
</script>
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
    <h2>Admin Panel - Add Questions</h2>
</div>

<div class="container">

<h2>Add New Question</h2>

<%
if(request.getParameter("success") != null){
%>
<h3 style="color:green;">Question Added Successfully ✅</h3>
<%
}
%>

<form action="addQuestion" method="post">

    <input type="text" name="question" placeholder="Enter Question"><br>

    <input type="text" name="opt1" placeholder="Option 1"><br>
    <input type="text" name="opt2" placeholder="Option 2"><br>
    <input type="text" name="opt3" placeholder="Option 3"><br>
    <input type="text" name="opt4" placeholder="Option 4"><br>

    <input type="text" name="correct" placeholder="Correct Answer"><br>

    <input type="submit" value="Add Question">

</form>

</div>

<script>
document.body.style.opacity = 0;

window.onload = function(){
    document.body.style.transition = "opacity 0.8s";
    document.body.style.opacity = 1;
};
</script><script>
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

<h3>All Questions</h3>

<table border="1" style="margin:auto;">
<tr>
    <th>ID</th>
    <th>Question</th>
    <th>Action</th>
</tr>

<%@ page import="java.sql.*" %>
<%@ page import="com.quiz.db.DBConnection" %>

<%
Connection con = DBConnection.getConnection();
Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery("SELECT * FROM questions");

while(rs.next()){
%>

<tr>
    <td><%= rs.getInt("id") %></td>
    <td><%= rs.getString("question") %></td>
    <td>
        <a href="deleteQuestion?id=<%= rs.getInt("id") %>">
            <button>Delete ❌</button>
        </a>
    </td>
</tr>

<%
}
%>
</table>

<br><br>

<h3>System Control</h3>

<form action="reset" method="post" onsubmit="return confirmReset()">
    <input type="submit" value="Reset All Results 🔄">
</form>

<%
if(request.getParameter("reset") != null){
%>
<h3 style="color:red;">All Results Reset Successfully</h3>
<%
}
%>
<form action="reset" method="post">
    <input type="submit" value="Reset Exam ">
</form>

</body>
</html>