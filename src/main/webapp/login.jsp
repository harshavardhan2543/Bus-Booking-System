<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

<style>

body{
    font-family:'Poppins',sans-serif;
    margin:0;
    background: linear-gradient(135deg,#0f2027,#203a43,#2c5364);
    min-height:100vh;
}

/* CARD STYLE */
.card{
    background:white;
    border-radius:15px;
    box-shadow:0 10px 30px rgba(0,0,0,0.3);
    padding:20px;
    transition:0.3s;
}

.card:hover{
    transform:translateY(-5px);
}

/* BUTTON */
.btn-main{
    background:linear-gradient(45deg,#4e73df,#1cc88a);
    border:none;
    color:white;
    padding:10px 20px;
    border-radius:8px;
    cursor:pointer;
}

.btn-main:hover{
    opacity:0.9;
}

</style>
<style>
body{
margin:0;
height:100vh;
background:linear-gradient(135deg,#2c3e50,#4e73df);
display:flex;
justify-content:center;
align-items:center;
font-family:'Segoe UI',sans-serif;
}

.card{
background:#ffffff;
width:360px;
padding:35px;
border-radius:18px;
box-shadow:0 20px 40px rgba(0,0,0,0.15);
}

h2{
text-align:center;
margin-bottom:25px;
color:#2c3e50;
font-weight:600;
}

input{
width:100%;
padding:12px;
margin-bottom:15px;
border-radius:10px;
border:1px solid #e3e6f0;
font-size:14px;
transition:0.2s;
}

input:focus{
outline:none;
border-color:#4e73df;
box-shadow:0 0 0 2px rgba(78,115,223,0.1);
}

.password-box{
position:relative;
}

.toggle{
position:absolute;
right:12px;
top:12px;
cursor:pointer;
font-size:13px;
color:#4e73df;
font-weight:500;
}

button{
width:100%;
padding:12px;
border-radius:25px;
border:none;
background-color:#4e73df;
color:white;
font-size:15px;
font-weight:600;
cursor:pointer;
}

button:hover{
background-color:#2e59d9;
}

.link{
text-align:center;
margin-top:15px;
font-size:14px;
}

.link a{
color:#4e73df;
text-decoration:none;
font-weight:500;
}

.error-msg{
background:#ffe6e6;
color:#e74a3b;
padding:10px;
border-radius:8px;
text-align:center;
margin-bottom:15px;
font-size:14px;
}
</style>
</head>

<body>

<div class="card">

<h2>Login</h2>

<%
String error = (String) request.getAttribute("errorMessage");
if(error != null){
%>

<div class="error-msg">
<%= error %>
</div>

<%
}
%>

<form action="<%=request.getContextPath()%>/login" method="post">

<input type="email" name="email" placeholder="Enter Email" required>

<div class="password-box">
<input type="password" id="loginPwd" name="password" placeholder="Enter Password" required>
<span class="toggle" onclick="toggleLogin()">Show</span>
</div>

<button type="submit">Login</button>

</form>

<div class="link">
New user?
<a href="register.jsp">Create Account</a>
</div>

</div>

<script>

function toggleLogin(){
let pwd=document.getElementById("loginPwd");

if(pwd.type==="password"){
pwd.type="text";
}else{
pwd.type="password";
}

}

</script>

</body>
</html>