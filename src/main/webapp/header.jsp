<style>
.top-bar{
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  background: white;
  display: flex;
  align-items: center;
  padding: 15px;
  z-index: 1000;
  box-shadow: 0 2px 5px rgba(0,0,0,0.2);
}

.menu-icon{
  font-size: 22px;
  cursor: pointer;
  margin-right: 15px;
  color: black;   /* 🔥 add this */
}

#overlay{
  position: fixed;
  width: 100%;
  height: 100%;
  background: rgba(0,0,0,0.4);
  top: 0;
  left: 0;
  display: none;
  z-index: 999;
}

.side-menu {
  position: fixed;
  top: 0;
  left: -280px;
  width: 280px;
  height: 100%;
  background: white;   /* 🔥 change */
  transition: 0.3s;
  z-index: 1001;
}

.menu-item {
  padding: 15px;
  cursor: pointer;
  border-bottom: 1px solid #ddd;
  color: black;        /* 🔥 add this */
  font-weight: 500;    /* optional */
}
.menu-item:hover {
  background: #f1f1f1;
}
</style>

<div class="top-bar">
  <span class="menu-icon" onclick="openMenu()" style="color:black; font-size:24px;">&#9776;</span>
  <b>Bus Booking</b>
</div>

<div id="overlay" onclick="closeMenu()"></div>

<div id="sideMenu" class="side-menu">

  <div class="menu-item" onclick="go('dashboard.jsp')">Home</div>
  <div class="menu-item" onclick="go('BookingServlet')">Bookings</div>
  <div class="menu-item" onclick="go('help.jsp')">Help</div>
  <div class="menu-item" onclick="go('logout.jsp')" style="color:red;">Logout</div>

</div>

<script>
function openMenu(){
  document.getElementById("sideMenu").style.left="0";
  document.getElementById("overlay").style.display="block";
}
function closeMenu(){
  document.getElementById("sideMenu").style.left="-280px";
  document.getElementById("overlay").style.display="none";
}
function go(p){
  window.location.href=p;
}
</script>