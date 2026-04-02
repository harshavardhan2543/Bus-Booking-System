<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
<title>Select Seats</title>

<style>

body{
    font-family:'Poppins',sans-serif;
    margin:0;
    background: linear-gradient(135deg,#0f2027,#203a43,#2c5364);
    min-height:100vh;
    color:white;
}

/* HEADER SPACE */
.page-content{
    margin-top:70px;
}

/* MAIN CARD */
.container{
    width:350px;
    margin:40px auto;
    background:white;
    padding:25px;
    border-radius:20px;
    box-shadow:0 20px 40px rgba(0,0,0,0.4);
    color:black;
}

/* TITLE */
.title{
    text-align:center;
    font-weight:600;
    margin-bottom:15px;
}

/* DRIVER */
.driver{
    text-align:right;
    font-size:20px;
    margin-bottom:15px;
}

/* ROW */
.row{
    display:flex;
    justify-content:space-between;
    margin-bottom:10px;
}

/* SEAT */
.seat{
    width:45px;
    height:45px;
    border-radius:10px;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:12px;
    cursor:pointer;
    transition:0.2s;
    border:2px solid #4CAF50;
}

/* STATES */
.available{
    background:white;
    color:#4CAF50;
}

.available:hover{
    background:#e8f5e9;
}

.sold{
    background:#ddd;
    color:#999;
    border:none;
    cursor:not-allowed;
}

.selected{
    background:#ff4081;
    color:white;
    border:none;
    transform:scale(1.1);
}

/* AISLE */
.aisle{
    width:25px;
}

/* LEGEND */
.legend{
    margin-top:15px;
    font-size:12px;
}

.legend div{
    margin:5px 0;
}

.box{
    width:15px;
    height:15px;
    display:inline-block;
    margin-right:5px;
}

.green{border:2px solid #4CAF50;}
.gray{background:#ddd;}
.pink{background:#ff4081;}

/* BUTTON */
.confirm-btn{
    width:100%;
    padding:12px;
    margin-top:15px;
    background:linear-gradient(45deg,#4e73df,#1cc88a);
    border:none;
    color:white;
    border-radius:10px;
    font-weight:600;
}

.confirm-btn:hover{
    opacity:0.9;
}

</style>


<script>

function selectSeat(el){

    if(el.classList.contains("sold")){
        return;
    }

    el.classList.toggle("selected");
}

function confirmBooking(){

    let selectedSeats = document.querySelectorAll(".seat.selected");

    if(selectedSeats.length === 0){
        alert("Please select at least one seat");
        return;
    }

    let seats = [];
    selectedSeats.forEach(s => seats.push(s.innerText));

    document.getElementById("seatsInput").value = seats.join(",");

    // 🔥 show summary popup
    alert("Selected Seats: " + seats.join(", "));

    document.getElementById("bookingForm").submit();
}
</script>

</head>

<body>

<!-- 🔥 HEADER ADD -->
<jsp:include page="header.jsp" />

<!-- 🔥 BOOKING HISTORY ADD -->


<h2>Select Seats</h2>

<div class="container">

<div class="driver">🛞</div>

<%
int seatNo = 1;

for(int i=0; i<10; i++){
%>

<div class="row">

    <% for(int j=0; j<2; j++){ 
        boolean sold = (Math.random() < 0.3);
    %>

    <div class="seat <%= sold ? "sold" : "available" %>" onclick="selectSeat(this)">
        <%= sold ? "X" : seatNo++ %>
    </div>

    <% } %>

    <div style="width:20px;"></div>

    <% for(int j=0; j<2; j++){ 
        boolean sold = (Math.random() < 0.3);
    %>

    <div class="seat <%= sold ? "sold" : "available" %>" onclick="selectSeat(this)">
        <%= sold ? "X" : seatNo++ %>
    </div>

    <% } %>

</div>

<% } %>

<div class="legend">

    <div><span class="box green"></span> Available</div>
    <div><span class="box gray"></span> Sold</div>
    <div><span class="box pink"></span> Selected</div>

</div>

</div>

<br>

<form id="bookingForm" action="summary.jsp" method="post">
<input type="hidden" name="from" value="<%= request.getParameter("from") %>">
<input type="hidden" name="to" value="<%= request.getParameter("to") %>">
<input type="hidden" name="date" value="<%= request.getParameter("date") %>">

<input type="hidden" name="seats" id="seatsInput">

<input type="hidden" name="busName" value="<%= request.getParameter("name") %>">
<input type="hidden" name="type" value="<%= request.getParameter("type") %>">
<input type="hidden" name="price" value="<%= request.getParameter("price") %>">
<input type="hidden" name="halts" value="<%= request.getParameter("halts") %>">

<button type="button" onclick="confirmBooking()" class="confirm-btn">
Confirm Booking
</button>

</form>

<form id="bookingForm" action="success.jsp" method="post">
    <input type="hidden" name="seats" id="seatsInput">
</form>

</body>
</html>