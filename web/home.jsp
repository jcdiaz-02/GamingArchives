<%-- Document : home Created on : 02 23, 22, 5:02:52 PM Author : Admin --%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link rel="icon" href="assets/logo.svg">
        <link rel="stylesheet" href="assets/css/asset-sheet.css">
        <link rel="stylesheet" href="assets/css/navbar-style.css">
        <link rel="stylesheet" href="assets/css/home-style.css">


        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

        <link href="https://fonts.googleapis.com/css2?family=Amaranth&family=Quicksand&family=VT323&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Audiowide&effect=anaglyph">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Press+Start+2P&effect=anaglyph">

        <script src="https://kit.fontawesome.com/db09b338f9.js" crossorigin="anonymous"></script>
        <title>UST-TGS</title>
    </head>

    <body>
        <%
            response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
            String uname = (String) session.getAttribute("username");
            if (uname != null) {
                response.sendRedirect("subpage/authenticatedHome.jsp");
            }
        %>
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
                    <a class="option" style="color:#B92432; " href="home.jsp">Home</a>
                    <a class="option" href="subpage/about.jsp">About</a>
                    <a class="option" href="EventOverview">Events</a>
                    <a class="option" href="subpage/contact.jsp">Contact</a>
                    <form class="button-nav-form" action="login/login.jsp">
                        <button type="submit" value="Login"  class="button">Login</button>
                    </form>

                </div>
            </div>
        </div>

        <!-- 1st section/ home -->
        <section class="home-section">
            <div class="home-header">
                <img class="home-logo" src="assets/logo.svg">
                <div class="home-title">
                    <h2 class="font-effect-anaglyph">UST-TGS</h2>
                    <h3 class="font-effect-anaglyph">UST THOMASIAN GAMING SOCIETY</h3>
                </div>
            </div>
            <div class="home-sub">
                <h5>UNIVERSITY OF SANTO TOMAS' GAMING ORGANIZATION</h5>
                <form action="subpage/about.jsp">
                    <button class="button" type="submit" >LEARN MORE</button>
                </form>

            </div>
        </section>
    </body>

</html>