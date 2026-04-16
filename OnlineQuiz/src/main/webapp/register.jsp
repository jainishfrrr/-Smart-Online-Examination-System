<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>

    <title>Register</title>
    <link rel="stylesheet" href="style.css">
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
    <h2>Register - AJP Quiz</h2>
</div>

<div class="container">

<h2>Create Account</h2>

<form action="register" method="post">
    <input type="text" name="username" placeholder="Enter Username"><br>
    <input type="password" name="password" placeholder="Enter Password"><br>
    <input type="submit" value="Register">
</form>

<br>
<a href="index.jsp">Already have account? Login</a>

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