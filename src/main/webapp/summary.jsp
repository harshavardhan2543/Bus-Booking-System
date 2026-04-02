<%@ page contentType="text/html; charset=UTF-8" %>

<%
String seats = request.getParameter("seats");
String busName = request.getParameter("busName");
String type = request.getParameter("type");
String price = request.getParameter("price");
String halts = request.getParameter("halts");

// NEW (important for DB)
String from = request.getParameter("from");
String to = request.getParameter("to");
String date = request.getParameter("date");

String username = (String) session.getAttribute("username");

if(seats == null) seats = "";

String[] seatArray = seats.split(",");
int seatCount = seatArray.length;

double total = seatCount * Double.parseDouble(price);
%>

<!DOCTYPE html>
<html>
<head>
<title>Booking Summary</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

<style>

body{
    font-family:'Poppins',sans-serif;
    margin:0;
    background: linear-gradient(135deg,#0f2027,#203a43,#2c5364);
    min-height:100vh;
    color:white;
}

/* MAIN WRAPPER */
.wrapper{
    display:flex;
    justify-content:center;
    align-items:flex-start;
    padding-top:100px;
}

/* CARD */
.container{
    width:420px;
}

/* GLASS CARD */
.card{
    background:rgba(255,255,255,0.1);
    backdrop-filter:blur(15px);
    border-radius:20px;
    padding:20px;
    margin-bottom:20px;
    box-shadow:0 10px 30px rgba(0,0,0,0.4);
}

/* TITLE */
.title{
    font-weight:600;
    margin-bottom:10px;
    font-size:16px;
}

/* TEXT */
.card p{
    margin:6px 0;
    font-size:14px;
}

/* INPUT */
.input{
    width:100%;
    padding:12px;
    margin:8px 0;
    border-radius:10px;
    border:none;
    outline:none;
    background:rgba(255,255,255,0.9);
    font-size:14px;
}

/* BUTTON */
.btn{
    width:100%;
    padding:14px;
    background:linear-gradient(45deg,#4e73df,#1cc88a);
    border:none;
    color:white;
    border-radius:12px;
    font-size:16px;
    font-weight:600;
    margin-top:10px;
    cursor:pointer;
}

.btn:hover{
    opacity:0.9;
    transform:scale(1.02);
}

</style>
</head>

<body>

<div class="wrapper">
<div class="container">

<!-- BUS DETAILS -->
<div class="card">

<div class="title">🚌 Bus Details</div>
<p><b>Bus:</b> <%= busName %></p>
<p><b>Type:</b> <%= type %></p>
<p><b>Seats:</b> <%= seats %></p>
<p><b>Food Halts:</b> <%= halts %></p>
<p><b>Total Price:</b> ₹ <%= total %></p>

<p><b>Bus:</b> <%= busName %></p>
<p><b>Type:</b> <%= type %></p>
<p><b>Seats:</b> <%= seats %></p>
<p><b>Food Halts:</b> <%= halts %></p>

<p><b>Total Price:</b> ₹ <%= total %></p>

</div>

<!-- PASSENGER FORM -->
<form action="BookingServlet" method="post">

<%
for(int i=0; i<seatCount; i++){
%>

<div class="card">

<div class="title">👤 Passenger <%= i+1 %> (Seat <%= seatArray[i] %>)</div>

<input class="input" type="text" name="name<%= i %>" placeholder="Name" required>
<input class="input" type="number" name="age<%= i %>" placeholder="Age" required>
<input class="input" type="text" name="phone<%= i %>" placeholder="Phone Number" required>

</div>

<%
}
%>

<!-- 🔥 HIDDEN DATA (IMPORTANT) -->
<input type="hidden" name="username" value="<%= username %>">
<input type="hidden" name="from" value="<%= from %>">
<input type="hidden" name="to" value="<%= to %>">
<input type="hidden" name="date" value="<%= date %>">
<input type="hidden" name="seats" value="<%= seats %>">
<input type="hidden" name="total" value="<%= total %>">

<button class="btn">Confirm Booking</button>

</form>

</div>
</div>

</body>
</html>