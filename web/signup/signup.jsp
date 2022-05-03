<%-- 
    Document   : signup
    Created on : 02 28, 22, 12:46:41 AM
    Author     : Admin
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link rel="icon" href="../assets/logo.svg">
        <link rel="stylesheet" href="../assets/css/asset-sheet.css">
        <link rel="stylesheet" href="../assets/css/navbar-style.css">
        <link rel="stylesheet" href="../assets/css/signup-style.css">

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

        <link href="https://fonts.googleapis.com/css2?family=Amaranth&family=Quicksand&family=VT323&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Audiowide&effect=anaglyph">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Press+Start+2P&effect=anaglyph">

        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">

        <script src="https://kit.fontawesome.com/db09b338f9.js" crossorigin="anonymous"></script>
        <title>UST-TGS</title>
    </head>
    <body>
        <!-- navbar -->
        <div class="bar"> 
            <input type="checkbox" id="check">
            <label for="check" class="checkbtn">
                <i class="fas fa-bars"></i>
            </label>

            <div class="logo-container" >
                <a href="home.jsp"><img class="nav-logo nav-logo2" src="../assets/logo.svg" ></a>
            </div>

            <div class="nav-content">
                <div class="nav-title">
                    <img class="nav-logo" src="../assets/logo.svg" alt="UST-TGS logo">
                    <a class="" href="../home.jsp"> 
                        <h1>UST Thomasian Gaming Society</h1>
                    </a>
                </div>
                <div class="nav-options" >
                    <a class="option" href="../home.jsp">Home</a>
                    <a class="option" href="../subpage/about.jsp">About</a>
                    <a class="option" href="../subpage/events.jsp">Events</a>
                    <a class="option" href="../subpage/contact.jsp">Contact</a>
                    <form class="button-nav-form" action="../login/login.jsp">
                        <button type="submit" value="Login"  class="button"/>Login</button>
                    </form>

                </div>
            </div>
        </div>
        <%
            session.setAttribute("identifier", "signup");
        %>
        <section class="signup-section">
            <form class="signup-container" method="post" action="../UserVerification">
                <h2>Sign Up</h2>
                <h3>Already registered? <a href="../login/login.jsp">Login</a></h3>

                <div class="input-container">

                    <label for="email"><b>Email</b></label>    
                    <div class="input">
                        <input type="text" pattern="[a-z0-9._%+-]+@ust.edu.ph$" placeholder="Enter Email" name="email" required>
                    </div>

                    <label for="uname"><b>Username</b></label>
                    <div class="input">
                        <input type="text" placeholder="Enter Username" name="uname" required>

                    </div>

                    <label for="psw"><b>Password</b></label>
                    <div class="input">

                        <input type="password" placeholder="Enter Password" name="psw" id="psw" required>
                        <span onclick="toggleVisibility()" class="material-icons-outlined psw-show">visibility_off</span>
                    </div>

                    <div class="input">
                        <input type="password" placeholder="Confirm Password" name="cpsw" id="cpsw" required>
                        <span onclick="toggleVisibility1()" class="material-icons-outlined psw-show">&#xe8f5;</span>
                    </div>

                </div>


                <div class="privacy-policy"> 
                    <input type="checkbox" id="privacy-policy" name="privacy-policy" value='' required>
                    <label for="privacy-policy"> 
                        I have read and agreed to the website's <a href="privacypolicy.jsp">Privacy Policy</a>
                    </label>
                </div>
                <button type="submit" name="button" value="signup">SIGN UP</button>

            </form>
        </section>       
    </body>

    <script>
        function toggleVisibility() {
            var psw = document.getElementById("psw");
            if (psw.type === "password") {
                psw.type = "text";
            } else {
                psw.type = "password";
            }
        }

        function toggleVisibility1() {
            var cpsw = document.getElementById("cpsw");
            if (cpsw.type === "password") {
                cpsw.type = "text";
            } else {
                cpsw.type = "password";
            }
        }
    </script>
</html>
