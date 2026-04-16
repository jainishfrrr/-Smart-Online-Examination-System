<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login Page</title>
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

<h2>Online Quiz Login</h2>

<form action="login" method="post">
    Username: <input type="text" name="username" /><br><br>
    Password: <input type="password" name="password" /><br><br>
    <input type="submit" value="Login" />
</form>

<script>
document.querySelectorAll("input[type='submit']").forEach(btn => {
    btn.addEventListener("click", () => {
        btn.style.transform = "scale(0.95)";
    });
});
</script>

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