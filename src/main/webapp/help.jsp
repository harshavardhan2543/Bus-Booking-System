<%@ page contentType="text/html; charset=UTF-8" %>

<html>
<head>
<title>Help</title>

<style>

body{
    font-family:'Poppins',sans-serif;
    margin:0;
    background: linear-gradient(135deg,#0f2027,#203a43,#2c5364);
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
}

/* FAQ */
.faq{
    margin:10px 0;
}

.question{
    font-weight:600;
}

.answer{
    font-size:14px;
    opacity:0.9;
}

/* BUTTON */
.btn{
    width:100%;
    padding:12px;
    margin-top:10px;
    background:linear-gradient(45deg,#4e73df,#1cc88a);
    border:none;
    color:white;
    border-radius:10px;
    cursor:pointer;
}

</style>
</head>

<body>

<jsp:include page="header.jsp" />

<div class="wrapper">

<div class="title">❓ Help & Support</div>

<!-- FAQ -->
<div class="card">

<div class="faq">
<div class="question">How to book a ticket?</div>
<div class="answer">Search buses → Select seats → Enter details → Confirm booking.</div>
</div>

<div class="faq">
<div class="question">Can I cancel ticket?</div>
<div class="answer">Currently cancellation is not available.</div>
</div>

<div class="faq">
<div class="question">How to check bookings?</div>
<div class="answer">Go to menu → Click on Bookings.</div>
</div>

</div>

<!-- CONTACT -->
<div class="card">
<div class="question">📞 Contact Us</div>
<p>Email: support@sahasrimatravels.com</p>
<p>Phone: +91 9701791856</p>
</div>

<!-- ACTIONS -->
<div class="card">
<button class="btn" onclick="location.href='dashboard.jsp'">🏠 Go Home</button>
<button class="btn" onclick="location.href='BookingServlet'">📄 View Bookings</button>
<button class="btn" onclick="location.href='logout.jsp'">🚪 Logout</button>
</div>

</div>

</body>
</html>