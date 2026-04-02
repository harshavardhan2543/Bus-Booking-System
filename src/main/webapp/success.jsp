<%@ page contentType="text/html; charset=UTF-8" %>

<%
String seats = (String) session.getAttribute("seats");
String from = (String) session.getAttribute("from");
String to = (String) session.getAttribute("to");
String date = (String) session.getAttribute("date");
%>
<%= seats != null ? seats : "Not Available"%>

<!DOCTYPE html>
<html>
<head>
<title>Booking Confirmed</title>
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
<meta name="viewport" content="width=device-width, initial-scale=1">

<style>

body{
    margin:0;
    font-family:'Segoe UI',sans-serif;
    background: linear-gradient(135deg,#0f2027,#203a43,#2c5364);
    color:white;
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
}

/* CARD */
.card{
    background:white;
    color:black;
    padding:30px;
    border-radius:20px;
    width:320px;
    text-align:center;
    box-shadow:0 15px 35px rgba(0,0,0,0.3);
}

/* SUCCESS ICON */
.success-icon{
    font-size:50px;
    color:#28a745;
    margin-bottom:10px;
}

/* TITLE */
.title{
    font-size:22px;
    font-weight:600;
    margin-bottom:10px;
}

/* DETAILS */
.details{
    font-size:15px;
    margin:10px 0;
    color:#555;
}

/* SEATS BOX */
.seats{
    background:#f1f5ff;
    padding:10px;
    border-radius:10px;
    font-weight:600;
    color:#2c3e50;
    margin-top:10px;
}

/* BUTTON */
.btn{
    margin-top:20px;
    padding:10px 20px;
    border:none;
    border-radius:8px;
    background:#4e73df;
    color:white;
    cursor:pointer;
    font-size:14px;
}

.btn:hover{
    background:#2e59d9;
}

</style>

</head>

<body>

<div class="card">

<div class="success-icon">✅</div>

<div class="title">Booking Confirmed!</div>

<div class="details">
Your bus seats have been successfully booked.
</div>

<div class="details">
<b>Journey:</b> Hyderabad → Vijayawada
</div>

<div class="details">
<b>Date:</b> 20 March 2026
</div>

<div class="details">
<b>Seats:</b>
<div class="seats">
<%= seats %>
</div>
</div>

<button class="btn" onclick="window.location.href='dashboard.jsp'">
Go to Home
</button>

</div>

</body>
</html>