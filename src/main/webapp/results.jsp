<%@ page import="java.util.*" %>
<%@ page import="java.time.*" %>
<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String username = (String) session.getAttribute("username");
if(username == null){
    response.sendRedirect("login.jsp");
    return;
}

/* ROUTE DATA */
String fromCity = (String) request.getAttribute("fromCity");
String toCity = (String) request.getAttribute("toCity");
String date = (String) request.getAttribute("journeyDate");

String day = "";

if(date != null){
    LocalDate d = LocalDate.parse(date);
    day = d.getDayOfWeek().toString();
}

@SuppressWarnings("unchecked")
List<Map<String,String>> busList = (List<Map<String,String>>) request.getAttribute("busList");
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Available Buses</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
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

body {
    margin:0;
    padding:0;
    font-family:'Segoe UI',sans-serif;
    background: linear-gradient(135deg,#0f2027,#203a43,#2c5364);
    min-height:100vh;
    color:white;
}

.top-bar{
    padding:25px 0;
}

.content-wrapper{
    display:flex;
    justify-content:center;
}

.content-box{
    width:100%;
    max-width:800px;
    background:white;
    color:black;
    padding:30px;
    border-radius:18px;
    box-shadow:0 15px 35px rgba(0,0,0,0.25);
}

.route-header{
    margin-bottom:25px;
}

.route-title{
    font-size:22px;
    font-weight:600;
}

.route-date{
    color:#666;
    font-size:14px;
}

.bus-card{
    border:1px solid #e3e6f0;
    border-radius:12px;
    padding:20px;
    margin-bottom:20px;
    transition:0.2s;
}

.bus-card:hover{
    box-shadow:0 5px 15px rgba(0,0,0,0.1);
}

.bus-name{
    font-weight:600;
    color:#2c3e50;
}

.price{
    font-weight:600;
    color:#4e73df;
    font-size:18px;
}

.book-btn{
    background-color:#4e73df;
    border:none;
    color:white;
}

.book-btn:hover{
    background-color:#2e59d9;
}

</style>

</head>

<body>

<div class="container">

<div class="top-bar d-flex justify-content-between align-items-center">

<h5>
<i class="bi bi-bus-front-fill"></i> Sahasrima Travels
</h5>

<div>
Welcome, <%= username %>
</div>

</div>

<div class="content-wrapper">

<div class="content-box">

<!-- ROUTE HEADER -->
<div class="route-header">

<div class="route-title">
<%= fromCity %> → <%= toCity %>
</div>

<div class="route-date">
<%= day %>, <%= date %>
</div>

<p style="font-size:12px;color:gray;margin-top:5px;">
Food halts are dynamically generated based on journey timing
</p>

</div>

<!-- BUS LIST -->

<%
if(busList == null || busList.isEmpty()){
%>

<div class="alert alert-warning text-center">
No buses available for selected route.
</div>

<%
}else{

for(Map<String,String> bus : busList){

double price = Double.parseDouble(bus.get("price"));
%>

<div class="bus-card">

<div class="d-flex justify-content-between align-items-center">

<div>

<div class="bus-name">
<%= bus.get("name") %>
</div>

<div class="text-muted">

🕒 Departure: <b>
<%= bus.get("departure") != null ? bus.get("departure") : "-" %>
</b> <br>

🏁 Arrival: <b>
<%= bus.get("arrival") != null ? bus.get("arrival") : "-" %>
</b> <br>

🚍 Type: <%= bus.get("type") %> |

💺 <span style="color:red;font-weight:bold;">
<%= bus.get("seats") %> seats left
</span>

</div>

<div class="text-muted mt-2">
🍽️ <b><%= bus.get("halts") %></b>
</div>

</div>

<div class="text-end">

<div class="price">
₹ <%= (int)price %>
</div>

<!-- BOOK NOW FORM -->
<form action="booking.jsp" method="post">

<input type="hidden" name="name" value="<%= bus.get("name") %>">
<input type="hidden" name="type" value="<%= bus.get("type") %>">
<input type="hidden" name="price" value="<%= bus.get("price") %>">
<input type="hidden" name="halts" value="<%= bus.get("halts") %>">
<input type="hidden" name="from" value="<%= request.getAttribute("fromCity") %>">
<input type="hidden" name="to" value="<%= request.getAttribute("toCity") %>">
<input type="hidden" name="date" value="<%= request.getAttribute("journeyDate") %>">

<button class="btn book-btn btn-sm mt-2">
Book Now
</button>

</form>

</div>

</div>

</div>

<%
}
}
%>

</div>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>