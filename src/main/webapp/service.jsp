<!DOCTYPE html>
<html>
<head>
<title>Select Service</title>
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
.card {
    background:white;
    padding:20px;
    margin:20px;
    border-radius:15px;
    box-shadow:0 5px 15px rgba(0,0,0,0.2);
    cursor:pointer;
}
.card:hover{
    transform:scale(1.03);
}
</style>

</head>
<body style="background:#f5f5f5; font-family:sans-serif;">

<h2 style="text-align:center;">Select Bus Service</h2>

<!-- APSRTC -->
<div class="card" onclick="window.location.href='SearchServlet?from=Kurnool&to=Hyderabad&journeyDate=2026-03-20&busType=APSRTC'">
    <h3>APSRTC Buses</h3>
    <p>Andhra Pradesh State Road Transport</p>
</div>

<!-- TSRTC -->
<div class="card" onclick="window.location.href='SearchServlet?from=Kurnool&to=Hyderabad&journeyDate=2026-03-20&busType=TSRTC'">
    <h3>TSRTC Buses</h3>
    <p>Telangana State Road Transport</p>
</div>

<form id="serviceForm" method="post" action="SearchServlet">
    <input type="hidden" name="busType" id="busType">
    <input type="hidden" name="from" value="Tirupati">
    <input type="hidden" name="to" value="Hyderabad">
    <input type="hidden" name="journeyDate" value="2026-03-20">
</form>

<script>
function selectService(type){
    document.getElementById("busType").value = type;
    document.getElementById("serviceForm").submit();
}
</script>

</body>
</html>