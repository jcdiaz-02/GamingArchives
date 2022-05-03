<%-- 
    Document   : about
    Created on : 02 25, 22, 10:33:45 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link rel="icon" href="../assets/logo.svg">
        <link rel="stylesheet" href="../assets/css/asset-sheet.css">
        <link rel="stylesheet" href="../assets/css/navbar-style.css">
        <link rel="stylesheet" href="../assets/css/about-style.css">


        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

        <link href="https://fonts.googleapis.com/css2?family=Amaranth&family=Quicksand&family=VT323&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Audiowide&effect=anaglyph">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Press+Start+2P&effect=anaglyph">

        <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">

        <script src="https://kit.fontawesome.com/db09b338f9.js" crossorigin="anonymous"></script>
        <title>UST-TGS</title>

    </head>
    <body>
        <!-- navbar -->
        <%
            response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
            String uname = (String) session.getAttribute("username");
            //session.setAttribute("verify", session.getAttribute("verify"));

            String role = (String) session.getAttribute("role");
            if (uname == null) {
                response.sendRedirect("../home.jsp");
            }
        %>
        <div class="bar"> 
            <input type="checkbox" id="check">
            <label for="check" class="checkbtn">
                <i class="fas fa-bars"></i>
            </label>

            <div class="logo-container" >
                <a href="../home.jsp"><img class="nav-logo nav-logo2" src="../assets/logo.svg" ></a>
            </div>

            <div class="nav-content">
                <div class="nav-title">
                    <img class="nav-logo" src="../assets/logo.svg" alt="UST-TGS logo">
                    <a class="" href="/"> 
                        <h1>UST Thomasian Gaming Society</h1>
                    </a>
                </div>
                <div class="nav-options" >
                    <a class="option" href="authenticatedHome.jsp">Home</a>
                    <a class="option" style="color:#B92432;" href="authenticatedAbout.jsp">About</a>
                    <a class="option" href="../EventOverview">Events</a>
                    <a class="option" href="authenticatedContacts.jsp">Contact</a>
                    <%
                        if (role.equalsIgnoreCase("member")) {
                    %>
                    <form class="button-nav-form"action="../MyAccountServlet">
                        <input type="hidden" name="verify" value="${verify}" />
                        <button type="submit" value="My Account"  class="button"/>My Account</button>
                    </form>
                    <%    } else if (role.equalsIgnoreCase("admin")) { %>
                    <form class="button-nav-form" action="../MyAccountServlet">
                        <input type="hidden" name="verify" value="${verify}" />
                        <button type="submit" value="ADMIN"  class="button"/>ADMIN</button>
                    </form>
                    <% }%>          
                </div>
            </div>
        </div>

        <!-- 1st section/ about -->
        <section class="about-section">
            <%response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");%>

            <div class="about-container">
                <div class="about-panel">
                    <span class="material-icons-outlined about-icon">&#xe8e1;</span>
                    <span class="about-text">
                        <h2> About </h2>
                        The Thomasian Gaming Society is a college-based organization of the University of Santo Tomas, 
                        College of Information and Computing Sciences, that focuses on Thomasian video game enthusiasts 
                        committed to cultivating and promoting camaraderie and sportsmanship in the video gaming community. 
                        The organization, imbued with the Thomasian core values--competence, commitment, and compassion--aims to provide an avenue for development of leadership, social skills and critical thinking as skilled individuals capable of building connections and contributing significant initiatives in the pursuit of culture, creativity and innovation through video games.
                    </span>
                </div>

                <div class="about-panel">
                    <span class="material-icons-outlined about-icon">&#xe8f4;</span>
                    <span class="about-text">
                        <h2> Vision </h2>
                        The Thomasian Gaming Society - CICS, as the first ever college-based gaming organization, envisions 
                        itself as an open platform for all Thomasian garners committed to building relationships and contributing 
                        significant change to man, God and country through video games. The organization will be the 
                        promenade of its members into a collective that molds the core skills and virtues of Thomasian leadership,
                        creativity and camaraderie.</span>
                </div>

                <div class="about-panel">
                    <span class="material-icons-outlined about-icon">&#xe87e;</span>
                    <span class="about-text">
                        <h2> Mission </h2>
                        The Thomasian Gaming Society is a college-based organization composed of like-minded Thomasian 
                        students with a passion and knack for video games, committed to establishing and cultivating a unique 
                        college-based video gaming culture and fostering sportsmanship and camaraderie through gaming in the 
                        community. The organization, guided by the Thomasian core values, aims to provide an holistic avenue 
                        for leadership and development of critical thinking and social skills in order to grow skilled and 
                        god-centered individuals capable of building connections with like-minded people in the pursuit of 
                        enriching gaming culture, encouraging creativity, and introducing innovation through video games.
                    </span>
                </div>
            </div>
        </section>
    </body>
</html>
