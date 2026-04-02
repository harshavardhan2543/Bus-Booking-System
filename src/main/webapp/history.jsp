<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<html>
<head>
<meta charset="UTF-8">
<title>Bookings</title>
<style>

body{
    font-family:'Poppins',sans-serif;
    margin:0;
    background: linear-gradient(135deg,#0f2027,#203a43,#2c5364);
    min-height:100vh;
    color:white;
}

/* WRAPPER */
.wrapper{
    padding-top:90px;
    display:flex;
    flex-direction:column;
    align-items:center;
}

/* TITLE */
.title{
    font-size:22px;
    font-weight:600;
    margin-bottom:20px;
}

/* CARD */
.card{
    width:420px;
    background:rgba(255,255,255,0.1);
    backdrop-filter:blur(15px);
    border-radius:18px;
    padding:20px;
    margin-bottom:20px;
    box-shadow:0 10px 30px rgba(0,0,0,0.4);
    transition:0.3s;
}

.card:hover{
    transform:translateY(-5px);
}

/* ROUTE */
.route{
    font-size:16px;
    font-weight:600;
    margin-bottom:8px;
}

/* DETAILS */
.details{
    font-size:14px;
    opacity:0.9;
    margin:4px 0;
}

/* PRICE */
.price{
    margin-top:8px;
    font-weight:600;
    color:#1cc88a;
}

/* EMPTY */
.empty{
    margin-top:30px;
    font-size:16px;
    opacity:0.8;
}

</style>
</head>

<body>

<jsp:include page="header.jsp" />

<div class="wrapper">

<div class="title">🧾 Your Bookings</div>

<%
List<Map<String,String>> list = (List<Map<String,String>>) request.getAttribute("bookings");

if(list != null && !list.isEmpty()){
    for(Map<String,String> b : list){
%>

<div class="card">

<div class="route">
<%= b.get("from") %> → <%= b.get("to") %>
</div>

<div class="details">📅 Date: <%= b.get("date") %></div>
<div class="details">💺 Seats: <%= b.get("seats") %></div>

<div class="price">₹ <%= b.get("price") %></div>

</div>

<%
    }
}else{
%>

<div class="empty">No bookings yet 🚫</div>

<%
}
%>
</div>
</body>
</html>