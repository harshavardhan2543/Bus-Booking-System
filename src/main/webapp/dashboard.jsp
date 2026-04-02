<%@ page session="true" %>
<jsp:include page="header.jsp" />
<%
String username = (String) session.getAttribute("username");
if(username == null){
response.sendRedirect("login.jsp");
return;
}
%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">
<title>Sahasrima Travels</title>
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

<!-- FLATPICKR -->

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/themes/dark.css">

<style>

body{
margin:0;
font-family:'Segoe UI',sans-serif;
background:linear-gradient(135deg,#0f2027,#203a43,#2c5364);
min-height:100vh;
color:white;
}
.page-content {
    margin-top: 70px;  /* adjust if needed */
}
.header-bar{
padding:25px 0;
display:flex;
justify-content:space-between;
align-items:center;
}

.brand{
font-size:26px;
font-weight:700;
}

.brand span{
color:#4e9fff;
}

.welcome{
font-size:14px;
opacity:0.85;
}

.search-wrapper{
display:flex;
justify-content:center;
margin-top:50px;
}

.search-card{
width:100%;
max-width:600px;
background:rgba(255,255,255,0.08);
backdrop-filter:blur(10px);
padding:35px;
border-radius:20px;
box-shadow:0 20px 40px rgba(0,0,0,0.35);
}

.form-control{
border-radius:10px;
padding:12px;
border:none;
}

.form-control:focus{
box-shadow:0 0 0 2px #4e9fff;
}

.search-btn{
background:linear-gradient(90deg,#4e9fff,#6f8cff);
border:none;
border-radius:10px;
padding:12px;
font-weight:600;
}

.input-wrapper{
position:relative;
}

/* AUTOCOMPLETE */

.suggestions{
position:absolute;
background:white;
color:black;
width:100%;
border-radius:8px;
margin-top:2px;
z-index:999;
}

.suggestions div{
padding:10px;
cursor:pointer;
}

.suggestions div:hover{
background:#f1f1f1;
}

/* DATE */

.date-card{
min-width:75px;
padding:8px;
text-align:center;
border-radius:10px;
cursor:pointer;
background:rgba(255,255,255,0.1);
transition:0.2s;
}

.date-card:hover{
background:rgba(255,255,255,0.2);
}

.active-date{
background:#4e9fff !important;
color:white;
}

/* SWAP */

.swap-btn{
border-radius:50%;
width:40px;
height:40px;
background:#4e9fff;
border:none;
color:white;
display:flex;
align-items:center;
justify-content:center;
margin:10px auto;
}

</style>

</head>

<body>

<jsp:include page="header.jsp" />
<div class="page-content">
<div class="container">

<div class="header-bar">

<div class="brand">
<i class="bi bi-bus-front-fill"></i>
Sahasrima<span>Travels</span>
</div>
<div class="welcome">
Welcome, <%= username %>
</div>

</div>

<div class="search-wrapper">

<div class="search-card">

<form action="SearchServlet" method="post">

<div class="mb-3 input-wrapper">

<label>From</label>

<input type="text" id="fromInput" name="from"
class="form-control" autocomplete="off" required>

<div id="fromSuggestions" class="suggestions"></div>

</div>

<div class="text-center">

<button type="button" id="swapBtn" class="swap-btn">
<i class="bi bi-arrow-left-right"></i>
</button>

</div>

<div class="mb-3 input-wrapper">

<label>To</label>

<input type="text" id="toInput" name="to"
class="form-control" autocomplete="off" required>

<div id="toSuggestions" class="suggestions"></div>

</div>

<div class="mb-3">

<label>Journey Date</label>

<div class="d-flex gap-2 mt-2" id="dateContainer"></div>

<input type="hidden" name="date" id="selectedDate">

</div>

<button type="submit" class="btn search-btn w-100">
<i class="bi bi-search"></i> Search Buses
</button>

</form>

</div>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

<script>

/* SWAP */

const swapBtn=document.getElementById("swapBtn");
const fromInput=document.getElementById("fromInput");
const toInput=document.getElementById("toInput");

swapBtn.onclick=function(){

let temp=fromInput.value;
fromInput.value=toInput.value;
toInput.value=temp;

};

/* AUTOCOMPLETE */

function setupAutocomplete(inputId,boxId){

const input=document.getElementById(inputId);
const box=document.getElementById(boxId);

input.addEventListener("keyup",function(){

let query=this.value;

if(query.length<2){
box.innerHTML="";
return;
}

fetch("CityServlet?term="+query)

.then(res=>res.json())

.then(data=>{

box.innerHTML="";

data.forEach(city=>{

let div=document.createElement("div");
div.textContent=city;

div.onclick=function(){
input.value=city;
box.innerHTML="";
}

box.appendChild(div);

});

});

});

}

setupAutocomplete("fromInput","fromSuggestions");
setupAutocomplete("toInput","toSuggestions");

/* DATE */

const container=document.getElementById("dateContainer");
const hiddenInput=document.getElementById("selectedDate");

const today=new Date();

for(let i=0;i<3;i++){

let d=new Date();
d.setDate(today.getDate()+i);

let fullDate=d.toISOString().split('T')[0];
let day=d.getDate();
let weekday=d.toLocaleDateString("en-US",{weekday:'short'});

let card=document.createElement("div");
card.className="date-card";

if(i===0){
card.classList.add("active-date");
hiddenInput.value=fullDate;
}

card.innerHTML=
"<div style='font-weight:bold'>"+day+"</div>"+
"<div style='font-size:12px'>"+weekday+"</div>";

card.onclick=function(){

document.querySelectorAll(".date-card")
.forEach(el=>el.classList.remove("active-date"));

card.classList.add("active-date");

hiddenInput.value=fullDate;

};

container.appendChild(card);

}

/* CALENDAR CARD */

let calendarCard=document.createElement("div");
calendarCard.className="date-card";
calendarCard.innerHTML="<i class='bi bi-calendar'></i><div style='font-size:12px'>More</div>";
container.appendChild(calendarCard);

const calendarInput=document.createElement("input");
calendarInput.type="text";
calendarInput.style.display="none";
document.body.appendChild(calendarInput);

flatpickr(calendarInput,{
minDate:"today",
dateFormat:"Y-m-d",
onChange:function(selectedDates,dateStr){

hiddenInput.value=dateStr;

document.querySelectorAll(".date-card")
.forEach(el=>el.classList.remove("active-date"));

calendarCard.classList.add("active-date");

let selectedDate=new Date(dateStr);
let day=selectedDate.getDate();
let month=selectedDate.toLocaleString('default',{month:'short'});

calendarCard.innerHTML=
"<div style='font-weight:bold'>"+day+"</div>"+
"<div style='font-size:12px'>"+month+"</div>";

}
});

calendarCard.onclick=function(){
calendarInput._flatpickr.open();
};

</script>

</div> <!-- container -->


</body>
</html>