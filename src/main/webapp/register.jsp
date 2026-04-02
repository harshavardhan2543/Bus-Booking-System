
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
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
        * {
            box-sizing: border-box;
            font-family: 'Segoe UI', sans-serif;
        }

        body {
            margin: 0;
            height: 100vh;
            background: linear-gradient(120deg, #667eea, #764ba2);
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .card {
            background: white;
            width: 400px;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.25);
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        input {
            width: 100%;
            padding: 10px;
            margin-bottom: 12px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        .password-box {
            position: relative;
        }

        .toggle {
            position: absolute;
            right: 10px;
            top: 10px;
            cursor: pointer;
            font-size: 14px;
            color: #667eea;
        }

        .strength {
            height: 6px;
            background: #ddd;
            border-radius: 4px;
            margin-bottom: 12px;
        }

        .strength div {
            height: 100%;
            width: 0;
            border-radius: 4px;
            transition: 0.3s;
        }

        button {
            width: 100%;
            padding: 12px;
            border-radius: 25px;
            border: none;
            background: linear-gradient(to right, #667eea, #764ba2);
            color: white;
            font-size: 16px;
            cursor: pointer;
        }

        .rules {
            font-size: 13px;
            color: #555;
            margin-bottom: 10px;
        }

        .link {
            text-align: center;
            margin-top: 10px;
        }

        /* Toast */
        .toast {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 12px 20px;
            background: #dc3545;
            color: white;
            border-radius: 6px;
            display: none;
        }
    </style>
</head>

<body>
<div class="card">
    <h2>Create Account</h2>

    <form action="<%= request.getContextPath() %>/register"
          method="post"
          onsubmit="return validatePassword()">

        <input type="text" name="firstname" placeholder="First Name" required>
        <input type="text" name="lastname" placeholder="Last Name" required>
        <input type="email" name="email" placeholder="Email" required>

        <div class="password-box">
            <input type="password" id="password" name="password"
                   placeholder="Password" required onkeyup="checkStrength()">
            <span class="toggle" onclick="togglePassword()">Show</span>
        </div>

        <div class="strength">
            <div id="strengthBar"></div>
        </div>

        <div class="rules">
            • Min 8 characters<br>
            • 1 Uppercase<br>
            • 1 Number<br>
            • 1 Special character
        </div>

        <input type="text" name="phone" placeholder="Phone">

        <button type="submit">Register</button>
    </form>

    <div class="link">
        Already have an account?
        <a href="login.jsp">Login</a>
    </div>
</div>

<div id="toast" class="toast"></div>

<script>
    function togglePassword() {
        let p = document.getElementById("password");
        p.type = p.type === "password" ? "text" : "password";
    }

    function checkStrength() {
        let pwd = document.getElementById("password").value;
        let bar = document.getElementById("strengthBar");

        if (pwd.length < 4) {
            bar.style.width = "25%";
            bar.style.background = "red";
        } else if (pwd.length < 7) {
            bar.style.width = "50%";
            bar.style.background = "orange";
        } else if (pwd.match(/[A-Z]/) && pwd.match(/[0-9]/) && pwd.match(/[@$!%*#?&]/)) {
            bar.style.width = "100%";
            bar.style.background = "green";
        } else {
            bar.style.width = "75%";
            bar.style.background = "yellowgreen";
        }
    }

    function validatePassword() {
        let pwd = document.getElementById("password").value;
        let regex = /^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#?&]).{8,}$/;

        if (!regex.test(pwd)) {
            showToast("Password does not meet requirements");
            return false;
        }
        return true;
    }

    function showToast(msg) {
        let toast = document.getElementById("toast");
        toast.innerText = msg;
        toast.style.display = "block";
        setTimeout(() => toast.style.display = "none", 3000);
    }
</script>

</body>
</html>
