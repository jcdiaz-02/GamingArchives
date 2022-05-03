<%--
    Document   : Error404
    Created on : 02 23, 21, 12:56:43 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link rel="icon" href="assets/logo.svg">
        <link rel="stylesheet" href="assets/css/asset-sheet.css">
        <link rel="stylesheet" href="assets/css/navbar-style.css">
        <link rel="stylesheet" href="assets/css/error-style.css">


        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

        <link href="https://fonts.googleapis.com/css2?family=Amaranth&family=Quicksand&family=VT323&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Audiowide&effect=anaglyph">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Press+Start+2P&effect=anaglyph">

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
                <a href="home.jsp"><img class="nav-logo nav-logo2" src="assets/logo.svg" ></a>
            </div>

            <div class="nav-content">
                <div class="nav-title">
                    <img class="nav-logo" src="assets/logo.svg" alt="UST-TGS logo">
                    <a class="" href="home.jsp"> 
                        <h1>UST Thomasian Gaming Society</h1>
                    </a>
                </div>
                <div class="nav-options">
                    <a class="option" href="home.jsp">Home</a>
                    <a class="option" href="subpage/about.jsp">About</a>
                    <a class="option" href="EventOverview">Events</a>
                    <a class="option" href="subpage/contact.jsp">Contact</a>
                    <form class="button-nav-form" action="login/login.jsp">
                        <input type="submit" value="Login"  class="button"/>
                    </form>

                </div>
            </div>
        </div>

        <!-- 1st section/ home -->
        <section class="error-section">
            <div class="error-header">
                <img class="error-logo" src="assets/pac.png">
                <div class="error-title">
                    <h2 class="font-effect-anaglyph">GAME OVER</h2>
                    <h3 >uh, oh this user does not exist...</h3>
                </div>
            </div>
            <div class="error-sub">
                <form action="login/login.jsp" method='POST'>
                    <button class="button" type="submit" >LOG-IN AGAIN</button>
                </form>

            </div>
        </section>

    </body>

</html>
